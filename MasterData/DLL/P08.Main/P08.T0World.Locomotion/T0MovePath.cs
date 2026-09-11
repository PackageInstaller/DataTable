using System;
using Cinemachine;
using Cinemachine.Utility;
using UnityEngine;

namespace P08.T0World.Locomotion;

public class T0MovePath : CinemachinePathBase
{
	public bool m_Looped;

	public bool worldSpacePath;

	public float aplha = 0.5f;

	public CinemachineSmoothPath.Waypoint[] m_Waypoints = new CinemachineSmoothPath.Waypoint[0];

	public CinemachineSmoothPath.Waypoint controlPointIn;

	public CinemachineSmoothPath.Waypoint controlPointOut;

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

	public override Quaternion EvaluateOrientation(float pos)
	{
		Quaternion obj = (worldSpacePath ? Quaternion.identity : base.transform.rotation);
		Vector3 upwards = obj * Vector3.up;
		Quaternion result = obj;
		if (m_Waypoints.Length != 0)
		{
			pos = GetBoundingIndices(pos, out var indexA, out var indexB);
			float angle = ((indexA != indexB) ? SplineHelpers.CatmullRom1(pos - (float)indexA, GetLeftControlPoint(indexA).roll, m_Waypoints[indexA].roll, m_Waypoints[indexB].roll, GetRightControlPoint(indexB).roll, aplha) : m_Waypoints[indexA].roll);
			Vector3 vector = EvaluateTangent(pos);
			if (!vector.AlmostZero())
			{
				vector.y = 0f;
				result = Quaternion.LookRotation(vector, upwards) * RollAroundForward(angle);
			}
		}
		return result;
	}

	public override Vector3 EvaluatePosition(float pos)
	{
		Vector3 vector = Vector3.zero;
		if (m_Waypoints.Length != 0)
		{
			pos = GetBoundingIndices(pos, out var indexA, out var indexB);
			vector = ((indexA != indexB) ? SplineHelpers.CatmullRom3(pos - (float)indexA, GetLeftControlPoint(indexA).position, m_Waypoints[indexA].position, m_Waypoints[indexB].position, GetRightControlPoint(indexB).position, aplha) : m_Waypoints[indexA].position);
		}
		if (worldSpacePath)
		{
			return vector;
		}
		return base.transform.TransformPoint(vector);
	}

	public override Vector3 EvaluateTangent(float pos)
	{
		Vector3 vector = Vector3.forward;
		if (m_Waypoints.Length > 1)
		{
			pos = GetBoundingIndices(pos, out var indexA, out var indexB);
			if (!Looped && indexA == m_Waypoints.Length - 1)
			{
				indexA--;
			}
			vector = SplineHelpers.CatmullRomTangant3(pos - (float)indexA, GetLeftControlPoint(indexA).position, m_Waypoints[indexA].position, m_Waypoints[indexB].position, GetRightControlPoint(indexB).position, aplha);
		}
		if (worldSpacePath)
		{
			return vector;
		}
		return base.transform.TransformDirection(vector);
	}

	private CinemachineSmoothPath.Waypoint GetLeftControlPoint(int index)
	{
		if (index == 0)
		{
			if (Looped)
			{
				CinemachineSmoothPath.Waypoint[] waypoints = m_Waypoints;
				return waypoints[waypoints.Length - 1];
			}
			return controlPointIn;
		}
		index = Math.Clamp(index, 1, m_Waypoints.Length - 1);
		return m_Waypoints[index - 1];
	}

	private CinemachineSmoothPath.Waypoint GetRightControlPoint(int index)
	{
		if (index == m_Waypoints.Length - 1)
		{
			if (Looped)
			{
				return m_Waypoints[0];
			}
			return controlPointOut;
		}
		index = Math.Clamp(index, 0, m_Waypoints.Length - 2);
		return m_Waypoints[index + 1];
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

	private static Quaternion RollAroundForward(float angle)
	{
		float f = angle * 0.5f * (MathF.PI / 180f);
		return new Quaternion(0f, 0f, Mathf.Sin(f), Mathf.Cos(f));
	}
}
