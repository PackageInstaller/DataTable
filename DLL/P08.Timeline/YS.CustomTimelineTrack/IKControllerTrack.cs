using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/角色/IK(IKController)")]
[TrackClipType(typeof(IKLookAtNode))]
[TrackClipType(typeof(SlowFollowNode))]
[TrackBindingType(typeof(Animator))]
[TrackColor(1f, 0.1f, 0.7f)]
public class IKControllerTrack : TrackAsset
{
}
