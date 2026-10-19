using System;
using UnityEngine.Serialization;

namespace UnityEngine.Rendering.Universal;

[Serializable]
[VolumeComponentMenuForRenderPipeline("Custom/Only DeSaturate Scene", new Type[] { typeof(UniversalRenderPipeline) })]
public class DeSaturate : VolumeComponent, IPostProcessComponent
{
	[FormerlySerializedAs("intensity")]
	public ClampedFloatParameter deSaturate = new ClampedFloatParameter(0f, 0f, 1f);

	public ClampedFloatParameter darken = new ClampedFloatParameter(0f, 0f, 1f);

	public bool IsActive()
	{
		if (!(deSaturate.value > 0f))
		{
			return darken.value > 0f;
		}
		return true;
	}

	public bool IsTileCompatible()
	{
		return false;
	}
}
