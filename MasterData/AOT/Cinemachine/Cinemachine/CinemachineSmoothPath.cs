using System;
using Cinemachine.Utility;
using UnityEngine;

namespace Cinemachine;

[AddComponentMenu("Cinemachine/CinemachineSmoothPath")]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.8/manual/CinemachineSmoothPath.html")]
[DisallowMultipleComponent]
[SaveDuringPlay]
[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
public class CinemachineSmoothPath : CinemachinePathBase
{
	[Serializable]
	[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
	public struct Waypoint
	{
		[Tooltip("Position in path-local space")]
		public Vector3 position;

		[Tooltip("Defines the roll of the path at this waypoint.  The other orientation axes are inferred from the tangent and world up.")]
		public float roll;

		internal Vector4 AsVector4 => new Vector4(position.x, position.y, position.z, roll);

		internal static Waypoint FromVector4(Vector4 v)
		{
			return new Waypoint
			{
				position = new Vector3(v[0], v[1], v[2]),
				roll = v[3]
			};
		}
	}

	[Tooltip("If checked, then the path ends are joined to form a continuous loop.")]
	public bool m_Looped;

	[Tooltip("The waypoints that define the path.  They will be interpolated using a bezier curve.")]
	public Waypoint[] m_Waypoints = new Waypoint[0];

	private Waypoint[] m_ControlPoints1;

	private Waypoint[] m_ControlPoints2;

	private bool m_IsLoopedCache;

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

	private void OnValidate()
	{
		InvalidateDistanceCache();
	}

	private void Reset()
	{
		m_Looped = false;
		m_Waypoints = new Waypoint[2]
		{
			new Waypoint
			{
				position = new Vector3(0f, 0f, -5f)
			},
			new Waypoint
			{
				position = new Vector3(0f, 0f, 5f)
			}
		};
		m_Appearance = new Appearance();
		InvalidateDistanceCache();
	}

	public override void InvalidateDistanceCache()
	{
		base.InvalidateDistanceCache();
		m_ControlPoints1 = null;
		m_ControlPoints2 = null;
	}

	private void UpdateControlPoints()
	{
		int num = ((m_Waypoints != null) ? m_Waypoints.Length : 0);
		if (num > 1 && (Looped != m_IsLoopedCache || m_ControlPoints1 == null || m_ControlPoints1.Length != num || m_ControlPoints2 == null || m_ControlPoints2.Length != num))
		{
			Vector4[] ctrl = new Vector4[num];
			Vector4[] ctrl2 = new Vector4[num];
			Vector4[] knot = new Vector4[num];
			for (int i = 0; i < num; i++)
			{
				knot[i] = m_Waypoints[i].AsVector4;
			}
			if (Looped)
			{
				SplineHelpers.ComputeSmoothControlPointsLooped(ref knot, ref ctrl, ref ctrl2);
			}
			else
			{
				SplineHelpers.ComputeSmoothControlPoints(ref knot, ref ctrl, ref ctrl2);
			}
			m_ControlPoints1 = new Waypoint[num];
			m_ControlPoints2 = new Waypoint[num];
			for (int j = 0; j < num; j++)
			{
				m_ControlPoints1[j] = Waypoint.FromVector4(ctrl[j]);
				m_ControlPoints2[j] = Waypoint.FromVector4(ctrl2[j]);
			}
			m_IsLoopedCache = Looped;
		}
	}

	private float GetBoundingIndices(float pos, out int indexA, out int indexB)
	{
		pos = StandardizePos(pos);
		int num = m_Waypoints.Length;
		if (num < 2)
		{
			indexA = (indexB = 0);
		}
		else
		{
			indexA = Mathf.FloorToInt(pos);
			if (indexA >= num)
			{
				pos -= MaxPos;
				indexA = 0;
			}
			indexB = indexA + 1;
			if (indexB == num)
			{
				if (Looped)
				{
					indexB = 0;
				}
				else
				{
					indexB--;
					indexA--;
				}
			}
		}
		return pos;
	}

	public override Vector3 EvaluatePosition(float pos)
	{
		Vector3 position = Vector3.zero;
		if (m_Waypoints.Length != 0)
		{
			UpdateControlPoints();
			pos = GetBoundingIndices(pos, out var indexA, out var indexB);
			position = ((indexA != indexB) ? SplineHelpers.Bezier3(pos - (float)indexA, m_Waypoints[indexA].position, m_ControlPoints1[indexA].position, m_ControlPoints2[indexA].position, m_Waypoints[indexB].position) : m_Waypoints[indexA].position);
		}
		return transform.TransformPoint(position);
	}

	public override Vector3 EvaluateTangent(float pos)
	{
		Vector3 direction = transform.rotation * Vector3.forward;
		if (m_Waypoints.Length > 1)
		{
			UpdateControlPoints();
			pos = GetBoundingIndices(pos, out var indexA, out var indexB);
			if (!Looped && indexA == m_Waypoints.Length - 1)
			{
				indexA--;
			}
			direction = SplineHelpers.BezierTangent3(pos - (float)indexA, m_Waypoints[indexA].position, m_ControlPoints1[indexA].position, m_ControlPoints2[indexA].position, m_Waypoints[indexB].position);
		}
		return transform.TransformDirection(direction);
	}

	public override Quaternion EvaluateOrientation(float pos)
	{
		Quaternion rotation = transform.rotation;
		Vector3 upwards = rotation * Vector3.up;
		Quaternion result = rotation;
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
				UpdateControlPoints();
				num = SplineHelpers.Bezier1(pos - (float)indexA, m_Waypoints[indexA].roll, m_ControlPoints1[indexA].roll, m_ControlPoints2[indexA].roll, m_Waypoints[indexB].roll);
			}
			Vector3 vector = EvaluateTangent(pos);
			if (!vector.AlmostZero())
			{
				result = Quaternion.LookRotation(vector, upwards) * RollAroundForward(num);
			}
		}
		return result;
	}

	private Quaternion RollAroundForward(float angle)
	{
		float f = angle * 0.5f * (MathF.PI / 180f);
		return new Quaternion(0f, 0f, Mathf.Sin(f), Mathf.Cos(f));
	}
}
