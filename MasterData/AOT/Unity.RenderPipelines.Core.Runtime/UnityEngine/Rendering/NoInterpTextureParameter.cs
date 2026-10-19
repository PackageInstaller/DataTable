using System;
using System.Diagnostics;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{m_Value} ({m_OverrideState})")]
public class NoInterpTextureParameter : VolumeParameter<Texture>
{
	public NoInterpTextureParameter(Texture value, bool overrideState = false)
		: base(value, overrideState)
	{
	}

	public override int GetHashCode()
	{
		int result = base.GetHashCode();
		if (value != null)
		{
			result = 23 * CoreUtils.GetTextureHash(value);
		}
		return result;
	}
}
