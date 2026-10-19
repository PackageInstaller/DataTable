using System.Threading;
using Cysharp.Threading.Tasks;
using Spine;
using Spine.Unity;
using UnityEngine;

namespace ACT.DialogueSystem;

public class SpineChangeAnimStepEventNodeProcessor : ChatStepEventNodeProcessor<SpineChangeAnimStepEventNode>
{
	protected override UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if (!(context as LuminDialogueContext).Skipping)
		{
			PlaySpineAnimation(TData.animationName, TData.loop, TData.trackIndex, TData.clearTracks, TData.mixDuration);
		}
		return UniTask.FromResult(DialogueNodeResult.Continue);
	}

	public override UniTask ExecuteStepEvent(ChatStep chatStep, DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if ((chatStep & TData.step) == 0)
		{
			return UniTask.CompletedTask;
		}
		return Execute(execution, context, token);
	}

	private static void PlaySpineAnimation(string animationName, bool loop, int trackIndex, bool clearTracks, float mixDuration)
	{
		if (string.IsNullOrEmpty(animationName))
		{
			return;
		}
		UIConversationScene instance = UIConversationScene.Instance;
		if (!instance)
		{
			return;
		}
		SkeletonAnimation skeletonAnimation = instance.GetComponent<SkeletonAnimation>();
		if (!skeletonAnimation)
		{
			skeletonAnimation = instance.GetComponentInChildren<SkeletonAnimation>(includeInactive: true);
		}
		if ((bool)skeletonAnimation)
		{
			Play(skeletonAnimation, animationName, loop, trackIndex, clearTracks, mixDuration);
			return;
		}
		SkeletonGraphic skeletonGraphic = instance.GetComponent<SkeletonGraphic>();
		if (!skeletonGraphic)
		{
			skeletonGraphic = instance.GetComponentInChildren<SkeletonGraphic>(includeInactive: true);
		}
		if ((bool)skeletonGraphic)
		{
			Play(skeletonGraphic, animationName, loop, trackIndex, clearTracks, mixDuration);
		}
		else
		{
			Debug.LogWarning("No Spine component found on UIConversationScene.");
		}
	}

	private static void Play(SkeletonAnimation skeletonAnimation, string animationName, bool loop, int trackIndex, bool clearTracks, float mixDuration)
	{
		if (skeletonAnimation.AnimationState == null || skeletonAnimation.Skeleton == null)
		{
			skeletonAnimation.Initialize(overwrite: true);
		}
		Play(skeletonAnimation.AnimationState, animationName, loop, trackIndex, clearTracks, mixDuration);
	}

	private static void Play(SkeletonGraphic skeletonGraphic, string animationName, bool loop, int trackIndex, bool clearTracks, float mixDuration)
	{
		if (skeletonGraphic.AnimationState == null || skeletonGraphic.Skeleton == null)
		{
			skeletonGraphic.Initialize(overwrite: true);
		}
		Play(skeletonGraphic.AnimationState, animationName, loop, trackIndex, clearTracks, mixDuration);
	}

	private static void Play(Spine.AnimationState animationState, string animationName, bool loop, int trackIndex, bool clearTracks, float mixDuration)
	{
		if (animationState == null)
		{
			return;
		}
		Spine.Animation animation = animationState.Data.SkeletonData.FindAnimation(animationName);
		if (animation == null)
		{
			Debug.LogWarning("Spine animation not found: " + animationName);
			return;
		}
		trackIndex = Mathf.Max(0, trackIndex);
		if (clearTracks)
		{
			animationState.ClearTracks();
		}
		else
		{
			animationState.ClearTrack(trackIndex);
		}
		animationState.SetAnimation(trackIndex, animation, loop).MixDuration = Mathf.Max(0f, mixDuration);
	}
}
