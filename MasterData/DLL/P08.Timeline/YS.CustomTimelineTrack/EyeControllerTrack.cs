using System;
using System.ComponentModel;
using RogoDigital.Lipsync;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/角色/眨眼(EyeController)")]
[TrackClipType(typeof(EyeControllerNode))]
[TrackBindingType(typeof(LipSync))]
[TrackColor(0.5f, 0.5f, 0f)]
public class EyeControllerTrack : TrackAsset
{
}
