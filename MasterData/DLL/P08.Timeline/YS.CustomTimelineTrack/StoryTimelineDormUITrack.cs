using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[DisplayName("剧情Timeline/后宅/UI 轨道")]
[TrackColor(0.26332188f, 0.6738754f, 0.8529412f)]
[TrackClipType(typeof(StoryTimelineDormBubbleUINode))]
[TrackClipType(typeof(StoryTimelineDormDialogUINode))]
[TrackClipType(typeof(StoryTimelineDormMaskUINode))]
public class StoryTimelineDormUITrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		return ScriptPlayable<StoryTimelineDormUITrackBehaviour>.Create(graph, inputCount);
	}
}
