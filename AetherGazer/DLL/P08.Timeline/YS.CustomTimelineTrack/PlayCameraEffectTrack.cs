using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/特效/镜头前特效(PlayCameraEffect)")]
[TrackClipType(typeof(PlayCameraEffectNode))]
public class PlayCameraEffectTrack : TrackAsset
{
}
