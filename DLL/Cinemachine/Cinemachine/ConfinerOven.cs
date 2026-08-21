using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Cinemachine;

internal class ConfinerOven
{
	public class BakedSolution
	{
		private float m_FrustumSizeIntSpace;

		private readonly AspectStretcher m_AspectStretcher;

		private readonly bool m_HasBones;

		private readonly double m_SqrPolygonDiagonal;

		private List<List<ClipperLib.IntPoint>> m_OriginalPolygon;

		private List<List<ClipperLib.IntPoint>> m_Solution;

		private const double k_ClipperEpsilon = 1000.0;

		public BakedSolution(float aspectRatio, float frustumHeight, bool hasBones, Rect polygonBounds, List<List<ClipperLib.IntPoint>> originalPolygon, List<List<ClipperLib.IntPoint>> solution)
		{
			m_AspectStretcher = new AspectStretcher(aspectRatio, polygonBounds.center.x);
			m_FrustumSizeIntSpace = frustumHeight * 100000f;
			m_HasBones = hasBones;
			m_OriginalPolygon = originalPolygon;
			m_Solution = solution;
			float num = polygonBounds.width / aspectRatio * 100000f;
			float num2 = polygonBounds.height * 100000f;
			m_SqrPolygonDiagonal = num * num + num2 * num2;
		}

		public bool IsValid()
		{
			return m_Solution != null;
		}

		public Vector2 ConfinePoint(in Vector2 pointToConfine)
		{
			if (m_Solution.Count <= 0)
			{
				return pointToConfine;
			}
			Vector2 vector = m_AspectStretcher.Stretch(pointToConfine);
			ClipperLib.IntPoint intPoint = new ClipperLib.IntPoint(vector.x * 100000f, vector.y * 100000f);
			for (int i = 0; i < m_Solution.Count; i++)
			{
				if (ClipperLib.Clipper.PointInPolygon(intPoint, m_Solution[i]) != 0)
				{
					return pointToConfine;
				}
			}
			bool flag = m_HasBones && IsInsideOriginal(intPoint);
			ClipperLib.IntPoint intPoint2 = intPoint;
			double num = double.MaxValue;
			for (int j = 0; j < m_Solution.Count; j++)
			{
				int count = m_Solution[j].Count;
				for (int k = 0; k < count; k++)
				{
					ClipperLib.IntPoint intPoint3 = m_Solution[j][k];
					ClipperLib.IntPoint intPoint4 = m_Solution[j][(k + 1) % count];
					ClipperLib.IntPoint intPoint5 = IntPointLerp(intPoint3, intPoint4, ClosestPointOnSegment(intPoint, intPoint3, intPoint4));
					double num2 = Mathf.Abs(intPoint.X - intPoint5.X);
					double num3 = Mathf.Abs(intPoint.Y - intPoint5.Y);
					double num4 = num2 * num2 + num3 * num3;
					if (num2 > (double)m_FrustumSizeIntSpace || num3 > (double)m_FrustumSizeIntSpace)
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
			static float ClosestPointOnSegment(ClipperLib.IntPoint point, ClipperLib.IntPoint s0, ClipperLib.IntPoint s1)
			{
				double num5 = s1.X - s0.X;
				double num6 = s1.Y - s0.Y;
				double num7 = num5 * num5 + num6 * num6;
				if (num7 < 1000.0)
				{
					return 0f;
				}
				double num8 = point.X - s0.X;
				double num9 = point.Y - s0.Y;
				return Mathf.Clamp01((float)((num8 * num5 + num9 * num6) / num7));
			}
			bool DoesIntersectOriginal(ClipperLib.IntPoint l1, ClipperLib.IntPoint l2)
			{
				foreach (List<ClipperLib.IntPoint> item in m_OriginalPolygon)
				{
					int count2 = item.Count;
					for (int m = 0; m < count2; m++)
					{
						if (FindIntersection(in l1, in l2, item[m], item[(m + 1) % count2]) == 2)
						{
							return true;
						}
					}
				}
				return false;
			}
			static ClipperLib.IntPoint IntPointLerp(ClipperLib.IntPoint a, ClipperLib.IntPoint b, float lerp)
			{
				return new ClipperLib.IntPoint
				{
					X = Mathf.RoundToInt((float)a.X + (float)(b.X - a.X) * lerp),
					Y = Mathf.RoundToInt((float)a.Y + (float)(b.Y - a.Y) * lerp)
				};
			}
			bool IsInsideOriginal(ClipperLib.IntPoint point)
			{
				return m_OriginalPolygon.Any((List<ClipperLib.IntPoint> t) => ClipperLib.Clipper.PointInPolygon(point, t) != 0);
			}
		}

		private static int FindIntersection(in ClipperLib.IntPoint p1, in ClipperLib.IntPoint p2, in ClipperLib.IntPoint p3, in ClipperLib.IntPoint p4)
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
			static double IntPointDiffSqrMagnitude(ClipperLib.IntPoint point1, ClipperLib.IntPoint point2)
			{
				double num8 = point1.X - point2.X;
				double num9 = point1.Y - point2.Y;
				return num8 * num8 + num9 * num9;
			}
		}
	}

	private readonly struct AspectStretcher
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
		public List<List<ClipperLib.IntPoint>> polygons;

		public float frustumHeight;

		public bool IsNull => polygons == null;

		public bool StateChanged(in List<List<ClipperLib.IntPoint>> paths)
		{
			if (paths.Count != polygons.Count)
			{
				return true;
			}
			for (int i = 0; i < paths.Count; i++)
			{
				if (paths[i].Count != polygons[i].Count)
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
		public ClipperLib.ClipperOffset offsetter;

		public List<PolygonSolution> solutions;

		public PolygonSolution rightCandidate;

		public PolygonSolution leftCandidate;

		public List<List<ClipperLib.IntPoint>> maxCandidate;

		public float stepSize;

		public float maxFrustumHeight;

		public float userSetMaxFrustumHeight;

		public float theoriticalMaxFrustumHeight;

		public float currentFrustumHeight;

		public float bakeTime;
	}

	private float m_MinFrustumHeightWithBones;

	private List<List<ClipperLib.IntPoint>> m_OriginalPolygon;

	private ClipperLib.IntPoint m_MidPoint;

	private List<List<ClipperLib.IntPoint>> m_Skeleton = new List<List<ClipperLib.IntPoint>>();

	private const long k_FloatToIntScaler = 100000L;

	private const float k_IntToFloatScaler = 1E-05f;

	private const float k_MinStepSize = 0.005f;

	private Rect m_PolygonRect;

	private AspectStretcher m_AspectStretcher = new AspectStretcher(1f, 0f);

	private float m_MaxComputationTimeForFullSkeletonBakeInSeconds = 5f;

	public float bakeProgress;

	private BakingStateCache m_Cache;

	public BakingState State { get; private set; }

	public ConfinerOven(in List<List<Vector2>> inputPath, in float aspectRatio, float maxFrustumHeight)
	{
		Initialize(in inputPath, in aspectRatio, maxFrustumHeight);
	}

	public BakedSolution GetBakedSolution(float frustumHeight)
	{
		frustumHeight = ((m_Cache.userSetMaxFrustumHeight <= 0f) ? frustumHeight : Mathf.Min(m_Cache.userSetMaxFrustumHeight, frustumHeight));
		if (State == BakingState.BAKED && frustumHeight > m_Cache.theoriticalMaxFrustumHeight)
		{
			return new BakedSolution(m_AspectStretcher.Aspect, frustumHeight, hasBones: false, m_PolygonRect, m_OriginalPolygon, new List<List<ClipperLib.IntPoint>>
			{
				new List<ClipperLib.IntPoint> { m_MidPoint }
			});
		}
		ClipperLib.ClipperOffset clipperOffset = new ClipperLib.ClipperOffset();
		clipperOffset.AddPaths(m_OriginalPolygon, ClipperLib.JoinType.jtMiter, ClipperLib.EndType.etClosedPolygon);
		List<List<ClipperLib.IntPoint>> solution = new List<List<ClipperLib.IntPoint>>();
		clipperOffset.Execute(ref solution, -1f * frustumHeight * 100000f);
		List<List<ClipperLib.IntPoint>> solution2 = new List<List<ClipperLib.IntPoint>>();
		if (State == BakingState.BAKING || m_Skeleton.Count == 0)
		{
			solution2 = solution;
		}
		else
		{
			ClipperLib.Clipper clipper = new ClipperLib.Clipper();
			clipper.AddPaths(solution, ClipperLib.PolyType.ptSubject, closed: true);
			clipper.AddPaths(m_Skeleton, ClipperLib.PolyType.ptClip, closed: true);
			clipper.Execute(ClipperLib.ClipType.ctUnion, solution2, ClipperLib.PolyFillType.pftEvenOdd, ClipperLib.PolyFillType.pftEvenOdd);
		}
		return new BakedSolution(m_AspectStretcher.Aspect, frustumHeight, m_MinFrustumHeightWithBones < frustumHeight, m_PolygonRect, m_OriginalPolygon, solution2);
	}

	private void Initialize(in List<List<Vector2>> inputPath, in float aspectRatio, float maxFrustumHeight)
	{
		m_Skeleton.Clear();
		m_Cache.userSetMaxFrustumHeight = maxFrustumHeight;
		m_MinFrustumHeightWithBones = float.MaxValue;
		m_PolygonRect = GetPolygonBoundingBox(in inputPath);
		m_AspectStretcher = new AspectStretcher(aspectRatio, m_PolygonRect.center.x);
		m_Cache.theoriticalMaxFrustumHeight = Mathf.Max(m_PolygonRect.width / aspectRatio, m_PolygonRect.height) / 2f;
		m_OriginalPolygon = new List<List<ClipperLib.IntPoint>>(inputPath.Count);
		for (int i = 0; i < inputPath.Count; i++)
		{
			List<Vector2> list = inputPath[i];
			int count = list.Count;
			List<ClipperLib.IntPoint> list2 = new List<ClipperLib.IntPoint>(count);
			for (int j = 0; j < count; j++)
			{
				Vector2 vector = m_AspectStretcher.Stretch(list[j]);
				list2.Add(new ClipperLib.IntPoint(vector.x * 100000f, vector.y * 100000f));
			}
			m_OriginalPolygon.Add(list2);
		}
		m_MidPoint = MidPointOfIntRect(ClipperLib.ClipperBase.GetBounds(m_OriginalPolygon));
		if (m_Cache.userSetMaxFrustumHeight < 0f)
		{
			State = BakingState.BAKED;
			return;
		}
		m_Cache.maxFrustumHeight = m_Cache.userSetMaxFrustumHeight;
		if (m_Cache.maxFrustumHeight == 0f || m_Cache.maxFrustumHeight > m_Cache.theoriticalMaxFrustumHeight)
		{
			m_Cache.maxFrustumHeight = m_Cache.theoriticalMaxFrustumHeight;
		}
		m_Cache.stepSize = m_Cache.maxFrustumHeight;
		m_Cache.offsetter = new ClipperLib.ClipperOffset();
		m_Cache.offsetter.AddPaths(m_OriginalPolygon, ClipperLib.JoinType.jtMiter, ClipperLib.EndType.etClosedPolygon);
		List<List<ClipperLib.IntPoint>> solution = new List<List<ClipperLib.IntPoint>>();
		m_Cache.offsetter.Execute(ref solution, 0.0);
		m_Cache.solutions = new List<PolygonSolution>();
		m_Cache.solutions.Add(new PolygonSolution
		{
			polygons = solution,
			frustumHeight = 0f
		});
		m_Cache.rightCandidate = default(PolygonSolution);
		m_Cache.leftCandidate = new PolygonSolution
		{
			polygons = solution,
			frustumHeight = 0f
		};
		m_Cache.currentFrustumHeight = 0f;
		m_Cache.maxCandidate = new List<List<ClipperLib.IntPoint>>();
		m_Cache.offsetter.Execute(ref m_Cache.maxCandidate, -1f * m_Cache.theoriticalMaxFrustumHeight * 100000f);
		m_Cache.bakeTime = 0f;
		State = BakingState.BAKING;
		bakeProgress = 0f;
		static Rect GetPolygonBoundingBox(in List<List<Vector2>> polygons)
		{
			float num = float.PositiveInfinity;
			float num2 = float.NegativeInfinity;
			float num3 = float.PositiveInfinity;
			float num4 = float.NegativeInfinity;
			for (int k = 0; k < polygons.Count; k++)
			{
				for (int l = 0; l < polygons[k].Count; l++)
				{
					Vector2 vector2 = polygons[k][l];
					num = Mathf.Min(num, vector2.x);
					num2 = Mathf.Max(num2, vector2.x);
					num3 = Mathf.Min(num3, vector2.y);
					num4 = Mathf.Max(num4, vector2.y);
				}
			}
			return new Rect(num, num3, Mathf.Max(0f, num2 - num), Mathf.Max(0f, num4 - num3));
		}
		static ClipperLib.IntPoint MidPointOfIntRect(ClipperLib.IntRect bounds)
		{
			return new ClipperLib.IntPoint((bounds.left + bounds.right) / 2, (bounds.top + bounds.bottom) / 2);
		}
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
			List<List<ClipperLib.IntPoint>> solution = new List<List<ClipperLib.IntPoint>>(m_Cache.leftCandidate.polygons.Count);
			m_Cache.stepSize = Mathf.Min(m_Cache.stepSize, m_Cache.maxFrustumHeight - m_Cache.leftCandidate.frustumHeight);
			m_Cache.currentFrustumHeight = m_Cache.leftCandidate.frustumHeight + m_Cache.stepSize;
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
					polygons = solution,
					frustumHeight = m_Cache.currentFrustumHeight
				};
				m_Cache.stepSize = Mathf.Max(m_Cache.stepSize / 2f, 0.005f);
			}
			else
			{
				m_Cache.leftCandidate = new PolygonSolution
				{
					polygons = solution,
					frustumHeight = m_Cache.currentFrustumHeight
				};
				if (!m_Cache.rightCandidate.IsNull)
				{
					m_Cache.stepSize = Mathf.Max(m_Cache.stepSize / 2f, 0.005f);
				}
			}
			if (!m_Cache.rightCandidate.IsNull && m_Cache.stepSize <= 0.005f)
			{
				m_Cache.solutions.Add(m_Cache.leftCandidate);
				m_Cache.solutions.Add(m_Cache.rightCandidate);
				m_Cache.leftCandidate = m_Cache.rightCandidate;
				m_Cache.rightCandidate = default(PolygonSolution);
				m_Cache.stepSize = m_Cache.maxFrustumHeight;
			}
			else if (m_Cache.rightCandidate.IsNull || m_Cache.leftCandidate.frustumHeight >= m_Cache.maxFrustumHeight)
			{
				m_Cache.solutions.Add(m_Cache.leftCandidate);
				break;
			}
			float num = Time.realtimeSinceStartup - realtimeSinceStartup;
			if (num > maxComputationTimePerFrameInSeconds)
			{
				m_Cache.bakeTime += num;
				if (m_Cache.bakeTime > m_MaxComputationTimeForFullSkeletonBakeInSeconds)
				{
					State = BakingState.TIMEOUT;
				}
				bakeProgress = m_Cache.leftCandidate.frustumHeight / m_Cache.maxFrustumHeight;
				return;
			}
		}
		ComputeSkeleton(in m_Cache.solutions);
		for (int num2 = m_Cache.solutions.Count - 1; num2 >= 0; num2--)
		{
			if (m_Cache.solutions[num2].polygons.Count == 0)
			{
				m_Cache.solutions.RemoveAt(num2);
			}
		}
		bakeProgress = 1f;
		State = BakingState.BAKED;
		void ComputeSkeleton(in List<PolygonSolution> solutions)
		{
			ClipperLib.Clipper clipper = new ClipperLib.Clipper();
			ClipperLib.ClipperOffset clipperOffset = new ClipperLib.ClipperOffset();
			for (int i = 1; i < solutions.Count - 1; i += 2)
			{
				PolygonSolution polygonSolution = solutions[i];
				PolygonSolution polygonSolution2 = solutions[i + 1];
				double num3 = 500000f * (polygonSolution2.frustumHeight - polygonSolution.frustumHeight);
				List<List<ClipperLib.IntPoint>> solution2 = new List<List<ClipperLib.IntPoint>>();
				clipperOffset.Clear();
				clipperOffset.AddPaths(polygonSolution.polygons, ClipperLib.JoinType.jtMiter, ClipperLib.EndType.etClosedPolygon);
				clipperOffset.Execute(ref solution2, num3);
				List<List<ClipperLib.IntPoint>> solution3 = new List<List<ClipperLib.IntPoint>>();
				clipperOffset.Clear();
				clipperOffset.AddPaths(polygonSolution2.polygons, ClipperLib.JoinType.jtMiter, ClipperLib.EndType.etClosedPolygon);
				clipperOffset.Execute(ref solution3, num3 * 2.0);
				List<List<ClipperLib.IntPoint>> list = new List<List<ClipperLib.IntPoint>>();
				clipper.Clear();
				clipper.AddPaths(solution2, ClipperLib.PolyType.ptSubject, closed: true);
				clipper.AddPaths(solution3, ClipperLib.PolyType.ptClip, closed: true);
				clipper.Execute(ClipperLib.ClipType.ctDifference, list, ClipperLib.PolyFillType.pftEvenOdd, ClipperLib.PolyFillType.pftEvenOdd);
				if (list.Count > 0 && list[0].Count > 0)
				{
					m_Skeleton.AddRange(list);
					if (m_MinFrustumHeightWithBones == float.MaxValue)
					{
						m_MinFrustumHeightWithBones = polygonSolution2.frustumHeight;
					}
				}
			}
		}
	}
}
