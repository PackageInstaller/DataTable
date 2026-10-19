using System;
using UnityEngine.Rendering;

namespace XPostProcessing;

[Serializable]
public sealed class VignetteTypeParameter : VolumeParameter<VignetteType>
{
	public VignetteTypeParameter(VignetteType value, bool overrideState = false)
		: base(value, overrideState)
	{
	}
}
