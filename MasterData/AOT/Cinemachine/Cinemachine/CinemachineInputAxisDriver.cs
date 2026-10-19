using System;
using Cinemachine.Utility;
using UnityEngine;

namespace Cinemachine;

[Serializable]
public struct CinemachineInputAxisDriver
{
	[Tooltip("Multiply the input by this amount prior to processing.  Controls the input power.")]
	public float multiplier;

	[Tooltip("The amount of time in seconds it takes to accelerate to a higher speed")]
	public float accelTime;

	[Tooltip("The amount of time in seconds it takes to decelerate to a lower speed")]
	public float decelTime;

	[Tooltip("The name of this axis as specified in Unity Input manager. Setting to an empty string will disable the automatic updating of this axis")]
	public string name;

	[NoSaveDuringPlay]
	[Tooltip("The value of the input axis.  A value of 0 means no input.  You can drive this directly from a custom input system, or you can set the Axis Name and have the value driven by the internal Input Manager")]
	public float inputValue;

	private float mCurrentSpeed;

	private const float Epsilon = 0.0001f;

	public void Validate()
	{
		accelTime = Mathf.Max(0f, accelTime);
		decelTime = Mathf.Max(0f, decelTime);
	}

	public bool Update(float deltaTime, ref AxisBase axis)
	{
		if (!string.IsNullOrEmpty(name))
		{
			try
			{
				inputValue = CinemachineCore.GetInputAxis(name);
			}
			catch (ArgumentException)
			{
			}
		}
		float num = inputValue * multiplier;
		if (deltaTime < 0.0001f)
		{
			mCurrentSpeed = 0f;
		}
		else
		{
			float num2 = num / deltaTime;
			float dampTime = ((Mathf.Abs(num2) < Mathf.Abs(mCurrentSpeed)) ? decelTime : accelTime);
			num2 = (mCurrentSpeed += Damper.Damp(num2 - mCurrentSpeed, dampTime, deltaTime));
			float num3 = axis.m_MaxValue - axis.m_MinValue;
			if (!axis.m_Wrap && decelTime > 0.0001f && num3 > 0.0001f)
			{
				float num4 = ClampValue(ref axis, axis.m_Value);
				float num5 = ClampValue(ref axis, num4 + num2 * deltaTime);
				if (((num2 > 0f) ? (axis.m_MaxValue - num5) : (num5 - axis.m_MinValue)) < 0.1f * num3 && Mathf.Abs(num2) > 0.0001f)
				{
					num2 = Damper.Damp(num5 - num4, decelTime, deltaTime) / deltaTime;
				}
			}
			num = num2 * deltaTime;
		}
		axis.m_Value = ClampValue(ref axis, axis.m_Value + num);
		return Mathf.Abs(inputValue) > 0.0001f;
	}

	public bool Update(float deltaTime, ref AxisState axis)
	{
		AxisBase axis2 = new AxisBase
		{
			m_Value = axis.Value,
			m_MinValue = axis.m_MinValue,
			m_MaxValue = axis.m_MaxValue,
			m_Wrap = axis.m_Wrap
		};
		bool result = Update(deltaTime, ref axis2);
		axis.Value = axis2.m_Value;
		return result;
	}

	private float ClampValue(ref AxisBase axis, float v)
	{
		float num = axis.m_MaxValue - axis.m_MinValue;
		if (axis.m_Wrap && num > 0.0001f)
		{
			v = (v - axis.m_MinValue) % num;
			v += axis.m_MinValue + ((v < 0f) ? num : 0f);
		}
		return Mathf.Clamp(v, axis.m_MinValue, axis.m_MaxValue);
	}
}
