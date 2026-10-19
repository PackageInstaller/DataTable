using System;
using UnityEngine.Rendering;

namespace XPostProcessing;

[Serializable]
public sealed class SceneScatterDepthLutSourceParameter : VolumeParameter<SceneScatterDepthLutSource>
{
	public SceneScatterDepthLutSourceParameter(SceneScatterDepthLutSource value, bool overrideState = false)
		: base(value, overrideState)
	{
	}
}
