using System;
using TrueSync;
using UnityEngine;

public class TrueSyncWaypointMove : LogicComponent
{
	public FP moveSpeed = 2f;

	private TSVector2[] __waypoints;

	private int _fromWaypointIndex;

	private FP _percentBetweenWaypoints = FP.Zero;

	private TrueSyncTransform _tsTransform;

	public override void OnActive()
	{
		_tsTransform = Entity.GetLogicComponent<TrueSyncTransform>();
	}

	public void Setup(Transform[] waypoints)
	{
		__waypoints = new TSVector2[waypoints.Length];
		for (int i = 0; i < waypoints.Length; i++)
		{
			Vector3 localPosition = waypoints[i].localPosition;
			__waypoints[i].Set(localPosition.x, localPosition.z);
		}
		Rotate();
	}

	public void Move(FP dt)
	{
		_fromWaypointIndex %= __waypoints.Length;
		int num = (_fromWaypointIndex + 1) % __waypoints.Length;
		FP fP = TSVector2.Distance(__waypoints[_fromWaypointIndex], __waypoints[num]);
		_percentBetweenWaypoints += dt * moveSpeed / fP;
		_percentBetweenWaypoints = TSMath.Clamp01(_percentBetweenWaypoints);
		TSVector2 point = TSVector2.Lerp(__waypoints[_fromWaypointIndex], __waypoints[num], _percentBetweenWaypoints);
		point = _tsTransform.TransformLocalPointToWorldSpace(point);
		_tsTransform.Position = point;
		if (_percentBetweenWaypoints >= 1f)
		{
			_percentBetweenWaypoints = 0f;
			_fromWaypointIndex++;
			if (_fromWaypointIndex >= __waypoints.Length - 1)
			{
				_fromWaypointIndex = 0;
				Array.Reverse(__waypoints);
			}
			Rotate();
		}
	}

	protected void Rotate()
	{
		int num = (_fromWaypointIndex + 1) % __waypoints.Length;
		TSVector2 tSVector = _tsTransform.TransformLocalPointToWorldSpace(__waypoints[_fromWaypointIndex]);
		TSVector2 tSVector2 = _tsTransform.TransformLocalPointToWorldSpace(__waypoints[num]);
		_tsTransform.Forward = (tSVector2 - tSVector).normalized;
	}
}
