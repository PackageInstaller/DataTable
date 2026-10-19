using System;
using ACT.Utility;
using UnityEngine;
using UnityEngine.Events;

namespace ACT.UI;

public abstract class TouchUIMaskBase : MonoBehaviour
{
	private float m_targetValue;

	[Range(0f, 1f)]
	[SerializeField]
	private float m_value;

	private float m_InterpolationTime;

	public UnityEvent<float, float> OnValueChanged = new UnityEvent<float, float>();

	[NonSerialized]
	public bool isChange;

	public float damp = 0.1f;

	public float targetValue
	{
		get
		{
			return m_targetValue;
		}
		set
		{
			m_targetValue = value;
			isChange = true;
		}
	}

	public float value
	{
		get
		{
			return m_value;
		}
		set
		{
			OnValueChanged.Invoke(m_value, value);
			m_value = value;
			SetValue();
		}
	}

	public abstract void SetValue();

	protected virtual void Changed()
	{
	}

	protected virtual float CalValue(float interpolationTime)
	{
		return InterpolationUtility.ExponentialInterpolation(value, targetValue, damp, interpolationTime);
	}

	public void Update()
	{
		if (!isChange || Mathf.Approximately(value, m_targetValue))
		{
			isChange = false;
			return;
		}
		m_InterpolationTime += Time.deltaTime;
		float num = CalValue(m_InterpolationTime);
		value = num;
		if (Mathf.Approximately(value, m_targetValue))
		{
			isChange = false;
			m_InterpolationTime = 0f;
			Changed();
		}
	}
}
