using System;
using UnityEngine;

namespace PathFinding2D.Runtime.Models;

[Serializable]
public class Waypoint
{
	[SerializeField]
	private uint pointId;

	[SerializeField]
	private Vector3 position;

	[SerializeField]
	private bool enabled = true;

	[SerializeField]
	private bool canMoveThrough = true;

	[SerializeField]
	private WaypointLayer layer;

	[SerializeField]
	private bool isEndPoint;

	[SerializeField]
	private EndPointDirection endPointDirection;

	public uint PointId => pointId;

	public Vector3 Position => position;

	public bool Enabled => enabled;

	public bool CanMoveThrough => canMoveThrough;

	public WaypointLayer Layer => layer;

	public bool IsEndPoint => isEndPoint;

	public EndPointDirection EndPointDirection => endPointDirection;

	public void SetEnable(bool isEnabled)
	{
		enabled = isEnabled;
	}

	public void SetMoveThrough(bool moveThrough)
	{
		canMoveThrough = moveThrough;
	}

	public void SetOffset(Vector3 offset)
	{
		position += offset;
	}

	public static Waypoint Create(uint id, Vector3 pos, int layer = 1, bool isEnabled = true, bool canMoveThrough = false, bool isEndPoint = false, EndPointDirection direction = EndPointDirection.None)
	{
		return new Waypoint
		{
			pointId = id,
			position = pos,
			enabled = isEnabled,
			layer = (WaypointLayer)layer,
			canMoveThrough = canMoveThrough,
			isEndPoint = isEndPoint,
			endPointDirection = direction
		};
	}
}
