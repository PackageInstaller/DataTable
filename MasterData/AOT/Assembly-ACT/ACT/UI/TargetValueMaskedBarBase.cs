using ACT.Utility;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Serialization;

namespace ACT.UI;

public abstract class TargetValueMaskedBarBase : MonoBehaviour
{
	private float m_TargetValue;

	[FormerlySerializedAs("m_Value")]
	[Range(0f, 1f)]
	[SerializeField]
	private float value;

	public UnityEvent<float, float> onValueChanged = new UnityEvent<float, float>();

	public float duration;

	public float delay;

	public bool isRefreshDelay;

	private bool m_IsChange;

	private float m_InterpolationTime;

	private float m_DelayTime;

	private bool m_IgnoreDelayOnce;

	public float TargetValue
	{
		get
		{
			return m_TargetValue;
		}
		set
		{
			m_TargetValue = value;
			m_IsChange = true;
			if (isRefreshDelay)
			{
				m_DelayTime = 0f;
			}
			SetTargetValue();
		}
	}

	public float Value
	{
		get
		{
			return value;
		}
		set
		{
			onValueChanged.Invoke(this.value, value);
			this.value = value;
			SetValue();
		}
	}

	public bool ChangeFinish => Mathf.Approximately(value, m_TargetValue);

	protected virtual void Awake()
	{
		m_TargetValue = value;
	}

	public void Update()
	{
		if (!m_IsChange || Value == m_TargetValue)
		{
			return;
		}
		if (!m_IgnoreDelayOnce && m_DelayTime < delay)
		{
			m_DelayTime += Time.deltaTime;
			return;
		}
		m_InterpolationTime += Time.deltaTime;
		float num = InterpolationUtility.ExponentialInterpolation(Value, TargetValue, duration, m_InterpolationTime);
		Value = num;
		if (Value == m_TargetValue)
		{
			m_IsChange = false;
			m_IgnoreDelayOnce = false;
			m_InterpolationTime = 0f;
			m_DelayTime = 0f;
		}
	}

	public void IgnoreDelayOnce()
	{
		m_IgnoreDelayOnce = true;
	}

	public void SetTargetImmediate(float target)
	{
		m_TargetValue = target;
		m_IsChange = false;
		m_InterpolationTime = 0f;
		m_DelayTime = 0f;
		m_IgnoreDelayOnce = false;
		SetTargetValue();
	}

	public void PlayValueToTarget()
	{
		if (Mathf.Approximately(value, m_TargetValue))
		{
			Value = m_TargetValue;
			m_IsChange = false;
			m_InterpolationTime = 0f;
			m_DelayTime = 0f;
			m_IgnoreDelayOnce = false;
		}
		else
		{
			m_IsChange = true;
			m_IgnoreDelayOnce = true;
			m_InterpolationTime = 0f;
			m_DelayTime = 0f;
		}
	}

	protected abstract void SetValue();

	protected abstract void SetTargetValue();
}
