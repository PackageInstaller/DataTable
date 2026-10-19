using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering.Universal.Internal;

internal sealed class TemporalDepthOfFieldRenderer
{
	private static readonly int s_Source = Shader.PropertyToID("_TemporalDoFSource");

	private static readonly int s_Depth = Shader.PropertyToID("_TemporalDoFDepthTexture");

	private static readonly int s_FullCoC = Shader.PropertyToID("_TemporalDoFFullCoC");

	private static readonly int s_FullCoCOutput = Shader.PropertyToID("_TemporalDoFFullCoCOutput");

	private static readonly int s_HistoryColor = Shader.PropertyToID("_TemporalDoFHistoryColor");

	private static readonly int s_HistoryCoC = Shader.PropertyToID("_TemporalDoFHistoryCoC");

	private static readonly int s_HalfColor = Shader.PropertyToID("_TemporalDoFHalfColor");

	private static readonly int s_HalfCoC = Shader.PropertyToID("_TemporalDoFHalfCoC");

	private static readonly int s_HalfColorOutput = Shader.PropertyToID("_TemporalDoFHalfColorOutput");

	private static readonly int s_HalfCoCOutput = Shader.PropertyToID("_TemporalDoFHalfCoCOutput");

	private static readonly int s_ComplexReal = Shader.PropertyToID("_TemporalDoFComplexReal");

	private static readonly int s_ComplexImag = Shader.PropertyToID("_TemporalDoFComplexImag");

	private static readonly int s_ComplexRealOutput = Shader.PropertyToID("_TemporalDoFComplexRealOutput");

	private static readonly int s_ComplexImagOutput = Shader.PropertyToID("_TemporalDoFComplexImagOutput");

	private static readonly int s_FarColor = Shader.PropertyToID("_TemporalDoFFarColor");

	private static readonly int s_FarColorOutput = Shader.PropertyToID("_TemporalDoFFarColorOutput");

	private static readonly int s_FullSize = Shader.PropertyToID("_TemporalDoFFullSize");

	private static readonly int s_WorkSize = Shader.PropertyToID("_TemporalDoFWorkSize");

	private static readonly int s_CoCParams = Shader.PropertyToID("_TemporalDoFCoCParams");

	private static readonly int s_TemporalParams = Shader.PropertyToID("_TemporalDoFTemporalParams");

	private static readonly int s_GBuffer2 = Shader.PropertyToID("_GBuffer2");

	private readonly ComputeShader m_ComputeShader;

	private readonly Material m_CompositeMaterial;

	private readonly ProfilingSampler m_ProfilingSampler = new ProfilingSampler("Temporal Depth Of Field");

	private readonly GraphicsFormat m_ColorFormat;

	private readonly GraphicsFormat m_CoCFormat;

	private readonly GraphicsFormat m_ComplexFormat;

	private readonly int m_ComputeCoCKernel;

	private readonly int m_TemporalPrefilterKernel;

	private readonly int m_FarBlurHorizontalKernel;

	private readonly int m_FarBlurVerticalKernel;

	private readonly bool m_IsSupported;

	private readonly RenderTexture m_HistoryColor0;

	private readonly RenderTexture m_HistoryColor1;

	private readonly RenderTexture m_HistoryCoC0;

	private readonly RenderTexture m_HistoryCoC1;

	private bool m_PreviousHistoryIs0 = true;

	private bool m_HistoryValid;

	private bool m_HistoryAllocated;

	private int m_HistoryCameraId;

	private int m_HistoryWidth;

	private int m_HistoryHeight;

	private bool m_HistoryHadMotion;

	private float m_HistoryFarStart;

	private float m_HistoryFarEnd;

	private float m_HistoryKernelScale;

	private float m_HistoryFieldOfView;

	private float m_HistoryOrthoSize;

	private bool m_HistoryOrthographic;

	internal TemporalDepthOfFieldRenderer(ComputeShader computeShader, Shader compositeShader)
	{
		m_ComputeShader = computeShader;
		m_CompositeMaterial = ((compositeShader != null && compositeShader.isSupported) ? CoreUtils.CreateEngineMaterial(compositeShader) : null);
		m_CoCFormat = GraphicsFormat.R16_SFloat;
		m_ComplexFormat = GraphicsFormat.R16G16B16A16_SFloat;
		m_ColorFormat = GraphicsFormat.B10G11R11_UFloatPack32;
		bool flag = m_ComputeShader != null && m_ComputeShader.HasKernel("ComputeCoC") && m_ComputeShader.HasKernel("TemporalPrefilter") && m_ComputeShader.HasKernel("FarBlurHorizontal") && m_ComputeShader.HasKernel("FarBlurVertical");
		m_IsSupported = (SystemInfo.supportsComputeShaders & flag) && m_CompositeMaterial != null && SystemInfo.IsFormatSupported(m_ColorFormat, FormatUsage.LoadStore) && SystemInfo.IsFormatSupported(m_CoCFormat, FormatUsage.LoadStore) && SystemInfo.IsFormatSupported(m_ComplexFormat, FormatUsage.LoadStore);
		if (m_IsSupported)
		{
			m_ComputeCoCKernel = m_ComputeShader.FindKernel("ComputeCoC");
			m_TemporalPrefilterKernel = m_ComputeShader.FindKernel("TemporalPrefilter");
			m_FarBlurHorizontalKernel = m_ComputeShader.FindKernel("FarBlurHorizontal");
			m_FarBlurVerticalKernel = m_ComputeShader.FindKernel("FarBlurVertical");
		}
		m_HistoryColor0 = CreateHistoryShell("_TemporalDoFHistoryColor0");
		m_HistoryColor1 = CreateHistoryShell("_TemporalDoFHistoryColor1");
		m_HistoryCoC0 = CreateHistoryShell("_TemporalDoFHistoryCoC0");
		m_HistoryCoC1 = CreateHistoryShell("_TemporalDoFHistoryCoC1");
	}

	internal bool Render(CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier destination, RenderTargetIdentifier depth, UniversalRenderer renderer, ref RenderingData renderingData, TemporalDepthOfField settings)
	{
		if (!m_IsSupported)
		{
			return false;
		}
		ref CameraData cameraData = ref renderingData.cameraData;
		RenderTextureDescriptor cameraTargetDescriptor = cameraData.cameraTargetDescriptor;
		if (cameraTargetDescriptor.dimension != TextureDimension.Tex2D || cameraTargetDescriptor.volumeDepth != 1)
		{
			ReleaseHistory();
			return false;
		}
		int width = cameraTargetDescriptor.width;
		int height = cameraTargetDescriptor.height;
		int num = ((settings.quality.value == TemporalDepthOfFieldQuality.PerformanceQuarter) ? 4 : 2);
		int num2 = Mathf.Max(1, (width + num - 1) / num);
		int num3 = Mathf.Max(1, (height + num - 1) / num);
		bool flag = renderer != null && renderer.actualRenderingMode == RenderingMode.Deferred && renderer.gBuffer2TextureRT != null;
		EnsureHistoryTextures(num2, num3);
		if (!m_HistoryAllocated)
		{
			return false;
		}
		if (ShouldResetHistory(ref cameraData, settings, flag, renderingData.postProcessingData.temporalJitter.z > 0.5f, num2, num3))
		{
			m_HistoryValid = false;
		}
		RenderTexture renderTexture = (m_PreviousHistoryIs0 ? m_HistoryColor0 : m_HistoryColor1);
		RenderTexture renderTexture2 = (m_PreviousHistoryIs0 ? m_HistoryCoC0 : m_HistoryCoC1);
		RenderTexture renderTexture3 = (m_PreviousHistoryIs0 ? m_HistoryColor1 : m_HistoryColor0);
		RenderTexture renderTexture4 = (m_PreviousHistoryIs0 ? m_HistoryCoC1 : m_HistoryCoC0);
		bool flag2 = m_HistoryValid & flag;
		using (new ProfilingScope(cmd, m_ProfilingSampler))
		{
			AllocateTemporaryRT(cmd, s_FullCoC, width, height, m_CoCFormat);
			AllocateTemporaryRT(cmd, s_ComplexReal, num2, num3, m_ComplexFormat);
			AllocateTemporaryRT(cmd, s_ComplexImag, num2, num3, m_ComplexFormat);
			AllocateTemporaryRT(cmd, s_FarColor, num2, num3, m_ColorFormat);
			float z = settings.kernelScale.value * ((float)height / 1200f) * (2f / (float)num);
			cmd.SetComputeVectorParam(m_ComputeShader, s_FullSize, new Vector4(width, height, 1f / (float)width, 1f / (float)height));
			cmd.SetComputeVectorParam(m_ComputeShader, s_WorkSize, new Vector4(num2, num3, 1f / (float)num2, 1f / (float)num3));
			cmd.SetComputeVectorParam(m_ComputeShader, s_CoCParams, new Vector4(settings.farStart.value, settings.farEnd.value, z, settings.historyCoCThreshold.value));
			cmd.SetComputeVectorParam(m_ComputeShader, s_TemporalParams, new Vector4(settings.temporalFeedback.value, flag2 ? 1f : 0f, flag ? 1f : 0f, 0f));
			cmd.SetComputeTextureParam(m_ComputeShader, m_ComputeCoCKernel, s_Depth, depth);
			cmd.SetComputeTextureParam(m_ComputeShader, m_ComputeCoCKernel, s_FullCoCOutput, s_FullCoC);
			Dispatch(cmd, m_ComputeCoCKernel, width, height);
			cmd.SetComputeTextureParam(m_ComputeShader, m_TemporalPrefilterKernel, s_Source, source);
			cmd.SetComputeTextureParam(m_ComputeShader, m_TemporalPrefilterKernel, s_FullCoC, s_FullCoC);
			cmd.SetComputeTextureParam(m_ComputeShader, m_TemporalPrefilterKernel, s_HistoryColor, renderTexture);
			cmd.SetComputeTextureParam(m_ComputeShader, m_TemporalPrefilterKernel, s_HistoryCoC, renderTexture2);
			BindMotionFeature(cmd, renderer, m_TemporalPrefilterKernel, flag);
			cmd.SetComputeTextureParam(m_ComputeShader, m_TemporalPrefilterKernel, s_HalfColorOutput, renderTexture3);
			cmd.SetComputeTextureParam(m_ComputeShader, m_TemporalPrefilterKernel, s_HalfCoCOutput, renderTexture4);
			Dispatch(cmd, m_TemporalPrefilterKernel, num2, num3);
			cmd.SetComputeTextureParam(m_ComputeShader, m_FarBlurHorizontalKernel, s_HalfColor, renderTexture3);
			cmd.SetComputeTextureParam(m_ComputeShader, m_FarBlurHorizontalKernel, s_HalfCoC, renderTexture4);
			cmd.SetComputeTextureParam(m_ComputeShader, m_FarBlurHorizontalKernel, s_ComplexRealOutput, s_ComplexReal);
			cmd.SetComputeTextureParam(m_ComputeShader, m_FarBlurHorizontalKernel, s_ComplexImagOutput, s_ComplexImag);
			Dispatch(cmd, m_FarBlurHorizontalKernel, num2, num3);
			cmd.SetComputeTextureParam(m_ComputeShader, m_FarBlurVerticalKernel, s_HalfCoC, renderTexture4);
			cmd.SetComputeTextureParam(m_ComputeShader, m_FarBlurVerticalKernel, s_ComplexReal, s_ComplexReal);
			cmd.SetComputeTextureParam(m_ComputeShader, m_FarBlurVerticalKernel, s_ComplexImag, s_ComplexImag);
			cmd.SetComputeTextureParam(m_ComputeShader, m_FarBlurVerticalKernel, s_FarColorOutput, s_FarColor);
			Dispatch(cmd, m_FarBlurVerticalKernel, num2, num3);
			cmd.SetGlobalTexture(s_FullCoC, s_FullCoC);
			cmd.SetGlobalTexture(s_FarColor, s_FarColor);
			cmd.SetGlobalTexture(ShaderPropertyId.sourceTex, source);
			cmd.Blit(source, destination, m_CompositeMaterial, 0);
			cmd.ReleaseTemporaryRT(s_FullCoC);
			cmd.ReleaseTemporaryRT(s_ComplexReal);
			cmd.ReleaseTemporaryRT(s_ComplexImag);
			cmd.ReleaseTemporaryRT(s_FarColor);
		}
		CommitHistory();
		return true;
	}

	internal void ReleaseHistory()
	{
		if (m_HistoryAllocated)
		{
			ReleaseGpuAllocation(m_HistoryColor0);
			ReleaseGpuAllocation(m_HistoryColor1);
			ReleaseGpuAllocation(m_HistoryCoC0);
			ReleaseGpuAllocation(m_HistoryCoC1);
			m_HistoryValid = false;
			m_HistoryAllocated = false;
			m_HistoryWidth = 0;
			m_HistoryHeight = 0;
		}
	}

	internal void Cleanup()
	{
		CoreUtils.Destroy(m_CompositeMaterial);
		DestroyHistoryTexture(m_HistoryColor0);
		DestroyHistoryTexture(m_HistoryColor1);
		DestroyHistoryTexture(m_HistoryCoC0);
		DestroyHistoryTexture(m_HistoryCoC1);
	}

	private bool ShouldResetHistory(ref CameraData cameraData, TemporalDepthOfField settings, bool hasMotion, bool temporalReset, int width, int height)
	{
		Camera camera = cameraData.camera;
		int instanceID = camera.GetInstanceID();
		bool result = (cameraData.resetHistoryForCamera | temporalReset) || RenderingProjectionChanged(camera) || m_HistoryCameraId != instanceID || m_HistoryWidth != width || m_HistoryHeight != height || m_HistoryHadMotion != hasMotion || !Mathf.Approximately(m_HistoryFarStart, settings.farStart.value) || !Mathf.Approximately(m_HistoryFarEnd, settings.farEnd.value) || !Mathf.Approximately(m_HistoryKernelScale, settings.kernelScale.value);
		m_HistoryCameraId = instanceID;
		m_HistoryWidth = width;
		m_HistoryHeight = height;
		m_HistoryHadMotion = hasMotion;
		m_HistoryFarStart = settings.farStart.value;
		m_HistoryFarEnd = settings.farEnd.value;
		m_HistoryKernelScale = settings.kernelScale.value;
		m_HistoryFieldOfView = camera.fieldOfView;
		m_HistoryOrthoSize = camera.orthographicSize;
		m_HistoryOrthographic = camera.orthographic;
		return result;
	}

	private bool RenderingProjectionChanged(Camera camera)
	{
		if (m_HistoryOrthographic == camera.orthographic && (camera.orthographic || Mathf.Approximately(m_HistoryFieldOfView, camera.fieldOfView)))
		{
			if (camera.orthographic)
			{
				return !Mathf.Approximately(m_HistoryOrthoSize, camera.orthographicSize);
			}
			return false;
		}
		return true;
	}

	private void CommitHistory()
	{
		m_PreviousHistoryIs0 = !m_PreviousHistoryIs0;
		m_HistoryValid = true;
	}

	private void BindMotionFeature(CommandBuffer cmd, UniversalRenderer renderer, int kernel, bool hasMotion)
	{
		if (!hasMotion)
		{
			cmd.SetComputeTextureParam(m_ComputeShader, kernel, s_GBuffer2, Texture2D.blackTexture);
		}
		else if (renderer.renderPassScheduleMode == RenderPassScheduleMode.Mobile)
		{
			cmd.SetComputeTextureParam(m_ComputeShader, kernel, s_GBuffer2, renderer.gBuffer2Texture);
		}
		else
		{
			cmd.SetComputeTextureParam(m_ComputeShader, kernel, s_GBuffer2, renderer.gBuffer2TextureRT);
		}
	}

	private void EnsureHistoryTextures(int width, int height)
	{
		if (EnsureHistoryTexture(m_HistoryColor0, width, height, m_ColorFormat) | EnsureHistoryTexture(m_HistoryColor1, width, height, m_ColorFormat) | EnsureHistoryTexture(m_HistoryCoC0, width, height, m_CoCFormat) | EnsureHistoryTexture(m_HistoryCoC1, width, height, m_CoCFormat))
		{
			m_HistoryValid = false;
			m_PreviousHistoryIs0 = true;
		}
		m_HistoryAllocated = m_HistoryColor0.IsCreated() && m_HistoryColor1.IsCreated() && m_HistoryCoC0.IsCreated() && m_HistoryCoC1.IsCreated();
	}

	private static RenderTexture CreateHistoryShell(string name)
	{
		return new RenderTexture(1, 1, 0)
		{
			name = name,
			filterMode = FilterMode.Bilinear,
			wrapMode = TextureWrapMode.Clamp,
			hideFlags = HideFlags.HideAndDontSave
		};
	}

	private static bool EnsureHistoryTexture(RenderTexture texture, int width, int height, GraphicsFormat format)
	{
		if (texture.IsCreated() && texture.width == width && texture.height == height && texture.graphicsFormat == format)
		{
			return false;
		}
		if (texture.IsCreated())
		{
			texture.Release();
		}
		RenderTextureDescriptor renderTextureDescriptor = new RenderTextureDescriptor(width, height);
		renderTextureDescriptor.graphicsFormat = format;
		renderTextureDescriptor.depthStencilFormat = GraphicsFormat.None;
		renderTextureDescriptor.depthBufferBits = 0;
		renderTextureDescriptor.msaaSamples = 1;
		renderTextureDescriptor.volumeDepth = 1;
		renderTextureDescriptor.enableRandomWrite = true;
		renderTextureDescriptor.useMipMap = false;
		renderTextureDescriptor.autoGenerateMips = false;
		renderTextureDescriptor.useDynamicScale = false;
		renderTextureDescriptor.sRGB = false;
		RenderTextureDescriptor descriptor = renderTextureDescriptor;
		texture.descriptor = descriptor;
		texture.filterMode = FilterMode.Bilinear;
		texture.wrapMode = TextureWrapMode.Clamp;
		texture.Create();
		return true;
	}

	private static void AllocateTemporaryRT(CommandBuffer cmd, int id, int width, int height, GraphicsFormat format)
	{
		cmd.GetTemporaryRT(id, width, height, 0, FilterMode.Bilinear, format, 1, enableRandomWrite: true, RenderTextureMemoryless.None, useDynamicScale: false);
	}

	private void Dispatch(CommandBuffer cmd, int kernel, int width, int height)
	{
		cmd.DispatchCompute(m_ComputeShader, kernel, (width + 7) / 8, (height + 7) / 8, 1);
	}

	private static void ReleaseGpuAllocation(RenderTexture texture)
	{
		if (texture != null && texture.IsCreated())
		{
			texture.Release();
		}
	}

	private static void DestroyHistoryTexture(RenderTexture texture)
	{
		if (!(texture == null))
		{
			if (texture.IsCreated())
			{
				texture.Release();
			}
			CoreUtils.Destroy(texture);
		}
	}
}
