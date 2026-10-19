using System;
using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;

namespace ACT.Timeline;

[Serializable]
public class AssetAnimationBehaviour : PlayableBehaviour
{
	public AnimationClip animationClip;

	[NonSerialized]
	public AnimationClipPlayable animationClipPlayable;

	[NonSerialized]
	public AnimationMixerPlayable animationMixerPlayable;

	[NonSerialized]
	public int index;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		base.OnBehaviourPlay(playable, info);
		if (animationClipPlayable.IsValid() && info.deltaTime != 0f)
		{
			animationClipPlayable.SetSpeed(1.0);
			animationClipPlayable.SetTime(0.0);
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		base.OnBehaviourPause(playable, info);
		if (animationClipPlayable.IsValid() && info.deltaTime != 0f)
		{
			animationClipPlayable.SetSpeed(0.0);
			animationClipPlayable.SetTime(0.0);
			animationMixerPlayable.SetInputWeight(index, 0f);
		}
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (animationMixerPlayable.IsValid())
		{
			animationMixerPlayable.SetInputWeight(index, info.weight);
		}
	}
}
