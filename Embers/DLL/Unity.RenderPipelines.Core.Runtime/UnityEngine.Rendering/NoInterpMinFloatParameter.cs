using System;
using System.Diagnostics;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{m_Value} ({m_OverrideState})")]
public class NoInterpMinFloatParameter : VolumeParameter<float>
{
	[NonSerialized]
	public float min;

	public override float value
	{
		get
		{
			return m_Value;
		}
		set
		{
			m_Value = Mathf.Max(value, min);
		}
	}

	public NoInterpMinFloatParameter(float value, float min, bool overrideState = false)
		: base(value, overrideState)
	{
		this.min = min;
	}
}
