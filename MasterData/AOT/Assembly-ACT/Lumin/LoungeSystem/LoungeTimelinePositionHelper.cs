using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Lumin.LoungeSystem;

public static class LoungeTimelinePositionHelper
{
	public static Dictionary<Transform, (Vector3 position, Quaternion rotation)> GetAllBindingTransforms(PlayableDirector director)
	{
		Dictionary<Transform, (Vector3, Quaternion)> dictionary = new Dictionary<Transform, (Vector3, Quaternion)>();
		if (director == null || director.playableAsset == null)
		{
			return dictionary;
		}
		TimelineAsset timelineAsset = director.playableAsset as TimelineAsset;
		if (timelineAsset == null)
		{
			return dictionary;
		}
		foreach (TrackAsset outputTrack in timelineAsset.GetOutputTracks())
		{
			if (outputTrack is AnimationTrack)
			{
				Transform transformFromBinding = GetTransformFromBinding(director.GetGenericBinding(outputTrack));
				if (transformFromBinding != null && !dictionary.ContainsKey(transformFromBinding))
				{
					dictionary[transformFromBinding] = (transformFromBinding.position, transformFromBinding.rotation);
				}
			}
		}
		return dictionary;
	}

	public static (Vector3 position, Quaternion rotation) GetTrackBindingTransform(PlayableDirector director, string trackName)
	{
		if (director == null || director.playableAsset == null)
		{
			return (position: Vector3.zero, rotation: Quaternion.identity);
		}
		TimelineAsset timelineAsset = director.playableAsset as TimelineAsset;
		if (timelineAsset == null)
		{
			return (position: Vector3.zero, rotation: Quaternion.identity);
		}
		foreach (TrackAsset outputTrack in timelineAsset.GetOutputTracks())
		{
			if (outputTrack.name == trackName)
			{
				Transform transformFromBinding = GetTransformFromBinding(director.GetGenericBinding(outputTrack));
				if (transformFromBinding != null)
				{
					return (position: transformFromBinding.position, rotation: transformFromBinding.rotation);
				}
			}
		}
		return (position: Vector3.zero, rotation: Quaternion.identity);
	}

	public static (Vector3 position, Quaternion rotation) GetTrackClipInitialPose(PlayableDirector director, string trackName, GameObject go)
	{
		if (director == null || director.playableAsset == null)
		{
			return (position: Vector3.zero, rotation: Quaternion.identity);
		}
		TimelineAsset timelineAsset = director.playableAsset as TimelineAsset;
		if (timelineAsset == null)
		{
			return (position: Vector3.zero, rotation: Quaternion.identity);
		}
		foreach (TrackAsset outputTrack in timelineAsset.GetOutputTracks())
		{
			if (!(outputTrack is AnimationTrack) || !(outputTrack.name == trackName))
			{
				continue;
			}
			foreach (TimelineClip clip in outputTrack.GetClips())
			{
				AnimationPlayableAsset animationPlayableAsset = clip.asset as AnimationPlayableAsset;
				if (animationPlayableAsset != null && animationPlayableAsset.clip != null)
				{
					return SampleClipPose(animationPlayableAsset.clip, go, 0f);
				}
			}
		}
		return (position: Vector3.zero, rotation: Quaternion.identity);
	}

	public static (Vector3 position, Quaternion rotation) SampleClipPose(AnimationClip clip, float time)
	{
		if (clip == null)
		{
			return (position: Vector3.zero, rotation: Quaternion.identity);
		}
		GameObject gameObject = new GameObject("_TempAnimSampler");
		gameObject.hideFlags = HideFlags.HideAndDontSave;
		try
		{
			Transform transform = gameObject.transform;
			transform.localPosition = Vector3.zero;
			transform.localRotation = Quaternion.identity;
			clip.SampleAnimation(gameObject, time);
			Vector3 localPosition = transform.localPosition;
			Quaternion localRotation = transform.localRotation;
			return (position: localPosition, rotation: localRotation);
		}
		finally
		{
			Object.DestroyImmediate(gameObject);
		}
	}

	public static (Vector3 position, Quaternion rotation) SampleClipPose(AnimationClip clip, GameObject targetGo, float time)
	{
		if (clip == null || targetGo == null)
		{
			return (position: Vector3.zero, rotation: Quaternion.identity);
		}
		Transform transform = targetGo.transform;
		Vector3 localPosition = transform.localPosition;
		Quaternion localRotation = transform.localRotation;
		try
		{
			clip.SampleAnimation(targetGo, time);
			Vector3 localPosition2 = transform.localPosition;
			Quaternion localRotation2 = transform.localRotation;
			return (position: localPosition2, rotation: localRotation2);
		}
		finally
		{
			transform.localPosition = localPosition;
			transform.localRotation = localRotation;
		}
	}

	private static Transform GetTransformFromBinding(Object binding)
	{
		if (!(binding is Animator { transform: var transform }))
		{
			if (!(binding is GameObject { transform: var transform2 }))
			{
				if (!(binding is Transform result))
				{
					if (!(binding is Component { transform: var transform3 }))
					{
						return null;
					}
					return transform3;
				}
				return result;
			}
			return transform2;
		}
		return transform;
	}
}
