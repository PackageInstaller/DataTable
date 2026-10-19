using System;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.Rendering.Universal.Internal;

namespace XPostProcessing;

public class AutoExposureRenderer : VolumeRenderer<AutoExposure>, IDisposable
{
	private static class ShaderIDs
	{
		internal static readonly int HistogramData = Shader.PropertyToID("_HistogramData");

		internal static readonly int ReCalculateData = Shader.PropertyToID("_ReCalculateData");

		internal static readonly int TargetResolution = Shader.PropertyToID("_TargetResolution");

		internal static readonly int HistogramBuffer = Shader.PropertyToID("_HistogramBuffer");

		internal static readonly int HistogramLut = Shader.PropertyToID("_HistogramLUT");

		internal static readonly int AEBuffer = Shader.PropertyToID("_AEBuffer");

		internal static readonly int HistogramLut2 = Shader.PropertyToID("_AEHistogramLUT");

		internal static readonly int AutoEVLUT = Shader.PropertyToID("_AutoEVLUT");

		internal static readonly int _Source = Shader.PropertyToID("_Source");

		internal static readonly int _ExposureLUTCS = Shader.PropertyToID("_ExposureLUTCS");

		internal static readonly int AppliedExposureLUT = Shader.PropertyToID("_AppliedExposureLUT");

		internal static readonly int DeferredSceneAutoExposureEnable = Shader.PropertyToID("_DeferredSceneAutoExposureEnable");
	}

	private const string PROFILER_TAG = "AutoExposure";

	private const float MinimumLuminance = 0.001f;

	private const int HistogramBinCount = 256;

	private const int HistogramSampleStride = 16;

	private const int HistogramThreadGroupSize = 8;

	private RenderTexture m_HistogramLUT;

	private ComputeBuffer m_histogramBuffer;

	private int m_HistogramBufferCount;

	public static ComputeBuffer m_AEBuffer;

	private ComputeShader cs;

	private const int kernel = 0;

	private const int kernel2 = 1;

	internal bool isAvailable => cs != null;

	public AutoExposureRenderer(PostProcessPass ppp)
	{
		cs = ppp.GetAutoEVCS();
	}

	private void creatLUTRT()
	{
		if (m_HistogramLUT == null)
		{
			m_HistogramLUT = new RenderTexture(256, 1, GraphicsFormat.R16_SFloat, GraphicsFormat.None);
			m_HistogramLUT.name = "HistogramLUT";
			m_HistogramLUT.hideFlags = HideFlags.HideAndDontSave;
			m_HistogramLUT.dimension = TextureDimension.Tex2D;
			m_HistogramLUT.volumeDepth = 1;
			m_HistogramLUT.enableRandomWrite = true;
			m_HistogramLUT.filterMode = FilterMode.Point;
			m_HistogramLUT.Create();
		}
	}

	private static void EnsureHistogramBuffer(ref ComputeBuffer buffer, ref int bufferCount, int requiredCount)
	{
		if (buffer == null || bufferCount < requiredCount)
		{
			int num = Mathf.NextPowerOfTwo(Mathf.Max(1, requiredCount));
			buffer?.Release();
			buffer = new ComputeBuffer(num, 4);
			bufferCount = num;
		}
	}

	private void creatBuffer(int histogramBufferCount)
	{
		EnsureHistogramBuffer(ref m_histogramBuffer, ref m_HistogramBufferCount, histogramBufferCount);
		if (m_AEBuffer == null)
		{
			m_AEBuffer = new ComputeBuffer(1, 8);
		}
	}

	public override void Cleanup()
	{
		Dispose();
	}

	public void Dispose()
	{
		if (m_histogramBuffer != null)
		{
			m_histogramBuffer.Release();
			m_histogramBuffer = null;
			m_HistogramBufferCount = 0;
		}
		if (m_AEBuffer != null)
		{
			m_AEBuffer.Release();
			m_AEBuffer = null;
		}
		if (m_HistogramLUT != null)
		{
			if (m_HistogramLUT.IsCreated())
			{
				m_HistogramLUT.Release();
			}
			CoreUtils.Destroy(m_HistogramLUT);
			m_HistogramLUT = null;
		}
	}

	internal void PublishAppliedExposure(CommandBuffer cmd, ref CameraData cameraData)
	{
		RenderTexture autoExposureHistoryLUT = cameraData.autoExposureHistoryLUT;
		if (!(autoExposureHistoryLUT == null))
		{
			cmd.SetGlobalTexture(ShaderIDs.AutoEVLUT, autoExposureHistoryLUT);
			if (m_HistogramLUT != null)
			{
				cmd.SetGlobalTexture(ShaderIDs.HistogramLut2, m_HistogramLUT);
			}
		}
	}

	internal void RenderCurrentSource(ref ScriptableRenderContext context, RenderTargetIdentifier source, int sourceWidth, int sourceHeight, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		creatLUTRT();
		RenderTexture autoExposureHistoryLUT = renderingData.cameraData.autoExposureHistoryLUT;
		RenderTexture autoExposureCurrentLUT = renderingData.cameraData.autoExposureCurrentLUT;
		if (!(autoExposureHistoryLUT == null) && !(autoExposureCurrentLUT == null))
		{
			cmd.BeginSample("AutoExposure");
			int num = Mathf.Max(1, sourceWidth);
			int num2 = Mathf.Max(1, sourceHeight);
			int num3 = (num + 16 - 1) / 16;
			int num4 = (num2 + 16 - 1) / 16;
			int num5 = (num3 + 8 - 1) / 8;
			int num6 = (num4 + 8 - 1) / 8;
			int histogramBufferCount = num5 * num6 * 256;
			creatBuffer(histogramBufferCount);
			ComputeBuffer histogramBuffer = m_histogramBuffer;
			ComputeBuffer aEBuffer = m_AEBuffer;
			RenderTexture histogramLUT = m_HistogramLUT;
			cmd.SetComputeVectorParam(cs, ShaderIDs.TargetResolution, new Vector4(num, num2, m_Settings.ExposureSpeed.value, Time.deltaTime));
			float num7 = Mathf.Max(0.001f, m_Settings.ExposureMin.value);
			float num8 = Mathf.Max(num7 + 0.001f, m_Settings.ExposureMax.value);
			cmd.SetComputeVectorParam(cs, ShaderIDs.HistogramData, new Vector4(num7, num8, m_Settings.filtering.value.x / 100f, m_Settings.filtering.value.y / 100f));
			float num9 = Mathf.Log(num7, 2f);
			float y = Mathf.Log(num8, 2f) - num9;
			float x = num9;
			cmd.SetComputeVectorParam(cs, ShaderIDs.ReCalculateData, new Vector4(x, y, m_Settings.GlobalScale.value, 256f));
			cmd.SetComputeTextureParam(cs, 0, ShaderIDs.AppliedExposureLUT, autoExposureHistoryLUT);
			cmd.SetComputeTextureParam(cs, 1, ShaderIDs.AppliedExposureLUT, autoExposureHistoryLUT);
			cmd.SetComputeTextureParam(cs, 1, ShaderIDs._ExposureLUTCS, autoExposureCurrentLUT);
			cmd.SetComputeTextureParam(cs, 1, ShaderIDs.HistogramLut, histogramLUT);
			cmd.SetComputeTextureParam(cs, 0, ShaderIDs._Source, source);
			cmd.SetComputeBufferParam(cs, 0, ShaderIDs.HistogramBuffer, histogramBuffer);
			cmd.SetComputeBufferParam(cs, 1, ShaderIDs.HistogramBuffer, histogramBuffer);
			cmd.SetComputeBufferParam(cs, 1, ShaderIDs.AEBuffer, aEBuffer);
			cmd.SetGlobalFloat(ShaderIDs.DeferredSceneAutoExposureEnable, 1f);
			cmd.SetGlobalTexture(ShaderIDs.HistogramLut2, histogramLUT);
			cmd.DispatchCompute(cs, 0, num5, num6, 1);
			cmd.DispatchCompute(cs, 1, 1, 1, 1);
			cmd.SetGlobalFloat(ShaderIDs.DeferredSceneAutoExposureEnable, 1f);
			cmd.EndSample("AutoExposure");
			context.ExecuteCommandBuffer(cmd);
			cmd.Clear();
		}
	}
}
