using System;
using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[Serializable]
public class StartAnimationClip : PlayableAsset, ITimelineClipAsset
{
	[SerializeField]
	private AnimationClip m_Clip;

	[SerializeField]
	private bool m_ApplyFootIK = true;

	[SerializeField]
	private AnimationPlayableAsset.LoopMode m_Loop;

	public ClipCaps clipCaps => ClipCaps.SpeedMultiplier | ClipCaps.Blending;

	public AnimationClip clip
	{
		get
		{
			return m_Clip;
		}
		set
		{
			if (value != null)
			{
				name = "StartAnimationClip of " + value.name;
			}
			m_Clip = value;
		}
	}

	public bool applyFootIK => m_ApplyFootIK;

	public AnimationPlayableAsset.LoopMode loop => m_Loop;

	public override double duration
	{
		get
		{
			if (!(m_Clip != null))
			{
				return base.duration;
			}
			return m_Clip.length;
		}
	}

	public override Playable CreatePlayable(PlayableGraph graph, GameObject go)
	{
		ScriptPlayable<StartAnimationClipBehaviour> scriptPlayable = ScriptPlayable<StartAnimationClipBehaviour>.Create(graph, new StartAnimationClipBehaviour
		{
			animationClip = m_Clip,
			loop = m_Loop
		});
		StartAnimationClipBehaviour behaviour = scriptPlayable.GetBehaviour();
		if (m_Clip != null)
		{
			AnimationClipPlayable animationClipPlayable = AnimationClipPlayable.Create(graph, m_Clip);
			animationClipPlayable.SetApplyFootIK(m_ApplyFootIK);
			animationClipPlayable.SetSpeed(0.0);
			animationClipPlayable.SetTime(0.0);
			behaviour.animationPlayable = animationClipPlayable;
		}
		return scriptPlayable;
	}
}
