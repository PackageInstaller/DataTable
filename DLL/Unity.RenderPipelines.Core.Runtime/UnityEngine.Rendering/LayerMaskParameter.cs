using System;
using System.Diagnostics;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{m_Value} ({m_OverrideState})")]
public class LayerMaskParameter : VolumeParameter<LayerMask>
{
	public LayerMaskParameter(LayerMask value, bool overrideState = false)
		: base(value, overrideState)
	{
	}
}
