using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/控制/资源开关(StoryTimelineActiveControl)")]
[TrackClipType(typeof(StoryTimelineActiveControlNode))]
public class StoryTimelineActiveControlTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		return ScriptPlayable<StoryTimelineActiveControlTrackBehaviour>.Create(graph, inputCount);
	}
}
