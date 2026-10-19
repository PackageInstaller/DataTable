using System;
using UnityEngine;

[Serializable]
public class TextureUIEffect : UIEffectSetting
{
	[Range(0f, 1f)]
	public float intensity;

	public Texture2D inputTexture;

	public Vector4 ScaleOffset = new Vector4(1f, 1f, 0f, 0f);

	public override bool IsActive()
	{
		return intensity > 0f;
	}

	public override string GetShaderName()
	{
		return "Hidden/PostProcessing/ImageProcessing/TextureEffect";
	}
}
