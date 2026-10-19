using System;
using UnityEngine;

[Serializable]
public class LineArtEffect : UIEffectSetting
{
	public float LineSize;

	[Range(0f, 1f)]
	public float LineWidth;

	[Range(0f, 1f)]
	public float LineDecorateWidth;

	[Range(0f, 1f)]
	public float Rotation;

	[Range(0f, 1f)]
	public float blend;

	public float OffsetSpeed;

	public Color LineColor = Color.white;

	public Color DecorateColor = Color.gray;

	public Color BackGroundColor = Color.black;

	public override bool IsActive()
	{
		return blend > 0f;
	}

	public override string GetShaderName()
	{
		return "Hidden/PostProcessing/ImageProcessing/LineArtEffect";
	}
}
