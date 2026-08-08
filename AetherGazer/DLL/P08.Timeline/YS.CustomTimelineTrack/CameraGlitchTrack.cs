using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/相机/相机故障(CameraGlitch)")]
[TrackClipType(typeof(CameraGlitchNode))]
public class CameraGlitchTrack : TrackAsset
{
}
