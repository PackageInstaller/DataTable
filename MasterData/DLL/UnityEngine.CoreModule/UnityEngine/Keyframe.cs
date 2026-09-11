using System;
using UnityEngine.Scripting;

namespace UnityEngine;

[RequiredByNativeCode]
public struct Keyframe
{
	private float m_Time;

	private float m_Value;

	private float m_InTangent;

	private float m_OutTangent;

	private int m_WeightedMode;

	private float m_InWeight;

	private float m_OutWeight;

	public float time
	{
		get
		{
			return m_Time;
		}
		set
		{
			m_Time = value;
		}
	}

	public float value
	{
		get
		{
			return m_Value;
		}
		set
		{
			m_Value = value;
		}
	}

	public float inTangent
	{
		get
		{
			return m_InTangent;
		}
		set
		{
			m_InTangent = value;
		}
	}

	public float outTangent
	{
		get
		{
			return m_OutTangent;
		}
		set
		{
			m_OutTangent = value;
		}
	}

	public float inWeight
	{
		get
		{
			return m_InWeight;
		}
		set
		{
			m_InWeight = value;
		}
	}

	public float outWeight
	{
		get
		{
			return m_OutWeight;
		}
		set
		{
			m_OutWeight = value;
		}
	}

	public WeightedMode weightedMode
	{
		get
		{
			return (WeightedMode)m_WeightedMode;
		}
		set
		{
			m_WeightedMode = (int)value;
		}
	}

	[Obsolete("Use AnimationUtility.SetKeyLeftTangentMode, AnimationUtility.SetKeyRightTangentMode, AnimationUtility.GetKeyLeftTangentMode or AnimationUtility.GetKeyRightTangentMode instead.")]
	public int tangentMode
	{
		get
		{
			return tangentModeInternal;
		}
		set
		{
			tangentModeInternal = value;
		}
	}

	internal int tangentModeInternal
	{
		get
		{
			return 0;
		}
		set
		{
		}
	}

	public Keyframe(float time, float value)
	{
		m_Time = time;
		m_Value = value;
		m_InTangent = 0f;
		m_OutTangent = 0f;
		m_WeightedMode = 0;
		m_InWeight = 0f;
		m_OutWeight = 0f;
	}

	public Keyframe(float time, float value, float inTangent, float outTangent)
	{
		m_Time = time;
		m_Value = value;
		m_InTangent = inTangent;
		m_OutTangent = outTangent;
		m_WeightedMode = 0;
		m_InWeight = 0f;
		m_OutWeight = 0f;
	}

	public Keyframe(float time, float value, float inTangent, float outTangent, float inWeight, float outWeight)
	{
		m_Time = time;
		m_Value = value;
		m_InTangent = inTangent;
		m_OutTangent = outTangent;
		m_WeightedMode = 3;
		m_InWeight = inWeight;
		m_OutWeight = outWeight;
	}
}
