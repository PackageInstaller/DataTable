using System;
using System.Diagnostics;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{m_Value} ({m_OverrideState})")]
public class NoInterpVector4Parameter : VolumeParameter<Vector4>
{
	public NoInterpVector4Parameter(Vector4 value, bool overrideState = false)
		: base(value, overrideState)
	{
	}
}
