using System;
using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[Serializable]
public class StartAnimationClipBehaviour : PlayableBehaviour
{
	public AnimationClip animationClip;

	public AnimationPlayableAsset.LoopMode loop;

	[NonSerialized]
	public Playable animationPlayable;

	[NonSerialized]
	public AnimationMixerPlayable animationMixerPlayable;

	[NonSerialized]
	public int index = -1;

	private double m_Time;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		base.OnBehaviourPlay(playable, info);
		if (animationPlayable.IsValid() && info.deltaTime != 0f)
		{
			m_Time = 0.0;
			animationPlayable.SetSpeed((loop == AnimationPlayableAsset.LoopMode.UseSourceAsset) ? info.effectiveSpeed : 0f);
			animationPlayable.SetTime(0.0);
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		base.OnBehaviourPause(playable, info);
		if (info.deltaTime != 0f)
		{
			m_Time = 0.0;
			if (animationPlayable.IsValid())
			{
				animationPlayable.SetSpeed(0.0);
				animationPlayable.SetTime(0.0);
			}
			SetMixerWeight(0f);
		}
	}

	public override void PrepareFrame(Playable playable, FrameData info)
	{
		UpdatePlayable(playable, info);
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		SetMixerWeight(info.weight);
	}

	private void UpdatePlayable(Playable playable, FrameData info)
	{
		if (!animationPlayable.IsValid())
		{
			return;
		}
		SetMixerWeight(info.weight);
		if (ShouldSamplePose())
		{
			SamplePose(playable);
			return;
		}
		if (loop == AnimationPlayableAsset.LoopMode.UseSourceAsset)
		{
			animationPlayable.SetSpeed(info.effectiveSpeed);
			return;
		}
		animationPlayable.SetSpeed(0.0);
		if (animationClip == null || info.deltaTime == 0f)
		{
			return;
		}
		float length = animationClip.length;
		if ((double)length <= double.Epsilon)
		{
			return;
		}
		m_Time += info.deltaTime * info.effectiveSpeed;
		if (loop == AnimationPlayableAsset.LoopMode.On)
		{
			while (m_Time < 0.0)
			{
				m_Time += length;
			}
			m_Time %= length;
		}
		else
		{
			m_Time = Math.Max(0.0, Math.Min(m_Time, length));
		}
		animationPlayable.SetTime(m_Time);
	}

	private void SetMixerWeight(float weight)
	{
		if (animationMixerPlayable.IsValid() && index >= 0 && index < animationMixerPlayable.GetInputCount())
		{
			animationMixerPlayable.SetInputWeight(index, weight);
		}
	}

	private bool ShouldSamplePose()
	{
		return !Application.isPlaying;
	}

	private void SamplePose(Playable playable)
	{
		animationPlayable.SetSpeed(0.0);
		if (!(animationClip == null))
		{
			float length = animationClip.length;
			if (!((double)length <= double.Epsilon))
			{
				animationPlayable.SetTime(GetPoseTime(playable.GetTime(), length));
			}
		}
	}

	private double GetPoseTime(double time, double length)
	{
		if (loop == AnimationPlayableAsset.LoopMode.On || (loop == AnimationPlayableAsset.LoopMode.UseSourceAsset && animationClip.isLooping))
		{
			time %= length;
			if (time < 0.0)
			{
				time += length;
			}
			return time;
		}
		return Math.Max(0.0, Math.Min(time, length));
	}
}
