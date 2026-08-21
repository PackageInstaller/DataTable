using System;
using System.Diagnostics;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{m_Value} ({m_OverrideState})")]
public class NoInterpMaxFloatParameter : VolumeParameter<float>
{
	[NonSerialized]
	public float max;

	public override float value
	{
		get
		{
			return m_Value;
		}
		set
		{
			m_Value = Mathf.Min(value, max);
		}
	}

	public NoInterpMaxFloatParameter(float value, float max, bool overrideState = false)
		: base(value, overrideState)
	{
		this.max = max;
	}
}
