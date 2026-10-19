using UnityEngine;
using UnityEngine.Rendering;

namespace XPostProcessing;

public sealed class GlitchWaveJitterRenderer : VolumeRenderer<GlitchWaveJitter>
{
	private static class ShaderIDs
	{
		internal static readonly int Params = Shader.PropertyToID("_Params");

		internal static readonly int Resolution = Shader.PropertyToID("_Resolution");
	}

	private const string PROFILER_TAG = "GlitchTileJitter";

	private float randomFrequency;

	public override void Render(CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier target)
	{
		if (!(m_BlitMaterial == null))
		{
			cmd.BeginSample("GlitchTileJitter");
			UpdateFrequency(m_Settings);
			m_BlitMaterial.SetVector(ShaderIDs.Params, new Vector4((m_Settings.intervalType.value == IntervalType.Random) ? randomFrequency : m_Settings.frequency.value, m_Settings.RGBSplit.value, m_Settings.speed.value, m_Settings.amount.value));
			m_BlitMaterial.SetVector(ShaderIDs.Resolution, m_Settings.customResolution.value ? m_Settings.resolution.value : new Vector2(Screen.width, Screen.height));
			cmd.Blit(source, target, m_BlitMaterial, (int)m_Settings.jitterDirection.value);
			cmd.EndSample("GlitchTileJitter");
		}
	}

	private void UpdateFrequency(GlitchWaveJitter m_Settings)
	{
		if (m_Settings.intervalType.value == IntervalType.Random)
		{
			randomFrequency = Random.Range(0f, m_Settings.frequency.value);
		}
		if (m_Settings.intervalType.value == IntervalType.Infinite)
		{
			m_BlitMaterial.EnableKeyword("USING_FREQUENCY_INFINITE");
		}
		else
		{
			m_BlitMaterial.DisableKeyword("USING_FREQUENCY_INFINITE");
		}
	}
}
