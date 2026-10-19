using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

[Serializable]
public class CharacterOnlyUIEffectRenderer : UIEffectRenderer<CharacterOnlyUIEffect>
{
	private static class ShaderIDs
	{
		internal static readonly int CharColor = Shader.PropertyToID("_CharacterColor");

		internal static readonly int BackColor = Shader.PropertyToID("_BackColor");
	}

	private CharacterOnlyUIEffectRenderer()
	{
		EffectName = "CharacterOnly";
	}

	public override bool Renderer(ref ScriptableRenderContext context, RenderTargetIdentifier source, RenderTargetIdentifier target, ref RenderingData renderingData, CommandBuffer cmd, float intensity)
	{
		if (!materialCreated)
		{
			materialCreated = Init();
		}
		if (setting != null)
		{
			if (setting.IsActive() && intensity > 0f)
			{
				m_BlitMaterial.SetColor(ShaderIDs.CharColor, setting.CharColor);
				m_BlitMaterial.SetColor(ShaderIDs.BackColor, setting.BackColor);
				ACTRenderingFunction.ACT_BlitWithOutLoad(cmd, source, target, m_BlitMaterial, 0);
				return true;
			}
			return false;
		}
		return false;
	}
}
