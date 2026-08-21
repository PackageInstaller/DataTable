using System;
using UnityEngine.Rendering;

[Serializable]
[VolumeComponentMenu("KIIF_Feature/DesaturateStencil")]
public class DesaturateStencilVolume : VolumeComponent
{
	public IntParameter stencilRefValue = new IntParameter(0);

	public ClampedFloatParameter desaturate = new ClampedFloatParameter(1f, 0f, 1f);

	public DepthOfFieldModeParameter stencilCompare = new DepthOfFieldModeParameter(CompareFunction.Greater);

	public bool IsActive()
	{
		if (stencilRefValue.value > 0)
		{
			return desaturate.value > 0f;
		}
		return false;
	}
}
