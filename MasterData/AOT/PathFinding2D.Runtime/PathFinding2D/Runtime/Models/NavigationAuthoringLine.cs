using System;
using System.Collections.Generic;
using UnityEngine;

namespace PathFinding2D.Runtime.Models;

[Serializable]
public class NavigationAuthoringLine
{
	[SerializeField]
	private string lineName = string.Empty;

	[SerializeField]
	private List<Waypoint> waypoints = new List<Waypoint>();

	[SerializeField]
	private bool useWorldSpace = true;

	[SerializeField]
	private Vector3 localOrigin;

	[SerializeField]
	private WaypointLayer layer;

	[SerializeField]
	private bool canMoveThrough;

	[SerializeField]
	private bool isVertical;

	public string LineName
	{
		get
		{
			return lineName;
		}
		set
		{
			lineName = value;
		}
	}

	public List<Waypoint> Waypoints => waypoints;

	public bool UseWorldSpace
	{
		get
		{
			return useWorldSpace;
		}
		set
		{
			useWorldSpace = value;
		}
	}

	public Vector3 LocalOrigin
	{
		get
		{
			return localOrigin;
		}
		set
		{
			localOrigin = value;
		}
	}

	public WaypointLayer Layer
	{
		get
		{
			return layer;
		}
		set
		{
			layer = value;
		}
	}

	public bool CanMoveThrough
	{
		get
		{
			return canMoveThrough;
		}
		set
		{
			canMoveThrough = value;
		}
	}

	public bool IsVertical
	{
		get
		{
			return isVertical;
		}
		set
		{
			isVertical = value;
		}
	}

	public void SetWaypoints(List<Waypoint> source)
	{
		waypoints = source ?? new List<Waypoint>();
	}

	public List<Waypoint> GetWorldWaypoints()
	{
		List<Waypoint> list = new List<Waypoint>(waypoints.Count);
		for (int i = 0; i < waypoints.Count; i++)
		{
			Waypoint waypoint = waypoints[i];
			if (waypoint == null)
			{
				continue;
			}
			Vector3 pos = (useWorldSpace ? waypoint.Position : (waypoint.Position + localOrigin));
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
			list.Add(Waypoint.Create(0u, pos, (int)layer, waypoint.Enabled, canMoveThrough, isEndPoint, direction));
		}
		return list;
	}
}
