using System;
using UnityEngine.Rendering;

namespace XPostProcessing;

[Serializable]
public sealed class DirectionParameter : VolumeParameter<Direction>
{
	public DirectionParameter(Direction value, bool overrideState = false)
		: base(value, overrideState)
	{
	}
}
