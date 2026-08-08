using System;
using Animancer;
using UnityEngine;
using UnityEngine.Playables;

[Serializable]
public class AnimancerPlayClipBehaviour : PlayableBehaviour
{
	[SerializeField]
	private AnimancerComponent animancer;

	private AnimancerState animancerState;

	public Animator m_animatior;

	public float m_speed;

	private Playable StatePlayable => animancerState.Playable;

	private AnimancerLayer Layer => animancer.Layers.get_Item(layer);

	public int layer { get; set; }

	public float blendTime { get; set; }

	public AnimationClip clip { get; set; }

	public AvatarMask avatarMask { get; set; }

	public override void OnGraphStart(Playable playable)
	{
		base.OnGraphStart(playable);
		if (!m_animatior.TryGetComponent<AnimancerComponent>(out animancer))
		{
			animancer = m_animatior.gameObject.AddComponent<AnimancerComponent>();
		}
	}

	public override void OnBehaviourPlay(Playable playable, FrameData inf)
	{
		if (!(null == m_animatior) && Application.isPlaying)
		{
			if (!LuaForUtil.IsManualAnimatorBlend)
			{
				blendTime = 0f;
			}
			double time = playable.GetTime();
			AnimancerLayer animancerLayer = animancer.Layers.get_Item(layer);
			animancerLayer.Mask = avatarMask;
			animancerState = animancerLayer.Play(clip, blendTime);
			StatePlayable.SetTime(time);
			StatePlayable.SetSpeed(m_speed);
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		_ = layer;
	}

	public override void PrepareFrame(Playable playable, FrameData info)
	{
		base.PrepareFrame(playable, info);
		if (AnimancerUtilities.IsValid(animancerState) && animancerState.IsActive)
		{
			animancerState.Speed = m_speed;
			animancerState.TimeD = playable.GetTime();
		}
	}
}
