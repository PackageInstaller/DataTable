using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.Rendering.Universal.Internal;

namespace XPostProcessing;

public sealed class BloomRenderer : VolumeRenderer<Bloom>
{
	private const string ProfilerTag = "Bloom";

	private const int MaxMipCount = 9;

	private const int OriginalMaxMipCount = 7;

	private const GraphicsFormat k_BloomFormat = GraphicsFormat.B10G11R11_UFloatPack32;

	private static readonly int[] s_DownMipIds = new int[9]
	{
		Shader.PropertyToID("_BloomDown0"),
		Shader.PropertyToID("_BloomDown1"),
		Shader.PropertyToID("_BloomDown2"),
		Shader.PropertyToID("_BloomDown3"),
		Shader.PropertyToID("_BloomDown4"),
		Shader.PropertyToID("_BloomDown5"),
		Shader.PropertyToID("_BloomDown6"),
		Shader.PropertyToID("_BloomDown7"),
		Shader.PropertyToID("_BloomDown8")
	};

	private static readonly int[] s_UpMipIds = new int[8]
	{
		Shader.PropertyToID("_BloomUp0"),
		Shader.PropertyToID("_BloomUp1"),
		Shader.PropertyToID("_BloomUp2"),
		Shader.PropertyToID("_BloomUp3"),
		Shader.PropertyToID("_BloomUp4"),
		Shader.PropertyToID("_BloomUp5"),
		Shader.PropertyToID("_BloomUp6"),
		Shader.PropertyToID("_BloomUp7")
	};

	private static readonly int[] s_OriginalMixMipIds = new int[6]
	{
		Shader.PropertyToID("_OriginalBloomMip1"),
		Shader.PropertyToID("_OriginalBloomMip2"),
		Shader.PropertyToID("_OriginalBloomMip3"),
		Shader.PropertyToID("_OriginalBloomMip4"),
		Shader.PropertyToID("_OriginalBloomMip5"),
		Shader.PropertyToID("_OriginalBloomMip6")
	};

	private static readonly int BloomSource = Shader.PropertyToID("_BloomSource");

	private static readonly int RasterSourceTex = Shader.PropertyToID("_SourceTex");

	private static readonly int RasterSourceTexelSize = Shader.PropertyToID("_SourceTex_TexelSize");

	private static readonly int RasterSourceLowMip = Shader.PropertyToID("_SourceTexLowMip");

	private static readonly int RasterSourceLowMipTexelSize = Shader.PropertyToID("_SourceTexLowMip_TexelSize");

	private static readonly int RasterParams = Shader.PropertyToID("_Params");

	private static readonly int BloomHighMip = Shader.PropertyToID("_BloomHighMip");

	private static readonly int BloomLowMip = Shader.PropertyToID("_BloomLowMip");

	private static readonly int BloomResult = Shader.PropertyToID("_BloomResult");

	private static readonly int BloomSourceTexelSize = Shader.PropertyToID("_BloomSourceTexelSize");

	private static readonly int BloomResultSize = Shader.PropertyToID("_BloomResultSize");

	private static readonly int BloomThreshold = Shader.PropertyToID("_BloomThreshold");

	private static readonly int BloomPrefilterScale = Shader.PropertyToID("_BloomPrefilterScale");

	private static readonly int BloomScatter = Shader.PropertyToID("_BloomScatter");

	private static readonly int BloomData = Shader.PropertyToID("_BloomData");

	private static readonly int BloomCompositeData = Shader.PropertyToID("_BloomCompositeData");

	private static readonly int BloomTex = Shader.PropertyToID("_BloomTex");

	private static readonly int RasterTemporary = Shader.PropertyToID("_BloomRasterTemporary");

	private static readonly int OriginalBloomThreshold = Shader.PropertyToID("_OriginalBloomThreshold");

	private static readonly int OriginalBloomClamp = Shader.PropertyToID("_OriginalBloomClamp");

	private static readonly int OriginalBloomType = Shader.PropertyToID("_OriginalBloomType");

	private static readonly int OriginalBloomScatter = Shader.PropertyToID("_OriginalBloomScatter");

	private static readonly int OriginalBloomGenericWeight = Shader.PropertyToID("_OriginalBloomGenericWeight");

	private static readonly int OriginalBloomIteration = Shader.PropertyToID("_OriginalBloomIteration");

	private static readonly int OriginalBloomBaseMip = Shader.PropertyToID("_OriginalBloomBaseMip");

	private static readonly int OriginalBloomWeightTexture0 = Shader.PropertyToID("_OriginalBloomWeightTexture0");

	private static readonly int OriginalBloomWeightTexture1 = Shader.PropertyToID("_OriginalBloomWeightTexture1");

	private static int s_AllocatedDownMipCount;

	private static int s_AllocatedUpMipCount;

	private readonly ComputeShader m_ComputeShader;

	private readonly Shader m_RasterShader;

	private readonly int[] m_MipWidths = new int[9];

	private readonly int[] m_MipHeights = new int[9];

	private ProfilingSampler m_ProfilingSampler;

	private bool m_UseCompute;

	private int m_PrefilterKernel;

	private int m_DownsampleKernel;

	private int m_UpsampleKernel;

	private int m_OriginalPrefilterDeferredPCKernel;

	private int m_OriginalPrefilterDeferredMobileKernel;

	private int m_OriginalDownsampleKernel;

	private int m_OriginalMixKernel;

	public BloomRenderer(ComputeShader computeShader, Shader rasterShader = null)
	{
		m_ComputeShader = computeShader;
		m_RasterShader = rasterShader;
	}

	public override bool Init()
	{
		m_ProfilingSampler = new ProfilingSampler("Bloom");
		_ = settings;
		bool flag = false;
		bool flag2 = false;
		bool flag3 = TryInitializeCompute();
		m_UseCompute = (flag ? flag3 : (!flag2 & flag3));
		if (flag && !flag3)
		{
			Debug.LogWarning("[Bloom] Editor 强制 Compute，但硬件/格式/Kernel 检查失败，回退到 Raster。");
		}
		string selectedPath;
		if (m_UseCompute)
		{
			selectedPath = (flag ? "Compute (Editor Forced)" : "Compute (Auto)");
		}
		else
		{
			selectedPath = (flag2 ? "Raster (Editor Forced)" : "Raster (Auto)");
		}
		if (!m_UseCompute && !TryCreateRasterMaterial())
		{
			LogHardwareCapabilities("Disabled (Raster shader unavailable)");
			return false;
		}
		LogHardwareCapabilities(selectedPath);
		return base.Init();
	}

	private void LogHardwareCapabilities(string selectedPath)
	{
		bool flag = SystemInfo.IsFormatSupported(GraphicsFormat.B10G11R11_UFloatPack32, FormatUsage.Render);
		bool flag2 = SystemInfo.IsFormatSupported(GraphicsFormat.B10G11R11_UFloatPack32, FormatUsage.LoadStore);
		bool flag3 = SystemInfo.IsFormatSupported(GraphicsFormat.B10G11R11_UFloatPack32, FormatUsage.Sample);
		bool flag4 = SystemInfo.IsFormatSupported(GraphicsFormat.B10G11R11_UFloatPack32, FormatUsage.Linear);
		bool flag5 = SystemInfo.IsFormatSupported(GraphicsFormat.R16G16B16A16_SFloat, FormatUsage.Render);
		bool flag6 = SystemInfo.IsFormatSupported(GraphicsFormat.R16G16B16A16_SFloat, FormatUsage.LoadStore);
		bool flag7 = SystemInfo.IsFormatSupported(GraphicsFormat.R16G16B16A16_SFloat, FormatUsage.Sample);
		bool flag8 = SystemInfo.IsFormatSupported(GraphicsFormat.R16G16B16A16_SFloat, FormatUsage.Linear);
		Debug.Log($"[Bloom] Init path={selectedPath}, format={GraphicsFormat.B10G11R11_UFloatPack32}, " + $"API={SystemInfo.graphicsDeviceType}, GPU={SystemInfo.graphicsDeviceName}, " + $"Version={SystemInfo.graphicsDeviceVersion}, ShaderLevel={SystemInfo.graphicsShaderLevel}, " + $"Compute={SystemInfo.supportsComputeShaders}, " + $"R11(Render={flag},LoadStore={flag2},Sample={flag3},Linear={flag4}), " + $"RGBA16F(Render={flag5},LoadStore={flag6},Sample={flag7},Linear={flag8})");
	}

	private bool TryInitializeCompute()
	{
		if (!SystemInfo.supportsComputeShaders || m_ComputeShader == null || !SystemInfo.IsFormatSupported(GraphicsFormat.B10G11R11_UFloatPack32, FormatUsage.LoadStore) || !m_ComputeShader.HasKernel("BloomPrefilter") || !m_ComputeShader.HasKernel("BloomDownsample") || !m_ComputeShader.HasKernel("BloomUpsample") || !m_ComputeShader.HasKernel("OriginalBloomPrefilterDeferredPC") || !m_ComputeShader.HasKernel("OriginalBloomPrefilterDeferredMobile") || !m_ComputeShader.HasKernel("OriginalBloomDownsample") || !m_ComputeShader.HasKernel("OriginalBloomMix"))
		{
			return false;
		}
		m_PrefilterKernel = m_ComputeShader.FindKernel("BloomPrefilter");
		m_DownsampleKernel = m_ComputeShader.FindKernel("BloomDownsample");
		m_UpsampleKernel = m_ComputeShader.FindKernel("BloomUpsample");
		m_OriginalPrefilterDeferredPCKernel = m_ComputeShader.FindKernel("OriginalBloomPrefilterDeferredPC");
		m_OriginalPrefilterDeferredMobileKernel = m_ComputeShader.FindKernel("OriginalBloomPrefilterDeferredMobile");
		m_OriginalDownsampleKernel = m_ComputeShader.FindKernel("OriginalBloomDownsample");
		m_OriginalMixKernel = m_ComputeShader.FindKernel("OriginalBloomMix");
		if (m_ComputeShader.IsSupported(m_PrefilterKernel) && m_ComputeShader.IsSupported(m_DownsampleKernel) && m_ComputeShader.IsSupported(m_UpsampleKernel) && m_ComputeShader.IsSupported(m_OriginalPrefilterDeferredPCKernel) && m_ComputeShader.IsSupported(m_OriginalPrefilterDeferredMobileKernel) && m_ComputeShader.IsSupported(m_OriginalDownsampleKernel))
		{
			return m_ComputeShader.IsSupported(m_OriginalMixKernel);
		}
		return false;
	}

	private bool TryCreateRasterMaterial()
	{
		if (m_BlitMaterial != null)
		{
			return true;
		}
		Shader shader = ((m_RasterShader != null) ? m_RasterShader : Shader.Find("Hidden/Universal Render Pipeline/Bloom"));
		if (shader == null || !shader.isSupported)
		{
			return false;
		}
		m_BlitMaterial = CoreUtils.CreateEngineMaterial(shader);
		return m_BlitMaterial != null;
	}

	public static void ReleaseCameraTemporaryRTs(CommandBuffer cmd)
	{
		for (int i = 0; i < s_AllocatedDownMipCount; i++)
		{
			cmd.ReleaseTemporaryRT(s_DownMipIds[i]);
		}
		for (int j = 0; j < s_AllocatedUpMipCount; j++)
		{
			cmd.ReleaseTemporaryRT(s_UpMipIds[j]);
		}
		s_AllocatedDownMipCount = 0;
		s_AllocatedUpMipCount = 0;
	}

	public override bool Render(ref ScriptableRenderContext context, RenderTargetIdentifier source, RenderTargetIdentifier target, PostProcessPass postProcessPass, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		using (new ProfilingScope(cmd, m_ProfilingSampler))
		{
			ReleaseCameraTemporaryRTs(cmd);
			Vector2 size = postProcessPass.GetSize();
			int num = Mathf.Max(1, (int)size.x);
			int num2 = Mathf.Max(1, (int)size.y);
			bool value = m_Settings.UseOriginalBloom.value;
			SetBloomCompositeParameters(cmd, value);
			if (!m_UseCompute)
			{
				RenderRasterBloom(cmd, source, postProcessPass, ref renderingData, num, num2, value);
				context.ExecuteCommandBuffer(cmd);
				cmd.Clear();
				return false;
			}
			if (value)
			{
				RenderOriginalBloom(cmd, source, postProcessPass, ref renderingData, num, num2);
				context.ExecuteCommandBuffer(cmd);
				cmd.Clear();
				return false;
			}
			int num3 = Mathf.Max(1, (num + 1) / 2);
			int num4 = Mathf.Max(1, (num2 + 1) / 2);
			int num5 = Mathf.Clamp(m_Settings.IterationCount.value, 1, 9);
			for (int i = 0; i < num5; i++)
			{
				int num6 = 1 << i;
				m_MipWidths[i] = Mathf.Max(1, (num3 + num6 / 2) / num6);
				m_MipHeights[i] = Mathf.Max(1, (num4 + num6 / 2) / num6);
			}
			for (int j = 0; j < num5; j++)
			{
				AllocateBloomRT(cmd, s_DownMipIds[j], m_MipWidths[j], m_MipHeights[j]);
				s_AllocatedDownMipCount++;
			}
			for (int k = 0; k < num5 - 1; k++)
			{
				AllocateBloomRT(cmd, s_UpMipIds[k], m_MipWidths[k], m_MipHeights[k]);
				s_AllocatedUpMipCount++;
			}
			cmd.SetComputeFloatParam(m_ComputeShader, BloomPrefilterScale, m_Settings.PrefilterScale.value);
			cmd.SetComputeFloatParam(m_ComputeShader, BloomScatter, m_Settings.Scatter.value);
			SetComputeSize(cmd, num, num2, num3, num4);
			cmd.SetComputeTextureParam(m_ComputeShader, m_PrefilterKernel, BloomSource, source);
			cmd.SetComputeTextureParam(m_ComputeShader, m_PrefilterKernel, BloomResult, s_DownMipIds[0]);
			int num7 = (num3 + 7) / 8;
			int num8 = (num4 + 7) / 8;
			cmd.DispatchCompute(m_ComputeShader, m_PrefilterKernel, num7, num8, 1);
			for (int l = 1; l < num5; l++)
			{
				SetComputeSize(cmd, m_MipWidths[l - 1], m_MipHeights[l - 1], m_MipWidths[l], m_MipHeights[l]);
				cmd.SetComputeTextureParam(m_ComputeShader, m_DownsampleKernel, BloomSource, s_DownMipIds[l - 1]);
				cmd.SetComputeTextureParam(m_ComputeShader, m_DownsampleKernel, BloomResult, s_DownMipIds[l]);
				int num9 = 1 << l;
				int threadGroupsX = (num7 + num9 - 1) / num9;
				int threadGroupsY = (num8 + num9 - 1) / num9;
				cmd.DispatchCompute(m_ComputeShader, m_DownsampleKernel, threadGroupsX, threadGroupsY, 1);
			}
			for (int num10 = num5 - 2; num10 >= 0; num10--)
			{
				int num11 = ((num10 == num5 - 2) ? s_DownMipIds[num10 + 1] : s_UpMipIds[num10 + 1]);
				SetComputeSize(cmd, m_MipWidths[num10 + 1], m_MipHeights[num10 + 1], m_MipWidths[num10], m_MipHeights[num10]);
				cmd.SetComputeTextureParam(m_ComputeShader, m_UpsampleKernel, BloomHighMip, s_DownMipIds[num10]);
				cmd.SetComputeTextureParam(m_ComputeShader, m_UpsampleKernel, BloomLowMip, num11);
				cmd.SetComputeTextureParam(m_ComputeShader, m_UpsampleKernel, BloomResult, s_UpMipIds[num10]);
				int num12 = 1 << num10;
				int threadGroupsX2 = (num7 + num12 - 1) / num12;
				int threadGroupsY2 = (num8 + num12 - 1) / num12;
				cmd.DispatchCompute(m_ComputeShader, m_UpsampleKernel, threadGroupsX2, threadGroupsY2, 1);
			}
			int num13 = ((num5 > 1) ? s_UpMipIds[0] : s_DownMipIds[0]);
			cmd.SetGlobalTexture(BloomTex, num13);
			postProcessPass.EnableBloomForUber();
			context.ExecuteCommandBuffer(cmd);
			cmd.Clear();
			return false;
		}
	}

	private void RenderOriginalBloom(CommandBuffer cmd, RenderTargetIdentifier source, PostProcessPass postProcessPass, ref RenderingData renderingData, int sourceWidth, int sourceHeight)
	{
		int num = Mathf.Clamp(m_Settings.iterateCount.value, 1, 7);
		while (num > 1 && sourceHeight / (1 << num) < 2)
		{
			num--;
		}
		for (int i = 0; i < num; i++)
		{
			int num2 = 1 << i + 1;
			m_MipWidths[i] = Mathf.Max(1, sourceWidth / num2);
			m_MipHeights[i] = Mathf.Max(1, sourceHeight / num2);
		}
		for (int j = 0; j < num; j++)
		{
			AllocateBloomRT(cmd, s_DownMipIds[j], m_MipWidths[j], m_MipHeights[j]);
			s_AllocatedDownMipCount++;
		}
		if (num > 1)
		{
			AllocateBloomRT(cmd, s_UpMipIds[0], m_MipWidths[0], m_MipHeights[0]);
			s_AllocatedUpMipCount = 1;
		}
		cmd.SetComputeFloatParam(m_ComputeShader, OriginalBloomThreshold, m_Settings.BloomThreshold.value);
		cmd.SetComputeFloatParam(m_ComputeShader, OriginalBloomClamp, m_Settings.BloomClamp.value);
		cmd.SetComputeFloatParam(m_ComputeShader, OriginalBloomType, m_Settings.BloomType.value);
		cmd.SetComputeFloatParam(m_ComputeShader, OriginalBloomScatter, m_Settings.BloomScatter.value);
		cmd.SetComputeFloatParam(m_ComputeShader, OriginalBloomGenericWeight, m_Settings.GenericBloomWeight.value);
		int andBindOriginalBloomPrefilterKernel = GetAndBindOriginalBloomPrefilterKernel(cmd, ref renderingData);
		SetComputeSize(cmd, sourceWidth, sourceHeight, m_MipWidths[0], m_MipHeights[0]);
		cmd.SetComputeTextureParam(m_ComputeShader, andBindOriginalBloomPrefilterKernel, BloomSource, source);
		cmd.SetComputeTextureParam(m_ComputeShader, andBindOriginalBloomPrefilterKernel, BloomResult, s_DownMipIds[0]);
		DispatchForSize(cmd, andBindOriginalBloomPrefilterKernel, m_MipWidths[0], m_MipHeights[0]);
		for (int k = 1; k < num; k++)
		{
			SetComputeSize(cmd, m_MipWidths[k - 1], m_MipHeights[k - 1], m_MipWidths[k], m_MipHeights[k]);
			cmd.SetComputeTextureParam(m_ComputeShader, m_OriginalDownsampleKernel, BloomSource, s_DownMipIds[k - 1]);
			cmd.SetComputeTextureParam(m_ComputeShader, m_OriginalDownsampleKernel, BloomResult, s_DownMipIds[k]);
			DispatchForSize(cmd, m_OriginalDownsampleKernel, m_MipWidths[k], m_MipHeights[k]);
		}
		if (num > 1)
		{
			cmd.SetComputeIntParam(m_ComputeShader, OriginalBloomIteration, num);
			cmd.SetComputeTextureParam(m_ComputeShader, m_OriginalMixKernel, OriginalBloomBaseMip, s_DownMipIds[0]);
			for (int l = 1; l <= 6; l++)
			{
				int num3 = Mathf.Min(l, num - 1);
				cmd.SetComputeTextureParam(m_ComputeShader, m_OriginalMixKernel, s_OriginalMixMipIds[l - 1], s_DownMipIds[num3]);
			}
			SetComputeSize(cmd, m_MipWidths[0], m_MipHeights[0], m_MipWidths[0], m_MipHeights[0]);
			cmd.SetComputeTextureParam(m_ComputeShader, m_OriginalMixKernel, BloomResult, s_UpMipIds[0]);
			DispatchForSize(cmd, m_OriginalMixKernel, m_MipWidths[0], m_MipHeights[0]);
		}
		int num4 = ((num > 1) ? s_UpMipIds[0] : s_DownMipIds[0]);
		cmd.SetGlobalTexture(BloomTex, num4);
		postProcessPass.EnableBloomForUber();
	}

	private void RenderRasterBloom(CommandBuffer cmd, RenderTargetIdentifier source, PostProcessPass postProcessPass, ref RenderingData renderingData, int sourceWidth, int sourceHeight, bool useOriginalBloom)
	{
		int num = (useOriginalBloom ? Mathf.Clamp(m_Settings.iterateCount.value, 1, 7) : Mathf.Clamp(m_Settings.IterationCount.value, 1, 9));
		if (useOriginalBloom)
		{
			while (num > 1 && sourceHeight / (1 << num) < 2)
			{
				num--;
			}
		}
		int num2 = Mathf.Max(1, (sourceWidth + 1) / 2);
		int num3 = Mathf.Max(1, (sourceHeight + 1) / 2);
		for (int i = 0; i < num; i++)
		{
			int num4 = 1 << i;
			m_MipWidths[i] = Mathf.Max(1, (num2 + num4 / 2) / num4);
			m_MipHeights[i] = Mathf.Max(1, (num3 + num4 / 2) / num4);
			AllocateBloomRT(cmd, s_DownMipIds[i], m_MipWidths[i], m_MipHeights[i]);
			s_AllocatedDownMipCount++;
		}
		int num5 = ((!useOriginalBloom) ? (num - 1) : ((num > 1) ? 1 : 0));
		for (int j = 0; j < num5; j++)
		{
			AllocateBloomRT(cmd, s_UpMipIds[j], m_MipWidths[j], m_MipHeights[j]);
			s_AllocatedUpMipCount++;
		}
		float z = (useOriginalBloom ? m_Settings.BloomThreshold.value : m_Settings.Threshold.value);
		float w = (useOriginalBloom ? 0.5f : Mathf.Max(0.0001f, m_Settings.SoftKnee.value));
		float x = (useOriginalBloom ? m_Settings.BloomScatter.value : m_Settings.Scatter.value);
		float y = (useOriginalBloom ? m_Settings.BloomClamp.value : 7777f);
		cmd.SetGlobalVector(RasterParams, new Vector4(x, y, z, w));
		if (useOriginalBloom)
		{
			BindRasterOriginalBloomInputs(cmd, ref renderingData);
			DrawRasterBloom(cmd, source, s_DownMipIds[0], 4, sourceWidth, sourceHeight, m_MipWidths[0], m_MipHeights[0], default, 1, 1);
			for (int k = 1; k < num; k++)
			{
				AllocateBloomRT(cmd, RasterTemporary, m_MipWidths[k], m_MipHeights[k]);
				DrawRasterBloom(cmd, s_DownMipIds[k - 1], RasterTemporary, 5, m_MipWidths[k - 1], m_MipHeights[k - 1], m_MipWidths[k], m_MipHeights[k], default, 1, 1);
				DrawRasterBloom(cmd, RasterTemporary, s_DownMipIds[k], 6, m_MipWidths[k], m_MipHeights[k], m_MipWidths[k], m_MipHeights[k], default, 1, 1);
				cmd.ReleaseTemporaryRT(RasterTemporary);
			}
			if (num > 1)
			{
				cmd.SetGlobalFloat(OriginalBloomIteration, num);
				cmd.SetGlobalTexture(OriginalBloomBaseMip, s_DownMipIds[0]);
				for (int l = 1; l <= 6; l++)
				{
					int num6 = Mathf.Min(l, num - 1);
					cmd.SetGlobalTexture(s_OriginalMixMipIds[l - 1], s_DownMipIds[num6]);
				}
				DrawRasterBloom(cmd, s_DownMipIds[0], s_UpMipIds[0], 7, m_MipWidths[0], m_MipHeights[0], m_MipWidths[0], m_MipHeights[0], default, 1, 1);
			}
		}
		else
		{
			DrawRasterBloom(cmd, source, s_DownMipIds[0], 0, sourceWidth, sourceHeight, m_MipWidths[0], m_MipHeights[0], default, 1, 1);
			for (int m = 1; m < num; m++)
			{
				AllocateBloomRT(cmd, RasterTemporary, m_MipWidths[m], m_MipHeights[m]);
				DrawRasterBloom(cmd, s_DownMipIds[m - 1], RasterTemporary, 1, m_MipWidths[m - 1], m_MipHeights[m - 1], m_MipWidths[m], m_MipHeights[m], default, 1, 1);
				DrawRasterBloom(cmd, RasterTemporary, s_DownMipIds[m], 2, m_MipWidths[m], m_MipHeights[m], m_MipWidths[m], m_MipHeights[m], default, 1, 1);
				cmd.ReleaseTemporaryRT(RasterTemporary);
			}
			for (int num7 = num - 2; num7 >= 0; num7--)
			{
				RenderTargetIdentifier lowMip = ((num7 == num - 2) ? s_DownMipIds[num7 + 1] : s_UpMipIds[num7 + 1]);
				DrawRasterBloom(cmd, s_DownMipIds[num7], s_UpMipIds[num7], 3, m_MipWidths[num7], m_MipHeights[num7], m_MipWidths[num7], m_MipHeights[num7], lowMip, m_MipWidths[num7 + 1], m_MipHeights[num7 + 1]);
			}
		}
		int num8 = ((num > 1) ? s_UpMipIds[0] : s_DownMipIds[0]);
		cmd.SetGlobalTexture(BloomTex, num8);
		postProcessPass.EnableBloomForUber();
	}

	private void BindRasterOriginalBloomInputs(CommandBuffer cmd, ref RenderingData renderingData)
	{
		UniversalRenderer renderer = renderingData.cameraData.renderer;
		Texture texture = renderer?.gBuffer2TextureRT;
		if (texture == null)
		{
			texture = Texture2D.blackTexture;
		}
		if (renderer != null && renderer.renderPassScheduleMode == RenderPassScheduleMode.Mobile)
		{
			cmd.SetGlobalTexture(OriginalBloomWeightTexture0, texture);
		}
		else
		{
			cmd.SetGlobalTexture(OriginalBloomWeightTexture1, texture);
		}
		cmd.SetGlobalFloat(OriginalBloomThreshold, m_Settings.BloomThreshold.value);
		cmd.SetGlobalFloat(OriginalBloomClamp, m_Settings.BloomClamp.value);
		cmd.SetGlobalFloat(OriginalBloomType, m_Settings.BloomType.value);
		cmd.SetGlobalFloat(OriginalBloomScatter, m_Settings.BloomScatter.value);
		cmd.SetGlobalFloat(OriginalBloomGenericWeight, m_Settings.GenericBloomWeight.value);
	}

	private void DrawRasterBloom(CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier target, int pass, int sourceWidth, int sourceHeight, int targetWidth, int targetHeight, RenderTargetIdentifier lowMip, int lowMipWidth, int lowMipHeight)
	{
		cmd.SetRenderTarget(target, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store);
		cmd.SetGlobalTexture(RasterSourceTex, source);
		cmd.SetGlobalVector(RasterSourceTexelSize, new Vector4(1f / (float)sourceWidth, 1f / (float)sourceHeight, sourceWidth, sourceHeight));
		if (pass == 3)
		{
			cmd.SetGlobalTexture(RasterSourceLowMip, lowMip);
			cmd.SetGlobalVector(RasterSourceLowMipTexelSize, new Vector4(1f / (float)lowMipWidth, 1f / (float)lowMipHeight, lowMipWidth, lowMipHeight));
		}
		RenderingUtils.DrawProcedural(cmd, m_BlitMaterial, pass, new Vector4(1f, 1f, 0f, 0f));
	}

	private void SetBloomCompositeParameters(CommandBuffer cmd, bool useOriginalBloom)
	{
		float value;
		float num;
		float y;
		float y2;
		if (useOriginalBloom)
		{
			value = m_Settings.BloomThreshold.value;
			num = 0.5f;
			y = 1f;
			y2 = m_Settings.BloomType.value;
		}
		else
		{
			value = m_Settings.Threshold.value;
			num = Mathf.Max(0.0001f, m_Settings.SoftKnee.value);
			y = m_Settings.PrefilterScale.value;
			y2 = 0f;
		}
		cmd.SetGlobalVector(BloomThreshold, new Vector4(value, value - num, num * 2f, 0.25f / num));
		cmd.SetGlobalVector(BloomData, new Vector4(m_Settings.Intensity.value, y, m_Settings.BrightPassReplacement.value, (float)m_Settings.CompositeMode.value));
		cmd.SetGlobalVector(BloomCompositeData, new Vector4(m_Settings.BloomSaturate.value, y2, 0f, 0f));
	}

	private int GetAndBindOriginalBloomPrefilterKernel(CommandBuffer cmd, ref RenderingData renderingData)
	{
		UniversalRenderer renderer = renderingData.cameraData.renderer;
		if (renderer != null && renderer.renderPassScheduleMode == RenderPassScheduleMode.Mobile)
		{
			cmd.SetComputeTextureParam(m_ComputeShader, m_OriginalPrefilterDeferredMobileKernel, OriginalBloomWeightTexture0, renderer.gBuffer2Texture);
			return m_OriginalPrefilterDeferredMobileKernel;
		}
		cmd.SetComputeTextureParam(m_ComputeShader, m_OriginalPrefilterDeferredPCKernel, OriginalBloomWeightTexture1, (renderer != null && renderer.gBuffer2TextureRT != null) ? renderer.gBuffer2TextureRT : Texture2D.blackTexture);
		return m_OriginalPrefilterDeferredPCKernel;
	}

	private void DispatchForSize(CommandBuffer cmd, int kernel, int width, int height)
	{
		cmd.DispatchCompute(m_ComputeShader, kernel, (width + 7) / 8, (height + 7) / 8, 1);
	}

	private void AllocateBloomRT(CommandBuffer cmd, int id, int width, int height)
	{
		cmd.GetTemporaryRT(id, width, height, 0, FilterMode.Bilinear, GraphicsFormat.B10G11R11_UFloatPack32, 1, m_UseCompute, RenderTextureMemoryless.None, useDynamicScale: false);
	}

	private void SetComputeSize(CommandBuffer cmd, int sourceWidth, int sourceHeight, int resultWidth, int resultHeight)
	{
		cmd.SetComputeVectorParam(m_ComputeShader, BloomSourceTexelSize, new Vector4(1f / (float)sourceWidth, 1f / (float)sourceHeight, sourceWidth, sourceHeight));
		cmd.SetComputeVectorParam(m_ComputeShader, BloomResultSize, new Vector4(resultWidth, resultHeight, 1f / (float)resultWidth, 1f / (float)resultHeight));
	}
}
