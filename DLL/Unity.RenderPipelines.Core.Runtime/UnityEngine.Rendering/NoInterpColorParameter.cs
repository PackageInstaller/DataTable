using System;
using System.Diagnostics;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{m_Value} ({m_OverrideState})")]
public class NoInterpColorParameter : VolumeParameter<Color>
{
	public bool hdr;

	[NonSerialized]
	public bool showAlpha = true;

	[NonSerialized]
	public bool showEyeDropper = true;

	public NoInterpColorParameter(Color value, bool overrideState = false)
		: base(value, overrideState)
	{
	}

	public NoInterpColorParameter(Color value, bool hdr, bool showAlpha, bool showEyeDropper, bool overrideState = false)
		: base(value, overrideState)
	{
		this.hdr = hdr;
		this.showAlpha = showAlpha;
		this.showEyeDropper = showEyeDropper;
		this.overrideState = overrideState;
	}
}
