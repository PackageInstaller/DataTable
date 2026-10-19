using UnityEngine;
using UnityEngine.Rendering;

namespace XPostProcessing;

public class RadialBlurV2Renderer : VolumeRenderer<RadialBlurV2>
{
	private static class ShaderIDs
	{
		internal static readonly int Params = Shader.PropertyToID("_Params");
	}

	private const string PROFILER_TAG = "RadialBlurV2";

	public override void Render(CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier target)
	{
		if (!(m_BlitMaterial == null))
		{
			cmd.BeginSample("RadialBlurV2");
			m_BlitMaterial.SetVector(ShaderIDs.Params, new Vector3(m_Settings.BlurRadius.value * 0.1f, m_Settings.RadialCenterX.value, m_Settings.RadialCenterY.value));
			cmd.Blit(source, target, m_BlitMaterial, (int)m_Settings.QualityLevel.value);
			cmd.EndSample("RadialBlurV2");
		}
	}
}
