using UnityEngine;

namespace Assets.MoveableLineRenderer.Scripts;

internal sealed class Point
{
	public Vector3 Position;

	private readonly float _timeCreated;

	public float TimeAlive => Time.time - _timeCreated;

	public Point(Vector3 position)
	{
		Position = position;
		_timeCreated = Time.time;
	}
}
