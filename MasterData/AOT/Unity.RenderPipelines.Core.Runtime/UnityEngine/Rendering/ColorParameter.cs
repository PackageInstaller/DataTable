using System;
using System.Diagnostics;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{m_Value} ({m_OverrideState})")]
public class ColorParameter : VolumeParameter<Color>
{
	[NonSerialized]
	public bool hdr;

	[NonSerialized]
	public bool showAlpha = true;

	[NonSerialized]
	public bool showEyeDropper = true;

	public ColorParameter(Color value, bool overrideState = false)
		: base(value, overrideState)
	{
	}

	public ColorParameter(Color value, bool hdr, bool showAlpha, bool showEyeDropper, bool overrideState = false)
		: base(value, overrideState)
	{
		this.hdr = hdr;
		this.showAlpha = showAlpha;
		this.showEyeDropper = showEyeDropper;
		this.overrideState = overrideState;
	}

	public override void Interp(Color from, Color to, float t)
	{
		m_Value.r = from.r + (to.r - from.r) * t;
		m_Value.g = from.g + (to.g - from.g) * t;
		m_Value.b = from.b + (to.b - from.b) * t;
		m_Value.a = from.a + (to.a - from.a) * t;
	}
}
