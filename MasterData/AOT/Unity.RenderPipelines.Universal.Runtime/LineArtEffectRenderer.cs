using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

[Serializable]
public class LineArtEffectRenderer : UIEffectRenderer<LineArtEffect>
{
	private static class ShaderIDs
	{
		internal static readonly int PointData = Shader.PropertyToID("_LineArtData");

		internal static readonly int LineColor = Shader.PropertyToID("_LineColor");

		internal static readonly int BackGroundColor = Shader.PropertyToID("_BackGroundColor");

		internal static readonly int LineOffset = Shader.PropertyToID("_LineOffset");

		internal static readonly int DecorateColor = Shader.PropertyToID("_DecorateColor");
	}

	private LineArtEffectRenderer()
	{
		EffectName = "LineArtEffect";
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
				m_BlitMaterial.SetVector(ShaderIDs.PointData, new Vector4(setting.LineSize, setting.LineWidth, setting.blend, setting.Rotation));
				m_BlitMaterial.SetVector(ShaderIDs.LineColor, setting.LineColor);
				m_BlitMaterial.SetVector(ShaderIDs.BackGroundColor, setting.BackGroundColor);
				m_BlitMaterial.SetVector(ShaderIDs.DecorateColor, setting.DecorateColor);
				m_BlitMaterial.SetVector(ShaderIDs.LineOffset, new Vector4(setting.OffsetSpeed, setting.LineDecorateWidth));
				ACTRenderingFunction.ACT_BlitWithOutLoad(cmd, source, target, m_BlitMaterial, 0);
				return true;
			}
			return false;
		}
		return false;
	}
}
