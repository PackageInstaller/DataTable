using System;
using Cinemachine.Utility;
using UnityEngine;

namespace Cinemachine;

[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
[SaveDuringPlay]
[DisallowMultipleComponent]
[AddComponentMenu("Cinemachine/CinemachinePath")]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.8/manual/CinemachinePath.html")]
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
	public Waypoint[] m_Waypoints = new Waypoint[0];

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

	public override Vector3 EvaluatePosition(float pos)
	{
		Vector3 vector = default;
		if (m_Waypoints.Length == 0)
		{
			vector = transform.position;
		}
		else
		{
			pos = GetBoundingIndices(pos, out var indexA, out var indexB);
			if (indexA == indexB)
			{
				vector = m_Waypoints[indexA].position;
			}
			else
			{
				Waypoint waypoint = m_Waypoints[indexA];
				Waypoint waypoint2 = m_Waypoints[indexB];
				vector = SplineHelpers.Bezier3(pos - (float)indexA, m_Waypoints[indexA].position, waypoint.position + waypoint.tangent, waypoint2.position - waypoint2.tangent, waypoint2.position);
			}
		}
		return transform.TransformPoint(vector);
	}

	public override Vector3 EvaluateTangent(float pos)
	{
		Vector3 vector = default;
		if (m_Waypoints.Length == 0)
		{
			vector = transform.rotation * Vector3.forward;
		}
		else
		{
			pos = GetBoundingIndices(pos, out var indexA, out var indexB);
			if (indexA == indexB)
			{
				vector = m_Waypoints[indexA].tangent;
			}
			else
			{
				Waypoint waypoint = m_Waypoints[indexA];
				Waypoint waypoint2 = m_Waypoints[indexB];
				vector = SplineHelpers.BezierTangent3(pos - (float)indexA, m_Waypoints[indexA].position, waypoint.position + waypoint.tangent, waypoint2.position - waypoint2.tangent, waypoint2.position);
			}
		}
		return transform.TransformDirection(vector);
	}

	public override Quaternion EvaluateOrientation(float pos)
	{
		Quaternion result = transform.rotation;
		if (m_Waypoints.Length != 0)
		{
			float num = 0f;
			pos = GetBoundingIndices(pos, out var indexA, out var indexB);
			if (indexA == indexB)
			{
				num = m_Waypoints[indexA].roll;
			}
			else
			{
				float num2 = m_Waypoints[indexA].roll;
				float num3 = m_Waypoints[indexB].roll;
				if (indexB == 0)
				{
					num2 %= 360f;
					num3 %= 360f;
				}
				num = Mathf.Lerp(num2, num3, pos - (float)indexA);
			}
			Vector3 vector = EvaluateTangent(pos);
			if (!vector.AlmostZero())
			{
				Vector3 upwards = transform.rotation * Vector3.up;
				result = Quaternion.LookRotation(vector, upwards) * Quaternion.AngleAxis(num, Vector3.forward);
			}
		}
		return result;
	}

	private void OnValidate()
	{
		InvalidateDistanceCache();
	}
}
