using System;
using System.Threading;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Core;
using ACT.DialogueSystem;
using ACT.Event;
using ACT.EventTrack;
using ACT.UI;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Drama;

public class AVGDialogueFromId : DialogueWrapper, IAVGDialogue
{
	public struct Options
	{
		public bool BlackScreen;

		public float FadeInTime;

		public float FadeOutTime;

		public bool WaitIdle;
	}

	private Options m_Options;

	private readonly int m_StoryGroupId;

	private readonly ConversationManager.ConversationTriggerSource m_TriggerSource;

	private long m_StartStamp;

	private LuminDialogueFlowType m_StoryGroupMode;

	private AssetLoadHandle m_AssetHandle;

	private GameObject m_DialogueInstance;

	private DialogueEnvironment m_DialogueEnvironment;

	private LuminDialogueContext m_Context;

	private bool m_IsRunning;

	private bool m_BeginSkipRunning;

	public long SkipToNode;

	public int StoryGroupId => m_StoryGroupId;

	public bool IsRunning
	{
		get
		{
			if (m_IsRunning)
			{
				return IsPlaying();
			}
			return false;
		}
	}

	public event Func<CancellationToken, UniTask> OnBegin;

	public event Func<CancellationToken, UniTask> OnEnd;

	public AVGDialogueFromId(int storyGroupId, ConversationManager.ConversationTriggerSource triggerSource, Options options)
	{
		m_StoryGroupId = storyGroupId;
		m_TriggerSource = triggerSource;
		m_Options = options;
	}

	protected override async UniTask Play(CancellationToken token)
	{
		if (!RuntimeConfigs.data.dialogueStoryGroupDatas.TryGetValue(m_StoryGroupId, out var storyGroupData))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"没有找到{m_StoryGroupId}对话");
			}
			return;
		}
		if (m_Options.BlackScreen)
		{
			Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(0, 0f);
			await Singleton<NewUIManager>.instance.BlackScreen.Enable(new FrameworkBlackScreenData
			{
				fadeInTime = TimeSpan.FromSeconds(m_Options.FadeInTime),
				fadeOutTime = TimeSpan.FromSeconds(m_Options.FadeOutTime)
			});
		}
		m_StoryGroupMode = (LuminDialogueFlowType)storyGroupData.mode;
		m_StartStamp = TimeManager.LocalTime.NowTimestamp;
		m_IsRunning = true;
		ConversationAVGStartEvt evt = Singleton<EventManager>.instance.GetEvt<ConversationAVGStartEvt>();
		evt.conversationId = m_StoryGroupId;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Conversation_AVG_Start, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		SendBeginEvent();
		m_AssetHandle = AssetStationManager.BattleStation.InstantiateAsync(storyGroupData.path);
		UniTask<bool> uniTask = m_AssetHandle.ToUniTask(PlayerLoopTiming.Update, token).SuppressCancellationThrow();
		UniTask uniTask2 = UniTask.CompletedTask;
		UniTask uniTask3 = UniTask.CompletedTask;
		UniTask uniTask4 = UniTask.CompletedTask;
		if (OnBegin != null)
		{
			uniTask2 = OnBegin(token);
		}
		if (m_TriggerSource == ConversationManager.ConversationTriggerSource.Mission)
		{
			Singleton<NewUIManager>.instance.CloseAllUI();
			uniTask3 = UniTask.WaitForSeconds(0.5f, ignoreTimeScale: false, PlayerLoopTiming.Update, token);
			if (m_Options.WaitIdle)
			{
				UniTask uniTask5 = UniTask.WaitForSeconds(2, ignoreTimeScale: false, PlayerLoopTiming.Update, token);
				uniTask4 = UniTask.WhenAny(WaitIdle(token), uniTask5);
			}
		}
		await UniTask.WhenAll(uniTask3, uniTask4, uniTask2, uniTask);
		m_DialogueInstance = m_AssetHandle.AsGameObject();
		m_DialogueEnvironment = m_DialogueInstance.GetComponent<DialogueEnvironment>();
		if (token.IsCancellationRequested)
		{
			if ((bool)m_DialogueInstance)
			{
				AssetStationManager.BattleStation.ReleaseInstance(m_DialogueInstance);
			}
			return;
		}
		m_Context = new LuminDialogueContext(m_StoryGroupId, m_StoryGroupMode, m_TriggerSource, m_DialogueEnvironment);
		await m_DialogueEnvironment.PlayAsync(m_Context, token).SuppressCancellationThrow();
		if ((bool)m_DialogueInstance)
		{
			AssetStationManager.BattleStation.ReleaseInstance(m_DialogueInstance);
		}
		if (OnEnd != null)
		{
			await OnEnd(token);
		}
		SendEndEvent();
		m_IsRunning = false;
		ConversationAVGEndEvt evt2 = Singleton<EventManager>.instance.GetEvt<ConversationAVGEndEvt>();
		evt2.conversationId = m_StoryGroupId;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Conversation_AVG_End, evt2);
		Singleton<EventManager>.instance.ReleaseEvt(evt2);
	}

	private async UniTask WaitIdle(CancellationToken token)
	{
		await UniTask.WaitUntil(() =>
		{
			if (!MonoECS.instance)
			{
				return false;
			}
			Entity mainEntity = MonoECS.instance.mainEntity;
			if (mainEntity == null)
			{
				return false;
			}
			CompMotion compMotion = mainEntity.GetCompMotion();
			CompPhysics compPhysics = mainEntity.GetCompPhysics();
			if (compMotion == null || compPhysics == null)
			{
				return false;
			}
			return compMotion.curMotionState == MotionState.Idle && compPhysics.isGrounded;
		}, PlayerLoopTiming.Update, token);
	}

	private void SendBeginEvent()
	{
		TrackDramaEvt evt = EventTrackSolver.Instance.GetEvt<TrackDramaEvt>();
		evt.conversationId = m_StoryGroupId;
		evt.subId = 0L;
		TrackDramaEvt trackDramaEvt = evt;
		trackDramaEvt.type = m_StoryGroupMode switch
		{
			LuminDialogueFlowType.AVG => 4, 
			LuminDialogueFlowType.AVG_Mission => 5, 
			LuminDialogueFlowType.AVG_NPC => 6, 
			_ => throw new ArgumentOutOfRangeException(), 
		};
		evt.status = 1;
		evt.conversationDuration = 0.0;
		evt.isSkip = false;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	private void SendEndEvent()
	{
		TrackDramaEvt evt = EventTrackSolver.Instance.GetEvt<TrackDramaEvt>();
		evt.conversationId = m_StoryGroupId;
		evt.subId = 0L;
		TrackDramaEvt trackDramaEvt = evt;
		trackDramaEvt.type = m_StoryGroupMode switch
		{
			LuminDialogueFlowType.AVG => 4, 
			LuminDialogueFlowType.AVG_Mission => 5, 
			LuminDialogueFlowType.AVG_NPC => 6, 
			_ => throw new ArgumentOutOfRangeException(), 
		};
		evt.status = 2;
		evt.conversationDuration = TimeManager.GetTimeSpan(TimeManager.LocalTime.NowTimestamp - m_StartStamp).TotalSeconds;
		evt.isSkip = m_Context.Skipping;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	async UniTask IAVGDialogue.BeginSkip()
	{
		if (m_Context == null)
		{
			ForceNext();
		}
		else
		{
			if (m_BeginSkipRunning)
			{
				return;
			}
			if (m_Context.SkipRequested)
			{
				ForceNext();
			}
			else
			{
				if (m_BeginSkipRunning)
				{
					return;
				}
				m_BeginSkipRunning = true;
				try
				{
					if (m_Context != null)
					{
						await m_Context.BeginSkip();
					}
				}
				finally
				{
					m_BeginSkipRunning = false;
					ForceNext();
				}
			}
		}
	}

	protected override void Skip()
	{
		((IAVGDialogue)this).BeginSkip();
	}
}
