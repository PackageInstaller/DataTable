using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.T0WorldTrack;

[Serializable]
[DisplayName("T0小场景/控制ik")]
[TrackClipType(typeof(T0WorldIKControlNode))]
public class T0WorldIKControlTrack : TrackAsset
{
}
