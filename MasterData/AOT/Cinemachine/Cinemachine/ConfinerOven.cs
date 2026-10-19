using System;
using System.Collections.Generic;
using ClipperLib;
using UnityEngine;

namespace Cinemachine;

internal class ConfinerOven
{
	public class BakedSolution
	{
		private float m_frustumSizeIntSpace;

		private readonly AspectStretcher m_AspectStretcher;

		private readonly bool m_HasBones;

		private readonly double m_SqrPolygonDiagonal;

		private List<List<IntPoint>> m_OriginalPolygon;

		public List<List<IntPoint>> m_Solution;

		private const double k_ClipperEpsilon = 1000.0;

		public float FrustumHeight { get; }

		public BakedSolution(float aspectRatio, float frustumHeight, bool hasBones, Rect polygonBounds, List<List<IntPoint>> originalPolygon, List<List<IntPoint>> solution)
		{
			m_AspectStretcher = new AspectStretcher(aspectRatio, polygonBounds.center.x);
			FrustumHeight = frustumHeight;
			m_frustumSizeIntSpace = frustumHeight * 100000f;
			m_HasBones = hasBones;
			m_OriginalPolygon = originalPolygon;
			m_Solution = solution;
			float num = polygonBounds.width / aspectRatio * 100000f;
			float num2 = polygonBounds.height * 100000f;
			m_SqrPolygonDiagonal = num * num + num2 * num2;
		}

		public void Clear()
		{
			m_Solution = null;
			m_OriginalPolygon = null;
		}

		public bool IsValid(float frustumHeight)
		{
			if (m_Solution != null)
			{
				return Mathf.Abs(frustumHeight - FrustumHeight) < 0.005f;
			}
			return false;
		}

		public Vector2 ConfinePoint(in Vector2 pointToConfine)
		{
			if (m_Solution.Count <= 0)
			{
				return pointToConfine;
			}
			Vector2 vector = m_AspectStretcher.Stretch(pointToConfine);
			IntPoint intPoint = new IntPoint(vector.x * 100000f, vector.y * 100000f);
			for (int i = 0; i < m_Solution.Count; i++)
			{
				if (Clipper.PointInPolygon(intPoint, m_Solution[i]) != 0)
				{
					return pointToConfine;
				}
			}
			bool flag = m_HasBones && IsInsideOriginal(intPoint);
			IntPoint intPoint2 = intPoint;
			double num = double.MaxValue;
			for (int j = 0; j < m_Solution.Count; j++)
			{
				int count = m_Solution[j].Count;
				for (int k = 0; k < count; k++)
				{
					IntPoint intPoint3 = m_Solution[j][k];
					IntPoint intPoint4 = m_Solution[j][(k + 1) % count];
					IntPoint intPoint5 = IntPointLerp(intPoint3, intPoint4, ClosestPointOnSegment(intPoint, intPoint3, intPoint4));
					double num2 = Mathf.Abs(intPoint.X - intPoint5.X);
					double num3 = Mathf.Abs(intPoint.Y - intPoint5.Y);
					double num4 = num2 * num2 + num3 * num3;
					if (num2 > (double)m_frustumSizeIntSpace || num3 > (double)m_frustumSizeIntSpace)
					{
						num4 += m_SqrPolygonDiagonal;
					}
					if (num4 < num && (!flag || !DoesIntersectOriginal(intPoint, intPoint5)))
					{
						num = num4;
						intPoint2 = intPoint5;
					}
				}
			}
			Vector2 p = new Vector2((float)intPoint2.X * 1E-05f, (float)intPoint2.Y * 1E-05f);
			return m_AspectStretcher.Unstretch(p);
		}

		private bool IsInsideOriginal(IntPoint p)
		{
			for (int i = 0; i < m_OriginalPolygon.Count; i++)
			{
				if (Clipper.PointInPolygon(p, m_OriginalPolygon[i]) != 0)
				{
					return true;
				}
			}
			return false;
		}

		private static float ClosestPointOnSegment(IntPoint p, IntPoint s0, IntPoint s1)
		{
			double num = s1.X - s0.X;
			double num2 = s1.Y - s0.Y;
			double num3 = num * num + num2 * num2;
			if (num3 < 1000.0)
			{
				return 0f;
			}
			double num4 = p.X - s0.X;
			double num5 = p.Y - s0.Y;
			return Mathf.Clamp01((float)((num4 * num + num5 * num2) / num3));
		}

		private static IntPoint IntPointLerp(IntPoint a, IntPoint b, float lerp)
		{
			return new IntPoint
			{
				X = Mathf.RoundToInt((float)a.X + (float)(b.X - a.X) * lerp),
				Y = Mathf.RoundToInt((float)a.Y + (float)(b.Y - a.Y) * lerp)
			};
		}

		private bool DoesIntersectOriginal(IntPoint l1, IntPoint l2)
		{
			foreach (List<IntPoint> item in m_OriginalPolygon)
			{
				int count = item.Count;
				for (int i = 0; i < count; i++)
				{
					if (FindIntersection(in l1, in l2, item[i], item[(i + 1) % count]) == 2)
					{
						return true;
					}
				}
			}
			return false;
		}

		private static int FindIntersection(in IntPoint p1, in IntPoint p2, in IntPoint p3, in IntPoint p4)
		{
			double num = p2.X - p1.X;
			double num2 = p2.Y - p1.Y;
			double num3 = p4.X - p3.X;
			double num4 = p4.Y - p3.Y;
			double num5 = num2 * num3 - num * num4;
			double num6 = ((double)(p1.X - p3.X) * num4 + (double)(p3.Y - p1.Y) * num3) / num5;
			if (double.IsInfinity(num6) || double.IsNaN(num6))
			{
				if (IntPointDiffSqrMagnitude(p1, p3) < 1000.0 || IntPointDiffSqrMagnitude(p1, p4) < 1000.0 || IntPointDiffSqrMagnitude(p2, p3) < 1000.0 || IntPointDiffSqrMagnitude(p2, p4) < 1000.0)
				{
					return 2;
				}
				return 0;
			}
			double num7 = ((double)(p3.X - p1.X) * num2 + (double)(p1.Y - p3.Y) * num) / (0.0 - num5);
			if (!(num6 >= 0.0) || !(num6 <= 1.0) || !(num7 >= 0.0) || !(num7 < 1.0))
			{
				return 1;
			}
			return 2;
		}

		private static double IntPointDiffSqrMagnitude(IntPoint p1, IntPoint p2)
		{
			double num = p1.X - p2.X;
			double num2 = p1.Y - p2.Y;
			return num * num + num2 * num2;
		}
	}

	private struct AspectStretcher
	{
		private readonly float m_InverseAspect;

		private readonly float m_CenterX;

		public float Aspect { get; }

		public AspectStretcher(float aspect, float centerX)
		{
			Aspect = aspect;
			m_InverseAspect = 1f / Aspect;
			m_CenterX = centerX;
		}

		public Vector2 Stretch(Vector2 p)
		{
			return new Vector2((p.x - m_CenterX) * m_InverseAspect + m_CenterX, p.y);
		}

		public Vector2 Unstretch(Vector2 p)
		{
			return new Vector2((p.x - m_CenterX) * Aspect + m_CenterX, p.y);
		}
	}

	private struct PolygonSolution
	{
		public List<List<IntPoint>> m_Polygons;

		public float m_FrustumHeight;

		public bool IsEmpty => m_Polygons == null;

		public bool StateChanged(in List<List<IntPoint>> paths)
		{
			if (paths.Count != m_Polygons.Count)
			{
				return true;
			}
			for (int i = 0; i < paths.Count; i++)
			{
				if (paths[i].Count != m_Polygons[i].Count)
				{
					return true;
				}
			}
			return false;
		}
	}

	public enum BakingState
	{
		BAKING,
		BAKED,
		TIMEOUT
	}

	private struct BakingStateCache
	{
		public ClipperOffset offsetter;

		public List<PolygonSolution> solutions;

		public PolygonSolution rightCandidate;

		public PolygonSolution leftCandidate;

		public List<List<IntPoint>> maxCandidate;

		public float stepSize;

		public float maxFrustumHeight;

		public float currentFrustumHeight;

		public float bakeTime;
	}

	private float m_MinFrustumHeightWithBones;

	private List<List<IntPoint>> m_OriginalPolygon;

	private List<List<IntPoint>> m_Skeleton = new List<List<IntPoint>>();

	private const long k_FloatToIntScaler = 100000L;

	private const float k_IntToFloatScaler = 1E-05f;

	private const float k_MinStepSize = 0.005f;

	private Rect m_PolygonRect;

	private AspectStretcher m_AspectStretcher = new AspectStretcher(1f, 0f);

	private float m_maxComputationTimeForFullSkeletonBakeInSeconds = 5f;

	public float m_BakeProgress;

	private BakingStateCache m_Cache;

	public BakingState State { get; private set; }

	public ConfinerOven(in List<List<Vector2>> inputPath, in float aspectRatio, float maxFrustumHeight)
	{
		Initialize(in inputPath, in aspectRatio, maxFrustumHeight);
	}

	public BakedSolution GetBakedSolution(float frustumHeight)
	{
		ClipperOffset clipperOffset = new ClipperOffset();
		clipperOffset.AddPaths(m_OriginalPolygon, JoinType.jtMiter, EndType.etClosedPolygon);
		List<List<IntPoint>> solution = new List<List<IntPoint>>();
		clipperOffset.Execute(ref solution, -1f * frustumHeight * 100000f);
		List<List<IntPoint>> solution2 = new List<List<IntPoint>>();
		if (State == BakingState.BAKING || m_Skeleton.Count == 0)
		{
			solution2 = solution;
		}
		else
		{
			Clipper clipper = new Clipper();
			clipper.AddPaths(solution, PolyType.ptSubject, closed: true);
			clipper.AddPaths(m_Skeleton, PolyType.ptClip, closed: true);
			clipper.Execute(ClipType.ctUnion, solution2, PolyFillType.pftEvenOdd, PolyFillType.pftEvenOdd);
		}
		return new BakedSolution(m_AspectStretcher.Aspect, frustumHeight, m_MinFrustumHeightWithBones < frustumHeight, m_PolygonRect, m_OriginalPolygon, solution2);
	}

	private void Initialize(in List<List<Vector2>> inputPath, in float aspectRatio, float maxFrustumHeight)
	{
		m_Skeleton.Clear();
		m_Cache.maxFrustumHeight = maxFrustumHeight;
		m_MinFrustumHeightWithBones = float.MaxValue;
		m_PolygonRect = GetPolygonBoundingBox(in inputPath);
		m_AspectStretcher = new AspectStretcher(aspectRatio, m_PolygonRect.center.x);
		m_OriginalPolygon = new List<List<IntPoint>>(inputPath.Count);
		for (int i = 0; i < inputPath.Count; i++)
		{
			List<Vector2> list = inputPath[i];
			int count = list.Count;
			List<IntPoint> list2 = new List<IntPoint>(count);
			for (int j = 0; j < count; j++)
			{
				Vector2 vector = m_AspectStretcher.Stretch(list[j]);
				list2.Add(new IntPoint(vector.x * 100000f, vector.y * 100000f));
			}
			m_OriginalPolygon.Add(list2);
		}
		if (m_Cache.maxFrustumHeight < 0f)
		{
			State = BakingState.BAKED;
			return;
		}
		float num = Mathf.Min(m_PolygonRect.width / aspectRatio, m_PolygonRect.height) / 2f;
		if (m_Cache.maxFrustumHeight == 0f || m_Cache.maxFrustumHeight > num)
		{
			m_Cache.maxFrustumHeight = num;
		}
		m_Cache.stepSize = m_Cache.maxFrustumHeight;
		m_Cache.offsetter = new ClipperOffset();
		m_Cache.offsetter.AddPaths(m_OriginalPolygon, JoinType.jtMiter, EndType.etClosedPolygon);
		List<List<IntPoint>> solution = new List<List<IntPoint>>();
		m_Cache.offsetter.Execute(ref solution, 0.0);
		m_Cache.solutions = new List<PolygonSolution>();
		m_Cache.solutions.Add(new PolygonSolution
		{
			m_Polygons = solution,
			m_FrustumHeight = 0f
		});
		m_Cache.rightCandidate = default;
		m_Cache.leftCandidate = new PolygonSolution
		{
			m_Polygons = solution,
			m_FrustumHeight = 0f
		};
		m_Cache.currentFrustumHeight = 0f;
		m_Cache.maxCandidate = new List<List<IntPoint>>();
		m_Cache.offsetter.Execute(ref m_Cache.maxCandidate, -1f * m_Cache.maxFrustumHeight * 100000f);
		m_Cache.bakeTime = 0f;
		State = BakingState.BAKING;
		m_BakeProgress = 0f;
	}

	public void BakeConfiner(float maxComputationTimePerFrameInSeconds)
	{
		if (State != BakingState.BAKING)
		{
			return;
		}
		float realtimeSinceStartup = Time.realtimeSinceStartup;
		while (m_Cache.solutions.Count < 1000)
		{
			List<List<IntPoint>> solution = new List<List<IntPoint>>(m_Cache.leftCandidate.m_Polygons.Count);
			m_Cache.stepSize = Mathf.Min(m_Cache.stepSize, m_Cache.maxFrustumHeight - m_Cache.leftCandidate.m_FrustumHeight);
			m_Cache.currentFrustumHeight = m_Cache.leftCandidate.m_FrustumHeight + m_Cache.stepSize;
			if (Math.Abs(m_Cache.currentFrustumHeight - m_Cache.maxFrustumHeight) < 0.0001f)
			{
				solution = m_Cache.maxCandidate;
			}
			else
			{
				m_Cache.offsetter.Execute(ref solution, -1f * m_Cache.currentFrustumHeight * 100000f);
			}
			if (m_Cache.leftCandidate.StateChanged(in solution))
			{
				m_Cache.rightCandidate = new PolygonSolution
				{
					m_Polygons = solution,
					m_FrustumHeight = m_Cache.currentFrustumHeight
				};
				m_Cache.stepSize = Mathf.Max(m_Cache.stepSize / 2f, 0.005f);
			}
			else
			{
				m_Cache.leftCandidate = new PolygonSolution
				{
					m_Polygons = solution,
					m_FrustumHeight = m_Cache.currentFrustumHeight
				};
				if (!m_Cache.rightCandidate.IsEmpty)
				{
					m_Cache.stepSize = Mathf.Max(m_Cache.stepSize / 2f, 0.005f);
				}
			}
			if (!m_Cache.rightCandidate.IsEmpty && m_Cache.stepSize <= 0.005f)
			{
				m_Cache.solutions.Add(m_Cache.leftCandidate);
				m_Cache.solutions.Add(m_Cache.rightCandidate);
				m_Cache.leftCandidate = m_Cache.rightCandidate;
				m_Cache.rightCandidate = default;
				m_Cache.stepSize = m_Cache.maxFrustumHeight;
			}
			else if (m_Cache.rightCandidate.IsEmpty || m_Cache.leftCandidate.m_FrustumHeight >= m_Cache.maxFrustumHeight)
			{
				m_Cache.solutions.Add(m_Cache.leftCandidate);
				break;
			}
			float num = Time.realtimeSinceStartup - realtimeSinceStartup;
			if (num > maxComputationTimePerFrameInSeconds)
			{
				m_Cache.bakeTime += num;
				if (m_Cache.bakeTime > m_maxComputationTimeForFullSkeletonBakeInSeconds)
				{
					State = BakingState.TIMEOUT;
				}
				m_BakeProgress = m_Cache.leftCandidate.m_FrustumHeight / m_Cache.maxFrustumHeight;
				return;
			}
		}
		ComputeSkeleton(in m_Cache.solutions);
		m_BakeProgress = 1f;
		State = BakingState.BAKED;
	}

	private static Rect GetPolygonBoundingBox(in List<List<Vector2>> polygons)
	{
		float num = float.PositiveInfinity;
		float num2 = float.NegativeInfinity;
		float num3 = float.PositiveInfinity;
		float num4 = float.NegativeInfinity;
		for (int i = 0; i < polygons.Count; i++)
		{
			List<Vector2> list = polygons[i];
			for (int j = 0; j < list.Count; j++)
			{
				Vector2 vector = list[j];
				num = Mathf.Min(num, vector.x);
				num2 = Mathf.Max(num2, vector.x);
				num3 = Mathf.Min(num3, vector.y);
				num4 = Mathf.Max(num4, vector.y);
			}
		}
		return new Rect(num, num3, Mathf.Max(0f, num2 - num), Mathf.Max(0f, num4 - num3));
	}

	private void ComputeSkeleton(in List<PolygonSolution> solutions)
	{
		Clipper clipper = new Clipper();
		ClipperOffset clipperOffset = new ClipperOffset();
		for (int i = 1; i < solutions.Count - 1; i += 2)
		{
			PolygonSolution polygonSolution = solutions[i];
			PolygonSolution polygonSolution2 = solutions[i + 1];
			double num = 500000f * (polygonSolution2.m_FrustumHeight - polygonSolution.m_FrustumHeight);
			List<List<IntPoint>> solution = new List<List<IntPoint>>();
			clipperOffset.Clear();
			clipperOffset.AddPaths(polygonSolution.m_Polygons, JoinType.jtMiter, EndType.etClosedPolygon);
			clipperOffset.Execute(ref solution, num);
			List<List<IntPoint>> solution2 = new List<List<IntPoint>>();
			clipperOffset.Clear();
			clipperOffset.AddPaths(polygonSolution2.m_Polygons, JoinType.jtMiter, EndType.etClosedPolygon);
			clipperOffset.Execute(ref solution2, num * 2.0);
			List<List<IntPoint>> list = new List<List<IntPoint>>();
			clipper.Clear();
			clipper.AddPaths(solution, PolyType.ptSubject, closed: true);
			clipper.AddPaths(solution2, PolyType.ptClip, closed: true);
			clipper.Execute(ClipType.ctDifference, list, PolyFillType.pftEvenOdd, PolyFillType.pftEvenOdd);
			if (list.Count > 0 && list[0].Count > 0)
			{
				m_Skeleton.AddRange(list);
				if (m_MinFrustumHeightWithBones == float.MaxValue)
				{
					m_MinFrustumHeightWithBones = polygonSolution2.m_FrustumHeight;
				}
			}
		}
	}
}
