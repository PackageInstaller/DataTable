using System;
using System.Diagnostics;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{m_Value} ({m_OverrideState})")]
public class Vector3Parameter : VolumeParameter<Vector3>
{
	public Vector3Parameter(Vector3 value, bool overrideState = false)
		: base(value, overrideState)
	{
	}

	public override void Interp(Vector3 from, Vector3 to, float t)
	{
		m_Value.x = from.x + (to.x - from.x) * t;
		m_Value.y = from.y + (to.y - from.y) * t;
		m_Value.z = from.z + (to.z - from.z) * t;
	}
}
