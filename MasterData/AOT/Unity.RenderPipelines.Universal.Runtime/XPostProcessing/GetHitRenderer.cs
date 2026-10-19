using UnityEngine;
using UnityEngine.Rendering;

namespace XPostProcessing;

public sealed class GetHitRenderer : VolumeRenderer<GetHit>
{
	private static class ShaderIDs
	{
		internal static readonly int Params = Shader.PropertyToID("_Params");

		internal static readonly int focus = Shader.PropertyToID("_focus");

		internal static readonly int DistortionID = Shader.PropertyToID("_DistortionTex");

		internal static readonly int DistortionOffsetID = Shader.PropertyToID("_DistortionTex_ST");

		internal static readonly int DistortionMaskID = Shader.PropertyToID("_DistortionMaskTex");
	}

	private const string PROFILER_TAG = "GetHit";

	public override void Render(CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier target)
	{
		if (!(m_BlitMaterial == null))
		{
			cmd.BeginSample("GetHit");
			float num = m_Settings.indensity.value * 0.01f;
			m_BlitMaterial.SetTexture(ShaderIDs.DistortionID, m_Settings.distortionTex.value);
			m_BlitMaterial.SetTexture(ShaderIDs.DistortionMaskID, m_Settings.distortionMaskTex.value);
			m_BlitMaterial.SetVector(ShaderIDs.DistortionOffsetID, m_Settings.distortionTexOffset.value);
			m_BlitMaterial.SetVector(ShaderIDs.Params, new Vector4(num * m_Settings.splitR.value, num * m_Settings.splitB.value, m_Settings.dIndensity.value * num, m_Settings.UseFocus.value));
			m_BlitMaterial.SetVector(ShaderIDs.focus, new Vector4(m_Settings.Focus.value.x, m_Settings.Focus.value.y, 0f, 0f));
			cmd.Blit(source, target, m_BlitMaterial);
			cmd.EndSample("GetHit");
		}
	}
}
