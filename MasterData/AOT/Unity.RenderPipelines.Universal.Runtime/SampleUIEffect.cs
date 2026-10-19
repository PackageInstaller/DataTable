using System;
using UnityEngine;

[Serializable]
public class SampleUIEffect : UIEffectSetting
{
	[Range(0f, 1f)]
	public float DarkenIntensity;

	public override bool IsActive()
	{
		return DarkenIntensity > 0f;
	}

	public override string GetShaderName()
	{
		return "Hidden/PostProcessing/ImageProcessing/UIDarken";
	}
}
