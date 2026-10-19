using System;
using UnityEngine.Rendering;

namespace XPostProcessing;

[Serializable]
public sealed class DirectionEXParameter : VolumeParameter<DirectionEX>
{
	public DirectionEXParameter(DirectionEX value, bool overrideState = false)
		: base(value, overrideState)
	{
	}
}
