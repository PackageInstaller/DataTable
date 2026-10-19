using System;
using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering.Universal;

[Serializable]
[VolumeComponentMenuForRenderPipeline("Post-processing/Color Lookup", new Type[] { typeof(UniversalRenderPipeline) })]
public sealed class ColorLookup : VolumeComponent, IPostProcessComponent
{
	[Tooltip("A non-sRGB 2D LUT baked after tone mapping into the generated internal LUT.")]
	public TextureParameter texture = new TextureParameter(null);

	[Tooltip("How much of the lookup texture contributes to the final color grading.")]
	public ClampedFloatParameter contribution = new ClampedFloatParameter(0f, 0f, 1f);

	public bool IsActive()
	{
		if (contribution.value > 0f)
		{
			return ValidateLUT();
		}
		return false;
	}

	public bool IsTileCompatible()
	{
		return true;
	}

	public bool ValidateLUT()
	{
		UniversalRenderPipelineAsset asset = UniversalRenderPipeline.asset;
		if (asset == null || texture.value == null)
		{
			return false;
		}
		int colorGradingLutSize = asset.colorGradingLutSize;
		if (texture.value.height != colorGradingLutSize)
		{
			return false;
		}
		bool flag = false;
		Texture value = texture.value;
		if (!(value is Texture2D texture2D))
		{
			if (value is RenderTexture renderTexture)
			{
				flag |= renderTexture.dimension == TextureDimension.Tex2D && renderTexture.width == colorGradingLutSize * colorGradingLutSize && !renderTexture.sRGB;
			}
		}
		else
		{
			flag |= texture2D.width == colorGradingLutSize * colorGradingLutSize && !GraphicsFormatUtility.IsSRGBFormat(texture2D.graphicsFormat);
		}
		return flag;
	}
}
