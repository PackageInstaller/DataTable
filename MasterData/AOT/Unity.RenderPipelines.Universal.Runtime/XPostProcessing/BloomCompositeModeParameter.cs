using System;
using UnityEngine.Rendering;

namespace XPostProcessing;

[Serializable]
public sealed class BloomCompositeModeParameter : VolumeParameter<BloomCompositeMode>
{
	public BloomCompositeModeParameter(BloomCompositeMode value, bool overrideState = false)
		: base(value, overrideState)
	{
	}
}
