using ACT.SceneLightVolume;
using XPostProcessing;

namespace UnityEngine.Rendering.Universal;

internal sealed class VolumeComponentCache
{
	private VolumeStack m_Stack;

	private int m_Version;

	internal int version => m_Version;

	internal ChannelMixer ChannelMixer { get; private set; }

	internal ColorAdjustments ColorAdjustments { get; private set; }

	internal ColorCurves ColorCurves { get; private set; }

	internal LiftGammaGain LiftGammaGain { get; private set; }

	internal ShadowsMidtonesHighlights ShadowsMidtonesHighlights { get; private set; }

	internal SplitToning SplitToning { get; private set; }

	internal Tonemapping Tonemapping { get; private set; }

	internal WhiteBalance WhiteBalance { get; private set; }

	internal CharColorControl CharColorControl { get; private set; }

	internal GenericColorControl GenericColorControl { get; private set; }

	internal DepthOfField DepthOfField { get; private set; }

	internal TemporalDepthOfField TemporalDepthOfField { get; private set; }

	internal PaniniProjection PaniniProjection { get; private set; }

	internal Vignette Vignette { get; private set; }

	internal ColorLookup ColorLookup { get; private set; }

	internal AutoExposure AutoExposure { get; private set; }

	internal Bloom Bloom { get; private set; }

	internal Atmosphere Atmosphere { get; private set; }

	internal ExpHeightFog ExpHeightFog { get; private set; }

	internal DeSaturate DeSaturate { get; private set; }

	internal PerfectDodge PerfectDodge { get; private set; }

	internal InnerWorldFilter InnerWorldFilter { get; private set; }

	internal ArtLine ArtLine { get; private set; }

	internal CameraShake CameraShake { get; private set; }

	internal BlackWhite BlackWhite { get; private set; }

	internal SceneLight SceneLight { get; private set; }

	internal T Get<T>() where T : VolumeComponent
	{
		EnsureCurrent();
		return m_Stack.GetComponent<T>();
	}

	internal void EnsureCurrent()
	{
		if (m_Stack == null)
		{
			VolumeStack stack = VolumeManager.instance.stack;
			CharColorControl component = stack.GetComponent<CharColorControl>();
			m_Stack = stack;
			m_Version++;
			ChannelMixer = stack.GetComponent<ChannelMixer>();
			ColorAdjustments = stack.GetComponent<ColorAdjustments>();
			ColorCurves = stack.GetComponent<ColorCurves>();
			LiftGammaGain = stack.GetComponent<LiftGammaGain>();
			ShadowsMidtonesHighlights = stack.GetComponent<ShadowsMidtonesHighlights>();
			SplitToning = stack.GetComponent<SplitToning>();
			Tonemapping = stack.GetComponent<Tonemapping>();
			WhiteBalance = stack.GetComponent<WhiteBalance>();
			CharColorControl = component;
			GenericColorControl = stack.GetComponent<GenericColorControl>();
			DepthOfField = stack.GetComponent<DepthOfField>();
			TemporalDepthOfField = stack.GetComponent<TemporalDepthOfField>();
			PaniniProjection = stack.GetComponent<PaniniProjection>();
			Vignette = stack.GetComponent<Vignette>();
			ColorLookup = stack.GetComponent<ColorLookup>();
			AutoExposure = stack.GetComponent<AutoExposure>();
			Bloom = stack.GetComponent<Bloom>();
			Atmosphere = stack.GetComponent<Atmosphere>();
			ExpHeightFog = stack.GetComponent<ExpHeightFog>();
			DeSaturate = stack.GetComponent<DeSaturate>();
			PerfectDodge = stack.GetComponent<PerfectDodge>();
			InnerWorldFilter = stack.GetComponent<InnerWorldFilter>();
			ArtLine = stack.GetComponent<ArtLine>();
			CameraShake = stack.GetComponent<CameraShake>();
			BlackWhite = stack.GetComponent<BlackWhite>();
			SceneLight = stack.GetComponent<SceneLight>();
		}
	}
}
