using System;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[Serializable]
[TrackClipType(typeof(StartAnimationClip))]
[TrackBindingType(typeof(Animator))]
public class StartAnimationTrackAsset : TrackAsset
{
	[SerializeField]
	private bool m_ApplyAvatarMask = true;

	[SerializeField]
	private AvatarMask m_AvatarMask;

	public AvatarMask avatarMask
	{
		get
		{
			return m_AvatarMask;
		}
		set
		{
			m_AvatarMask = value;
		}
	}

	public bool applyAvatarMask
	{
		get
		{
			return m_ApplyAvatarMask;
		}
		set
		{
			m_ApplyAvatarMask = value;
		}
	}

	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		PlayableDirector director = ((go != null) ? go.GetComponent<PlayableDirector>() : null);
		Animator binding = GetBinding(director);
		StartAnimationTrackBehaviour startAnimationTrackBehaviour = new StartAnimationTrackBehaviour();
		startAnimationTrackBehaviour.animator = binding;
		startAnimationTrackBehaviour.avatarMask = m_AvatarMask;
		startAnimationTrackBehaviour.applyAvatarMask = m_ApplyAvatarMask;
		startAnimationTrackBehaviour.trackAsset = this;
		return ScriptPlayable<StartAnimationTrackBehaviour>.Create(graph, startAnimationTrackBehaviour, inputCount);
	}

	internal Animator GetBinding(PlayableDirector director)
	{
		if (director == null)
		{
			return null;
		}
		UnityEngine.Object key = this;
		if (isSubTrack)
		{
			key = parent;
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
