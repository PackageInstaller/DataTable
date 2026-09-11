using System.ComponentModel;
using UnityEngine;
using UnityEngine.Timeline;

[DisplayName("DLC角色面部特殊表情(DLCExpression)")]
[TrackClipType(typeof(DLCExpressionNode))]
[TrackBindingType(typeof(GameObject), TrackBindingFlags.AllowCreateComponent)]
public class DLCExpressionTrack : TrackAsset
{
}
