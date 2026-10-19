using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Drama;
using ACT.EventTrack;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine.Pool;

namespace ACT.DialogueSystem;

public class BlackScreenNodeProcessor : DialogueNodeProcessor<BlackScreenNode>
{
	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueFlowProcessor luminFlow = (LuminDialogueFlowProcessor)Flow;
		LuminDialogueContext luminContext = context as LuminDialogueContext;
		MonoConversationView conversationView = Singleton<ConversationManager>.instance.conversationView;
		bool lastIsSkipping = luminContext.Skipping;
		int contentId = luminFlow.GetContentId(TData.key);
		if (contentId != 0)
		{
			Singleton<ConversationManager>.instance.RecordHistory_Normal(luminFlow.TData.storyGroupId, TData.key, 0, contentId, (int)(TData.key % 1000), isPlayer: false);
		}
		long startTime = TimeManager.LocalTime.NowTimestamp;
		if (luminContext.Skipping)
		{
			for (int i = 0; i < ChildrenCount; i++)
			{
				await GetChild(i).Execute(execution, context, token);
			}
			return DialogueNodeResult.Continue;
		}
		conversationView.blackScreen.Show(TData.speed).Forget();
		await LuminDialogueUtility.WaitForSecondsOrForceNext(TData.speed, token, () =>
		{
			conversationView?.blackScreen?.ForceShow();
		});
		List<UniTask> tasks = CollectionPool<List<UniTask>, UniTask>.Get();
		try
		{
			tasks.Add(Singleton<ConversationManager>.instance.conversationView.normalView.HideAndClearContent());
			for (int num = 0; num < ChildrenCount; num++)
			{
				DialogueNodeProcessor child = GetChild(num);
				tasks.Add(child.Execute(execution, context, token));
			}
			conversationView.blackScreen.SetText(luminFlow.GetContentId(TData.key));
			await UniTask.WhenAll(tasks);
		}
		finally
		{
			CollectionPool<List<UniTask>, UniTask>.Release(tasks);
		}
		await LuminDialogueUtility.WaitUntilOrInput(() => (bool)conversationView && conversationView.blackScreen.typeWriter.IsFinished, token, () =>
		{
			conversationView?.blackScreen?.typeWriter?.StopTweenString();
			return true;
		}, () =>
		{
			conversationView?.blackScreen?.typeWriter?.StopTweenString();
		});
		await LuminDialogueUtility.WaitForSecondsOrInput(TData.duration, token, () => true);
		if (TData.waitOut)
		{
			conversationView.blackScreen.Hide(TData.speed).Forget();
			await LuminDialogueUtility.WaitForSecondsOrForceNext(TData.speed, token, () =>
			{
				conversationView?.blackScreen?.ForceHide();
			});
		}
		else
		{
			conversationView.blackScreen.Hide(TData.speed).Forget();
		}
		if (!lastIsSkipping && luminContext.Skipping && TData.key > 0)
		{
			TrackDramaEvt evt = EventTrackSolver.Instance.GetEvt<TrackDramaEvt>();
			evt.conversationId = luminContext.StoryGroupId;
			evt.subId = TData.key;
			TrackDramaEvt trackDramaEvt = evt;
			trackDramaEvt.type = luminContext.StoryGroupMode switch
			{
				LuminDialogueFlowType.AVG => 4, 
				LuminDialogueFlowType.AVG_Mission => 5, 
				LuminDialogueFlowType.AVG_NPC => 6, 
				_ => throw new ArgumentOutOfRangeException(), 
			};
			evt.status = 2;
			evt.conversationDuration = TimeManager.GetTimeSpan(TimeManager.LocalTime.NowTimestamp - startTime).TotalSeconds;
			evt.isSkip = true;
			EventTrackSolver.Instance.Dispatch(evt);
		}
		return DialogueNodeResult.Continue;
	}
}
