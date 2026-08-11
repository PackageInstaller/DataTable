using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public sealed class PathInterpolator
{
	private List<Vector3> path = new List<Vector3>();

	private float distanceToSegmentStart;

	private float currentDistance;

	private float currentSegmentLength = float.PositiveInfinity;

	private float totalDistance = float.PositiveInfinity;

	public Vector3 position
	{
		get
		{
			float t = ((currentSegmentLength > 0.0001f) ? ((currentDistance - distanceToSegmentStart) / currentSegmentLength) : 0f);
			return Vector3.Lerp(path[segmentIndex], path[segmentIndex + 1], t);
		}
	}

	public Vector3 endPoint => path[path.Count - 1];

	public Vector3 tangent => path[segmentIndex + 1] - path[segmentIndex];

	public float remainingDistance
	{
		get
		{
			return Mathf.Max(totalDistance - distance, 0f);
		}
		set
		{
			distance = Mathf.Max(totalDistance - value, 0f);
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

	public bool valid
	{
		get
		{
			if (path != null)
			{
				return path.Count > 0;
			}
			return false;
		}
	}

	public void GetRemainingPath(List<Vector3> buffer)
	{
		if (!valid)
		{
			throw new Exception("PathInterpolator is not valid");
		}
		buffer.Add(position);
		for (int i = segmentIndex + 1; i < path.Count; i++)
		{
			buffer.Add(path[i]);
		}
	}

	public void PathClear()
	{
		if (path != null)
		{
			path.Clear();
		}
	}

	public void SetPath(Vector3[] pathList)
	{
		if (pathList == null)
		{
			return;
		}
		path.Clear();
		path.AddRange(pathList);
		currentDistance = 0f;
		segmentIndex = 0;
		distanceToSegmentStart = 0f;
		if (pathList.Length == 0)
		{
			totalDistance = float.PositiveInfinity;
			currentSegmentLength = float.PositiveInfinity;
			return;
		}
		if (path.Count == 1)
		{
			path.Add(path[0]);
		}
		if (path.Count < 2)
		{
			throw new ArgumentException("Path must have a length of at least 2");
		}
		currentSegmentLength = (path[1] - path[0]).magnitude;
		totalDistance = 0f;
		Vector3 vector = path[0];
		for (int i = 1; i < path.Count; i++)
		{
			Vector3 vector2 = path[i];
			totalDistance += (vector2 - vector).magnitude;
			vector = vector2;
		}
	}

	private void MoveToSegment(int index, float fractionAlongSegment)
	{
		if (path != null)
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
	}

	public void MoveToClosestPoint(Vector3 point)
	{
		if (path == null)
		{
			return;
		}
		float num = float.PositiveInfinity;
		float fractionAlongSegment = 0f;
		int index = 0;
		for (int i = 0; i < path.Count - 1; i++)
		{
			float num2 = VectorMath.ClosestPointOnLineFactor(path[i], path[i + 1], point);
			Vector3 vector = Vector3.Lerp(path[i], path[i + 1], num2);
			float sqrMagnitude = (point - vector).sqrMagnitude;
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
		if (path != null)
		{
			while (allowForwards && segmentIndex < path.Count - 2 && (path[segmentIndex + 1] - point).sqrMagnitude <= (path[segmentIndex] - point).sqrMagnitude)
			{
				NextSegment();
			}
			while (allowBackwards && segmentIndex > 0 && (path[segmentIndex - 1] - point).sqrMagnitude <= (path[segmentIndex] - point).sqrMagnitude)
			{
				PrevSegment();
			}
			float num = 0f;
			float num2 = 0f;
			float num3 = float.PositiveInfinity;
			float num4 = float.PositiveInfinity;
			if (segmentIndex > 0)
			{
				num = VectorMath.ClosestPointOnLineFactor(path[segmentIndex - 1], path[segmentIndex], point);
				num3 = (Vector3.Lerp(path[segmentIndex - 1], path[segmentIndex], num) - point).sqrMagnitude;
			}
			if (segmentIndex < path.Count - 1)
			{
				num2 = VectorMath.ClosestPointOnLineFactor(path[segmentIndex], path[segmentIndex + 1], point);
				num4 = (Vector3.Lerp(path[segmentIndex], path[segmentIndex + 1], num2) - point).sqrMagnitude;
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
	}

	public void MoveToCircleIntersection2D(Vector3 circleCenter3D, float radius)
	{
		if (path != null && path.Count != 0)
		{
			while (segmentIndex < path.Count - 2 && VectorMath.ClosestPointOnLineFactor(path[segmentIndex], path[segmentIndex + 1], circleCenter3D) > 1f)
			{
				NextSegment();
			}
			while (segmentIndex < path.Count - 2 && (path[segmentIndex + 1] - circleCenter3D).sqrMagnitude <= radius * radius)
			{
				NextSegment();
			}
			float fractionAlongSegment = VectorMath.LineCircleIntersectionFactor(circleCenter3D, path[segmentIndex], path[segmentIndex + 1], radius);
			MoveToSegment(segmentIndex, fractionAlongSegment);
		}
	}

	private void PrevSegment()
	{
		segmentIndex--;
		currentSegmentLength = (path[segmentIndex + 1] - path[segmentIndex]).magnitude;
		distanceToSegmentStart -= currentSegmentLength;
	}

	private void NextSegment()
	{
		segmentIndex++;
		distanceToSegmentStart += currentSegmentLength;
		currentSegmentLength = (path[segmentIndex + 1] - path[segmentIndex]).magnitude;
	}
}
