using System;
using Cinemachine.Utility;
using UnityEngine;
using UnityEngine.Serialization;

namespace Cinemachine;

[Serializable]
[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
public struct AxisState(float minValue, float maxValue, bool wrap, bool rangeLocked, float maxSpeed, float accelTime, float decelTime, string name, bool invert)
{
	public enum SpeedMode
	{
		MaxSpeed,
		InputValueGain
	}

	public interface IInputAxisProvider
	{
		float GetAxisValue(int axis);
	}

	[Serializable]
	[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
	public struct Recentering(bool enabled, float waitTime, float recenteringTime)
	{
		[Tooltip("If checked, will enable automatic recentering of the axis. If unchecked, recenting is disabled.")]
		public bool m_enabled = enabled;

		[Tooltip("If no user input has been detected on the axis, the axis will wait this long in seconds before recentering.")]
		public float m_WaitTime = waitTime;

		[Tooltip("How long it takes to reach destination once recentering has started.")]
		public float m_RecenteringTime = recenteringTime;

		private float m_LastUpdateTime = 0f;

		private float mLastAxisInputTime = 0f;

		private float mRecenteringVelocity = 0f;

		[SerializeField]
		[FormerlySerializedAs("m_HeadingDefinition")]
		[HideInInspector]
		private int m_LegacyHeadingDefinition = (m_LegacyVelocityFilterStrength = -1);

		[SerializeField]
		[FormerlySerializedAs("m_VelocityFilterStrength")]
		[HideInInspector]
		private int m_LegacyVelocityFilterStrength;

		public void Validate()
		{
			m_WaitTime = Mathf.Max(0f, m_WaitTime);
			m_RecenteringTime = Mathf.Max(0f, m_RecenteringTime);
		}

		public void CopyStateFrom(ref Recentering other)
		{
			if (mLastAxisInputTime != other.mLastAxisInputTime)
			{
				other.mRecenteringVelocity = 0f;
			}
			mLastAxisInputTime = other.mLastAxisInputTime;
		}

		public void CancelRecentering()
		{
			mLastAxisInputTime = Time.realtimeSinceStartup;
			mRecenteringVelocity = 0f;
		}

		public void RecenterNow()
		{
			mLastAxisInputTime = -1f;
		}

		public void DoRecentering(ref AxisState axis, float deltaTime, float recenterTarget)
		{
			if (deltaTime > 0f)
			{
				deltaTime = Time.realtimeSinceStartup - m_LastUpdateTime;
			}
			m_LastUpdateTime = Time.realtimeSinceStartup;
			if (!m_enabled && deltaTime >= 0f)
			{
				return;
			}
			recenterTarget = axis.ClampValue(recenterTarget);
			if (deltaTime < 0f)
			{
				CancelRecentering();
				if (m_enabled)
				{
					axis.Value = recenterTarget;
				}
				return;
			}
			float num = axis.ClampValue(axis.Value);
			float num2 = recenterTarget - num;
			if (num2 != 0f && (!(mLastAxisInputTime >= 0f) || !(Time.realtimeSinceStartup < mLastAxisInputTime + m_WaitTime)))
			{
				float num3 = axis.m_MaxValue - axis.m_MinValue;
				if (axis.m_Wrap && Mathf.Abs(num2) > num3 * 0.5f)
				{
					num += Mathf.Sign(recenterTarget - num) * num3;
				}
				num = ((!(m_RecenteringTime < 0.001f) && !(Mathf.Abs(num - recenterTarget) < 0.001f)) ? Mathf.SmoothDamp(num, recenterTarget, ref mRecenteringVelocity, m_RecenteringTime, 9999f, deltaTime) : recenterTarget);
				axis.Value = axis.ClampValue(num);
			}
		}

		internal bool LegacyUpgrade(ref int heading, ref int velocityFilter)
		{
			if (m_LegacyHeadingDefinition != -1 && m_LegacyVelocityFilterStrength != -1)
			{
				heading = m_LegacyHeadingDefinition;
				velocityFilter = m_LegacyVelocityFilterStrength;
				m_LegacyHeadingDefinition = (m_LegacyVelocityFilterStrength = -1);
				return true;
			}
			return false;
		}
	}

	[NoSaveDuringPlay]
	[Tooltip("The current value of the axis.")]
	public float Value = (minValue + maxValue) / 2f;

	[Tooltip("How to interpret the Max Speed setting: in units/second, or as a direct input value multiplier")]
	public SpeedMode m_SpeedMode = SpeedMode.MaxSpeed;

	[Tooltip("The maximum speed of this axis in units/second, or the input value multiplier, depending on the Speed Mode")]
	public float m_MaxSpeed = maxSpeed;

	[Tooltip("The amount of time in seconds it takes to accelerate to MaxSpeed with the supplied Axis at its maximum value")]
	public float m_AccelTime = accelTime;

	[Tooltip("The amount of time in seconds it takes to decelerate the axis to zero if the supplied axis is in a neutral position")]
	public float m_DecelTime = decelTime;

	[FormerlySerializedAs("m_AxisName")]
	[Tooltip("The name of this axis as specified in Unity Input manager. Setting to an empty string will disable the automatic updating of this axis")]
	public string m_InputAxisName = name;

	[Tooltip("The value of the input axis.  A value of 0 means no input.  You can drive this directly from a custom input system, or you can set the Axis Name and have the value driven by the internal Input Manager")]
	[NoSaveDuringPlay]
	public float m_InputAxisValue = 0f;

	[Tooltip("If checked, then the raw value of the input axis will be inverted before it is used")]
	[FormerlySerializedAs("m_InvertAxis")]
	public bool m_InvertInput = invert;

	[Tooltip("The minimum value for the axis")]
	public float m_MinValue = minValue;

	[Tooltip("The maximum value for the axis")]
	public float m_MaxValue = maxValue;

	[Tooltip("If checked, then the axis will wrap around at the min/max values, forming a loop")]
	public bool m_Wrap = wrap;

	[Tooltip("Automatic recentering to at-rest position")]
	public Recentering m_Recentering = new Recentering(enabled: false, 1f, 2f);

	private float m_CurrentSpeed = 0f;

	private float m_LastUpdateTime = 0f;

	private int m_LastUpdateFrame = 0;

	private const float Epsilon = 0.0001f;

	private IInputAxisProvider m_InputAxisProvider = null;

	private int m_InputAxisIndex = 0;

	public bool HasInputProvider => m_InputAxisProvider != null;

	public bool ValueRangeLocked { get; set; } = rangeLocked;

	public bool HasRecentering { get; set; } = false;

	public void Validate()
	{
		if (m_SpeedMode == SpeedMode.MaxSpeed)
		{
			m_MaxSpeed = Mathf.Max(0f, m_MaxSpeed);
		}
		m_AccelTime = Mathf.Max(0f, m_AccelTime);
		m_DecelTime = Mathf.Max(0f, m_DecelTime);
		m_MaxValue = Mathf.Clamp(m_MaxValue, m_MinValue, m_MaxValue);
	}

	public void Reset()
	{
		m_InputAxisValue = 0f;
		m_CurrentSpeed = 0f;
		m_LastUpdateTime = 0f;
		m_LastUpdateFrame = 0;
	}

	public void SetInputAxisProvider(int axis, IInputAxisProvider provider)
	{
		m_InputAxisIndex = axis;
		m_InputAxisProvider = provider;
	}

	public bool Update(float deltaTime)
	{
		if (Time.frameCount == m_LastUpdateFrame)
		{
			return false;
		}
		m_LastUpdateFrame = Time.frameCount;
		if (deltaTime > 0f && m_LastUpdateTime != 0f)
		{
			deltaTime = Time.realtimeSinceStartup - m_LastUpdateTime;
		}
		m_LastUpdateTime = Time.realtimeSinceStartup;
		if (m_InputAxisProvider != null)
		{
			m_InputAxisValue = m_InputAxisProvider.GetAxisValue(m_InputAxisIndex);
		}
		else if (!string.IsNullOrEmpty(m_InputAxisName))
		{
			try
			{
				m_InputAxisValue = CinemachineCore.GetInputAxis(m_InputAxisName);
			}
			catch (ArgumentException ex)
			{
				Debug.LogError(ex.ToString());
			}
		}
		float num = m_InputAxisValue;
		if (m_InvertInput)
		{
			num *= -1f;
		}
		if (m_SpeedMode == SpeedMode.MaxSpeed)
		{
			return MaxSpeedUpdate(num, deltaTime);
		}
		num *= m_MaxSpeed;
		if (deltaTime < 0f)
		{
			m_CurrentSpeed = 0f;
		}
		else if (deltaTime > 0.0001f)
		{
			float dampTime = ((Mathf.Abs(num) < Mathf.Abs(m_CurrentSpeed)) ? m_DecelTime : m_AccelTime);
			m_CurrentSpeed += Damper.Damp(num - m_CurrentSpeed, dampTime, deltaTime);
			float num2 = m_MaxValue - m_MinValue;
			if (!m_Wrap && m_DecelTime > 0.0001f && num2 > 0.0001f)
			{
				float num3 = ClampValue(Value);
				float num4 = ClampValue(num3 + m_CurrentSpeed * deltaTime);
				if (((m_CurrentSpeed > 0f) ? (m_MaxValue - num4) : (num4 - m_MinValue)) < 0.1f * num2 && Mathf.Abs(m_CurrentSpeed) > 0.0001f)
				{
					m_CurrentSpeed = Damper.Damp(num4 - num3, m_DecelTime, deltaTime) / deltaTime;
				}
			}
			num = m_CurrentSpeed * deltaTime;
		}
		Value = ClampValue(Value + m_CurrentSpeed);
		return Mathf.Abs(num) > 0.0001f;
	}

	private float ClampValue(float v)
	{
		float num = m_MaxValue - m_MinValue;
		if (m_Wrap && num > 0.0001f)
		{
			v = (v - m_MinValue) % num;
			v += m_MinValue + ((v < 0f) ? num : 0f);
		}
		return Mathf.Clamp(v, m_MinValue, m_MaxValue);
	}

	private bool MaxSpeedUpdate(float input, float deltaTime)
	{
		if (m_MaxSpeed > 0.0001f)
		{
			float num = input * m_MaxSpeed;
			if (Mathf.Abs(num) < 0.0001f || (Mathf.Sign(m_CurrentSpeed) == Mathf.Sign(num) && Mathf.Abs(num) < Mathf.Abs(m_CurrentSpeed)))
			{
				float num2 = Mathf.Min(Mathf.Abs(num - m_CurrentSpeed) / Mathf.Max(0.0001f, m_DecelTime) * deltaTime, Mathf.Abs(m_CurrentSpeed));
				m_CurrentSpeed -= Mathf.Sign(m_CurrentSpeed) * num2;
			}
			else
			{
				float num3 = Mathf.Abs(num - m_CurrentSpeed) / Mathf.Max(0.0001f, m_AccelTime);
				m_CurrentSpeed += Mathf.Sign(num) * num3 * deltaTime;
				if (Mathf.Sign(m_CurrentSpeed) == Mathf.Sign(num) && Mathf.Abs(m_CurrentSpeed) > Mathf.Abs(num))
				{
					m_CurrentSpeed = num;
				}
			}
		}
		float maxSpeed = GetMaxSpeed();
		m_CurrentSpeed = Mathf.Clamp(m_CurrentSpeed, 0f - maxSpeed, maxSpeed);
		if (Mathf.Abs(m_CurrentSpeed) < 0.0001f)
		{
			m_CurrentSpeed = 0f;
		}
		Value += m_CurrentSpeed * deltaTime;
		if (Value > m_MaxValue || Value < m_MinValue)
		{
			if (m_Wrap)
			{
				if (Value > m_MaxValue)
				{
					Value = m_MinValue + (Value - m_MaxValue);
				}
				else
				{
					Value = m_MaxValue + (Value - m_MinValue);
				}
			}
			else
			{
				Value = Mathf.Clamp(Value, m_MinValue, m_MaxValue);
				m_CurrentSpeed = 0f;
			}
		}
		return Mathf.Abs(input) > 0.0001f;
	}

	private float GetMaxSpeed()
	{
		float num = m_MaxValue - m_MinValue;
		if (!m_Wrap && num > 0f)
		{
			float num2 = num / 10f;
			if (m_CurrentSpeed > 0f && m_MaxValue - Value < num2)
			{
				float t = (m_MaxValue - Value) / num2;
				return Mathf.Lerp(0f, m_MaxSpeed, t);
			}
			if (m_CurrentSpeed < 0f && Value - m_MinValue < num2)
			{
				float t2 = (Value - m_MinValue) / num2;
				return Mathf.Lerp(0f, m_MaxSpeed, t2);
			}
		}
		return m_MaxSpeed;
	}
}
