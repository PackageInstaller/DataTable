using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

public class AnimancerPlayClipNode : PlayableAsset, ITimelineClipAsset
{
	public int layer;

	public AvatarMask avatarMask;

	public AnimationClip clip;

	public float blendTime = 0.3f;

	public Animator animator;

	public AnimancerPlayClipBehaviour template;

	public ClipCaps clipCaps
	{
		get
		{
			ClipCaps clipCaps = ClipCaps.Extrapolation | ClipCaps.ClipIn | ClipCaps.SpeedMultiplier;
			if ((bool)clip && clip.isLooping)
			{
				clipCaps |= ClipCaps.Looping;
			}
			return clipCaps;
		}
	}

	public override double duration
	{
		get
		{
			if (clip != null)
			{
				return clip.length;
			}
			return 1.0;
		}
	}

	public AnimationClip curves
	{
		get
		{
			return clip;
		}
		internal set
		{
			clip = value;
		}
	}

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<AnimancerPlayClipBehaviour> scriptPlayable = ScriptPlayable<AnimancerPlayClipBehaviour>.Create(graph, template);
		AnimancerPlayClipBehaviour behaviour = scriptPlayable.GetBehaviour();
		if (behaviour != null)
		{
			behaviour.m_animatior = animator;
			behaviour.layer = layer;
			behaviour.avatarMask = avatarMask;
			behaviour.clip = clip;
			behaviour.blendTime = blendTime;
		}
		return scriptPlayable;
	}
}
