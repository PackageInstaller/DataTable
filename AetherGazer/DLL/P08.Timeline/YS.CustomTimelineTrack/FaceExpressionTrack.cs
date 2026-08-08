using System;
using System.ComponentModel;
using RogoDigital.Lipsync;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("测试功能/FaceExpression")]
[TrackClipType(typeof(FaceExpressionNode))]
[TrackBindingType(typeof(LipSync))]
[TrackColor(0.5f, 0.5f, 0f)]
public class FaceExpressionTrack : TrackAsset
{
}
