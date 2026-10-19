using System;
using UnityEngine;

[Serializable]
public class CharOrderUIEffect : UIEffectSetting
{
	[Range(0f, 1f)]
	public float intensity;

	public Texture2D _OffsetTexture = Texture2D.grayTexture;

	public Vector4 _OffsetOffset_ST = new Vector4(1f, 1f, 0f, 0f);

	[Range(0f, 1f)]
	public float _OffsetIntensity;

	public Texture2D _BlendTexture = Texture2D.whiteTexture;

	public Vector4 _BlendOffset_ST = new Vector4(1f, 1f, 0f, 0f);

	public Texture2D _FlowTexture = Texture2D.whiteTexture;

	public Vector4 _FlowOffset_ST = new Vector4(1f, 1f, 0f, 0f);

	[Range(0f, 1f)]
	public float BlendTime = 0.1f;

	[Range(0f, 1f)]
	public float RemapMin;

	[Range(0f, 1f)]
	public float RemapMax = 1f;

	public override bool IsActive()
	{
		return intensity > 0f;
	}

	public override string GetShaderName()
	{
		return "Hidden/PostProcessing/ImageProcessing/UIEffectCharMask";
	}
}
