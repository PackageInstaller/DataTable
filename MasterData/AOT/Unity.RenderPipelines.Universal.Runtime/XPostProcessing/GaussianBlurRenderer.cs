using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.Rendering.Universal.Internal;

namespace XPostProcessing;

public class GaussianBlurRenderer : VolumeRenderer<GaussianBlur>
{
	private static class ShaderIDs
	{
		internal static readonly int BlurRadius = Shader.PropertyToID("_BlurOffset");

		internal static readonly int SourceTex = Shader.PropertyToID("_SourceTex");

		internal static readonly int BufferRT1 = Shader.PropertyToID("_BufferRT1");

		internal static readonly int BufferRT2 = Shader.PropertyToID("_BufferRT2");
	}

	private const string PROFILER_TAG = "GaussianBlur";

	private static void DrawBlur(CommandBuffer cmd, Material material, int pass, RenderTargetIdentifier source, RenderTargetIdentifier target, Vector4 blitBias)
	{
		cmd.SetRenderTarget(target, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store);
		cmd.SetGlobalTexture(ShaderIDs.SourceTex, source);
		RenderingUtils.DrawProcedural(cmd, material, pass, blitBias);
	}

	public override void Render(CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier target, PostProcessPass ppp)
	{
		if (!(m_BlitMaterial == null))
		{
			cmd.BeginSample("GaussianBlur");
			Vector2 size = ppp.GetSize();
			int num = (int)size.x;
			int num2 = (int)size.y;
			float value = m_Settings.BlurRadius.value;
			float value2 = m_Settings.RTDownScaling.value;
			int value3 = m_Settings.Iteration.value;
			float x = value / (float)num;
			float y = value / (float)num2;
			int width = (int)((float)num / value2);
			int height = (int)((float)num2 / value2);
			cmd.GetTemporaryRT(ShaderIDs.BufferRT1, width, height, 0, FilterMode.Bilinear, RenderTextureFormat.RGB111110Float);
			cmd.GetTemporaryRT(ShaderIDs.BufferRT2, width, height, 0, FilterMode.Bilinear, RenderTextureFormat.RGB111110Float);
			Vector4 blitBias = new Vector4(1f, 1f, 0f, 0f);
			DrawBlur(cmd, m_BlitMaterial, 0, source, ShaderIDs.BufferRT1, blitBias);
			for (int i = 0; i < value3; i++)
			{
				cmd.SetGlobalVector(ShaderIDs.BlurRadius, new Vector4(x, 0f, 0f, 0f));
				DrawBlur(cmd, m_BlitMaterial, 0, ShaderIDs.BufferRT1, ShaderIDs.BufferRT2, blitBias);
				cmd.SetGlobalVector(ShaderIDs.BlurRadius, new Vector4(0f, y, 0f, 0f));
				DrawBlur(cmd, m_BlitMaterial, 0, ShaderIDs.BufferRT2, ShaderIDs.BufferRT1, blitBias);
			}
			DrawBlur(cmd, m_BlitMaterial, 1, ShaderIDs.BufferRT1, target, blitBias);
			cmd.ReleaseTemporaryRT(ShaderIDs.BufferRT1);
			cmd.ReleaseTemporaryRT(ShaderIDs.BufferRT2);
			cmd.EndSample("GaussianBlur");
		}
	}
}
