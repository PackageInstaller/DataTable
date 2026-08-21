using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/控制/StoryTimelineCharCtrl")]
[TrackClipType(typeof(StoryTimelineCharCtrlNode))]
[TrackClipType(typeof(StoryTimelineMapTriggerNode))]
[TrackClipType(typeof(StoryTimelineCharTeleportNode))]
public class StoryTimelineCharCtrlTrack : TrackAsset
{
}
