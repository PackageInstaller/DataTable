using UnityEngine;
using UnityEngine.Rendering;

namespace XPostProcessing;

public class BlackWhiteRenderer : VolumeRenderer<BlackWhite>
{
	private static class ShaderIDs
	{
		public static readonly int ParamsID = Shader.PropertyToID("_Params");

		public static readonly int Params2ID = Shader.PropertyToID("_Params2");

		public static readonly int ColorID = Shader.PropertyToID("_Color");

		public static readonly int NoiseTexID = Shader.PropertyToID("_NoiseTex");

		public static readonly int DissolveTexID = Shader.PropertyToID("_DissolveTex");

		public static readonly int DissolveOffset = Shader.PropertyToID("_DissolveTilling");

		public static readonly int Params3ID = Shader.PropertyToID("_Params3");

		public static readonly int Params4ID = Shader.PropertyToID("_Params4");
	}

	private const string PROFILER_TAG = "BlackWhite";

	public override void Render(CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier target)
	{
		if (!(m_BlitMaterial == null))
		{
			cmd.BeginSample("BlackWhite");
			m_BlitMaterial.SetTexture(ShaderIDs.NoiseTexID, m_Settings.NoiseTex.value);
			m_BlitMaterial.SetTexture(ShaderIDs.DissolveTexID, m_Settings.DissolveTex.value);
			m_BlitMaterial.SetVector(ShaderIDs.ColorID, m_Settings.TintColor.value);
			m_BlitMaterial.SetVector(ShaderIDs.ParamsID, new Vector4(m_Settings.Threshold.value, m_Settings.Center.value.x, m_Settings.Center.value.y, m_Settings.Range.value));
			m_BlitMaterial.SetVector(ShaderIDs.Params2ID, m_Settings.TextureTilling.value);
			m_BlitMaterial.SetVector(ShaderIDs.DissolveOffset, m_Settings.DissolveTilling.value);
			m_BlitMaterial.SetVector(ShaderIDs.Params3ID, new Vector4(m_Settings.NoisePower.value, m_Settings.Change.value, m_Settings.DissolveWeight.value, m_Settings.StepScale.value));
			m_BlitMaterial.SetVector(ShaderIDs.Params4ID, new Vector4(m_Settings.StepCount.value, m_Settings.Detail.value, m_Settings.MinPower.value, 0f));
			cmd.Blit(source, target, m_BlitMaterial, 0);
			cmd.EndSample("BlackWhite");
		}
	}
}
