using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering.Universal;

public class SSRHiZPass : ScriptableRenderPass
{
	private static class ShaderContants
	{
		public static readonly int HiZDepthTextureID = Shader.PropertyToID("_SSRHiZDepthTexture");

		public static readonly int HiZSourceID = Shader.PropertyToID("_SSRHiZSource");

		public static readonly int HiZTargetID = Shader.PropertyToID("_SSRHiZTarget");

		public static readonly int HiZMipCountID = Shader.PropertyToID("_SSRHiZMipCount");
	}

	private const int MaxMipCount = 5;

	private const int ThreadGroupSize = 8;

	private const string CopyDepthKernelName = "CopyDepth";

	private const string DownsampleKernelName = "Downsample";

	private readonly ComputeShader m_ComputeShader;

	private readonly GraphicsFormat m_GraphicsFormat;

	private readonly int m_CopyDepthKernel;

	private readonly int m_DownsampleKernel;

	private int m_MipCount;

	public SSRHiZPass(ComputeShader computeShader, GraphicsFormat graphicsFormat)
	{
		profilingSampler = new ProfilingSampler("SSRHiZPass");
		renderPassEvent = RenderPassEvent.SSRHiZPass;
		m_ComputeShader = computeShader;
		m_GraphicsFormat = graphicsFormat;
		m_CopyDepthKernel = computeShader.FindKernel("CopyDepth");
		m_DownsampleKernel = computeShader.FindKernel("Downsample");
		targetCount = 0u;
	}

	internal static bool TryGetSupportedFormat(ComputeShader computeShader, out GraphicsFormat format)
	{
		format = GraphicsFormat.None;
		if (!SystemInfo.supportsComputeShaders || computeShader == null || !computeShader.HasKernel("CopyDepth") || !computeShader.HasKernel("Downsample"))
		{
			return false;
		}
		format = GraphicsFormat.R32_SFloat;
		return true;
	}

	public void Setup()
	{
	}

	public override void Configure(ref RenderingData renderingData)
	{
		nativeRenderPassType = NativeRenderPassType.None;
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		UniversalRenderer renderer = renderingData.cameraData.renderer;
		if (m_ComputeShader == null || renderer == null)
		{
			return;
		}
		CommandBuffer cmd = renderingData.cmd;
		RenderTextureDescriptor cameraTargetDescriptor = renderingData.cameraData.cameraTargetDescriptor;
		cameraTargetDescriptor.depthBufferBits = 0;
		cameraTargetDescriptor.depthStencilFormat = GraphicsFormat.None;
		cameraTargetDescriptor.graphicsFormat = m_GraphicsFormat;
		cameraTargetDescriptor.msaaSamples = 1;
		cameraTargetDescriptor.bindMS = false;
		cameraTargetDescriptor.memoryless = RenderTextureMemoryless.None;
		cameraTargetDescriptor.enableRandomWrite = true;
		cameraTargetDescriptor.useMipMap = true;
		cameraTargetDescriptor.autoGenerateMips = false;
		m_MipCount = CalculateMipCount(cameraTargetDescriptor.width, cameraTargetDescriptor.height);
		cameraTargetDescriptor.mipCount = m_MipCount;
		using (new ProfilingScope(cmd, profilingSampler))
		{
			cmd.GetTemporaryRT(ShaderContants.HiZDepthTextureID, cameraTargetDescriptor, FilterMode.Point);
			cmd.SetGlobalInteger(ShaderContants.HiZMipCountID, m_MipCount);
			cmd.SetComputeTextureParam(m_ComputeShader, m_CopyDepthKernel, ShaderPropertyId._CameraDepthTexture, renderer.cameraDepthTexture);
			cmd.SetComputeTextureParam(m_ComputeShader, m_CopyDepthKernel, ShaderContants.HiZTargetID, ShaderContants.HiZDepthTextureID, 0);
			Dispatch(cmd, m_CopyDepthKernel, cameraTargetDescriptor.width, cameraTargetDescriptor.height);
			int num = cameraTargetDescriptor.width;
			int num2 = cameraTargetDescriptor.height;
			for (int i = 1; i < m_MipCount; i++)
			{
				int num3 = Mathf.Max(1, num >> 1);
				int num4 = Mathf.Max(1, num2 >> 1);
				cmd.SetComputeTextureParam(m_ComputeShader, m_DownsampleKernel, ShaderContants.HiZSourceID, ShaderContants.HiZDepthTextureID, i - 1);
				cmd.SetComputeTextureParam(m_ComputeShader, m_DownsampleKernel, ShaderContants.HiZTargetID, ShaderContants.HiZDepthTextureID, i);
				Dispatch(cmd, m_DownsampleKernel, num3, num4);
				num = num3;
				num2 = num4;
			}
			cmd.SetGlobalTexture(ShaderContants.HiZDepthTextureID, ShaderContants.HiZDepthTextureID);
		}
	}

	private void Dispatch(CommandBuffer cmd, int kernel, int width, int height)
	{
		int threadGroupsX = Mathf.Max(1, (width + 8 - 1) / 8);
		int threadGroupsY = Mathf.Max(1, (height + 8 - 1) / 8);
		cmd.DispatchCompute(m_ComputeShader, kernel, threadGroupsX, threadGroupsY, 1);
	}

	private static int CalculateMipCount(int width, int height)
	{
		int num = 1;
		int num2 = Mathf.Max(width, height);
		while (num2 > 1 && num < 5)
		{
			num2 = Mathf.Max(1, num2 >> 1);
			num++;
		}
		return num;
	}
}
