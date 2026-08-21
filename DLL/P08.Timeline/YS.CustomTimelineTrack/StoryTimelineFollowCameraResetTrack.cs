using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/相机/重置跟随相机朝向")]
[TrackClipType(typeof(StoryTimelineResetFollowCamera))]
public class StoryTimelineFollowCameraResetTrack : TrackAsset
{
}
