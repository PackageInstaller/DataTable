using System;
using Cinemachine.Utility;
using UnityEngine;

namespace Cinemachine;

public abstract class CinemachinePathBase : MonoBehaviour
{
	[Serializable]
	[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
	public class Appearance
	{
		[Tooltip("The color of the path itself when it is active in the editor")]
		public Color pathColor = Color.green;

		[Tooltip("The color of the path itself when it is inactive in the editor")]
		public Color inactivePathColor = Color.gray;

		[Tooltip("The width of the railroad-tracks that are drawn to represent the path")]
		[Range(0f, 10f)]
		public float width = 0.2f;
	}

	public enum PositionUnits
	{
		PathUnits,
		Distance,
		Normalized
	}

	[Tooltip("Path samples per waypoint.  This is used for calculating path distances.")]
	[Range(1f, 100f)]
	public int m_Resolution = 20;

	[Tooltip("The settings that control how the path will appear in the editor scene view.")]
	public Appearance m_Appearance = new Appearance();

	private float[] m_DistanceToPos;

	private float[] m_PosToDistance;

	private int m_CachedSampleSteps;

	private float m_PathLength;

	private float m_cachedPosStepSize;

	private float m_cachedDistanceStepSize;

	public abstract float MinPos { get; }

	public abstract float MaxPos { get; }

	public abstract bool Looped { get; }

	public abstract int DistanceCacheSampleStepsPerSegment { get; }

	public float PathLength
	{
		get
		{
			if (DistanceCacheSampleStepsPerSegment < 1)
			{
				return 0f;
			}
			if (!DistanceCacheIsValid())
			{
				ResamplePath(DistanceCacheSampleStepsPerSegment);
			}
			return m_PathLength;
		}
	}

	public virtual float StandardizePos(float pos)
	{
		if (Looped && MaxPos > 0f)
		{
			pos %= MaxPos;
			if (pos < 0f)
			{
				pos += MaxPos;
			}
			return pos;
		}
		return Mathf.Clamp(pos, 0f, MaxPos);
	}

	public virtual Vector3 EvaluatePosition(float pos)
	{
		return base.transform.TransformPoint(EvaluateLocalPosition(pos));
	}

	public virtual Vector3 EvaluateTangent(float pos)
	{
		return base.transform.TransformDirection(EvaluateLocalTangent(pos));
	}

	public virtual Quaternion EvaluateOrientation(float pos)
	{
		return base.transform.rotation * EvaluateLocalOrientation(pos);
	}

	public abstract Vector3 EvaluateLocalPosition(float pos);

	public abstract Vector3 EvaluateLocalTangent(float pos);

	public abstract Quaternion EvaluateLocalOrientation(float pos);

	public virtual float FindClosestPoint(Vector3 p, int startSegment, int searchRadius, int stepsPerSegment)
	{
		float num = MinPos;
		float num2 = MaxPos;
		if (searchRadius >= 0)
		{
			if (Looped)
			{
				int num3 = Mathf.Min(searchRadius, Mathf.FloorToInt((num2 - num) / 2f));
				num = startSegment - num3;
				num2 = startSegment + num3 + 1;
			}
			else
			{
				num = Mathf.Max(startSegment - searchRadius, MinPos);
				num2 = Mathf.Min(startSegment + searchRadius + 1, MaxPos);
			}
		}
		stepsPerSegment = Mathf.RoundToInt(Mathf.Clamp(stepsPerSegment, 1f, 100f));
		float num4 = 1f / (float)stepsPerSegment;
		float num5 = startSegment;
		float num6 = float.MaxValue;
		int num7 = ((stepsPerSegment == 1) ? 1 : 3);
		for (int i = 0; i < num7; i++)
		{
			Vector3 vector = EvaluatePosition(num);
			for (float num8 = num + num4; num8 <= num2; num8 += num4)
			{
				Vector3 vector2 = EvaluatePosition(num8);
				float num9 = p.ClosestPointOnSegment(vector, vector2);
				float num10 = Vector3.SqrMagnitude(p - Vector3.Lerp(vector, vector2, num9));
				if (num10 < num6)
				{
					num6 = num10;
					num5 = num8 - (1f - num9) * num4;
				}
				vector = vector2;
			}
			num = num5 - num4;
			num2 = num5 + num4;
			num4 /= (float)stepsPerSegment;
		}
		return num5;
	}

	public float MinUnit(PositionUnits units)
	{
		return units switch
		{
			PositionUnits.Normalized => 0f, 
			PositionUnits.Distance => 0f, 
			_ => MinPos, 
		};
	}

	public float MaxUnit(PositionUnits units)
	{
		return units switch
		{
			PositionUnits.Normalized => 1f, 
			PositionUnits.Distance => PathLength, 
			_ => MaxPos, 
		};
	}

	public virtual float StandardizeUnit(float pos, PositionUnits units)
	{
		switch (units)
		{
		case PositionUnits.PathUnits:
			return StandardizePos(pos);
		case PositionUnits.Distance:
			return StandardizePathDistance(pos);
		default:
		{
			float pathLength = PathLength;
			if (pathLength < 0.0001f)
			{
				return 0f;
			}
			return StandardizePathDistance(pos * pathLength) / pathLength;
		}
		}
	}

	public Vector3 EvaluatePositionAtUnit(float pos, PositionUnits units)
	{
		return EvaluatePosition(ToNativePathUnits(pos, units));
	}

	public Vector3 EvaluateTangentAtUnit(float pos, PositionUnits units)
	{
		return EvaluateTangent(ToNativePathUnits(pos, units));
	}

	public Quaternion EvaluateOrientationAtUnit(float pos, PositionUnits units)
	{
		return EvaluateOrientation(ToNativePathUnits(pos, units));
	}

	public virtual void InvalidateDistanceCache()
	{
		m_DistanceToPos = null;
		m_PosToDistance = null;
		m_CachedSampleSteps = 0;
		m_PathLength = 0f;
	}

	public bool DistanceCacheIsValid()
	{
		if (MaxPos != MinPos)
		{
			if (m_DistanceToPos != null && m_PosToDistance != null && m_CachedSampleSteps == DistanceCacheSampleStepsPerSegment)
			{
				return m_CachedSampleSteps > 0;
			}
			return false;
		}
		return true;
	}

	public float StandardizePathDistance(float distance)
	{
		float pathLength = PathLength;
		if (pathLength < 1E-05f)
		{
			return 0f;
		}
		if (Looped)
		{
			distance %= pathLength;
			if (distance < 0f)
			{
				distance += pathLength;
			}
		}
		return Mathf.Clamp(distance, 0f, pathLength);
	}

	public float ToNativePathUnits(float pos, PositionUnits units)
	{
		if (units == PositionUnits.PathUnits)
		{
			return pos;
		}
		if (DistanceCacheSampleStepsPerSegment < 1 || PathLength < 0.0001f)
		{
			return MinPos;
		}
		if (units == PositionUnits.Normalized)
		{
			pos *= PathLength;
		}
		pos = StandardizePathDistance(pos);
		float num = pos / m_cachedDistanceStepSize;
		int num2 = Mathf.FloorToInt(num);
		if (num2 >= m_DistanceToPos.Length - 1)
		{
			return MaxPos;
		}
		float t = num - (float)num2;
		return MinPos + Mathf.Lerp(m_DistanceToPos[num2], m_DistanceToPos[num2 + 1], t);
	}

	public float FromPathNativeUnits(float pos, PositionUnits units)
	{
		if (units == PositionUnits.PathUnits)
		{
			return pos;
		}
		float pathLength = PathLength;
		if (DistanceCacheSampleStepsPerSegment < 1 || pathLength < 0.0001f)
		{
			return 0f;
		}
		pos = StandardizePos(pos);
		float num = pos / m_cachedPosStepSize;
		int num2 = Mathf.FloorToInt(num);
		if (num2 >= m_PosToDistance.Length - 1)
		{
			pos = m_PathLength;
		}
		else
		{
			float t = num - (float)num2;
			pos = Mathf.Lerp(m_PosToDistance[num2], m_PosToDistance[num2 + 1], t);
		}
		if (units == PositionUnits.Normalized)
		{
			pos /= pathLength;
		}
		return pos;
	}

	private void ResamplePath(int stepsPerSegment)
	{
		InvalidateDistanceCache();
		float minPos = MinPos;
		float maxPos = MaxPos;
		float num = 1f / (float)Mathf.Max(1, stepsPerSegment);
		int num2 = Mathf.RoundToInt((maxPos - minPos) / num) + 1;
		m_PosToDistance = new float[num2];
		m_CachedSampleSteps = stepsPerSegment;
		m_cachedPosStepSize = num;
		Vector3 a = EvaluatePosition(0f);
		m_PosToDistance[0] = 0f;
		float num3 = minPos;
		for (int i = 1; i < num2; i++)
		{
			num3 += num;
			Vector3 vector = EvaluatePosition(num3);
			float num4 = Vector3.Distance(a, vector);
			m_PathLength += num4;
			a = vector;
			m_PosToDistance[i] = m_PathLength;
		}
		m_DistanceToPos = new float[num2];
		m_DistanceToPos[0] = 0f;
		if (num2 <= 1)
		{
			return;
		}
		num = (m_cachedDistanceStepSize = m_PathLength / (float)(num2 - 1));
		float num5 = 0f;
		int num6 = 1;
		for (int j = 1; j < num2; j++)
		{
			num5 += num;
			float num7 = m_PosToDistance[num6];
			while (num7 < num5 && num6 < num2 - 1)
			{
				num7 = m_PosToDistance[++num6];
			}
			float num8 = m_PosToDistance[num6 - 1];
			float num9 = num7 - num8;
			float num10 = (num5 - num8) / num9;
			m_DistanceToPos[j] = m_cachedPosStepSize * (num10 + (float)num6 - 1f);
		}
	}
}
