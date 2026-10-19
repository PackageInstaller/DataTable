using System;
using System.Collections.Generic;
using UnityEngine;

namespace PathFinding2D.Runtime.Models;

[Serializable]
public class NavigationData : ScriptableObject
{
	[SerializeField]
	[Tooltip("烘焙后的全部寻路节点。运行时只读使用这份列表。")]
	public List<Waypoint> Waypoints = new List<Waypoint>();

	[SerializeField]
	[Tooltip("节点之间的有向连接。权重通常是两点距离。")]
	public List<PointLink> PointLinks = new List<PointLink>();
}
