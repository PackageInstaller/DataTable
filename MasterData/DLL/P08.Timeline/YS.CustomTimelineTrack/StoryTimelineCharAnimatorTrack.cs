using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("测试功能/StoryTimelineCharAnimator")]
[TrackClipType(typeof(StoryTimelineCharAnimationNode))]
[TrackBindingType(typeof(Animator))]
public class StoryTimelineCharAnimatorTrack : TrackAsset
{
}
