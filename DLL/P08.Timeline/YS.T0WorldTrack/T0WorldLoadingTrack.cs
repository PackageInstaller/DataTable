using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.T0WorldTrack;

[Serializable]
[DisplayName("T0小场景/Loding逻辑")]
[TrackClipType(typeof(T0WorldLoadingNode))]
public class T0WorldLoadingTrack : TrackAsset
{
}
