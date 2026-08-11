using System;
using Cinemachine.Utility;
using UnityEngine;

namespace Cinemachine;

[AddComponentMenu("Cinemachine/CinemachinePath")]
[DisallowMultipleComponent]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.9/manual/CinemachinePath.html")]
[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
[SaveDuringPlay]
public class CinemachinePath : CinemachinePathBase
{
	[Serializable]
	[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
	public struct Waypoint
	{
		[Tooltip("Position in path-local space")]
		public Vector3 position;

		[Tooltip("Offset from the position, which defines the tangent of the curve at the waypoint.  The length of the tangent encodes the strength of the bezier handle.  The same handle is used symmetrically on both sides of the waypoint, to ensure smoothness.")]
		public Vector3 tangent;

		[Tooltip("Defines the roll of the path at this waypoint.  The other orientation axes are inferred from the tangent and world up.")]
		public float roll;
	}

	[Tooltip("If checked, then the path ends are joined to form a continuous loop.")]
	public bool m_Looped;

	[Tooltip("The waypoints that define the path.  They will be interpolated using a bezier curve.")]
	public Waypoint[] m_Waypoints = Array.Empty<Waypoint>();

	public override float MinPos => 0f;

	public override float MaxPos
	{
		get
		{
			int num = m_Waypoints.Length - 1;
			if (num < 1)
			{
				return 0f;
			}
			return m_Looped ? (num + 1) : num;
		}
	}

	public override bool Looped => m_Looped;

	public override int DistanceCacheSampleStepsPerSegment => m_Resolution;

	private void Reset()
	{
		m_Looped = false;
		m_Waypoints = new Waypoint[2]
		{
			new Waypoint
			{
				position = new Vector3(0f, 0f, -5f),
				tangent = new Vector3(1f, 0f, 0f)
			},
			new Waypoint
			{
				position = new Vector3(0f, 0f, 5f),
				tangent = new Vector3(1f, 0f, 0f)
			}
		};
		m_Appearance = new Appearance();
		InvalidateDistanceCache();
	}

	private void OnValidate()
	{
		InvalidateDistanceCache();
	}

	private float GetBoundingIndices(float pos, out int indexA, out int indexB)
	{
		pos = StandardizePos(pos);
		int num = Mathf.RoundToInt(pos);
		if (Mathf.Abs(pos - (float)num) < 0.0001f)
		{
			indexA = (indexB = ((num != m_Waypoints.Length) ? num : 0));
		}
		else
		{
			indexA = Mathf.FloorToInt(pos);
			if (indexA >= m_Waypoints.Length)
			{
				pos -= MaxPos;
				indexA = 0;
			}
			indexB = Mathf.CeilToInt(pos);
			if (indexB >= m_Waypoints.Length)
			{
				indexB = 0;
			}
		}
		return pos;
	}

	public override Vector3 EvaluateLocalPosition(float pos)
	{
		Vector3 result = Vector3.zero;
		if (m_Waypoints.Length != 0)
		{
			pos = GetBoundingIndices(pos, out var indexA, out var indexB);
			if (indexA == indexB)
			{
				result = m_Waypoints[indexA].position;
			}
			else
			{
				Waypoint waypoint = m_Waypoints[indexA];
				Waypoint waypoint2 = m_Waypoints[indexB];
				result = SplineHelpers.Bezier3(pos - (float)indexA, m_Waypoints[indexA].position, waypoint.position + waypoint.tangent, waypoint2.position - waypoint2.tangent, waypoint2.position);
			}
		}
		return result;
	}

	public override Vector3 EvaluateLocalTangent(float pos)
	{
		Vector3 result = Vector3.forward;
		if (m_Waypoints.Length != 0)
		{
			pos = GetBoundingIndices(pos, out var indexA, out var indexB);
			if (indexA == indexB)
			{
				result = m_Waypoints[indexA].tangent;
			}
			else
			{
				Waypoint waypoint = m_Waypoints[indexA];
				Waypoint waypoint2 = m_Waypoints[indexB];
				result = SplineHelpers.BezierTangent3(pos - (float)indexA, m_Waypoints[indexA].position, waypoint.position + waypoint.tangent, waypoint2.position - waypoint2.tangent, waypoint2.position);
			}
		}
		return result;
	}

	public override Quaternion EvaluateLocalOrientation(float pos)
	{
		Quaternion result = Quaternion.identity;
		if (m_Waypoints.Length != 0)
		{
			pos = GetBoundingIndices(pos, out var indexA, out var indexB);
			Vector3 vector = EvaluateLocalTangent(pos);
			if (!vector.AlmostZero())
			{
				result = Quaternion.LookRotation(vector) * RollAroundForward(GetRoll(indexA, indexB, pos));
			}
		}
		return result;
	}

	internal float GetRoll(int indexA, int indexB, float standardizedPos)
	{
		if (indexA == indexB)
		{
			return m_Waypoints[indexA].roll;
		}
		float num = m_Waypoints[indexA].roll;
		float num2 = m_Waypoints[indexB].roll;
		if (indexB == 0)
		{
			num %= 360f;
			num2 %= 360f;
		}
		return Mathf.Lerp(num, num2, standardizedPos - (float)indexA);
	}

	private static Quaternion RollAroundForward(float angle)
	{
		float f = angle * 0.5f * (MathF.PI / 180f);
		return new Quaternion(0f, 0f, Mathf.Sin(f), Mathf.Cos(f));
	}
}
