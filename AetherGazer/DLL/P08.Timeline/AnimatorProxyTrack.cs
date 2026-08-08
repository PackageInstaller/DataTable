using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[Serializable]
[DisplayName("UI/动态代理/角色/动画混合")]
[TrackClipType(typeof(AnimatorProxyNode))]
[TrackBindingType(typeof(DynamicTimelineController))]
public class AnimatorProxyTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		return AnimatorProxyMixer.Create(graph, inputCount);
	}

	protected override Playable CreatePlayable(PlayableGraph graph, GameObject go, TimelineClip clip)
	{
		if (clip.asset is AnimatorProxyNode animatorProxyNode)
		{
			DynamicTimelineController binding = GetBinding((go != null) ? go.GetComponent<PlayableDirector>() : null);
			animatorProxyNode.controller = binding;
		}
		return base.CreatePlayable(graph, go, clip);
	}

	internal DynamicTimelineController GetBinding(PlayableDirector director)
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
		DynamicTimelineController dynamicTimelineController = null;
		if (obj != null)
		{
			dynamicTimelineController = obj as DynamicTimelineController;
			GameObject gameObject = obj as GameObject;
			if (dynamicTimelineController == null && gameObject != null)
			{
				dynamicTimelineController = gameObject.GetComponent<DynamicTimelineController>();
			}
		}
		return dynamicTimelineController;
	}
}
