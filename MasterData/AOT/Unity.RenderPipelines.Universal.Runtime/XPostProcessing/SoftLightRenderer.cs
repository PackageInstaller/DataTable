using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal.Internal;

namespace XPostProcessing;

public class SoftLightRenderer : VolumeRenderer<SoftLight>
{
	private static class ShaderIDs
	{
		internal static readonly int BlurRadius = Shader.PropertyToID("_BlurOffset");

		internal static readonly int BufferRT1 = Shader.PropertyToID("_BufferRT1");

		internal static readonly int BufferRT2 = Shader.PropertyToID("_BufferRT2");

		internal static readonly int BlendWeight = Shader.PropertyToID("_BlendWeight");

		internal static readonly int SourTex = Shader.PropertyToID("_SourTex");
	}

	private const string PROFILER_TAG = "SoftLight";

	public override bool PlatformCompatible()
	{
		return true;
	}

	public override void Render(CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier target, PostProcessPass ppp)
	{
		if (m_BlitMaterial == null)
		{
			return;
		}
		cmd.BeginSample("SoftLight");
		Vector2 size = ppp.GetSize();
		int width = (int)(size.x / m_Settings.RTDownScaling.value);
		int height = (int)(size.y / m_Settings.RTDownScaling.value);
		cmd.GetTemporaryRT(ShaderIDs.BufferRT1, width, height, 0, FilterMode.Bilinear, GraphicsFormat.B10G11R11_UFloatPack32);
		cmd.GetTemporaryRT(ShaderIDs.BufferRT2, width, height, 0, FilterMode.Bilinear, GraphicsFormat.B10G11R11_UFloatPack32);
		m_BlitMaterial.SetVector(ShaderIDs.BlendWeight, new Vector4(m_Settings.BlendWeight.value, m_Settings.BlendType.value));
		for (int i = 0; i < m_Settings.Iteration.value; i++)
		{
			cmd.SetGlobalVector(ShaderIDs.BlurRadius, new Vector4(m_Settings.BlurRadius.value / size.x, 0f, 0f, 0f));
			if (i == 0)
			{
				ACTRenderingFunction.ACT_BlitWithOutLoad(cmd, source, ShaderIDs.BufferRT2, m_BlitMaterial, 0);
			}
			else
			{
				ACTRenderingFunction.ACT_BlitWithOutLoad(cmd, ShaderIDs.BufferRT1, ShaderIDs.BufferRT2, m_BlitMaterial, 0);
			}
			cmd.SetGlobalVector(ShaderIDs.BlurRadius, new Vector4(0f, m_Settings.BlurRadius.value / size.y, 0f, 0f));
			ACTRenderingFunction.ACT_BlitWithOutLoad(cmd, ShaderIDs.BufferRT2, ShaderIDs.BufferRT1, m_BlitMaterial, 0);
		}
		cmd.SetGlobalTexture(ShaderIDs.SourTex, source);
		ACTRenderingFunction.ACT_BlitWithOutLoad(cmd, ShaderIDs.BufferRT1, target, m_BlitMaterial, 1);
		cmd.ReleaseTemporaryRT(ShaderIDs.BufferRT1);
		cmd.ReleaseTemporaryRT(ShaderIDs.BufferRT2);
		cmd.EndSample("SoftLight");
	}
}
