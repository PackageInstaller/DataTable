using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.T0WorldTrack;

[Serializable]
[DisplayName("T0小场景/台词")]
[TrackClipType(typeof(T0WorldSubtitleNode))]
public class T0WorldSubtitleTrack : TrackAsset
{
}
