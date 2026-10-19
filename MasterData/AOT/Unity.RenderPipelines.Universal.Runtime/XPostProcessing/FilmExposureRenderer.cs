using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.Rendering.Universal.Internal;

namespace XPostProcessing;

public class FilmExposureRenderer : VolumeRenderer<FilmExposure>
{
	private static class ShaderIDs
	{
		internal static readonly int data = Shader.PropertyToID("_FilmExposureData");

		internal static readonly int exposure = Shader.PropertyToID("_FilmExposureIntensity");
	}

	private const string PROFILER_TAG = "FilmExposure";

	private float randomFrequency;

	public override bool Render(ref ScriptableRenderContext context, RenderTargetIdentifier source, RenderTargetIdentifier target, PostProcessPass ppp, ref RenderingData renderingData)
	{
		if (m_BlitMaterial == null)
		{
			return false;
		}
		CommandBuffer cmd = renderingData.cmd;
		cmd.BeginSample("FilmExposure");
		Color value = m_Settings.FilmColor.value;
		m_BlitMaterial.SetVector(ShaderIDs.data, new Vector4(value.r, value.g, value.b, m_Settings.Intensity.value));
		m_BlitMaterial.SetFloat(ShaderIDs.exposure, m_Settings.Exposure.value);
		cmd.Blit(source, target, m_BlitMaterial, 0);
		cmd.EndSample("FilmExposure");
		context.ExecuteCommandBuffer(cmd);
		cmd.Clear();
		return true;
	}
}
