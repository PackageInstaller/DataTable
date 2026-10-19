using UnityEngine;
using UnityEngine.Rendering;

namespace XPostProcessing;

public class SpeedLineRenderer : VolumeRenderer<SpeedLine>
{
	private static class ShaderIDs
	{
		internal static readonly int Scale = Shader.PropertyToID("_Scale");

		internal static readonly int FadeScale = Shader.PropertyToID("_FadeScale");

		internal static readonly int FadeData = Shader.PropertyToID("_FadeData");

		internal static readonly int Color = Shader.PropertyToID("_Color");

		internal static readonly int VP = Shader.PropertyToID("_VP");

		internal static readonly int CastDir = Shader.PropertyToID("_CastDir");

		internal static readonly int DataPack = Shader.PropertyToID("_dataPack");

		internal static readonly int NoiseTex = Shader.PropertyToID("_NoiseTex");

		internal static readonly int CheckDir = Shader.PropertyToID("_CheckDir");
	}

	private const string PROFILER_TAG = "SpeedLine";

	public override void Render(CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier target)
	{
		if (!(m_BlitMaterial == null))
		{
			cmd.BeginSample("SpeedLine");
			Vector4 value = new Vector4(m_Settings.NoiseScale.value.x, m_Settings.NoiseScale.value.y, m_Settings.NoiseOffset.value.x, m_Settings.NoiseOffset.value.y);
			m_BlitMaterial.SetVector(ShaderIDs.Scale, value);
			Vector4 value2 = new Vector4(m_Settings.FadeNoiseScale.value.x, m_Settings.FadeNoiseScale.value.y, m_Settings.FadeNoiseOffset.value.x, m_Settings.FadeNoiseOffset.value.y);
			m_BlitMaterial.SetVector(ShaderIDs.FadeScale, value2);
			Vector4 value3 = new Vector4(m_Settings.FadeNoisePower.value, m_Settings.FadeRangeMin.value, m_Settings.FadeRangeMax.value, m_Settings.Weight.value);
			m_BlitMaterial.SetVector(ShaderIDs.FadeData, value3);
			Color value4 = m_Settings.Color.value;
			m_BlitMaterial.SetColor(ShaderIDs.Color, value4);
			Camera current = Camera.current;
			if (current == null)
			{
				Matrix4x4 identity = Matrix4x4.identity;
			}
			else
			{
				Matrix4x4 identity = current.worldToCameraMatrix;
				Matrix4x4 value5 = current.projectionMatrix * identity;
				cmd.SetGlobalMatrix(ShaderIDs.VP, value5);
			}
			m_BlitMaterial.SetVector(ShaderIDs.CastDir, m_Settings.CastDir.value);
			Vector4 value6 = new Vector4(m_Settings.angle.value, m_Settings.Threshold.value, m_Settings.ThresholdRange.value, m_Settings.DissolveMapScale.value);
			m_BlitMaterial.SetVector(ShaderIDs.DataPack, value6);
			m_BlitMaterial.SetTexture(ShaderIDs.NoiseTex, m_Settings.LineTex.value);
			if (m_Settings.CheckDir.value)
			{
				m_BlitMaterial.SetFloat(ShaderIDs.CheckDir, 1f);
			}
			else
			{
				m_BlitMaterial.SetFloat(ShaderIDs.CheckDir, 0f);
			}
			cmd.Blit(source, target, m_BlitMaterial, 0);
			cmd.EndSample("SpeedLine");
		}
	}
}
