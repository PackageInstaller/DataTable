using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.Rendering.Universal.Internal;

namespace XPostProcessing;

internal sealed class AutoExposurePass : ScriptableRenderPass
{
	private const string GameHistoryContextName = "Game";

	private readonly AutoExposureRenderer m_Renderer;

	private readonly VolumeComponentCache m_VolumeComponents;

	private readonly bool m_IsAvailable;

	private bool m_MeterCurrentCamera;

	private AutoExposureHistoryResources m_GameHistoryResources;

	internal AutoExposurePass(PostProcessPass postProcessPass, VolumeComponentCache volumeComponents)
	{
		profilingSampler = new ProfilingSampler("AutoExposurePass");
		renderPassEvent = RenderPassEvent.AutoExposurePass;
		targetCount = 0u;
		m_VolumeComponents = volumeComponents;
		m_Renderer = new AutoExposureRenderer(postProcessPass);
		m_Renderer.SetVolumeComponentCache(volumeComponents);
		m_IsAvailable = m_Renderer.isAvailable && m_Renderer.PlatformCompatible() && m_Renderer.Init();
	}

	internal bool Setup(ref RenderingData renderingData, bool postProcessingEnabled)
	{
		NativeRenderPassManager nativeRenderPassManager = renderingData.nativeRenderPassManager;
		nativeRenderPassManager.autoExposureEnabledForCamera = false;
		m_MeterCurrentCamera = false;
		ref CameraData cameraData = ref renderingData.cameraData;
		if ((!cameraData.isGameCamera && !cameraData.isSceneViewCamera) || !cameraData.isBase)
		{
			return false;
		}
		if (!postProcessingEnabled || !m_IsAvailable || m_VolumeComponents.BlackWhite.IsActive() || !m_Renderer.IsActive())
		{
			return false;
		}
		AutoExposureHistoryResources orCreateHistoryResources = GetOrCreateHistoryResources(ref cameraData);
		if (cameraData.resetHistoryForCamera)
		{
			orCreateHistoryResources.Reset();
		}
		orCreateHistoryResources.AdvanceFrame();
		cameraData.autoExposureHistoryLUT = orCreateHistoryResources.historyExposureLUT;
		cameraData.autoExposureCurrentLUT = orCreateHistoryResources.currentExposureLUT;
		if (cameraData.autoExposureHistoryLUT == null || cameraData.autoExposureCurrentLUT == null)
		{
			return false;
		}
		m_MeterCurrentCamera = true;
		nativeRenderPassManager.autoExposureEnabledForCamera = true;
		return true;
	}

	private AutoExposureHistoryResources GetOrCreateHistoryResources(ref CameraData cameraData)
	{
		return EnsureHistoryResources(ref m_GameHistoryResources, "Game");
	}

	private static AutoExposureHistoryResources EnsureHistoryResources(ref AutoExposureHistoryResources historyResources, string contextName)
	{
		if (historyResources != null && historyResources.isCreated)
		{
			return historyResources;
		}
		historyResources?.Dispose();
		historyResources = new AutoExposureHistoryResources(contextName);
		return historyResources;
	}

	private void ReleaseHistoryResources()
	{
		m_GameHistoryResources?.Dispose();
		m_GameHistoryResources = null;
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		m_Renderer.PublishAppliedExposure(renderingData.cmd, ref renderingData.cameraData);
	}

	internal void RenderAfterTemporal(ref ScriptableRenderContext context, RenderTargetIdentifier source, int sourceWidth, int sourceHeight, ref RenderingData renderingData)
	{
		if (m_MeterCurrentCamera)
		{
			m_MeterCurrentCamera = false;
			m_Renderer.RenderCurrentSource(ref context, source, sourceWidth, sourceHeight, ref renderingData);
		}
	}

	internal void Cleanup()
	{
		ReleaseHistoryResources();
		m_Renderer.Cleanup();
	}

	internal void ReleasePersistentRenderResources()
	{
		ReleaseHistoryResources();
		m_Renderer.Dispose();
	}
}
