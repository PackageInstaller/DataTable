using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/特效/扰动效果(StoryTimelineFluid)")]
[TrackClipType(typeof(StoryTimelineFluidNode))]
[TrackBindingType(typeof(Animator))]
public class StoryTimelineFluidTrack : TrackAsset
{
}
