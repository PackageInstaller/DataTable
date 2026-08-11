using System;
using UnityEngine.Rendering;

[Serializable]
[VolumeComponentMenu("KIIF_Feature/PostprocessFog")]
public class PostprecessFogVolume : VolumeComponent
{
	public BoolParameter EnableFog = new BoolParameter(value: false);

	public bool IsActive()
	{
		return EnableFog.value;
	}
}
