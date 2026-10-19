using System;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

[Serializable]
public class BlurUIEffectRenderer : UIEffectRenderer<BlurUIEffect>
{
	private static class ShaderIDs
	{
		internal static readonly int SourceTex = Shader.PropertyToID("_SourceTex");

		internal static readonly int SourceTexelSize = Shader.PropertyToID("_SourceTex_TexelSize");

		internal static readonly int BufferRT1 = Shader.PropertyToID("_BufferRT1");

		internal static readonly int BufferRT2 = Shader.PropertyToID("_BufferRT2");

		internal static readonly int ComputeSource = Shader.PropertyToID("_UIBlurSource");

		internal static readonly int ComputeResult = Shader.PropertyToID("_UIBlurResult");

		internal static readonly int ComputeResultSize = Shader.PropertyToID("_UIBlurResultSize");

		internal static readonly int ComputeSourceSize = Shader.PropertyToID("_UIBlurSourceSize");

		internal static readonly int GaussianSamples = Shader.PropertyToID("_UIBlurGaussianSamples");

		internal static readonly int GaussianCenterWeight = Shader.PropertyToID("_UIBlurGaussianCenterWeight");

		internal static readonly int GaussianSamplePairCount = Shader.PropertyToID("_UIBlurGaussianSamplePairCount");
	}

	private const int k_ComputeGroupSize = 16;

	private const int k_WorkingDownsample = 8;

	private const string k_WidePrefilterKernelName = "UIBlurWidePrefilter";

	private const string k_GaussianHorizontalKernelName = "UIBlurGaussianHorizontal";

	private const string k_GaussianVerticalKernelName = "UIBlurGaussianVertical";

	private const int k_MaxGaussianSamplePairs = 24;

	private const float k_GaussianCutoff = 3.7f;

	private const float k_PrefilterVariance = 5.3333335f;

	private const GraphicsFormat k_ColorFormat = GraphicsFormat.B10G11R11_UFloatPack32;

	private ComputeShader m_ComputeShader;

	private bool m_CapabilitiesChecked;

	private bool m_ComputeSupported;

	private bool m_KernelsSupported;

	private int m_WidePrefilterKernel = -1;

	private int m_GaussianHorizontalKernel = -1;

	private int m_GaussianVerticalKernel = -1;

	private readonly Vector4[] m_GaussianSamples = new Vector4[24];

	private float m_CachedGaussianSigma = -1f;

	private float m_GaussianCenterWeight = 1f;

	private int m_GaussianSamplePairCount;

	public BlurUIEffectRenderer()
	{
		EffectName = "UIBlur";
	}

	private bool TryPrepareCompute(ref RenderingData renderingData)
	{
		if (!m_CapabilitiesChecked)
		{
			m_CapabilitiesChecked = true;
			m_ComputeSupported = SystemInfo.supportsComputeShaders && SystemInfo.IsFormatSupported(GraphicsFormat.B10G11R11_UFloatPack32, FormatUsage.LoadStore);
		}
		if (!m_ComputeSupported)
		{
			return false;
		}
		ComputeShader computeShader = renderingData.cameraData.renderer?.uiBlurComputeShader;
		if (computeShader == null)
		{
			return false;
		}
		if (m_ComputeShader != computeShader)
		{
			m_ComputeShader = computeShader;
			m_KernelsSupported = false;
			if (!computeShader.HasKernel("UIBlurWidePrefilter") || !computeShader.HasKernel("UIBlurGaussianHorizontal") || !computeShader.HasKernel("UIBlurGaussianVertical"))
			{
				return false;
			}
			m_WidePrefilterKernel = m_ComputeShader.FindKernel("UIBlurWidePrefilter");
			m_GaussianHorizontalKernel = m_ComputeShader.FindKernel("UIBlurGaussianHorizontal");
			m_GaussianVerticalKernel = m_ComputeShader.FindKernel("UIBlurGaussianVertical");
			m_KernelsSupported = m_ComputeShader.IsSupported(m_WidePrefilterKernel) && m_ComputeShader.IsSupported(m_GaussianHorizontalKernel) && m_ComputeShader.IsSupported(m_GaussianVerticalKernel);
		}
		return m_KernelsSupported;
	}

	private void DispatchWidePrefilter(CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier target, int sourceWidth, int sourceHeight, int targetWidth, int targetHeight)
	{
		cmd.SetComputeVectorParam(m_ComputeShader, ShaderIDs.ComputeSourceSize, new Vector4(sourceWidth, sourceHeight, 1f / (float)sourceWidth, 1f / (float)sourceHeight));
		cmd.SetComputeVectorParam(m_ComputeShader, ShaderIDs.ComputeResultSize, new Vector4(targetWidth, targetHeight, 1f / (float)targetWidth, 1f / (float)targetHeight));
		cmd.SetComputeTextureParam(m_ComputeShader, m_WidePrefilterKernel, ShaderIDs.ComputeSource, source);
		cmd.SetComputeTextureParam(m_ComputeShader, m_WidePrefilterKernel, ShaderIDs.ComputeResult, target);
		cmd.DispatchCompute(m_ComputeShader, m_WidePrefilterKernel, (targetWidth + 16 - 1) / 16, (targetHeight + 16 - 1) / 16, 1);
	}

	private void PrepareGaussianSamples(float sigma)
	{
		if (Mathf.Abs(m_CachedGaussianSigma - sigma) < 0.001f)
		{
			return;
		}
		m_CachedGaussianSigma = sigma;
		m_GaussianSamplePairCount = 0;
		m_GaussianCenterWeight = 1f;
		if (!(sigma < 0.01f))
		{
			float num = 0.5f / (sigma * sigma);
			int num2 = Mathf.Min(Mathf.CeilToInt(3.7f * sigma), 48);
			float num3 = 1f;
			for (int i = 1; i <= num2; i += 2)
			{
				float num4 = Mathf.Exp((float)(-i * i) * num);
				int num5 = i + 1;
				float num6 = ((num5 <= num2) ? Mathf.Exp((float)(-num5 * num5) * num) : 0f);
				float num7 = num4 + num6;
				float x = ((float)i * num4 + (float)num5 * num6) / num7;
				m_GaussianSamples[m_GaussianSamplePairCount++] = new Vector4(x, num7, 0f, 0f);
				num3 += num7 * 2f;
			}
			float num8 = (m_GaussianCenterWeight = 1f / num3);
			for (int j = 0; j < m_GaussianSamplePairCount; j++)
			{
				m_GaussianSamples[j].y *= num8;
			}
		}
	}

	private void DispatchGaussian(CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier temporary, RenderTargetIdentifier target, int width, int height, float sigma)
	{
		PrepareGaussianSamples(sigma);
		cmd.SetComputeVectorParam(m_ComputeShader, ShaderIDs.ComputeResultSize, new Vector4(width, height, 1f / (float)width, 1f / (float)height));
		cmd.SetComputeVectorArrayParam(m_ComputeShader, ShaderIDs.GaussianSamples, m_GaussianSamples);
		cmd.SetComputeFloatParam(m_ComputeShader, ShaderIDs.GaussianCenterWeight, m_GaussianCenterWeight);
		cmd.SetComputeIntParam(m_ComputeShader, ShaderIDs.GaussianSamplePairCount, m_GaussianSamplePairCount);
		cmd.SetComputeTextureParam(m_ComputeShader, m_GaussianHorizontalKernel, ShaderIDs.ComputeSource, source);
		cmd.SetComputeTextureParam(m_ComputeShader, m_GaussianHorizontalKernel, ShaderIDs.ComputeResult, temporary);
		cmd.DispatchCompute(m_ComputeShader, m_GaussianHorizontalKernel, (width + 16 - 1) / 16, (height + 16 - 1) / 16, 1);
		cmd.SetComputeTextureParam(m_ComputeShader, m_GaussianVerticalKernel, ShaderIDs.ComputeSource, temporary);
		cmd.SetComputeTextureParam(m_ComputeShader, m_GaussianVerticalKernel, ShaderIDs.ComputeResult, target);
		cmd.DispatchCompute(m_ComputeShader, m_GaussianVerticalKernel, (width + 16 - 1) / 16, (height + 16 - 1) / 16, 1);
	}

	public override bool Renderer(ref ScriptableRenderContext context, RenderTargetIdentifier source, RenderTargetIdentifier target, ref RenderingData renderingData, CommandBuffer cmd, float intensity)
	{
		float num = Mathf.Clamp01(intensity);
		if (num <= 0f || setting == null || !setting.IsActive())
		{
			return false;
		}
		if (!materialCreated)
		{
			materialCreated = Init();
		}
		if (!materialCreated)
		{
			return false;
		}
		bool flag = TryPrepareCompute(ref renderingData);
		UniversalRenderer renderer = renderingData.cameraData.renderer;
		RenderTextureDescriptor currentColorBufferDescriptor = renderer.GetCurrentColorBufferDescriptor();
		int num2 = Mathf.Max(currentColorBufferDescriptor.width, 1);
		int num3 = Mathf.Max(currentColorBufferDescriptor.height, 1);
		int num4 = Mathf.Max((num2 + 8 - 1) / 8, 1);
		int num5 = Mathf.Max((num3 + 8 - 1) / 8, 1);
		float num6 = setting.BlurRadius * num;
		float num7 = Mathf.Sqrt(Mathf.Max(num6 * num6 - 5.3333335f, 0f)) / 8f;
		bool flag2 = num7 >= 0.01f;
		cmd.GetTemporaryRT(ShaderIDs.BufferRT1, num4, num5, 0, FilterMode.Bilinear, GraphicsFormat.B10G11R11_UFloatPack32, 1, flag, RenderTextureMemoryless.None, useDynamicScale: false);
		if (flag2)
		{
			cmd.GetTemporaryRT(ShaderIDs.BufferRT2, num4, num5, 0, FilterMode.Bilinear, GraphicsFormat.B10G11R11_UFloatPack32, 1, flag, RenderTextureMemoryless.None, useDynamicScale: false);
		}
		RenderTargetIdentifier renderTargetIdentifier = new RenderTargetIdentifier(ShaderIDs.BufferRT1);
		if (flag)
		{
			DispatchWidePrefilter(cmd, source, renderTargetIdentifier, num2, num3, num4, num5);
			if (flag2)
			{
				DispatchGaussian(cmd, renderTargetIdentifier, new RenderTargetIdentifier(ShaderIDs.BufferRT2), renderTargetIdentifier, num4, num5, num7);
			}
		}
		else
		{
			cmd.SetGlobalVector(ShaderIDs.ComputeResultSize, new Vector4(num4, num5, 1f / (float)num4, 1f / (float)num5));
			DrawRasterBlur(cmd, source, renderTargetIdentifier, 2, num2, num3);
			if (flag2)
			{
				PrepareGaussianSamples(num7);
				cmd.SetGlobalVectorArray(ShaderIDs.GaussianSamples, m_GaussianSamples);
				cmd.SetGlobalFloat(ShaderIDs.GaussianCenterWeight, m_GaussianCenterWeight);
				cmd.SetGlobalInt(ShaderIDs.GaussianSamplePairCount, m_GaussianSamplePairCount);
				DrawRasterBlur(cmd, renderTargetIdentifier, ShaderIDs.BufferRT2, 3, num4, num5);
				DrawRasterBlur(cmd, ShaderIDs.BufferRT2, renderTargetIdentifier, 4, num4, num5);
			}
		}
		Vector4 scaleBiasTex = new Vector4(1f, 1f, 0f, 0f);
		cmd.SetRenderTarget(target, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, renderer.cameraDepthTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store);
		cmd.SetGlobalTexture(ShaderIDs.SourceTex, renderTargetIdentifier);
		RenderingUtils.DrawProcedural(cmd, m_BlitMaterial, 1, scaleBiasTex);
		cmd.ReleaseTemporaryRT(ShaderIDs.BufferRT1);
		if (flag2)
		{
			cmd.ReleaseTemporaryRT(ShaderIDs.BufferRT2);
		}
		return true;
	}

	private void DrawRasterBlur(CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier target, int pass, int sourceWidth, int sourceHeight)
	{
		cmd.SetRenderTarget(target, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store);
		cmd.SetGlobalTexture(ShaderIDs.SourceTex, source);
		cmd.SetGlobalVector(ShaderIDs.SourceTexelSize, new Vector4(1f / (float)sourceWidth, 1f / (float)sourceHeight, sourceWidth, sourceHeight));
		RenderingUtils.DrawProcedural(cmd, m_BlitMaterial, pass, new Vector4(1f, 1f, 0f, 0f));
	}

	public override void Cleanup()
	{
		base.Cleanup();
		m_ComputeShader = null;
		m_CapabilitiesChecked = false;
		m_ComputeSupported = false;
		m_KernelsSupported = false;
		m_WidePrefilterKernel = -1;
		m_GaussianHorizontalKernel = -1;
		m_GaussianVerticalKernel = -1;
		m_CachedGaussianSigma = -1f;
	}
}
