using System;
using System.Diagnostics;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{m_Value} ({m_OverrideState})")]
public class Vector2Parameter : VolumeParameter<Vector2>
{
	public Vector2Parameter(Vector2 value, bool overrideState = false)
		: base(value, overrideState)
	{
	}

	public override void Interp(Vector2 from, Vector2 to, float t)
	{
		m_Value.x = from.x + (to.x - from.x) * t;
		m_Value.y = from.y + (to.y - from.y) * t;
	}
}
