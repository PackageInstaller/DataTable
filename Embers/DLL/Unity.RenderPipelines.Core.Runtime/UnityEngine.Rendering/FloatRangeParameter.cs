using System;
using System.Diagnostics;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{m_Value} ({m_OverrideState})")]
public class FloatRangeParameter : VolumeParameter<Vector2>
{
	[NonSerialized]
	public float min;

	[NonSerialized]
	public float max;

	public override Vector2 value
	{
		get
		{
			return m_Value;
		}
		set
		{
			m_Value.x = Mathf.Max(value.x, min);
			m_Value.y = Mathf.Min(value.y, max);
		}
	}

	public FloatRangeParameter(Vector2 value, float min, float max, bool overrideState = false)
		: base(value, overrideState)
	{
		this.min = min;
		this.max = max;
	}

	public override void Interp(Vector2 from, Vector2 to, float t)
	{
		m_Value.x = from.x + (to.x - from.x) * t;
		m_Value.y = from.y + (to.y - from.y) * t;
	}
}
