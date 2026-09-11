using System;
using System.ComponentModel;
using RogoDigital.Lipsync;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/角色/口型与表情(LipSync)")]
[TrackClipType(typeof(LipSyncNode))]
[TrackBindingType(typeof(LipSync))]
[TrackColor(0.5f, 0.5f, 0f)]
public class LipSyncTrack : TrackAsset
{
}
