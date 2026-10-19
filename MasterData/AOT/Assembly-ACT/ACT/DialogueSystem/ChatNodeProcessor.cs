using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Core;
using ACT.Drama;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Pool;

namespace ACT.DialogueSystem;

public class ChatNodeProcessor : DialogueNodeProcessor<ChatNode>
{
	private bool m_AutoNext;

	private int m_Effect;

	private readonly StageActorState[] m_StageActorStates = new StageActorState[4];

	protected override void OnInit()
	{
		m_AutoNext = TData.autoNext;
		if (TData.noClick)
		{
			m_AutoNext = true;
		}
		m_Effect = TData.effect;
	}

	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueFlowProcessor luminFlow = Flow as LuminDialogueFlowProcessor;
		LuminDialogueContext luminContext = (LuminDialogueContext)context;
		long startTime = TimeManager.LocalTime.NowTimestamp;
		bool lastIsSkipping = luminContext.Skipping;
		int contentId = luminFlow.GetGenderContentId(TData.key);
		if (TData.important)
		{
			luminContext.Skipping = false;
		}
		if (contentId != 0)
		{
			int speakerId = 0;
			if (RuntimeConfigs.data.dialogueCharacterDatas.TryGetValue(TData.speakerId, out var value))
			{
				speakerId = value.nameLocal;
			}
			Singleton<ConversationManager>.instance.RecordHistory_Normal(luminFlow.TData.storyGroupId, TData.key, speakerId, contentId, (int)(TData.key % 1000), TData.speaker == "<playername/>");
		}
		List<MonoConversationView.OptionData> optionDatas = null;
		if (!luminContext.Skipping)
		{
			optionDatas = CollectionPool<List<MonoConversationView.OptionData>, MonoConversationView.OptionData>.Get();
		}
		int defaultOptionIndex = -1;
		for (int i = 0; i < ChildrenCount; i++)
		{
			if (GetChild(i) is ChatOptionNodeProcessor chatOptionNodeProcessor && chatOptionNodeProcessor.Check())
			{
				if (defaultOptionIndex < 0)
				{
					defaultOptionIndex = i;
				}
				if (!luminContext.Skipping)
				{
					MonoConversationView.OptionData item = new MonoConversationView.OptionData
					{
						OptionIndex = i,
						OptionId = chatOptionNodeProcessor.TData.key,
						ContentId = luminFlow.GetContentId(chatOptionNodeProcessor.TData.key),
						IconId = chatOptionNodeProcessor.TData.iconId
					};
					optionDatas.Add(item);
				}
			}
		}
		List<int> contentKeyWordIds = luminFlow?.GetKeyWords(TData.key);
		if (contentKeyWordIds != null && contentKeyWordIds.Count > 0)
		{
			UnLockTextLibraries evt = Singleton<EventManager>.instance.GetEvt<UnLockTextLibraries>();
			evt.unlockTextLibraries = contentKeyWordIds;
			evt.isFromAVG = true;
			evt.isFromAVGSkip = luminContext.Skipping;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UnLockTextLibrary, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
		if (!luminContext.Skipping)
		{
			await LuminDialogueUtility.AwaitConversationView(token);
		}
		if (!luminContext.Skipping & lastIsSkipping)
		{
			await luminContext.States.ApplyAllStates(context, token);
		}
		MonoConversationView.DialogueArg dialogueData = null;
		if (!luminContext.Skipping)
		{
			bool flag = TData.speaker == "<playername/>";
			int storySummaryContentId = (RuntimeConfigs.data.dialogueStoryGroupDatas.TryGetValue(luminFlow.TData.storyGroupId, out var value2) ? value2.storySummary : 0);
			MonoConversationView.TimelineLeftModelMode leftModelMode = MonoConversationView.TimelineLeftModelMode.NonTimeline;
			if (luminFlow.TData.dialogueType == LuminDialogueFlowType.AVG_NPC || luminFlow.TData.dialogueType == LuminDialogueFlowType.AVG_Mission)
			{
				leftModelMode = (flag ? MonoConversationView.TimelineLeftModelMode.TimelineHide : ((TData.speakerId != 0) ? MonoConversationView.TimelineLeftModelMode.TimelineShow : MonoConversationView.TimelineLeftModelMode.TimelineHide));
				if (!TData.showLeftModel)
				{
					leftModelMode = MonoConversationView.TimelineLeftModelMode.TimelineHide;
				}
			}
			dialogueData = new MonoConversationView.DialogueArg
			{
				ID = TData.key,
				StoryGroupId = luminFlow.TData.storyGroupId,
				StorySummaryContentId = storySummaryContentId,
				ContentId = contentId,
				KeyWords = contentKeyWordIds,
				VoiceIndex = (int)(TData.key % 1000),
				ContentTypeSpeed = ((TData.contentTypeSpeed < 35) ? 35 : TData.contentTypeSpeed),
				AutoNext = m_AutoNext,
				AutoNextDelay = ((TData.autoNextDelay < 0f) ? 0.5f : TData.autoNextDelay),
				OptionDatas = optionDatas,
				HideUI = TData.noUI,
				IsSubtitle = TData.subtitle,
				LeftModelMode = leftModelMode
			};
			switch (TData.imagePosition)
			{
			case ChatImagePosition.MiddleCenter:
				dialogueData.ImageOffset = 0f;
				break;
			case ChatImagePosition.MiddleLeft:
				dialogueData.ImageOffset = -250f;
				break;
			case ChatImagePosition.MiddleRight:
				dialogueData.ImageOffset = 250f;
				break;
			case ChatImagePosition.Custom:
				dialogueData.ImageOffset = TData.imageOffset;
				break;
			}
			if (flag)
			{
				dialogueData.SpeakerId = 10001;
				int[] array;
				if (TData.goldSpeakerAvatar)
				{
					array = ((G.detailUserInfo.Brief.Gender == 1) ? LuminDialogueSettings.GoldMalePlayerAvatarIds : LuminDialogueSettings.GoldFemalePlayerAvatarIds);
				}
				else
				{
					array = ((G.detailUserInfo.Brief.Gender == 1) ? LuminDialogueSettings.MalePlayerAvatarIds : LuminDialogueSettings.FemalePlayerAvatarIds);
				}
				dialogueData.SpeakerHeadId = array[TData.speakerAvatar];
				dialogueData.SpeakerNameId = 0;
				if (RuntimeConfigs.data.dialogueCharacterDatas.TryGetValue(10001, out var value3))
				{
					dialogueData.SpeakerNameId = value3.nameLocal;
				}
			}
			else
			{
				dialogueData.SpeakerId = TData.speakerId;
				dialogueData.SpeakerHeadId = 1;
				dialogueData.SpeakerNameId = 0;
				if (RuntimeConfigs.data.dialogueCharacterDatas.TryGetValue(dialogueData.SpeakerId, out var value4))
				{
					dialogueData.SpeakerNameId = value4.nameLocal;
					dialogueData.SpeakerHeadId = (value4.icon ? dialogueData.SpeakerId : dialogueData.SpeakerHeadId);
				}
			}
			LuminDialogueFlowType dialogueType = luminFlow.TData.dialogueType;
			if ((uint)(dialogueType - 4) <= 2u)
			{
				dialogueData.CanSkip = !TData.important;
			}
			if (string.IsNullOrEmpty(TData.speaker))
			{
				dialogueData.SpeakerType = 0;
			}
			else if (TData.speaker == "<playername/>")
			{
				dialogueData.SpeakerType = 1;
			}
			else
			{
				dialogueData.SpeakerType = 0;
			}
		}
		if (!luminContext.Skipping)
		{
			await LuminDialogueUtility.WhenAllPooled(InvokeStepEffects(ChatStep.OnEnter, execution, context, token), Singleton<ConversationManager>.instance.conversationView.normalView.PreShow(dialogueData));
		}
		else
		{
			await InvokeStepEffects(ChatStep.OnEnter, execution, context, token);
		}
		if (luminFlow.TData.dialogueType == LuminDialogueFlowType.AVG)
		{
			await InvokeStepEffects(ChatStep.OnBeforeUpdateScene, execution, context, token);
			if (token.IsCancellationRequested)
			{
				return DialogueNodeResult.Continue;
			}
			await LuminDialogueUtility.WhenAllPooled(InvokeStepEffects(ChatStep.OnUpdateScene, execution, context, token), UpdateSceneState(luminContext, token));
			if (token.IsCancellationRequested)
			{
				return DialogueNodeResult.Continue;
			}
			RegisterSpeakerLipSync();
			if (!luminContext.Skipping)
			{
				PlayEmoji();
			}
			await InvokeStepEffects(ChatStep.OnAfterUpdateScene, execution, context, token);
			if (token.IsCancellationRequested)
			{
				return DialogueNodeResult.Continue;
			}
		}
		LuminFlowState luminFlowState = luminContext.States.GetOrCreateState<LuminFlowState>();
		if (!luminFlowState.RootFinished)
		{
			await UniTask.WaitUntil(() => luminFlowState.RootFinished, PlayerLoopTiming.Update, token);
			if (token.IsCancellationRequested)
			{
				return DialogueNodeResult.Continue;
			}
		}
		await InvokeStepEffects(ChatStep.OnBeforeShowDialogue, execution, context, token);
		if (token.IsCancellationRequested)
		{
			return DialogueNodeResult.Continue;
		}
		ConversationTaskContext choiceTask = null;
		if (luminContext.Skipping)
		{
			await InvokeStepEffects(ChatStep.OnShowDialogue, execution, context, token);
			if (token.IsCancellationRequested)
			{
				return DialogueNodeResult.Continue;
			}
		}
		else
		{
			choiceTask = new ConversationTaskContext();
			DialogueInputHandle inputHandle = default;
			if (Singleton<ConversationManager>.instance.PlayingDialogue is IAVGDialogue iAVGDialogue)
			{
				inputHandle = iAVGDialogue.RegisterInputHandler(new DialogueInputActions(TryNext, TriggerFinish));
			}
			try
			{
				Singleton<ConversationManager>.instance.conversationView.SetUIViewData(dialogueData);
				Singleton<ConversationManager>.instance.conversationView.ShowView_V2(choiceTask).Forget();
				UniTask task = UniTask.WaitUntil(() => choiceTask.Finished, PlayerLoopTiming.Update, token).ContinueWith(() =>
				{
					if (!token.IsCancellationRequested && optionDatas.Count > 0)
					{
						Singleton<ConversationManager>.instance.RecordUsedChoice(optionDatas[choiceTask.Choice].OptionId);
						Singleton<ConversationManager>.instance.SetKeyPoint((int)optionDatas[choiceTask.Choice].OptionId);
					}
				});
				UniTask task2 = InvokeStepEffects(ChatStep.OnShowDialogue, execution, context, token);
				await LuminDialogueUtility.WhenAllPooled(task, task2).SuppressCancellationThrow();
				if (token.IsCancellationRequested)
				{
					return DialogueNodeResult.Continue;
				}
			}
			finally
			{
				inputHandle.Dispose();
			}
		}
		await InvokeStepEffects(ChatStep.OnAfterShowDialogue, execution, context, token);
		if (token.IsCancellationRequested)
		{
			return DialogueNodeResult.Continue;
		}
		await InvokeStepEffects(ChatStep.OnExit, execution, context, token);
		if (token.IsCancellationRequested)
		{
			return DialogueNodeResult.Continue;
		}
		if (luminContext.Skipping && !lastIsSkipping)
		{
			TrackDramaEvt evt2 = EventTrackSolver.Instance.GetEvt<TrackDramaEvt>();
			evt2.conversationId = luminContext.StoryGroupId;
			evt2.subId = TData.key;
			TrackDramaEvt trackDramaEvt = evt2;
			trackDramaEvt.type = luminContext.StoryGroupMode switch
			{
				LuminDialogueFlowType.AVG => 4, 
				LuminDialogueFlowType.AVG_Mission => 5, 
				LuminDialogueFlowType.AVG_NPC => 6, 
				_ => throw new ArgumentOutOfRangeException(), 
			};
			evt2.status = 2;
			evt2.conversationDuration = TimeManager.GetTimeSpan(TimeManager.LocalTime.NowTimestamp - startTime).TotalSeconds;
			evt2.isSkip = true;
			EventTrackSolver.Instance.Dispatch(evt2);
		}
		if (luminContext.Skipping)
		{
			if (defaultOptionIndex >= 0)
			{
				return await GetChild(defaultOptionIndex).Execute(execution, context, token);
			}
		}
		else if (optionDatas.Count > 0)
		{
			if (choiceTask.Choice < 0)
			{
				Debug.LogError(choiceTask.Choice);
			}
			return await GetChild(optionDatas[choiceTask.Choice].OptionIndex).Execute(execution, context, token);
		}
		return DialogueNodeResult.Continue;
		void TriggerFinish()
		{
			choiceTask.Choice = 0;
			choiceTask.Finish();
			Singleton<ConversationManager>.instance.conversationView.normalView.TriggerFinish();
		}
		bool TryNext()
		{
			if (!TData.noClick)
			{
				Singleton<ConversationManager>.instance.conversationView.normalView.ManualClicked();
			}
			return true;
		}
	}

	private async UniTask InvokeStepEffects(ChatStep step, DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		List<UniTask> tasks = null;
		try
		{
			for (int i = 0; i < ChildrenCount; i++)
			{
				if (GetChild(i) is IChatStepEventNode chatStepEventNode)
				{
					if (tasks == null)
					{
						tasks = CollectionPool<List<UniTask>, UniTask>.Get();
					}
					tasks.Add(chatStepEventNode.ExecuteStepEvent(step, execution, context, token));
				}
			}
			if (tasks != null)
			{
				await UniTask.WhenAll(tasks).SuppressCancellationThrow();
			}
		}
		finally
		{
			if (tasks != null)
			{
				CollectionPool<List<UniTask>, UniTask>.Release(tasks);
			}
		}
	}

	private void PlayEmoji()
	{
		UIConversationScene instance = UIConversationScene.Instance;
		MonoConversationEmojiLayer monoConversationEmojiLayer = Singleton<ConversationManager>.instance?.conversationView?.emoji;
		if ((bool)instance && (bool)monoConversationEmojiLayer)
		{
			PlayEmoji(0, TData.emoji1, instance, monoConversationEmojiLayer);
			PlayEmoji(1, TData.emoji2, instance, monoConversationEmojiLayer);
			PlayEmoji(2, TData.emoji3, instance, monoConversationEmojiLayer);
			PlayEmoji(3, TData.emoji4, instance, monoConversationEmojiLayer);
		}
	}

	private static void PlayEmoji(int actorIndex, int emojiId, UIConversationScene conversationScene, MonoConversationEmojiLayer emojiLayer)
	{
		if (emojiId > 0 && conversationScene.TryGetActorHeadTransform(actorIndex, out var headTransform))
		{
			emojiLayer.Play(emojiId, headTransform);
		}
	}

	private void RegisterSpeakerLipSync()
	{
		UIConversationScene instance = UIConversationScene.Instance;
		if ((bool)instance)
		{
			int num = TData.speakerId;
			if (num == 10001)
			{
				num = ((G.detailUserInfo.Brief.Gender == 1) ? 10002 : 10001);
			}
			instance.RegisterLipSyncBySpeaker(num);
		}
	}

	private async UniTask UpdateSceneState(LuminDialogueContext luminContext, CancellationToken token)
	{
		List<UniTask> tasks = CollectionPool<List<UniTask>, UniTask>.Get();
		bool skipping = luminContext.Skipping;
		try
		{
			ActorsState orCreateState = luminContext.States.GetOrCreateState<ActorsState>();
			m_StageActorStates[0] = new StageActorState
			{
				actor = TData.actor1,
				actorAnimName = TData.actorAnim1s,
				actorFaceName = TData.actorFace1s,
				lookAtType = TData.actorLookAtType1,
				rotationYOffset = TData.actorRotationYOffset1,
				positionOffset = TData.actorPositionOffset1,
				scaleOffset = TData.actorScaleOffset1,
				emoji = TData.emoji1
			};
			m_StageActorStates[1] = new StageActorState
			{
				actor = TData.actor2,
				actorAnimName = TData.actorAnim2s,
				actorFaceName = TData.actorFace2s,
				lookAtType = TData.actorLookAtType2,
				rotationYOffset = TData.actorRotationYOffset2,
				positionOffset = TData.actorPositionOffset2,
				scaleOffset = TData.actorScaleOffset2,
				emoji = TData.emoji2
			};
			m_StageActorStates[2] = new StageActorState
			{
				actor = TData.actor3,
				actorAnimName = TData.actorAnim3s,
				actorFaceName = TData.actorFace3s,
				lookAtType = TData.actorLookAtType3,
				rotationYOffset = TData.actorRotationYOffset3,
				positionOffset = TData.actorPositionOffset3,
				scaleOffset = TData.actorScaleOffset3,
				emoji = TData.emoji3
			};
			m_StageActorStates[3] = new StageActorState
			{
				actor = TData.actor4,
				actorAnimName = TData.actorAnim4s,
				actorFaceName = TData.actorFace4s,
				lookAtType = TData.actorLookAtType4,
				rotationYOffset = TData.actorRotationYOffset4,
				positionOffset = TData.actorPositionOffset4,
				scaleOffset = TData.actorScaleOffset4,
				emoji = TData.emoji4
			};
			tasks.Add(orCreateState.ApplyChange(TData.stageMode, m_StageActorStates, token, skipping));
			EffectState orCreateState2 = luminContext.States.GetOrCreateState<EffectState>();
			tasks.Add(orCreateState2.SetEffect(m_Effect, token, skipping));
			await UniTask.WhenAll(tasks).SuppressCancellationThrow();
			if (!skipping)
			{
				luminContext.UpdateSceneCompleted();
			}
		}
		finally
		{
			CollectionPool<List<UniTask>, UniTask>.Release(tasks);
		}
	}
}
