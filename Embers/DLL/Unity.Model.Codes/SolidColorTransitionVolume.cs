using System;
using UnityEngine.Rendering;

[Serializable]
[VolumeComponentMenu("KIIF_Feature/SolidColorTransition")]
public class SolidColorTransitionVolume : VolumeComponent
{
	public BoolParameter Enable = new BoolParameter(value: true);

	public FloatParameter Transition = new FloatParameter(0f);

	public bool IsActive()
	{
		if (active)
		{
			return Enable.value;
		}
		return false;
	}
}
