using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/文本/标题和旁白(StoryTimelineUI)")]
[TrackClipType(typeof(StoryTimelineUINode))]
[TrackClipType(typeof(StoryTimelineUISkipNode))]
public class StoryTimelineUITrack : TrackAsset
{
}
