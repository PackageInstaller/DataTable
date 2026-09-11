using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[Serializable]
[DisplayName("UI/动态代理/角色/坐标设置")]
[TrackClipType(typeof(TransformProxyNode))]
[TrackBindingType(typeof(DynamicTimelineController))]
public class TransformProxyTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		return TransformProxyMixer.Create(graph, inputCount);
	}

	protected override Playable CreatePlayable(PlayableGraph graph, GameObject go, TimelineClip clip)
	{
		if (clip.asset is TransformProxyNode transformProxyNode)
		{
			DynamicTimelineController binding = GetBinding((go != null) ? go.GetComponent<PlayableDirector>() : null);
			transformProxyNode.controller = binding;
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
