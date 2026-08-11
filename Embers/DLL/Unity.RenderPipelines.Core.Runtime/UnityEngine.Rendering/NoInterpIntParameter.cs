using System;
using System.Diagnostics;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{m_Value} ({m_OverrideState})")]
public class NoInterpIntParameter : VolumeParameter<int>
{
	public NoInterpIntParameter(int value, bool overrideState = false)
		: base(value, overrideState)
	{
	}
}
