using System.Collections.Generic;
using UnityEngine.Rendering.Universal;
using UnityEngine.Rendering.Universal.Internal;

namespace XPostProcessing;

public class CustomPostProcess
{
	private List<AbstractVolumeRenderer> m_PostProcessingRenderers = new List<AbstractVolumeRenderer>();

	private readonly VolumeComponentCache m_VolumeComponents;

	public List<AbstractVolumeRenderer> renderers => m_PostProcessingRenderers;

	internal CustomPostProcess(PostProcessPass ppp, VolumeComponentCache volumeComponents)
	{
		m_VolumeComponents = volumeComponents;
		AddEffect(new FilmExposureRenderer());
		AddEffect(new BlackWhiteRenderer());
		AddEffect(new SpeedLineRenderer());
		AddEffect(new GetHitRenderer());
		AddEffect(new GlitchRGBSplitV5Renderer());
		AddEffect(new GlitchWaveJitterRenderer());
		AddEffect(new DirectionalBlurRenderer());
		AddEffect(new GaussianBlurRenderer());
		AddEffect(new RadialBlurV2Renderer());
		AddEffect(new SolarHaloRenderer());
		AddEffect(new BloomRenderer(ppp.BloomCS, ppp.BloomPS));
		AddEffect(new FilmBlackRenderer());
		AddEffect(new InnerWorldFilterRenderer());
	}

	private void AddEffect(AbstractVolumeRenderer renderer)
	{
		renderer.SetVolumeComponentCache(m_VolumeComponents);
		if (renderer.PlatformCompatible() && renderer.Init())
		{
			m_PostProcessingRenderers.Add(renderer);
		}
	}

	public void Cleanup()
	{
		for (int i = 0; i < m_PostProcessingRenderers.Count; i++)
		{
			m_PostProcessingRenderers[i].Cleanup();
		}
		m_PostProcessingRenderers.Clear();
	}
}
