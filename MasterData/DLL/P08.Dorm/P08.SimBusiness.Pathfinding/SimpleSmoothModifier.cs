using System;
using System.Collections.Generic;
using Pathfinding;
using Pathfinding.Util;
using UnityEngine;

namespace P08.SimBusiness.Pathfinding;

[Serializable]
[AddComponentMenu("P08_Pathfinding/Modifiers/Simple Smooth")]
[RequireComponent(typeof(PathfindingSeeker))]
[HelpURL("http://arongranberg.com/astar/docs/class_pathfinding_1_1_simple_smooth_modifier.php")]
public class SimpleSmoothModifier : MonoModifier
{
	public enum SmoothType
	{
		Simple,
		Bezier,
		OffsetSimple,
		CurvedNonuniform
	}

	public SmoothType smoothType;

	[Tooltip("The number of times to subdivide (divide in half) the path segments. [0...inf] (recommended [1...10])")]
	public int subdivisions = 2;

	[Tooltip("Number of times to apply smoothing")]
	public int iterations = 2;

	[Tooltip("Determines how much smoothing to apply in each smooth iteration. 0.5 usually produces the nicest looking curves")]
	[Range(0f, 1f)]
	public float strength = 0.5f;

	[Tooltip("Toggle to divide all lines in equal length segments")]
	public bool uniformLength = true;

	[Tooltip("The length of each segment in the smoothed path. A high value yields rough paths and low value yields very smooth paths, but is slower")]
	public float maxSegmentLength = 2f;

	[Tooltip("Length factor of the bezier curves' tangents")]
	public float bezierTangentLength = 0.4f;

	[Tooltip("Offset to apply in each smoothing iteration when using Offset Simple")]
	public float offset = 0.2f;

	[Tooltip("How much to smooth the path. A higher value will give a smoother path, but might take the character far off the optimal path.")]
	public float factor = 0.1f;

	public override int Order => 50;

	public override void Apply(Path p)
	{
		if (p.vectorPath == null)
		{
			Debug.LogWarning("Can't process NULL path (has another modifier logged an error?)");
			return;
		}
		List<Vector3> list = null;
		switch (smoothType)
		{
		case SmoothType.Simple:
			list = SmoothSimple(p.vectorPath);
			break;
		case SmoothType.Bezier:
			list = SmoothBezier(p.vectorPath);
			break;
		case SmoothType.OffsetSimple:
			list = SmoothOffsetSimple(p.vectorPath);
			break;
		case SmoothType.CurvedNonuniform:
			list = CurvedNonuniform(p.vectorPath);
			break;
		}
		if (list != p.vectorPath)
		{
			ListPool<Vector3>.Release(p.vectorPath);
			p.vectorPath = list;
		}
	}

	public List<Vector3> CurvedNonuniform(List<Vector3> path)
	{
		if (maxSegmentLength <= 0f)
		{
			Debug.LogWarning("Max Segment Length is <= 0 which would cause DivByZero-exception or other nasty errors (avoid this)");
			return path;
		}
		int num = 0;
		for (int i = 0; i < path.Count - 1; i++)
		{
			float magnitude = (path[i] - path[i + 1]).magnitude;
			for (float num2 = 0f; num2 <= magnitude; num2 += maxSegmentLength)
			{
				num++;
			}
		}
		List<Vector3> list = ListPool<Vector3>.Claim(num);
		Vector3 vector = (path[1] - path[0]).normalized;
		for (int j = 0; j < path.Count - 1; j++)
		{
			float magnitude2 = (path[j] - path[j + 1]).magnitude;
			Vector3 vector2 = vector;
			Vector3 vector3 = ((j < path.Count - 2) ? ((path[j + 2] - path[j + 1]).normalized - (path[j] - path[j + 1]).normalized).normalized : (path[j + 1] - path[j]).normalized);
			Vector3 tan = vector2 * magnitude2 * factor;
			Vector3 tan2 = vector3 * magnitude2 * factor;
			Vector3 a = path[j];
			Vector3 b = path[j + 1];
			float num3 = 1f / magnitude2;
			for (float num4 = 0f; num4 <= magnitude2; num4 += maxSegmentLength)
			{
				float t = num4 * num3;
				list.Add(GetPointOnCubic(a, b, tan, tan2, t));
			}
			vector = vector3;
		}
		list[list.Count - 1] = path[path.Count - 1];
		return list;
	}

	public static Vector3 GetPointOnCubic(Vector3 a, Vector3 b, Vector3 tan1, Vector3 tan2, float t)
	{
		float num = t * t;
		float num2 = num * t;
		float num3 = 2f * num2 - 3f * num + 1f;
		float num4 = -2f * num2 + 3f * num;
		float num5 = num2 - 2f * num + t;
		float num6 = num2 - num;
		return num3 * a + num4 * b + num5 * tan1 + num6 * tan2;
	}

	public List<Vector3> SmoothOffsetSimple(List<Vector3> path)
	{
		if (path.Count <= 2 || iterations <= 0)
		{
			return path;
		}
		if (iterations > 12)
		{
			Debug.LogWarning("A very high iteration count was passed, won't let this one through");
			return path;
		}
		int num = (path.Count - 2) * (int)Mathf.Pow(2f, iterations) + 2;
		List<Vector3> list = ListPool<Vector3>.Claim(num);
		List<Vector3> list2 = ListPool<Vector3>.Claim(num);
		for (int i = 0; i < num; i++)
		{
			list.Add(Vector3.zero);
			list2.Add(Vector3.zero);
		}
		for (int j = 0; j < path.Count; j++)
		{
			list[j] = path[j];
		}
		for (int k = 0; k < iterations; k++)
		{
			int num2 = (path.Count - 2) * (int)Mathf.Pow(2f, k) + 2;
			List<Vector3> list3 = list;
			list = list2;
			list2 = list3;
			for (int l = 0; l < num2 - 1; l++)
			{
				Vector3 vector = list2[l];
				Vector3 vector2 = list2[l + 1];
				Vector3 normalized = Vector3.Cross(vector2 - vector, Vector3.up).normalized;
				bool flag = false;
				bool flag2 = false;
				bool flag3 = false;
				bool flag4 = false;
				if (l != 0 && !VectorMath.IsColinearXZ(vector, vector2, list2[l - 1]))
				{
					flag3 = true;
					flag = VectorMath.RightOrColinearXZ(vector, vector2, list2[l - 1]);
				}
				if (l < num2 - 1 && !VectorMath.IsColinearXZ(vector, vector2, list2[l + 2]))
				{
					flag4 = true;
					flag2 = VectorMath.RightOrColinearXZ(vector, vector2, list2[l + 2]);
				}
				if (flag3)
				{
					list[l * 2] = vector + (flag ? (normalized * offset * 1f) : (-normalized * offset * 1f));
				}
				else
				{
					list[l * 2] = vector;
				}
				if (flag4)
				{
					list[l * 2 + 1] = vector2 + (flag2 ? (normalized * offset * 1f) : (-normalized * offset * 1f));
				}
				else
				{
					list[l * 2 + 1] = vector2;
				}
			}
			list[(path.Count - 2) * (int)Mathf.Pow(2f, k + 1) + 2 - 1] = list2[num2 - 1];
		}
		ListPool<Vector3>.Release(list2);
		return list;
	}

	public List<Vector3> SmoothSimple(List<Vector3> path)
	{
		if (path.Count < 2)
		{
			return path;
		}
		List<Vector3> list;
		if (uniformLength)
		{
			maxSegmentLength = Mathf.Max(maxSegmentLength, 0.005f);
			float num = 0f;
			for (int i = 0; i < path.Count - 1; i++)
			{
				num += Vector3.Distance(path[i], path[i + 1]);
			}
			list = ListPool<Vector3>.Claim(Mathf.FloorToInt(num / maxSegmentLength) + 2);
			float num2 = 0f;
			for (int j = 0; j < path.Count - 1; j++)
			{
				Vector3 a = path[j];
				Vector3 b = path[j + 1];
				float num3;
				for (num3 = Vector3.Distance(a, b); num2 < num3; num2 += maxSegmentLength)
				{
					list.Add(Vector3.Lerp(a, b, num2 / num3));
				}
				num2 -= num3;
			}
			list.Add(path[path.Count - 1]);
		}
		else
		{
			subdivisions = Mathf.Max(subdivisions, 0);
			if (subdivisions > 10)
			{
				Debug.LogWarning("Very large number of subdivisions. Cowardly refusing to subdivide every segment into more than " + (1 << subdivisions) + " subsegments");
				subdivisions = 10;
			}
			int num4 = 1 << subdivisions;
			list = ListPool<Vector3>.Claim((path.Count - 1) * num4 + 1);
			Subdivide(path, list, num4);
		}
		if (strength > 0f)
		{
			for (int k = 0; k < iterations; k++)
			{
				Vector3 vector = list[0];
				for (int l = 1; l < list.Count - 1; l++)
				{
					Vector3 vector2 = list[l];
					list[l] = Vector3.Lerp(vector2, (vector + list[l + 1]) / 2f, strength);
					vector = vector2;
				}
			}
		}
		return list;
		static void Subdivide(List<Vector3> points, List<Vector3> result, int subSegments)
		{
			for (int m = 0; m < points.Count - 1; m++)
			{
				for (int n = 0; n < subSegments; n++)
				{
					result.Add(Vector3.Lerp(points[m], points[m + 1], (float)n / (float)subSegments));
				}
			}
			result.Add(points[points.Count - 1]);
		}
	}

	public List<Vector3> SmoothBezier(List<Vector3> path)
	{
		if (subdivisions < 0)
		{
			subdivisions = 0;
		}
		int num = 1 << subdivisions;
		List<Vector3> list = ListPool<Vector3>.Claim();
		for (int i = 0; i < path.Count - 1; i++)
		{
			Vector3 vector = ((i != 0) ? (path[i + 1] - path[i - 1]) : (path[i + 1] - path[i]));
			Vector3 vector2 = ((i != path.Count - 2) ? (path[i] - path[i + 2]) : (path[i] - path[i + 1]));
			vector *= bezierTangentLength;
			vector2 *= bezierTangentLength;
			Vector3 vector3 = path[i];
			Vector3 p = vector3 + vector;
			Vector3 vector4 = path[i + 1];
			Vector3 p2 = vector4 + vector2;
			for (int j = 0; j < num; j++)
			{
				list.Add(AstarSplines.CubicBezier(vector3, p, p2, vector4, (float)j / (float)num));
			}
		}
		list.Add(path[path.Count - 1]);
		return list;
	}
}
