using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/相机/切换方式(StoryTimelineCameraCutType)")]
[TrackClipType(typeof(StoryTimelineCameraCutTypeNode))]
public class StoryTimelineCameraCutTypeTrack : TrackAsset
{
}
