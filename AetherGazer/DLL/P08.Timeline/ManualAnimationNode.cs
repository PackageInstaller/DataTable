using System;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[Serializable]
public class ManualAnimationNode : PlayableAsset, ITimelineClipAsset
{
	public AnimationClip m_clip;

	public float m_blendTime = 0.3f;

	public Animator animator;

	[NonSerialized]
	[HideInInspector]
	public double speed;

	public ClipCaps clipCaps => ClipCaps.ClipIn | ClipCaps.SpeedMultiplier;

	public override double duration
	{
		get
		{
			if (m_clip != null)
			{
				return m_clip.length;
			}
			return 1.0;
		}
	}

	public AnimationClip curves
	{
		get
		{
			return m_clip;
		}
		internal set
		{
			m_clip = value;
		}
	}

	public override Playable CreatePlayable(PlayableGraph graph, GameObject go)
	{
		if (m_clip == null || m_clip.legacy)
		{
			return Playable.Null;
		}
		ScriptPlayable<ManualAnimationBehaviour> scriptPlayable = ScriptPlayable<ManualAnimationBehaviour>.Create(graph);
		ManualAnimationBehaviour behaviour = scriptPlayable.GetBehaviour();
		if (behaviour != null)
		{
			behaviour.m_clip = m_clip;
			behaviour.m_blendTime = m_blendTime;
			behaviour.m_animatior = animator;
			behaviour.m_speed = speed;
		}
		return scriptPlayable;
	}
}
