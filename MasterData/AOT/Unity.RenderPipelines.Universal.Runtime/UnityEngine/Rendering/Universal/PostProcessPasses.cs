using System;
using UnityEngine.Rendering.Universal.Internal;
using XPostProcessing;

namespace UnityEngine.Rendering.Universal;

internal struct PostProcessPasses : IDisposable
{
	private ColorGradingLutPass m_ColorGradingLutPass;

	private PostProcessPass m_PostProcessPass;

	private PostProcessPass m_FinalPostProcessPass;

	private AutoExposurePass m_AutoExposurePass;

	private RenderTargetHandle m_AfterPostProcessColor;

	private RenderTargetHandle m_ColorGradingLut;

	private PostProcessData m_RendererPostProcessData;

	private PostProcessData m_CurrentPostProcessData;

	private readonly VolumeComponentCache m_VolumeComponents;

	public ColorGradingLutPass colorGradingLutPass => m_ColorGradingLutPass;

	public PostProcessPass postProcessPass => m_PostProcessPass;

	public PostProcessPass finalPostProcessPass => m_FinalPostProcessPass;

	internal AutoExposurePass autoExposurePass => m_AutoExposurePass;

	public RenderTargetHandle afterPostProcessColor => m_AfterPostProcessColor;

	public RenderTargetHandle colorGradingLut => m_ColorGradingLut;

	public bool isCreated => m_CurrentPostProcessData != null;

	internal PostProcessPasses(PostProcessData rendererPostProcessData, VolumeComponentCache volumeComponents)
	{
		m_VolumeComponents = volumeComponents;
		m_ColorGradingLutPass = null;
		m_PostProcessPass = null;
		m_FinalPostProcessPass = null;
		m_AutoExposurePass = null;
		m_AfterPostProcessColor = default;
		m_ColorGradingLut = default;
		m_CurrentPostProcessData = null;
		m_AfterPostProcessColor.Init("_AfterPostProcessTexture");
		m_ColorGradingLut.Init("_InternalGradingLut");
		m_RendererPostProcessData = rendererPostProcessData;
		Recreate(rendererPostProcessData);
	}

	public void Recreate(PostProcessData data)
	{
		if ((bool)m_RendererPostProcessData)
		{
			data = m_RendererPostProcessData;
		}
		if (!(data == m_CurrentPostProcessData))
		{
			if (m_CurrentPostProcessData != null)
			{
				m_ColorGradingLutPass?.Cleanup();
				m_PostProcessPass?.Cleanup();
				m_FinalPostProcessPass?.Cleanup();
				m_AutoExposurePass?.Cleanup();
				m_ColorGradingLutPass = null;
				m_PostProcessPass = null;
				m_FinalPostProcessPass = null;
				m_AutoExposurePass = null;
				m_CurrentPostProcessData = null;
			}
			if (data != null)
			{
				m_ColorGradingLutPass = new ColorGradingLutPass(RenderPassEvent.ColorGradingLutPass, data, m_VolumeComponents);
				m_PostProcessPass = new PostProcessPass(RenderPassEvent.PostProcessPass, data, final: false, m_VolumeComponents);
				m_FinalPostProcessPass = new PostProcessPass(RenderPassEvent.FinalPostProcessPass, data, final: true, m_VolumeComponents);
				m_AutoExposurePass = new AutoExposurePass(m_PostProcessPass, m_VolumeComponents);
				m_PostProcessPass.SetAutoExposurePass(m_AutoExposurePass);
				m_CurrentPostProcessData = data;
			}
		}
	}

	public void Dispose()
	{
		m_ColorGradingLutPass?.Cleanup();
		m_PostProcessPass?.Cleanup();
		m_FinalPostProcessPass?.Cleanup();
		m_AutoExposurePass?.Cleanup();
	}
}
