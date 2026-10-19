using UnityEngine;

public enum RotateType
{
	[InspectorName("不旋转")]
	Non,
	[InspectorName("单向旋转")]
	Loop,
	[InspectorName("往复旋转")]
	PingPong
}
