using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.T0WorldTrack;

[Serializable]
[DisplayName("T0小场景/动画")]
[TrackClipType(typeof(T0WorldAniEndingNode))]
public class T0WorldAniTrack : TrackAsset
{
}
