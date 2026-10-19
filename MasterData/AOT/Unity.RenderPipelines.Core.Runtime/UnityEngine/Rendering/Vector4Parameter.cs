using System;
using System.Diagnostics;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{m_Value} ({m_OverrideState})")]
public class Vector4Parameter : VolumeParameter<Vector4>
{
	public Vector4Parameter(Vector4 value, bool overrideState = false)
		: base(value, overrideState)
	{
	}

	public override void Interp(Vector4 from, Vector4 to, float t)
	{
		m_Value.x = from.x + (to.x - from.x) * t;
		m_Value.y = from.y + (to.y - from.y) * t;
		m_Value.z = from.z + (to.z - from.z) * t;
		m_Value.w = from.w + (to.w - from.w) * t;
	}
}
