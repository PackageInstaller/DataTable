using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

[Serializable]
public class CharOrderUIEffectRenderer : UIEffectRenderer<CharOrderUIEffect>
{
	private static class ShaderIDs
	{
		internal static readonly int OffsetTexture = Shader.PropertyToID("_OffsetTexture");

		internal static readonly int OffsetTexture_ST = Shader.PropertyToID("_OffsetTexture_Size");

		internal static readonly int BlendTexture = Shader.PropertyToID("_BlendTexture");

		internal static readonly int BlendTexture_ST = Shader.PropertyToID("_BlendTexture_Size");

		internal static readonly int FlowTexture = Shader.PropertyToID("_flowTexture");

		internal static readonly int FlowTexture_ST = Shader.PropertyToID("_flowTexture_Size");

		internal static readonly int Data = Shader.PropertyToID("_OrderData");

		internal static readonly int Data2 = Shader.PropertyToID("_OrderData2");
	}

	private CharOrderUIEffectRenderer()
	{
		EffectName = "CharOrderUIEffect";
	}

	public override bool Renderer(ref ScriptableRenderContext context, RenderTargetIdentifier source, RenderTargetIdentifier target, ref RenderingData renderingData, CommandBuffer cmd, float intensity)
	{
		if (!materialCreated)
		{
			materialCreated = Init();
		}
		if (setting != null)
		{
			if (setting.IsActive())
			{
				if (setting._OffsetTexture != null)
				{
					m_BlitMaterial.SetTexture(ShaderIDs.OffsetTexture, setting._OffsetTexture);
				}
				m_BlitMaterial.SetVector(ShaderIDs.OffsetTexture_ST, setting._OffsetOffset_ST);
				if (setting._BlendTexture != null)
				{
					m_BlitMaterial.SetTexture(ShaderIDs.BlendTexture, setting._BlendTexture);
				}
				m_BlitMaterial.SetVector(ShaderIDs.BlendTexture_ST, setting._BlendOffset_ST);
				if (setting._FlowTexture != null)
				{
					m_BlitMaterial.SetTexture(ShaderIDs.FlowTexture, setting._FlowTexture);
				}
				m_BlitMaterial.SetVector(ShaderIDs.FlowTexture_ST, setting._FlowOffset_ST);
				m_BlitMaterial.SetVector(ShaderIDs.Data, new Vector4(setting.intensity, setting.BlendTime, setting._OffsetIntensity));
				m_BlitMaterial.SetVector(ShaderIDs.Data2, new Vector4(setting.RemapMin, setting.RemapMax));
				ACTRenderingFunction.ACT_BlitWithOutLoad(cmd, source, target, m_BlitMaterial, 0);
				return true;
			}
			return false;
		}
		return false;
	}
}
