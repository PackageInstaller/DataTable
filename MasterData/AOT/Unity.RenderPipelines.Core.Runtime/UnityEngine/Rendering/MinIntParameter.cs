using System;
using System.Diagnostics;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{m_Value} ({m_OverrideState})")]
public class MinIntParameter : IntParameter
{
	[NonSerialized]
	public int min;

	public override int value
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

	public MinIntParameter(int value, int min, bool overrideState = false)
		: base(value, overrideState)
	{
		this.min = min;
	}
}
