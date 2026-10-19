using System;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

[Serializable]
public class SampleUIEffectRenderer : UIEffectRenderer<SampleUIEffect>
{
	private SampleUIEffectRenderer()
	{
		EffectName = "UIDarken";
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
				m_BlitMaterial.SetFloat("_UIDarkenIntensity", setting.DarkenIntensity * intensity);
				ACTRenderingFunction.ACT_BlitWithOutLoad(cmd, source, target, m_BlitMaterial, 0);
				return true;
			}
			return false;
		}
		return false;
	}
}
