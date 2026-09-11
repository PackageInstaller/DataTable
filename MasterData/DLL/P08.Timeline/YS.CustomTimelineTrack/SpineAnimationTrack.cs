using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("特效工具/Spine动画(SpineAnimation)")]
[TrackClipType(typeof(SpineAnimationClip))]
[TrackBindingType(typeof(GameObject))]
public class SpineAnimationTrack : TrackAsset
{
}
