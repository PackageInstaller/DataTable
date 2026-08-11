using System;
using System.Diagnostics;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{m_Value} ({m_OverrideState})")]
public class NoInterpCubemapParameter : VolumeParameter<Cubemap>
{
	public NoInterpCubemapParameter(Cubemap value, bool overrideState = false)
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
