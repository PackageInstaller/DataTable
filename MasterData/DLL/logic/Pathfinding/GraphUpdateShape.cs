using UnityEngine;

namespace Pathfinding;

public class GraphUpdateShape
{
	private Vector3[] _points;

	private Vector3[] _convexPoints;

	private bool _convex;

	private Vector3 right;

	private Vector3 forward;

	private Vector3 up;

	private Vector3 origin;

	public float minimumHeight;

	public Vector3[] points
	{
		get
		{
			return _points;
		}
		set
		{
			_points = value;
			if (convex)
			{
				CalculateConvexHull();
			}
		}
	}

	public bool convex
	{
		get
		{
			return _convex;
		}
		set
		{
			if ((_convex != value) & value)
			{
				CalculateConvexHull();
			}
			_convex = value;
		}
	}

	public GraphUpdateShape()
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		right = Vector3.right;
		forward = Vector3.forward;
		up = Vector3.up;
		base._002Ector();
	}

	public GraphUpdateShape(Vector3[] points, bool convex, Matrix4x4 matrix, float minimumHeight)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		//IL_003d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		//IL_005a: Unknown result type (might be due to invalid IL or missing references)
		//IL_005f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0067: Unknown result type (might be due to invalid IL or missing references)
		//IL_006c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0072: Unknown result type (might be due to invalid IL or missing references)
		//IL_0077: Unknown result type (might be due to invalid IL or missing references)
		//IL_007c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0084: Unknown result type (might be due to invalid IL or missing references)
		//IL_0089: Unknown result type (might be due to invalid IL or missing references)
		//IL_008f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0094: Unknown result type (might be due to invalid IL or missing references)
		//IL_0099: Unknown result type (might be due to invalid IL or missing references)
		right = Vector3.right;
		forward = Vector3.forward;
		up = Vector3.up;
		base._002Ector();
		this.convex = convex;
		this.points = points;
		origin = ((Matrix4x4)(ref matrix)).MultiplyPoint3x4(Vector3.zero);
		right = ((Matrix4x4)(ref matrix)).MultiplyPoint3x4(Vector3.right) - origin;
		up = ((Matrix4x4)(ref matrix)).MultiplyPoint3x4(Vector3.up) - origin;
		forward = ((Matrix4x4)(ref matrix)).MultiplyPoint3x4(Vector3.forward) - origin;
		this.minimumHeight = minimumHeight;
	}

	private void CalculateConvexHull()
	{
		_convexPoints = ((points != null) ? Polygon.ConvexHullXZ(points) : null);
	}

	public Bounds GetBounds()
	{
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_0034: Unknown result type (might be due to invalid IL or missing references)
		return GetBounds(convex ? _convexPoints : points, right, up, forward, origin, minimumHeight);
	}

	public static Bounds GetBounds(Vector3[] points, Matrix4x4 matrix, float minimumHeight)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_002d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		//IL_0047: Unknown result type (might be due to invalid IL or missing references)
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_004c: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = ((Matrix4x4)(ref matrix)).MultiplyPoint3x4(Vector3.zero);
		Vector3 val2 = ((Matrix4x4)(ref matrix)).MultiplyPoint3x4(Vector3.right) - val;
		Vector3 val3 = ((Matrix4x4)(ref matrix)).MultiplyPoint3x4(Vector3.up) - val;
		Vector3 val4 = ((Matrix4x4)(ref matrix)).MultiplyPoint3x4(Vector3.forward) - val;
		return GetBounds(points, val2, val3, val4, val, minimumHeight);
	}

	private static Bounds GetBounds(Vector3[] points, Vector3 right, Vector3 up, Vector3 forward, Vector3 origin, float minimumHeight)
	{
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0085: Unknown result type (might be due to invalid IL or missing references)
		//IL_0092: Unknown result type (might be due to invalid IL or missing references)
		//IL_0097: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ae: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ce: Unknown result type (might be due to invalid IL or missing references)
		//IL_00dc: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ef: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ff: Unknown result type (might be due to invalid IL or missing references)
		//IL_0104: Unknown result type (might be due to invalid IL or missing references)
		//IL_0109: Unknown result type (might be due to invalid IL or missing references)
		//IL_010b: Unknown result type (might be due to invalid IL or missing references)
		//IL_010d: Unknown result type (might be due to invalid IL or missing references)
		//IL_010f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0114: Unknown result type (might be due to invalid IL or missing references)
		//IL_0119: Unknown result type (might be due to invalid IL or missing references)
		//IL_011b: Unknown result type (might be due to invalid IL or missing references)
		//IL_011c: Unknown result type (might be due to invalid IL or missing references)
		//IL_011e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0123: Unknown result type (might be due to invalid IL or missing references)
		//IL_0124: Unknown result type (might be due to invalid IL or missing references)
		//IL_0125: Unknown result type (might be due to invalid IL or missing references)
		//IL_0127: Unknown result type (might be due to invalid IL or missing references)
		//IL_012c: Unknown result type (might be due to invalid IL or missing references)
		//IL_012d: Unknown result type (might be due to invalid IL or missing references)
		//IL_012f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0131: Unknown result type (might be due to invalid IL or missing references)
		//IL_0136: Unknown result type (might be due to invalid IL or missing references)
		//IL_0138: Unknown result type (might be due to invalid IL or missing references)
		//IL_013a: Unknown result type (might be due to invalid IL or missing references)
		//IL_013c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0141: Unknown result type (might be due to invalid IL or missing references)
		//IL_0153: Unknown result type (might be due to invalid IL or missing references)
		//IL_0154: Unknown result type (might be due to invalid IL or missing references)
		//IL_0156: Unknown result type (might be due to invalid IL or missing references)
		//IL_0160: Unknown result type (might be due to invalid IL or missing references)
		//IL_0165: Unknown result type (might be due to invalid IL or missing references)
		//IL_0167: Unknown result type (might be due to invalid IL or missing references)
		//IL_016c: Unknown result type (might be due to invalid IL or missing references)
		//IL_016e: Unknown result type (might be due to invalid IL or missing references)
		//IL_016f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0174: Unknown result type (might be due to invalid IL or missing references)
		if (points == null || points.Length == 0)
		{
			return default(Bounds);
		}
		float num = points[0].y;
		float num2 = points[0].y;
		for (int i = 0; i < points.Length; i++)
		{
			num = Mathf.Min(num, points[i].y);
			num2 = Mathf.Max(num2, points[i].y);
		}
		float num3 = Mathf.Max(minimumHeight - (num2 - num), 0f) * 0.5f;
		num -= num3;
		num2 += num3;
		Vector3 val = right * points[0].x + up * points[0].y + forward * points[0].z;
		Vector3 val2 = val;
		for (int j = 0; j < points.Length; j++)
		{
			Vector3 val3 = right * points[j].x + forward * points[j].z;
			Vector3 val4 = val3 + up * num;
			Vector3 val5 = val3 + up * num2;
			val = Vector3.Min(val, val4);
			val = Vector3.Min(val, val5);
			val2 = Vector3.Max(val2, val4);
			val2 = Vector3.Max(val2, val5);
		}
		return new Bounds((val + val2) * 0.5f + origin, val2 - val);
	}

	public bool Contains(GraphNode node)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		return Contains((Vector3)node.position);
	}

	public bool Contains(Vector3 point)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_002d: Unknown result type (might be due to invalid IL or missing references)
		//IL_002f: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ae: Unknown result type (might be due to invalid IL or missing references)
		//IL_0072: Unknown result type (might be due to invalid IL or missing references)
		//IL_007e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0083: Unknown result type (might be due to invalid IL or missing references)
		point -= origin;
		Vector3 p = default(Vector3);
		((Vector3)(ref p))._002Ector(Vector3.Dot(point, right) / ((Vector3)(ref right)).sqrMagnitude, 0f, Vector3.Dot(point, forward) / ((Vector3)(ref forward)).sqrMagnitude);
		if (convex)
		{
			if (_convexPoints == null)
			{
				return false;
			}
			int i = 0;
			int num = _convexPoints.Length - 1;
			for (; i < _convexPoints.Length; i++)
			{
				if (VectorMath.RightOrColinearXZ(_convexPoints[i], _convexPoints[num], p))
				{
					return false;
				}
				num = i;
			}
			return true;
		}
		if (_points != null)
		{
			return Polygon.ContainsPointXZ(_points, p);
		}
		return false;
	}
}
