using System;
using UnityEngine;

namespace PathFinding2D.Models;

[Serializable]
public class NavigationAutoTickerDebugSettings
{
	[Tooltip("开启后，自动采样会画出射线和净空检测辅助线，方便排查采点问题。")]
	public bool showDebug;

	[Tooltip("自动采样向下射线的调试颜色。")]
	public Color rayColor = Color.red;

	[Tooltip("路径线段起点调试颜色。")]
	public Color startPointColor = Color.green;

	[Tooltip("路径线段终点调试颜色。")]
	public Color endPointColor = Color.red;

	[Tooltip("高度变化折点调试颜色。")]
	public Color cornerPointColor = Color.yellow;

	[Tooltip("采样线段调试颜色。")]
	public Color segmentColor = Color.blue;

	[Tooltip("头顶空间足够时的调试颜色。")]
	public Color headroomCheckColor = Color.green;

	[Tooltip("头顶被挡住、判定不可站立时的调试颜色。")]
	public Color headroomCheckFailedColor = Color.magenta;
}
