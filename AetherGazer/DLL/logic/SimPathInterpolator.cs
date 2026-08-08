using System;
using System.Collections.Generic;
using Pathfinding;
using Pathfinding.Util;

public class SimPathInterpolator
{
	private List<Int3> path;

	private Int distanceToSegmentStart;

	private Int currentSegmentLength;

	private Int currentDistance;

	private Int totalDistance;

	public virtual Int3 position
	{
		get
		{
			VFactor f = ((currentSegmentLength > 0) ? new VFactor((currentDistance - distanceToSegmentStart).i, currentSegmentLength.i) : VFactor.zero);
			return IntMath.Lerp(path[segmentIndex], path[segmentIndex + 1], f);
		}
	}

	public Int3 tangent => path[segmentIndex + 1] - path[segmentIndex];

	public Int remainingDistance
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

	public Int distance
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

	public void SetPath(List<Int3> path)
	{
		if (path.Count < 2)
		{
			throw new ArgumentException("Path must have a length of at least 2");
		}
		this.path = path;
		currentDistance = 0;
		segmentIndex = 0;
		distanceToSegmentStart = 0;
		currentSegmentLength = (path[1] - path[0]).IntMagnitude;
		totalDistance = 0;
		Int3 @int = path[0];
		for (int i = 1; i < path.Count; i++)
		{
			Int3 int2 = path[i];
			totalDistance += (int2 - @int).IntMagnitude;
			@int = int2;
		}
	}

	public void MoveToSegment(int index, VFactor fractionAlongSegment)
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
		distance = distanceToSegmentStart + currentSegmentLength * VFactor.Clamp01(fractionAlongSegment);
	}

	public void MoveToClosestPoint(Int3 point)
	{
		long num = long.MaxValue;
		VFactor fractionAlongSegment = VFactor.zero;
		int index = 0;
		for (int i = 0; i < path.Count - 1; i++)
		{
			VFactor vFactor = ClosestPointOnLineFactor(path[i], path[i + 1], point);
			Int3 @int = IntMath.Lerp(path[i], path[i + 1], vFactor);
			long sqrMagnitudeLong = (point - @int).sqrMagnitudeLong;
			if (sqrMagnitudeLong < num)
			{
				num = sqrMagnitudeLong;
				fractionAlongSegment = vFactor;
				index = i;
			}
		}
		MoveToSegment(index, fractionAlongSegment);
	}

	public static VFactor ClosestPointOnLineFactor(Int3 lineStart, Int3 lineEnd, Int3 point)
	{
		Int3 rhs = lineEnd - lineStart;
		long sqrMagnitudeLong = rhs.sqrMagnitudeLong;
		int num = Int3.Dot(point - lineStart, rhs);
		if (sqrMagnitudeLong != 0L)
		{
			return new VFactor(num, sqrMagnitudeLong);
		}
		return VFactor.zero;
	}

	public void MoveToLocallyClosestPoint(Int3 point, bool allowForwards = true, bool allowBackwards = true)
	{
		while (allowForwards && segmentIndex < path.Count - 2 && (path[segmentIndex + 1] - point).sqrMagnitudeLong <= (path[segmentIndex] - point).sqrMagnitudeLong)
		{
			NextSegment();
		}
		while (allowBackwards && segmentIndex > 0 && (path[segmentIndex - 1] - point).sqrMagnitudeLong <= (path[segmentIndex] - point).sqrMagnitudeLong)
		{
			PrevSegment();
		}
		VFactor vFactor = VFactor.zero;
		VFactor vFactor2 = VFactor.zero;
		long num = long.MaxValue;
		long num2 = long.MaxValue;
		if (segmentIndex > 0)
		{
			vFactor = ClosestPointOnLineFactor(path[segmentIndex - 1], path[segmentIndex], point);
			num = (IntMath.Lerp(path[segmentIndex - 1], path[segmentIndex], vFactor) - point).sqrMagnitudeLong;
		}
		if (segmentIndex < path.Count - 1)
		{
			vFactor2 = ClosestPointOnLineFactor(path[segmentIndex], path[segmentIndex + 1], point);
			num2 = (IntMath.Lerp(path[segmentIndex], path[segmentIndex + 1], vFactor2) - point).sqrMagnitudeLong;
		}
		if (num < num2)
		{
			MoveToSegment(segmentIndex - 1, vFactor);
		}
		else
		{
			MoveToSegment(segmentIndex, vFactor2);
		}
	}

	public void MoveToCircleIntersection2D(Int3 circleCenter3D, Int radius, IMovementPlane transform)
	{
		Int2 @int = transform.ToPlane(circleCenter3D);
		while (segmentIndex < path.Count - 2 && (transform.ToPlane(path[segmentIndex + 1]) - @int).sqrMagnitudeLong <= radius.i * radius.i)
		{
			NextSegment();
		}
		VFactor fractionAlongSegment = VectorMath.LineCircleIntersectionFactor(@int, transform.ToPlane(path[segmentIndex]), transform.ToPlane(path[segmentIndex + 1]), radius);
		MoveToSegment(segmentIndex, fractionAlongSegment);
	}

	protected virtual void PrevSegment()
	{
		segmentIndex--;
		currentSegmentLength = (path[segmentIndex + 1] - path[segmentIndex]).IntMagnitude;
		distanceToSegmentStart -= currentSegmentLength;
	}

	protected virtual void NextSegment()
	{
		segmentIndex++;
		distanceToSegmentStart += currentSegmentLength;
		currentSegmentLength = (path[segmentIndex + 1] - path[segmentIndex]).IntMagnitude;
	}
}
