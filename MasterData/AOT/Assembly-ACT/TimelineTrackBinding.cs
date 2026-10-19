using System;
using System.Collections.Generic;
using ACT;
using ACT.Model;
using Runtime.Model;
using UnityEngine;
using UnityEngine.Playables;

public class TimelineTrackBinding
{
	private static readonly Dictionary<TrackType, GetTrackObjectBase> _trackObjectHandlers = new Dictionary<TrackType, GetTrackObjectBase>
	{
		{
			TrackType.NPC,
			new GetNpcTrackObject()
		},
		{
			TrackType.Player,
			new GetPlayerTrackObject()
		},
		{
			TrackType.Camera,
			new GetCameraTrackObject()
		},
		{
			TrackType.SceneObject,
			new GetSceneObjectTrackObject()
		},
		{
			TrackType.Interact,
			new GetInteractTrackObject()
		},
		{
			TrackType.MainRole_Male,
			new GetMainRoleTrackObject(1)
		},
		{
			TrackType.MainRole_Female,
			new GetMainRoleTrackObject(2)
		}
	};

	public static void SetTrackBinding(PlayableDirector pd, Dictionary<string, TrackData> trackBindingAssets)
	{
		if (trackBindingAssets == null || trackBindingAssets.Count == 0)
		{
			return;
		}
		Dictionary<string, (PlayableBinding, int)> dictionary = new Dictionary<string, (PlayableBinding, int)>();
		int num = 0;
		foreach (PlayableBinding output in pd.playableAsset.outputs)
		{
			if (trackBindingAssets.ContainsKey(output.streamName) && !dictionary.ContainsKey(output.streamName))
			{
				dictionary.Add(output.streamName, (output, num));
			}
			if (output.streamName != "Markers")
			{
				num++;
			}
		}
		foreach (KeyValuePair<string, TrackData> trackBindingAsset in trackBindingAssets)
		{
			if (dictionary.TryGetValue(trackBindingAsset.Key, out var value))
			{
				UnityEngine.Object assetObject = GetAssetObject(pd, value.Item1, trackBindingAsset.Value, value.Item2);
				if (assetObject != null)
				{
					pd.SetGenericBinding(value.Item1.sourceObject, assetObject);
				}
			}
		}
		pd.stopped += (PlayableDirector _) =>
		{
			Model<RuntimeTimelineModel>.Interface.ClearAnimationTrack(_);
		};
	}

	public static UnityEngine.Object GetAssetObject(PlayableDirector pd, PlayableBinding pb, TrackData trackData, int outputIndex)
	{
		if (trackData.trackType == TrackType.None)
		{
			return null;
		}
		if (!_trackObjectHandlers.TryGetValue(trackData.trackType, out var value))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"未找到TrackType: {trackData.trackType} 的处理器");
			}
			return null;
		}
		Type outputTargetType = pb.outputTargetType;
		value.GetTrackObject(pd, pb, outputTargetType, trackData.trackData, outputIndex, out var trackObject);
		return trackObject;
	}
}
