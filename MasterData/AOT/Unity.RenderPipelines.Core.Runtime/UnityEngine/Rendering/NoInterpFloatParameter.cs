using System;
using System.Diagnostics;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{m_Value} ({m_OverrideState})")]
public class NoInterpFloatParameter : VolumeParameter<float>
{
	public NoInterpFloatParameter(float value, bool overrideState = false)
		: base(value, overrideState)
	{
	}
}
