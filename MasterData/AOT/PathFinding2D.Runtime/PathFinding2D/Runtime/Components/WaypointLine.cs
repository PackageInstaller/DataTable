using System.Collections.Generic;
using PathFinding2D.Runtime.Models;
using UnityEngine;

namespace PathFinding2D.Runtime.Components;

public class WaypointLine : MonoBehaviour
{
	[SerializeField]
	[Tooltip("这条路径线上的关键点。手调时主要改这些点位。")]
	private List<Waypoint> waypoints = new List<Waypoint>();

	[SerializeField]
	[Tooltip("勾选：点位是世界坐标；不勾选：点位相对本物体位置。")]
	private bool useWorldSpace = true;

	[SerializeField]
	[Tooltip("这条线归属的寻路层，影响跨层连接规则。")]
	private WaypointLayer layer;

	[SerializeField]
	[Tooltip("勾选后，其它平台可与该线发生穿透式上下连接（如薄平台）。")]
	private bool canMoveThrough;

	[SerializeField]
	[Tooltip("勾选表示梯子/竖井一类竖直路径，端点按垂直方向处理。")]
	private bool isVertical;

	public List<Waypoint> Waypoints => GetWaypoints();

	public bool UseWorldSpace => useWorldSpace;

	public WaypointLayer Layer => layer;

	public bool CanMoveThrough => canMoveThrough;

	public bool IsVertical => isVertical;

	public void Set(List<Waypoint> wp, bool useWorldSpace, bool canMoveThrough, bool isVertical, WaypointLayer layer)
	{
		waypoints = wp;
		this.useWorldSpace = useWorldSpace;
		this.canMoveThrough = canMoveThrough;
		this.isVertical = isVertical;
		this.layer = layer;
	}

	public List<Waypoint> GetWaypoints()
	{
		List<Waypoint> list = new List<Waypoint>();
		for (int i = 0; i < waypoints.Count; i++)
		{
			Waypoint waypoint = waypoints[i];
			Vector3 pos = (UseWorldSpace ? waypoint.Position : (waypoint.Position + transform.position));
			bool isEndPoint = false;
			EndPointDirection direction = EndPointDirection.None;
			if (!isVertical)
			{
				if (waypoints.Count == 1)
				{
					direction = EndPointDirection.Left | EndPointDirection.Right;
					isEndPoint = true;
				}
				else if (i == 0)
				{
					direction = EndPointDirection.Left;
					isEndPoint = true;
				}
				else if (i == waypoints.Count - 1)
				{
					direction = EndPointDirection.Right;
					isEndPoint = true;
				}
			}
			else if (i == 0 || i == waypoints.Count - 1)
			{
				isEndPoint = true;
				direction = EndPointDirection.Vertical;
			}
			Waypoint item = Waypoint.Create(0u, pos, (int)Layer, waypoint.Enabled, CanMoveThrough, isEndPoint, direction);
			list.Add(item);
		}
		return list;
	}
}
