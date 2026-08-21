using System;
using System.Collections.Generic;
using UnityEngine;

namespace Pathfinding.Util;

public class PathInterpolator
{
	private List<Vector3> path;

	private float distanceToSegmentStart;

	private float currentSegmentLength;

	private float currentDistance;

	private float totalDistance;

	public virtual Vector3 position
	{
		get
		{
			//IL_0035: Unknown result type (might be due to invalid IL or missing references)
			//IL_0048: Unknown result type (might be due to invalid IL or missing references)
			//IL_004e: Unknown result type (might be due to invalid IL or missing references)
			float num = ((currentSegmentLength > 0.0001f) ? ((currentDistance - distanceToSegmentStart) / currentSegmentLength) : 0f);
			return Vector3.Lerp(path[segmentIndex], path[segmentIndex + 1], num);
		}
	}

	public Vector3 tangent
	{
		get
		{
			//IL_000e: Unknown result type (might be due to invalid IL or missing references)
			//IL_001f: Unknown result type (might be due to invalid IL or missing references)
			//IL_0024: Unknown result type (might be due to invalid IL or missing references)
			return path[segmentIndex + 1] - path[segmentIndex];
		}
	}

	public float remainingDistance
	{
		get
		{
			return totalDistance - distance;
		}
		set
		{
			distance = totalDistance - value;
		}
	}

	public float distance
	{
		get
		{
			return currentDistance;
		}
		set
		{
			currentDistance = value;
			while (currentDistance < distanceToSegmentStart && segmentIndex > 0)
			{
				PrevSegment();
			}
			while (currentDistance > distanceToSegmentStart + currentSegmentLength && segmentIndex < path.Count - 2)
			{
				NextSegment();
			}
		}
	}

	public int segmentIndex { get; private set; }

	public bool valid => path != null;

	public void SetPath(List<Vector3> path)
	{
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		//IL_0047: Unknown result type (might be due to invalid IL or missing references)
		//IL_004c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0066: Unknown result type (might be due to invalid IL or missing references)
		//IL_006b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0072: Unknown result type (might be due to invalid IL or missing references)
		//IL_0077: Unknown result type (might be due to invalid IL or missing references)
		//IL_007f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0080: Unknown result type (might be due to invalid IL or missing references)
		//IL_0081: Unknown result type (might be due to invalid IL or missing references)
		//IL_0086: Unknown result type (might be due to invalid IL or missing references)
		//IL_0094: Unknown result type (might be due to invalid IL or missing references)
		//IL_0095: Unknown result type (might be due to invalid IL or missing references)
		if (path.Count < 2)
		{
			throw new ArgumentException("Path must have a length of at least 2");
		}
		this.path = path;
		currentDistance = 0f;
		segmentIndex = 0;
		distanceToSegmentStart = 0f;
		Vector3 val = path[1] - path[0];
		currentSegmentLength = ((Vector3)(ref val)).magnitude;
		totalDistance = 0f;
		Vector3 val2 = path[0];
		for (int i = 1; i < path.Count; i++)
		{
			Vector3 val3 = path[i];
			float num = totalDistance;
			val = val3 - val2;
			totalDistance = num + ((Vector3)(ref val)).magnitude;
			val2 = val3;
		}
	}

	public void MoveToSegment(int index, float fractionAlongSegment)
	{
		if (index < 0 || index >= path.Count - 1)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		while (segmentIndex > index)
		{
			PrevSegment();
		}
		while (segmentIndex < index)
		{
			NextSegment();
		}
		distance = distanceToSegmentStart + Mathf.Clamp01(fractionAlongSegment) * currentSegmentLength;
	}

	public void MoveToClosestPoint(Vector3 point)
	{
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		//IL_0057: Unknown result type (might be due to invalid IL or missing references)
		//IL_0058: Unknown result type (might be due to invalid IL or missing references)
		//IL_005a: Unknown result type (might be due to invalid IL or missing references)
		//IL_005f: Unknown result type (might be due to invalid IL or missing references)
		float num = float.PositiveInfinity;
		float fractionAlongSegment = 0f;
		int index = 0;
		for (int i = 0; i < path.Count - 1; i++)
		{
			float num2 = VectorMath.ClosestPointOnLineFactor(path[i], path[i + 1], point);
			Vector3 val = Vector3.Lerp(path[i], path[i + 1], num2);
			Vector3 val2 = point - val;
			float sqrMagnitude = ((Vector3)(ref val2)).sqrMagnitude;
			if (sqrMagnitude < num)
			{
				num = sqrMagnitude;
				fractionAlongSegment = num2;
				index = i;
			}
		}
		MoveToSegment(index, fractionAlongSegment);
	}

	public void MoveToLocallyClosestPoint(Vector3 point, bool allowForwards = true, bool allowBackwards = true)
	{
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0033: Unknown result type (might be due to invalid IL or missing references)
		//IL_0034: Unknown result type (might be due to invalid IL or missing references)
		//IL_0039: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		//IL_0059: Unknown result type (might be due to invalid IL or missing references)
		//IL_00eb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fc: Unknown result type (might be due to invalid IL or missing references)
		//IL_0101: Unknown result type (might be due to invalid IL or missing references)
		//IL_0116: Unknown result type (might be due to invalid IL or missing references)
		//IL_0127: Unknown result type (might be due to invalid IL or missing references)
		//IL_012d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0132: Unknown result type (might be due to invalid IL or missing references)
		//IL_0133: Unknown result type (might be due to invalid IL or missing references)
		//IL_0138: Unknown result type (might be due to invalid IL or missing references)
		//IL_0086: Unknown result type (might be due to invalid IL or missing references)
		//IL_008b: Unknown result type (might be due to invalid IL or missing references)
		//IL_008c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0091: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ab: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ac: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b1: Unknown result type (might be due to invalid IL or missing references)
		//IL_0163: Unknown result type (might be due to invalid IL or missing references)
		//IL_0176: Unknown result type (might be due to invalid IL or missing references)
		//IL_017b: Unknown result type (might be due to invalid IL or missing references)
		//IL_018e: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a1: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a7: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ac: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ad: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b2: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val;
		while (allowForwards && segmentIndex < path.Count - 2)
		{
			val = path[segmentIndex + 1] - point;
			float sqrMagnitude = ((Vector3)(ref val)).sqrMagnitude;
			val = path[segmentIndex] - point;
			if (sqrMagnitude <= ((Vector3)(ref val)).sqrMagnitude)
			{
				NextSegment();
				continue;
			}
			break;
		}
		while (allowBackwards && segmentIndex > 0)
		{
			val = path[segmentIndex - 1] - point;
			float sqrMagnitude2 = ((Vector3)(ref val)).sqrMagnitude;
			val = path[segmentIndex] - point;
			if (!(sqrMagnitude2 <= ((Vector3)(ref val)).sqrMagnitude))
			{
				break;
			}
			PrevSegment();
		}
		float num = 0f;
		float num2 = 0f;
		float num3 = float.PositiveInfinity;
		float num4 = float.PositiveInfinity;
		if (segmentIndex > 0)
		{
			num = VectorMath.ClosestPointOnLineFactor(path[segmentIndex - 1], path[segmentIndex], point);
			val = Vector3.Lerp(path[segmentIndex - 1], path[segmentIndex], num) - point;
			num3 = ((Vector3)(ref val)).sqrMagnitude;
		}
		if (segmentIndex < path.Count - 1)
		{
			num2 = VectorMath.ClosestPointOnLineFactor(path[segmentIndex], path[segmentIndex + 1], point);
			val = Vector3.Lerp(path[segmentIndex], path[segmentIndex + 1], num2) - point;
			num4 = ((Vector3)(ref val)).sqrMagnitude;
		}
		if (num3 < num4)
		{
			MoveToSegment(segmentIndex - 1, num);
		}
		else
		{
			MoveToSegment(segmentIndex, num2);
		}
	}

	public void MoveToCircleIntersection2D(Vector3 circleCenter3D, float radius, IMovementPlane transform)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0051: Unknown result type (might be due to invalid IL or missing references)
		//IL_0052: Unknown result type (might be due to invalid IL or missing references)
		//IL_0064: Unknown result type (might be due to invalid IL or missing references)
		//IL_0069: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0082: Unknown result type (might be due to invalid IL or missing references)
		//IL_0087: Unknown result type (might be due to invalid IL or missing references)
		//IL_008c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0034: Unknown result type (might be due to invalid IL or missing references)
		//IL_0039: Unknown result type (might be due to invalid IL or missing references)
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0044: Unknown result type (might be due to invalid IL or missing references)
		Vector2 val = transform.ToPlane(circleCenter3D);
		while (segmentIndex < path.Count - 2)
		{
			Vector2 val2 = transform.ToPlane(path[segmentIndex + 1]) - val;
			if (!(((Vector2)(ref val2)).sqrMagnitude <= radius * radius))
			{
				break;
			}
			NextSegment();
		}
		float fractionAlongSegment = VectorMath.LineCircleIntersectionFactor(Vector2.op_Implicit(val), Vector2.op_Implicit(transform.ToPlane(path[segmentIndex])), Vector2.op_Implicit(transform.ToPlane(path[segmentIndex + 1])), radius);
		MoveToSegment(segmentIndex, fractionAlongSegment);
	}

	protected virtual void PrevSegment()
	{
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		segmentIndex--;
		Vector3 val = path[segmentIndex + 1] - path[segmentIndex];
		currentSegmentLength = ((Vector3)(ref val)).magnitude;
		distanceToSegmentStart -= currentSegmentLength;
	}

	protected virtual void NextSegment()
	{
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_004d: Unknown result type (might be due to invalid IL or missing references)
		segmentIndex++;
		distanceToSegmentStart += currentSegmentLength;
		Vector3 val = path[segmentIndex + 1] - path[segmentIndex];
		currentSegmentLength = ((Vector3)(ref val)).magnitude;
	}
}
