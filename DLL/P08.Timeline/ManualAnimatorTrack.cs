using System;
using System.Collections.Generic;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[Serializable]
[DisplayName("DLC配置/Animator混合轨道")]
[TrackClipType(typeof(ManualAnimationNode), false)]
[TrackBindingType(typeof(Animator))]
[TrackColor(0.39f, 0.2f, 0.53f)]
public class ManualAnimatorTrack : TrackAsset
{
	public override IEnumerable<PlayableBinding> outputs
	{
		get
		{
			if (!Application.isPlaying)
			{
				yield return AnimationPlayableBinding.Create(base.name, this);
			}
			else
			{
				yield return ScriptPlayableBinding.Create(base.name, this, null);
			}
		}
	}

	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		if (!Application.isPlaying)
		{
			return AnimationMixerPlayable.Create(graph, inputCount);
		}
		return Playable.Create(graph, inputCount);
	}

	protected override Playable CreatePlayable(PlayableGraph graph, GameObject go, TimelineClip clip)
	{
		if (clip.asset is ManualAnimationNode manualAnimationNode)
		{
			Animator binding = GetBinding((go != null) ? go.GetComponent<PlayableDirector>() : null);
			manualAnimationNode.animator = binding;
			manualAnimationNode.speed = clip.timeScale;
		}
		return base.CreatePlayable(graph, go, clip);
	}

	internal Animator GetBinding(PlayableDirector director)
	{
		if (director == null)
		{
			return null;
		}
		UnityEngine.Object key = this;
		if (base.isSubTrack)
		{
			key = base.parent;
		}
		UnityEngine.Object obj = null;
		if (director != null)
		{
			obj = director.GetGenericBinding(key);
		}
		Animator animator = null;
		if (obj != null)
		{
			animator = obj as Animator;
			GameObject gameObject = obj as GameObject;
			if (animator == null && gameObject != null)
			{
				animator = gameObject.GetComponent<Animator>();
			}
		}
		return animator;
	}
}
