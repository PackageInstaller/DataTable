using System;
using UnityEngine.Rendering;

[Serializable]
[VolumeComponentMenu("KIIF_Feature/RoomStencil")]
public class RoomStencilVolume : VolumeComponent
{
	public IntParameter stencilRefValue = new IntParameter(0);

	public FloatParameter blurSpread = new FloatParameter(0f);

	public ClampedIntParameter preDownSample = new ClampedIntParameter(0, 0, 8);

	public ClampedIntParameter blurIterations = new ClampedIntParameter(4, 1, 16);

	public bool IsActive()
	{
		return active;
	}

	public bool IsTileCompatible()
	{
		return false;
	}
}
