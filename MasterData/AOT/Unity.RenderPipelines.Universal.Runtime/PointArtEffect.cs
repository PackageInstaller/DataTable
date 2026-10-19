using System;
using UnityEngine;

[Serializable]
public class PointArtEffect : UIEffectSetting
{
	public enum PointArtType
	{
		Lumin,
		RGB,
		Uniform
	}

	public bool pureColor;

	public float pointSize;

	public float pointMinSize;

	public Color BackGroundColor = Color.white;

	public PointArtType pointArtType;

	public override bool IsActive()
	{
		return pointSize > 0f;
	}

	public override string GetShaderName()
	{
		return "Hidden/PostProcessing/ImageProcessing/PointArtEffect";
	}
}
