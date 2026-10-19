using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Core;
using ACT.DialogueSystem;
using ACT.Drama.Conversation;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Sound.Management;
using ACT.UI;
using ACT.Utility;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using UnityEngine;

namespace ACT.Drama;

public class ConversationManager : Singleton<ConversationManager>
{
	public enum ConversationTriggerSource
	{
		Normal,
		Mission
	}

	public enum HistoryItemType
	{
		Normal,
		Option,
		BlackScreen
	}

	public struct HistoryItem
	{
		public HistoryItemType type;

		public int storyGroupId;

		public long dialogueId;

		public int speakerId;

		public int contentId;

		public bool isPlayer;

		public int voiceIndex;
	}

	private Queue<IDialogueWrapper> m_DialogueQueue = new Queue<IDialogueWrapper>();

	private IDialogueWrapper m_PlayingDialogue;

	private bool m_IsPlaying;

	private bool m_Active;

	private bool m_PauseInputPushed;

	private CancellationTokenSource m_LifetimeCTS;

	private string m_RichPlayerName;

	private string m_CatchedPlayerName;

	private IConversationDebugger m_Debugger;

	private List<int> m_SendKeyPoints;

	private List<HistoryItem> m_RecordedHistory = new List<HistoryItem>();

	private HashSet<long> m_RecordedUsedChoices = new HashSet<long>();

	public MonoConversationView conversationView;

	private bool m_canInterrupt;

	private XNodeDialogue m_PlayingXNodeDialogue;

	public IDialogueWrapper PlayingDialogue => m_PlayingDialogue;

	public bool IsPlaying => m_IsPlaying;

	public List<HistoryItem> RecordedHistory => m_RecordedHistory;

	public HashSet<long> RecordedUsedChoices => m_RecordedUsedChoices;

	public bool isOver => m_PlayingXNodeDialogue == null;

	public bool CanInterrupt => m_canInterrupt;

	public IDialogueWrapper PlayingXNodeDialogue => m_PlayingXNodeDialogue;

	public async UniTask<bool> BeginConversation(int storyGroupId, ConversationTriggerSource triggerSource = ConversationTriggerSource.Normal, AVGDialogueFromId.Options options = default(AVGDialogueFromId.Options))
	{
		AVGDialogueFromId dialogueWrapper = CreateDialogueWrapperFromStoryGroupId(storyGroupId, triggerSource, options);
		if (dialogueWrapper == null)
		{
			return false;
		}
		m_DialogueQueue.Enqueue(dialogueWrapper);
		Process().Forget();
		await UniTask.WaitUntil(() => !dialogueWrapper.IsPlaying());
		if (dialogueWrapper.IsAborted())
		{
			return false;
		}
		Singleton<ConversationManager>.instance.SetKeyPoint(storyGroupId);
		Singleton<ConversationManager>.instance.SendKeyPoints();
		return true;
	}

	public async UniTask<bool> BeginConversation(GameObject dialogueInstance, ConversationTriggerSource triggerSource = ConversationTriggerSource.Normal)
	{
		AVGDialogueFromInstance dialogueWrapper = CreateDialogueWrapperFromAvgInstance(dialogueInstance, triggerSource);
		m_DialogueQueue.Enqueue(dialogueWrapper);
		Process().Forget();
		await UniTask.WaitUntil(() => !dialogueWrapper.IsPlaying());
		if (!m_Active)
		{
			return false;
		}
		Singleton<ConversationManager>.instance.SetKeyPoint(dialogueWrapper.StoryGroupId);
		Singleton<ConversationManager>.instance.SendKeyPoints();
		return true;
	}

	public AVGDialogueFromId CreateDialogueWrapperFromStoryGroupId(int storyGroupId, ConversationTriggerSource triggerSource, AVGDialogueFromId.Options options)
	{
		if (!RuntimeConfigs.data.dialogueStoryGroupDatas.TryGetValue(storyGroupId, out var _))
		{
			m_Debugger?.LogError($"没有找到{storyGroupId}对话");
			return null;
		}
		AVGDialogueFromId aVGDialogueFromId = new AVGDialogueFromId(storyGroupId, triggerSource, options);
		aVGDialogueFromId.OnBegin += async (CancellationToken token) =>
		{
			if (!token.IsCancellationRequested)
			{
				Prepare();
			}
		};
		aVGDialogueFromId.OnEnd += async (CancellationToken token) =>
		{
			Reset();
			if (m_DialogueQueue.Count > 0)
			{
				IDialogueWrapper dialogueWrapper = m_DialogueQueue.Peek();
				if (dialogueWrapper is AVGDialogueFromId || dialogueWrapper is AVGDialogueFromInstance)
				{
					GameUtility.SetCameraLayerDialog(isTimeline: true);
				}
			}
			if (token.IsCancellationRequested)
			{
				return;
			}
			try
			{
				await ToMainView(token);
			}
			catch (Exception exception)
			{
				m_Debugger?.LogError(exception);
			}
		};
		return aVGDialogueFromId;
	}

	public AVGDialogueFromInstance CreateDialogueWrapperFromAvgInstance(GameObject dialogueInstance, ConversationTriggerSource triggerSource)
	{
		AVGDialogueFromInstance aVGDialogueFromInstance = new AVGDialogueFromInstance(dialogueInstance, triggerSource);
		aVGDialogueFromInstance.OnBegin += async (CancellationToken token) =>
		{
			if (!token.IsCancellationRequested)
			{
				Prepare();
			}
		};
		aVGDialogueFromInstance.OnEnd += async (CancellationToken token) =>
		{
			Reset();
			if (m_DialogueQueue.Count > 0)
			{
				IDialogueWrapper dialogueWrapper = m_DialogueQueue.Peek();
				if (dialogueWrapper is AVGDialogueFromId || dialogueWrapper is AVGDialogueFromInstance)
				{
					GameUtility.SetCameraLayerDialog(isTimeline: true);
				}
			}
			if (token.IsCancellationRequested)
			{
				return;
			}
			try
			{
				await ToMainView(token);
			}
			catch (Exception message)
			{
				Debug.LogError(message);
			}
		};
		return aVGDialogueFromInstance;
	}

	public override void Init()
	{
		if (m_Debugger == null)
		{
			m_Debugger = new ConversationDebugger();
		}
		m_LifetimeCTS?.Cancel();
		m_LifetimeCTS?.Dispose();
		m_LifetimeCTS = new CancellationTokenSource();
		RestorePlayerInput();
		m_DialogueQueue.Clear();
		m_PlayingDialogue?.Stop();
		m_PlayingDialogue = null;
		InitXNode();
		m_IsPlaying = false;
		m_RichPlayerName = string.Empty;
		InitKeyPoints();
		m_Active = true;
	}

	public override void UnInit()
	{
		m_Active = false;
		m_LifetimeCTS?.Cancel();
		m_LifetimeCTS?.Dispose();
		m_LifetimeCTS = null;
		RestorePlayerInput();
		m_DialogueQueue.Clear();
		m_PlayingDialogue?.Stop();
		m_PlayingDialogue = null;
		UnInitXNode();
		m_IsPlaying = false;
		m_RichPlayerName = string.Empty;
		UnInitKeyPoints();
	}

	public string GetRichPlayerName()
	{
		if (!string.Equals(m_CatchedPlayerName, G.detailUserInfo?.Brief?.Nickname))
		{
			m_CatchedPlayerName = G.detailUserInfo?.Brief?.Nickname;
			m_RichPlayerName = string.Empty;
		}
		if (string.IsNullOrEmpty(m_RichPlayerName))
		{
			m_RichPlayerName = "<color=#FFB819>" + m_CatchedPlayerName + "</color>";
		}
		return m_RichPlayerName;
	}

	private void RestorePlayerInput()
	{
		if (m_PauseInputPushed)
		{
			MonoECS.instance?.PopPauseInput();
			m_PauseInputPushed = false;
		}
	}

	private void Prepare()
	{
		MonoECS monoECS = MonoECS.instance;
		Entity? entity = monoECS?.mainEntity;
		CompBehave compBehave = entity?.GetCompBehave();
		if (compBehave != null)
		{
			compBehave.EntityTags.AddTag(EntityTag.IgnoreAttack);
			compBehave.EntityTags.AddTag(EntityTag.IgnoreTrap);
			compBehave.EntityTags.AddTag(EntityTag.UnHatable);
			compBehave.EntityTags.AddTag(EntityTag.SystemControl);
		}
		GameManager.monsterSystem?.ClearAllMonsterHatredAndHide();
		if ((bool)monoECS && !m_PauseInputPushed)
		{
			monoECS.PushPauseInput();
			m_PauseInputPushed = true;
		}
		monoECS?.ClearMainEntityInput();
		if (entity.HasValue && entity.GetValueOrDefault().IsValid)
		{
			GameManager.behaveSystem?.TimelineStop(entity.Value, force: false);
		}
		monoECS?.SetPlayerTag(MonoECS.PlayerTag.Timeline);
		entity?.SetBool("InTimeline", value: true);
		GameUtility.SetCameraLayerDialog(isTimeline: true);
	}

	private void Reset()
	{
		if (m_Active)
		{
			Singleton<DramaVoiceManager>.instance.Release();
			Entity mainEntity = MonoECS.instance.mainEntity;
			if (mainEntity != null)
			{
				CompBehave compBehave = mainEntity.GetCompBehave();
				if (compBehave != null && compBehave.EntityTags != null)
				{
					compBehave.EntityTags.RemoveTag(EntityTag.IgnoreAttack);
					compBehave.EntityTags.RemoveTag(EntityTag.IgnoreTrap);
					compBehave.EntityTags.RemoveTag(EntityTag.UnHatable);
					compBehave.EntityTags.RemoveTag(EntityTag.SystemControl);
				}
				mainEntity.SetBool("InTimeline", value: false);
			}
			GameManager.monsterSystem.ShowAllMonsterRenderer();
		}
		RestorePlayerInput();
		MonoECS.instance.RemovePlayerTag(MonoECS.PlayerTag.Timeline);
		GameUtility.SetCameraLayerDialog(isTimeline: false);
	}

	private static async UniTask<bool> WaitForPlayerOperationEnd(CancellationToken token)
	{
		if (MonoECS.instance == null || Singleton<GameState>.instance.WorldState == WorldState.Leave)
		{
			return true;
		}
		if (Singleton<GameState>.instance.CanEnterPlayerOperation(MonoECS.PlayerTag.Timeline))
		{
			return false;
		}
		return await UniTask.WaitUntil(() => MonoECS.instance == null || Singleton<GameState>.instance.WorldState == WorldState.Leave || Singleton<GameState>.instance.CanEnterPlayerOperation(MonoECS.PlayerTag.Timeline), PlayerLoopTiming.Update, token).SuppressCancellationThrow() || MonoECS.instance == null || Singleton<GameState>.instance.WorldState == WorldState.Leave;
	}

	private async UniTaskVoid Process()
	{
		if (m_IsPlaying)
		{
			return;
		}
		try
		{
			m_IsPlaying = true;
			CancellationToken token = m_LifetimeCTS.Token;
			while (m_DialogueQueue.Count > 0 && m_Active && !token.IsCancellationRequested && !(await WaitForPlayerOperationEnd(token)))
			{
				if (Model<GuideModel>.HasInstance() && Model<GuideModel>.Interface.IsInStrongGuide())
				{
					await UniTask.Yield();
					continue;
				}
				if (!token.IsCancellationRequested)
				{
					ClearRecord();
					IDialogueWrapper playingDialogue = m_DialogueQueue.Dequeue();
					m_PlayingDialogue = playingDialogue;
					await m_PlayingDialogue.Play(token);
					m_PlayingDialogue = null;
					ClearRecord();
					continue;
				}
				break;
			}
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
		finally
		{
			RestorePlayerInput();
			m_IsPlaying = false;
		}
	}

	public async UniTask<bool> BeginConversation(DialogueWrapper dialogueWrapper)
	{
		m_DialogueQueue.Enqueue(dialogueWrapper);
		Process().Forget();
		await UniTask.WaitUntil(() => !dialogueWrapper.IsPlaying());
		return true;
	}

	public void TryNext()
	{
		PlayingDialogue?.TryNext();
	}

	private async UniTask ToMainView(CancellationToken token)
	{
		if (token.IsCancellationRequested || !m_Active || m_DialogueQueue.Count > 0)
		{
			return;
		}
		if ((bool)conversationView)
		{
			await conversationView.CloseAsync();
		}
		else if ((bool)conversationView)
		{
			if (conversationView.UIController.State != UIState.Opened)
			{
				await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_BATTLEMAIN);
				if (token.IsCancellationRequested)
				{
					return;
				}
			}
			else
			{
				await UniTask.WaitUntil(() =>
				{
					if ((bool)conversationView)
					{
						UIState state = conversationView.UIController.State;
						return state == UIState.Opened || state == UIState.Closed;
					}
					return true;
				}, PlayerLoopTiming.Update, token).SuppressCancellationThrow();
				if (token.IsCancellationRequested)
				{
					return;
				}
				if ((bool)conversationView)
				{
					await conversationView.CloseAsync();
					if (token.IsCancellationRequested)
					{
						return;
					}
					if (Singleton<NewUIManager>.instance.GetStackCount() == 0)
					{
						if (Singleton<GameManager>.instance.worldManager.GetCurrentWorld().SceneStatus != SceneStatus.Lounge)
						{
							await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_BATTLEMAIN);
						}
						else
						{
							await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_LOUNGEMAIN);
						}
						if (token.IsCancellationRequested)
						{
							return;
						}
					}
				}
			}
			conversationView = null;
		}
		else if (Singleton<GameManager>.instance.worldManager.GetCurrentWorld().SceneStatus == SceneStatus.Lounge)
		{
			await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_LOUNGEMAIN);
		}
		else
		{
			await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_BATTLEMAIN);
		}
	}

	private void InitKeyPoints()
	{
		if (m_SendKeyPoints == null)
		{
			m_SendKeyPoints = new List<int>();
		}
		else
		{
			m_SendKeyPoints.Clear();
		}
	}

	private void UnInitKeyPoints()
	{
		m_SendKeyPoints?.Clear();
	}

	public void SendKeyPoints()
	{
		List<int> sendList = ListPool<int>.Get();
		foreach (int sendKeyPoint in m_SendKeyPoints)
		{
			sendList.Add(sendKeyPoint);
		}
		G.service.SendConversationKeyPoint(sendList, (bool r) =>
		{
			if (r)
			{
				foreach (int item in sendList)
				{
					m_SendKeyPoints.Remove(item);
				}
				ListPool<int>.Release(sendList);
			}
		});
	}

	public void SetKeyPoint(int keyPoint)
	{
		m_SendKeyPoints.Add(keyPoint);
	}

	public void ClearKeyPoints(List<int> keyPoints)
	{
		List<int> sendList = ListPool<int>.Get();
		sendList.AddRange(keyPoints);
		G.service.ClearConversationKeyPoints(sendList, (bool r) =>
		{
			if (r)
			{
				ListPool<int>.Release(sendList);
			}
		});
	}

	public bool HaveKeyPoint(int key)
	{
		if (G.localPlayer.Achievements.Info.ConversationKeyPoints.ContainsKey(key))
		{
			return true;
		}
		if (m_SendKeyPoints.Contains(key))
		{
			return true;
		}
		return false;
	}

	public bool HavePersistentKeyPoint(int key)
	{
		if (G.localPlayer.Achievements.Info.ConversationKeyPoints.ContainsKey(key))
		{
			return true;
		}
		return false;
	}

	public bool HaveKeyPoints(List<KeyPointState> keyPointStates)
	{
		MapField<int, int> conversationKeyPoints = G.localPlayer.Achievements.Info.ConversationKeyPoints;
		foreach (KeyPointState keyPointState in keyPointStates)
		{
			if (!conversationKeyPoints.ContainsKey(keyPointState.key) && !m_SendKeyPoints.Contains(keyPointState.key))
			{
				return false;
			}
		}
		return true;
	}

	private void ClearRecord()
	{
		m_RecordedHistory.Clear();
		m_RecordedUsedChoices.Clear();
	}

	public void RecordHistory_Normal(int storyGroupId, long dialogueId, int speakerId, int contentId, int voiceIndex, bool isPlayer)
	{
		if (IsPlaying)
		{
			m_RecordedHistory.Add(new HistoryItem
			{
				type = HistoryItemType.Normal,
				storyGroupId = storyGroupId,
				dialogueId = dialogueId,
				speakerId = speakerId,
				contentId = contentId,
				isPlayer = isPlayer,
				voiceIndex = voiceIndex
			});
		}
	}

	public void RecordHistory_Option(int storyGroupId, long dialogueId, int speakerId, int contentId, bool isPlayer)
	{
		if (IsPlaying)
		{
			m_RecordedHistory.Add(new HistoryItem
			{
				type = HistoryItemType.Option,
				storyGroupId = storyGroupId,
				dialogueId = dialogueId,
				speakerId = speakerId,
				contentId = contentId,
				isPlayer = isPlayer,
				voiceIndex = 0
			});
		}
	}

	public void RecordUsedChoice(long id)
	{
		if (IsPlaying)
		{
			m_RecordedUsedChoices.Add(id);
		}
	}

	private void InitXNode()
	{
		((IDialogueWrapper)m_PlayingXNodeDialogue)?.Stop();
		m_PlayingXNodeDialogue = null;
	}

	private void UnInitXNode()
	{
		((IDialogueWrapper)m_PlayingXNodeDialogue)?.Stop();
		m_PlayingXNodeDialogue = null;
	}

	private async UniTask BeginConversationByXNode(int id, object context = null)
	{
		throw new Exception("不要再用这个了");
	}

	public bool ConversationStart(int id, object context = null)
	{
		throw new Exception("不要再用这个了");
	}

	public async void JumpConversation(bool doEvent = true)
	{
		throw new Exception("不要再用这个了");
	}

	public async UniTask StartLogic(bool canOperation, bool canInterrupt, int mainId, ACT.Drama.Conversation.CharacterInfo[] characterData, LuminDialogueFlowType dialogueFlowType = LuminDialogueFlowType.None)
	{
		throw new Exception("不要再用这个了");
	}

	public async UniTask EndLogic(CancellationToken cancellationToken)
	{
		throw new Exception("不要再用这个了");
	}

	public CancellationTokenSource JumpToBranch()
	{
		throw new Exception("不要再用这个了");
	}
}
