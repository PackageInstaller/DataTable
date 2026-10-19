using System;
using UnityEngine.Rendering;

namespace XPostProcessing;

[Serializable]
public sealed class SceneScatterQualityParameter : VolumeParameter<SceneScatterQuality>
{
	public SceneScatterQualityParameter(SceneScatterQuality value, bool overrideState = false)
		: base(value, overrideState)
	{
	}
}
