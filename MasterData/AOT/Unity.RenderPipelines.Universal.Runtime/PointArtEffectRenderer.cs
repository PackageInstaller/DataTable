using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

[Serializable]
public class PointArtEffectRenderer : UIEffectRenderer<PointArtEffect>
{
	private static class ShaderIDs
	{
		internal static readonly int PointData = Shader.PropertyToID("_PointArtData");

		internal static readonly int PointType = Shader.PropertyToID("_PointArtType");

		internal static readonly int BackGroundColor = Shader.PropertyToID("_BackGroundColor");
	}

	private PointArtEffectRenderer()
	{
		EffectName = "UIPointArt";
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
				m_BlitMaterial.SetInteger(ShaderIDs.PointType, (int)setting.pointArtType);
				m_BlitMaterial.SetVector(ShaderIDs.PointData, new Vector4(setting.pointSize, setting.pointMinSize, intensity, setting.pureColor ? 1 : 0));
				m_BlitMaterial.SetColor(ShaderIDs.BackGroundColor, setting.BackGroundColor);
				ACTRenderingFunction.ACT_BlitWithOutLoad(cmd, source, target, m_BlitMaterial, 0);
				return true;
			}
			return false;
		}
		return false;
	}
}
