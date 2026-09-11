using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/控制/StoryTimelineEnableRender")]
[TrackClipType(typeof(StoryTimelineEnableRenderNode))]
[TrackClipType(typeof(StoryTimelineDestoryNode))]
[TrackClipType(typeof(StoryTimelineCreateAssetNode))]
[TrackClipType(typeof(StoryTimelineTriggerNode))]
[TrackClipType(typeof(StoryTimelineStartNode))]
[TrackBindingType(typeof(GameObject))]
public class StoryTimelineEnableRenderTrack : TrackAsset
{
}
