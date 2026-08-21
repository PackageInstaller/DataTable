using System;
using UnityEngine.Rendering;

[Serializable]
public sealed class DepthOfFieldModeParameter : VolumeParameter<CompareFunction>
{
	public DepthOfFieldModeParameter(CompareFunction value, bool overrideState = false)
		: base(value, overrideState)
	{
	}
}
