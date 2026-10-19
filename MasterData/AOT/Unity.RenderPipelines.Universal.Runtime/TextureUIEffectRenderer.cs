using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

[Serializable]
public class TextureUIEffectRenderer : UIEffectRenderer<TextureUIEffect>
{
	private static class ShaderIDs
	{
		internal static readonly int TextureOffset = Shader.PropertyToID("_InputTexture_ST");

		internal static readonly int intensity = Shader.PropertyToID("_OffsetIntensity");

		internal static readonly int inputTexture = Shader.PropertyToID("_InputTexture");
	}

	private TextureUIEffectRenderer()
	{
		EffectName = "TextureEffect";
	}

	public override bool Renderer(ref ScriptableRenderContext context, RenderTargetIdentifier source, RenderTargetIdentifier target, ref RenderingData renderingData, CommandBuffer cmd, float intensity)
	{
		if (!materialCreated)
		{
			materialCreated = Init();
		}
		if (setting != null)
		{
			if (setting.IsActive() && setting.inputTexture != null)
			{
				m_BlitMaterial.SetTexture(ShaderIDs.inputTexture, setting.inputTexture);
				m_BlitMaterial.SetVector(ShaderIDs.TextureOffset, setting.ScaleOffset);
				m_BlitMaterial.SetFloat(ShaderIDs.intensity, setting.intensity * intensity);
				ACTRenderingFunction.ACT_BlitWithOutLoad(cmd, source, target, m_BlitMaterial, 0);
				return true;
			}
			return false;
		}
		return false;
	}
}
