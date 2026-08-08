using UnityEngine;

namespace PigeonCoopToolkit.Effects.Trails;

public class PCTrailPoint
{
	public Vector3 Forward;

	public Vector3 Position;

	public int PointNumber;

	private float _timeActive;

	private float _distance;

	public override string ToString()
	{
		return Position.ToString();
	}

	public virtual void Update(float deltaTime)
	{
		_timeActive += deltaTime;
	}

	public float TimeActive()
	{
		return _timeActive;
	}

	public void SetTimeActive(float time)
	{
		_timeActive = time;
	}

	public void SetDistanceFromStart(float distance)
	{
		_distance = distance;
	}

	public float GetDistanceFromStart()
	{
		return _distance;
	}

	public void Reset()
	{
		Forward = Vector3.zero;
		Position = Vector3.zero;
		PointNumber = 0;
		_timeActive = 0f;
		_distance = 0f;
	}
}
