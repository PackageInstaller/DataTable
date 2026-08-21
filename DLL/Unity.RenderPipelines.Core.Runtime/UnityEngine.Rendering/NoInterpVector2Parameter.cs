using System;
using System.Diagnostics;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{m_Value} ({m_OverrideState})")]
public class NoInterpVector2Parameter : VolumeParameter<Vector2>
{
	public NoInterpVector2Parameter(Vector2 value, bool overrideState = false)
		: base(value, overrideState)
	{
	}
}
