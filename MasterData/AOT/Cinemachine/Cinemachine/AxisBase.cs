using System;
using UnityEngine;

namespace Cinemachine;

[Serializable]
public struct AxisBase
{
	[NoSaveDuringPlay]
	[Tooltip("The current value of the axis.")]
	public float m_Value;

	[Tooltip("The minimum value for the axis")]
	public float m_MinValue;

	[Tooltip("The maximum value for the axis")]
	public float m_MaxValue;

	[Tooltip("If checked, then the axis will wrap around at the min/max values, forming a loop")]
	public bool m_Wrap;

	public void Validate()
	{
		m_MaxValue = Mathf.Clamp(m_MaxValue, m_MinValue, m_MaxValue);
	}
}
