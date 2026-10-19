using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering.Universal.Internal;

public class ColorGradingLutPass : ScriptableRenderPass
{
	private struct CurveState
	{
		public TextureCurve curve;

		public static CurveState From(TextureCurve curve)
		{
			return new CurveState
			{
				curve = curve
			};
		}

		public bool Equals(CurveState other)
		{
			return curve == other.curve;
		}
	}

	private struct ColorControlState
	{
		public Vector4 lift;

		public Vector4 gamma;

		public Vector4 gain;

		public Vector4 shadows;

		public Vector4 midtones;

		public Vector4 highlights;

		public Vector4 adjustments;

		public static ColorControlState From(CharColorControl colorControl)
		{
			return new ColorControlState
			{
				lift = colorControl.lift.value,
				gamma = colorControl.gamma.value,
				gain = colorControl.gain.value,
				shadows = colorControl.shadows.value,
				midtones = colorControl.midtones.value,
				highlights = colorControl.highlights.value,
				adjustments = new Vector4(colorControl.postExposure.value, colorControl.contrast.value, colorControl.hueShift.value, colorControl.saturation.value)
			};
		}

		public bool Equals(ColorControlState other)
		{
			if (lift == other.lift && gamma == other.gamma && gain == other.gain && shadows == other.shadows && midtones == other.midtones && highlights == other.highlights)
			{
				return adjustments == other.adjustments;
			}
			return false;
		}
	}

	private struct ColorGradingLutState
	{
		public Vector4 whiteBalance;

		public Vector4 colorAdjustments;

		public Color colorFilter;

		public Vector4 channelMixerRed;

		public Vector4 channelMixerGreen;

		public Vector4 channelMixerBlue;

		public Vector4 shadowsMidtonesHighlightsShadows;

		public Vector4 shadowsMidtonesHighlightsMidtones;

		public Vector4 shadowsMidtonesHighlightsHighlights;

		public Vector4 shadowsHighlightsLimits;

		public Vector4 lift;

		public Vector4 gamma;

		public Vector4 gain;

		public Color splitToningShadows;

		public Color splitToningHighlights;

		public float splitToningBalance;

		public int tonemappingMode;

		public float acesType;

		public CurveState masterCurve;

		public CurveState redCurve;

		public CurveState greenCurve;

		public CurveState blueCurve;

		public CurveState hueVsHueCurve;

		public CurveState hueVsSatCurve;

		public CurveState lumVsSatCurve;

		public CurveState satVsSatCurve;

		public Texture userLut;

		public float userLutContribution;

		public ColorControlState charColorControl;

		public bool Equals(ColorGradingLutState other)
		{
			if (whiteBalance == other.whiteBalance && colorAdjustments == other.colorAdjustments && colorFilter == other.colorFilter && channelMixerRed == other.channelMixerRed && channelMixerGreen == other.channelMixerGreen && channelMixerBlue == other.channelMixerBlue && shadowsMidtonesHighlightsShadows == other.shadowsMidtonesHighlightsShadows && shadowsMidtonesHighlightsMidtones == other.shadowsMidtonesHighlightsMidtones && shadowsMidtonesHighlightsHighlights == other.shadowsMidtonesHighlightsHighlights && shadowsHighlightsLimits == other.shadowsHighlightsLimits && lift == other.lift && gamma == other.gamma && gain == other.gain && splitToningShadows == other.splitToningShadows && splitToningHighlights == other.splitToningHighlights && splitToningBalance == other.splitToningBalance && tonemappingMode == other.tonemappingMode && acesType == other.acesType && masterCurve.Equals(other.masterCurve) && redCurve.Equals(other.redCurve) && greenCurve.Equals(other.greenCurve) && blueCurve.Equals(other.blueCurve) && hueVsHueCurve.Equals(other.hueVsHueCurve) && hueVsSatCurve.Equals(other.hueVsSatCurve) && lumVsSatCurve.Equals(other.lumVsSatCurve) && satVsSatCurve.Equals(other.satVsSatCurve) && (object)userLut == other.userLut && userLutContribution == other.userLutContribution)
			{
				return charColorControl.Equals(other.charColorControl);
			}
			return false;
		}
	}

	private static class ShaderConstants
	{
		public static readonly int _Lut_Params = Shader.PropertyToID("_Lut_Params");

		public static readonly int _ColorBalance = Shader.PropertyToID("_ColorBalance");

		public static readonly int _ColorFilter = Shader.PropertyToID("_ColorFilter");

		public static readonly int _ChannelMixerRed = Shader.PropertyToID("_ChannelMixerRed");

		public static readonly int _ChannelMixerGreen = Shader.PropertyToID("_ChannelMixerGreen");

		public static readonly int _ChannelMixerBlue = Shader.PropertyToID("_ChannelMixerBlue");

		public static readonly int _HueSatCon = Shader.PropertyToID("_HueSatCon");

		public static readonly int _Lift = Shader.PropertyToID("_Lift");

		public static readonly int _Gamma = Shader.PropertyToID("_Gamma");

		public static readonly int _Gain = Shader.PropertyToID("_Gain");

		public static readonly int _Shadows = Shader.PropertyToID("_Shadows");

		public static readonly int _Midtones = Shader.PropertyToID("_Midtones");

		public static readonly int _Highlights = Shader.PropertyToID("_Highlights");

		public static readonly int _ShaHiLimits = Shader.PropertyToID("_ShaHiLimits");

		public static readonly int _SplitShadows = Shader.PropertyToID("_SplitShadows");

		public static readonly int _SplitHighlights = Shader.PropertyToID("_SplitHighlights");

		public static readonly int _CurveMaster = Shader.PropertyToID("_CurveMaster");

		public static readonly int _CurveRed = Shader.PropertyToID("_CurveRed");

		public static readonly int _CurveGreen = Shader.PropertyToID("_CurveGreen");

		public static readonly int _CurveBlue = Shader.PropertyToID("_CurveBlue");

		public static readonly int _CurveHueVsHue = Shader.PropertyToID("_CurveHueVsHue");

		public static readonly int _CurveHueVsSat = Shader.PropertyToID("_CurveHueVsSat");

		public static readonly int _CurveLumVsSat = Shader.PropertyToID("_CurveLumVsSat");

		public static readonly int _CurveSatVsSat = Shader.PropertyToID("_CurveSatVsSat");

		public static readonly int _UserLut = Shader.PropertyToID("_UserLut");

		public static readonly int _UserLut_Params = Shader.PropertyToID("_UserLut_Params");

		public static readonly int _ACESType = Shader.PropertyToID("_ACESType");

		public static readonly int _CharPostExposure = Shader.PropertyToID("_CharPostExposure");

		public static readonly int _ACTChromaProtect = Shader.PropertyToID("_ACTChromaProtect");

		public static readonly int _InternalLut = Shader.PropertyToID("_InternalLut");
	}

	private readonly Material m_LutBuilderHdr;

	private readonly GraphicsFormat m_HdrLutFormat;

	private readonly VolumeComponentCache m_VolumeComponents;

	private RenderTargetHandle m_InternalLut;

	private RenderTexture m_InternalLutTexture;

	private RenderTexture m_CharColorLutTexture;

	private ColorGradingLutState m_LastState;

	private ColorGradingLutState m_PendingState;

	private bool m_HasValidLut;

	private bool m_ShouldRenderLut;

	private int CharColorControlTag;

	internal ColorGradingLutPass(RenderPassEvent evt, PostProcessData data, VolumeComponentCache volumeComponents)
	{
		m_VolumeComponents = volumeComponents;
		profilingSampler = new ProfilingSampler("ColorGradingLutPass");
		renderPassEvent = evt;
		overrideCameraTarget = true;
		m_LutBuilderHdr = Load(data.shaders.lutBuilderHdrPS);
		m_HdrLutFormat = GraphicsFormat.R16G16B16A16_SFloat;
		targetCount = 0u;
		CharColorControlTag = Shader.PropertyToID("_CharColorLUT");
		Material Load(Shader shader)
		{
			if (shader == null)
			{
				Debug.LogError("Missing shader. " + GetType().DeclaringType.Name + " render pass will not execute. Check for missing reference in the renderer resources.");
				return null;
			}
			return CoreUtils.CreateEngineMaterial(shader);
		}
	}

	public bool Setup(in RenderTargetHandle internalLut, ref RenderingData renderingData)
	{
		m_InternalLut = internalLut;
		int lutSize = renderingData.postProcessingData.lutSize;
		int width = lutSize * lutSize;
		EnsureLutTextures(width, lutSize, m_HdrLutFormat);
		m_PendingState = CaptureCurrentState();
		m_ShouldRenderLut = !m_HasValidLut || !m_LastState.Equals(m_PendingState);
		BindCachedLuts(renderingData.cmd);
		return m_ShouldRenderLut;
	}

	private void EnsureLutTextures(int width, int height, GraphicsFormat format)
	{
		if (!(m_InternalLutTexture != null) || !m_InternalLutTexture.IsCreated())
		{
			ReleaseCachedLuts();
			RenderTextureDescriptor desc = new RenderTextureDescriptor(width, height, format, 0);
			desc.vrUsage = VRTextureUsage.None;
			m_InternalLutTexture = CreateCachedLut(desc, "_InternalGradingLut");
			m_CharColorLutTexture = CreateCachedLut(desc, "_CharColorLUT");
			m_HasValidLut = false;
		}
	}

	private static RenderTexture CreateCachedLut(RenderTextureDescriptor desc, string name)
	{
		RenderTexture renderTexture = new RenderTexture(desc);
		renderTexture.name = name;
		renderTexture.hideFlags = HideFlags.HideAndDontSave;
		renderTexture.filterMode = FilterMode.Bilinear;
		renderTexture.wrapMode = TextureWrapMode.Clamp;
		renderTexture.anisoLevel = 0;
		renderTexture.Create();
		return renderTexture;
	}

	private void BindCachedLuts(CommandBuffer cmd)
	{
		cmd.SetGlobalTexture(m_InternalLut.id, m_InternalLutTexture);
		cmd.SetGlobalTexture(ShaderConstants._InternalLut, m_InternalLutTexture);
		cmd.SetGlobalTexture(CharColorControlTag, m_CharColorLutTexture);
	}

	private void ReleaseCachedLuts()
	{
		CoreUtils.Destroy(m_InternalLutTexture);
		CoreUtils.Destroy(m_CharColorLutTexture);
		m_InternalLutTexture = null;
		m_CharColorLutTexture = null;
		m_HasValidLut = false;
		m_ShouldRenderLut = false;
	}

	internal void ReleasePersistentRenderResources()
	{
		ReleaseCachedLuts();
	}

	private ColorGradingLutState CaptureCurrentState()
	{
		ColorLookup colorLookup = m_VolumeComponents.ColorLookup;
		bool flag = colorLookup.IsActive();
		Texture userLut = (flag ? colorLookup.texture.value : null);
		return new ColorGradingLutState
		{
			whiteBalance = new Vector4(m_VolumeComponents.WhiteBalance.temperature.value, m_VolumeComponents.WhiteBalance.tint.value, 0f, 0f),
			colorAdjustments = new Vector4(m_VolumeComponents.ColorAdjustments.contrast.value, m_VolumeComponents.ColorAdjustments.hueShift.value, m_VolumeComponents.ColorAdjustments.saturation.value, 0f),
			colorFilter = m_VolumeComponents.ColorAdjustments.colorFilter.value,
			channelMixerRed = new Vector4(m_VolumeComponents.ChannelMixer.redOutRedIn.value, m_VolumeComponents.ChannelMixer.redOutGreenIn.value, m_VolumeComponents.ChannelMixer.redOutBlueIn.value, 0f),
			channelMixerGreen = new Vector4(m_VolumeComponents.ChannelMixer.greenOutRedIn.value, m_VolumeComponents.ChannelMixer.greenOutGreenIn.value, m_VolumeComponents.ChannelMixer.greenOutBlueIn.value, 0f),
			channelMixerBlue = new Vector4(m_VolumeComponents.ChannelMixer.blueOutRedIn.value, m_VolumeComponents.ChannelMixer.blueOutGreenIn.value, m_VolumeComponents.ChannelMixer.blueOutBlueIn.value, 0f),
			shadowsMidtonesHighlightsShadows = m_VolumeComponents.ShadowsMidtonesHighlights.shadows.value,
			shadowsMidtonesHighlightsMidtones = m_VolumeComponents.ShadowsMidtonesHighlights.midtones.value,
			shadowsMidtonesHighlightsHighlights = m_VolumeComponents.ShadowsMidtonesHighlights.highlights.value,
			shadowsHighlightsLimits = new Vector4(m_VolumeComponents.ShadowsMidtonesHighlights.shadowsStart.value, m_VolumeComponents.ShadowsMidtonesHighlights.shadowsEnd.value, m_VolumeComponents.ShadowsMidtonesHighlights.highlightsStart.value, m_VolumeComponents.ShadowsMidtonesHighlights.highlightsEnd.value),
			lift = m_VolumeComponents.LiftGammaGain.lift.value,
			gamma = m_VolumeComponents.LiftGammaGain.gamma.value,
			gain = m_VolumeComponents.LiftGammaGain.gain.value,
			splitToningShadows = m_VolumeComponents.SplitToning.shadows.value,
			splitToningHighlights = m_VolumeComponents.SplitToning.highlights.value,
			splitToningBalance = m_VolumeComponents.SplitToning.balance.value,
			tonemappingMode = (int)m_VolumeComponents.Tonemapping.mode.value,
			acesType = m_VolumeComponents.Tonemapping.ACESType.value,
			masterCurve = CurveState.From(m_VolumeComponents.ColorCurves.master.value),
			redCurve = CurveState.From(m_VolumeComponents.ColorCurves.red.value),
			greenCurve = CurveState.From(m_VolumeComponents.ColorCurves.green.value),
			blueCurve = CurveState.From(m_VolumeComponents.ColorCurves.blue.value),
			hueVsHueCurve = CurveState.From(m_VolumeComponents.ColorCurves.hueVsHue.value),
			hueVsSatCurve = CurveState.From(m_VolumeComponents.ColorCurves.hueVsSat.value),
			lumVsSatCurve = CurveState.From(m_VolumeComponents.ColorCurves.lumVsSat.value),
			satVsSatCurve = CurveState.From(m_VolumeComponents.ColorCurves.satVsSat.value),
			userLut = userLut,
			userLutContribution = (flag ? colorLookup.contribution.value : 0f),
			charColorControl = ColorControlState.From(m_VolumeComponents.CharColorControl)
		};
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		if (!m_ShouldRenderLut)
		{
			return;
		}
		CommandBuffer cmd = renderingData.cmd;
		using (new ProfilingScope(cmd, ProfilingSampler.Get(URPProfileId.ColorGradingLUT)))
		{
			ChannelMixer channelMixer = m_VolumeComponents.ChannelMixer;
			ColorAdjustments colorAdjustments = m_VolumeComponents.ColorAdjustments;
			ColorCurves colorCurves = m_VolumeComponents.ColorCurves;
			LiftGammaGain liftGammaGain = m_VolumeComponents.LiftGammaGain;
			ShadowsMidtonesHighlights shadowsMidtonesHighlights = m_VolumeComponents.ShadowsMidtonesHighlights;
			SplitToning splitToning = m_VolumeComponents.SplitToning;
			Tonemapping tonemapping = m_VolumeComponents.Tonemapping;
			WhiteBalance whiteBalance = m_VolumeComponents.WhiteBalance;
			CharColorControl charColorControl = m_VolumeComponents.CharColorControl;
			int lutSize = renderingData.postProcessingData.lutSize;
			int num = lutSize * lutSize;
			Material lutBuilderHdr = m_LutBuilderHdr;
			Vector3 vector = ColorUtils.ColorBalanceToLMSCoeffs(whiteBalance.temperature.value, whiteBalance.tint.value);
			Vector4 value = new Vector4(colorAdjustments.hueShift.value / 360f, colorAdjustments.saturation.value / 100f + 1f, colorAdjustments.contrast.value / 100f + 1f, 0f);
			Vector4 value2 = new Vector4(channelMixer.redOutRedIn.value / 100f, channelMixer.redOutGreenIn.value / 100f, channelMixer.redOutBlueIn.value / 100f, 0f);
			Vector4 value3 = new Vector4(channelMixer.greenOutRedIn.value / 100f, channelMixer.greenOutGreenIn.value / 100f, channelMixer.greenOutBlueIn.value / 100f, 0f);
			Vector4 value4 = new Vector4(channelMixer.blueOutRedIn.value / 100f, channelMixer.blueOutGreenIn.value / 100f, channelMixer.blueOutBlueIn.value / 100f, 0f);
			Vector4 value5 = new Vector4(shadowsMidtonesHighlights.shadowsStart.value, shadowsMidtonesHighlights.shadowsEnd.value, shadowsMidtonesHighlights.highlightsStart.value, shadowsMidtonesHighlights.highlightsEnd.value);
			Vector4 value6;
			Vector4 value7;
			Vector4 value8;
			(value6, value7, value8) = ColorUtils.PrepareShadowsMidtonesHighlights(shadowsMidtonesHighlights.shadows.value, shadowsMidtonesHighlights.midtones.value, shadowsMidtonesHighlights.highlights.value);
			Vector4 value9;
			Vector4 value10;
			Vector4 value11;
			(value9, value10, value11) = ColorUtils.PrepareLiftGammaGain(liftGammaGain.lift.value, liftGammaGain.gamma.value, liftGammaGain.gain.value);
			var (value12, value13) = ColorUtils.PrepareSplitToning((Vector4)splitToning.shadows.value, (Vector4)splitToning.highlights.value, splitToning.balance.value);
			lutBuilderHdr.SetVector(value: new Vector4(lutSize, 0.5f / (float)num, 0.5f / (float)lutSize, (float)lutSize / ((float)lutSize - 1f)), nameID: ShaderConstants._Lut_Params);
			lutBuilderHdr.SetVector(ShaderConstants._ColorBalance, vector);
			cmd.SetGlobalVector(ShaderConstants._ColorFilter, colorAdjustments.colorFilter.value.linear);
			lutBuilderHdr.SetVector(ShaderConstants._ChannelMixerRed, value2);
			lutBuilderHdr.SetVector(ShaderConstants._ChannelMixerGreen, value3);
			lutBuilderHdr.SetVector(ShaderConstants._ChannelMixerBlue, value4);
			cmd.SetGlobalVector(ShaderConstants._HueSatCon, value);
			cmd.SetGlobalVector(ShaderConstants._Lift, value9);
			cmd.SetGlobalVector(ShaderConstants._Gamma, value10);
			cmd.SetGlobalVector(ShaderConstants._Gain, value11);
			cmd.SetGlobalVector(ShaderConstants._Shadows, value6);
			cmd.SetGlobalVector(ShaderConstants._Midtones, value7);
			cmd.SetGlobalVector(ShaderConstants._Highlights, value8);
			lutBuilderHdr.SetVector(ShaderConstants._ShaHiLimits, value5);
			lutBuilderHdr.SetVector(ShaderConstants._SplitShadows, value12);
			lutBuilderHdr.SetVector(ShaderConstants._SplitHighlights, value13);
			lutBuilderHdr.SetTexture(ShaderConstants._CurveMaster, colorCurves.master.value.GetTexture());
			lutBuilderHdr.SetTexture(ShaderConstants._CurveRed, colorCurves.red.value.GetTexture());
			lutBuilderHdr.SetTexture(ShaderConstants._CurveGreen, colorCurves.green.value.GetTexture());
			lutBuilderHdr.SetTexture(ShaderConstants._CurveBlue, colorCurves.blue.value.GetTexture());
			lutBuilderHdr.SetTexture(ShaderConstants._CurveHueVsHue, colorCurves.hueVsHue.value.GetTexture());
			lutBuilderHdr.SetTexture(ShaderConstants._CurveHueVsSat, colorCurves.hueVsSat.value.GetTexture());
			lutBuilderHdr.SetTexture(ShaderConstants._CurveLumVsSat, colorCurves.lumVsSat.value.GetTexture());
			lutBuilderHdr.SetTexture(ShaderConstants._CurveSatVsSat, colorCurves.satVsSat.value.GetTexture());
			Texture userLut = m_PendingState.userLut;
			if (userLut != null)
			{
				lutBuilderHdr.SetTexture(ShaderConstants._UserLut, userLut);
				lutBuilderHdr.SetVector(ShaderConstants._UserLut_Params, new Vector4(1f / (float)userLut.width, 1f / (float)userLut.height, (float)userLut.height - 1f, m_PendingState.userLutContribution));
			}
			else
			{
				lutBuilderHdr.SetVector(ShaderConstants._UserLut_Params, Vector4.zero);
			}
			lutBuilderHdr.shaderKeywords = null;
			switch (tonemapping.mode.value)
			{
			case TonemappingMode.Neutral:
				lutBuilderHdr.EnableKeyword("_TONEMAP_NEUTRAL");
				break;
			case TonemappingMode.ACES:
				lutBuilderHdr.EnableKeyword("_TONEMAP_ACES");
				cmd.SetGlobalFloat(ShaderConstants._ACESType, tonemapping.ACESType.value);
				break;
			}
			cmd.SetGlobalFloat(ShaderConstants._ACTChromaProtect, 0f);
			cmd.Blit(null, m_InternalLutTexture, lutBuilderHdr, 0);
			value = new Vector4(charColorControl.hueShift.value / 360f, charColorControl.saturation.value / 100f + 1f, charColorControl.contrast.value / 100f + 1f, 0f);
			(value6, value7, value8) = ColorUtils.PrepareShadowsMidtonesHighlights(charColorControl.shadows.value, charColorControl.midtones.value, charColorControl.highlights.value);
			(value9, value10, value11) = ColorUtils.PrepareLiftGammaGain(charColorControl.lift.value, charColorControl.gamma.value, charColorControl.gain.value);
			cmd.SetGlobalVector(ShaderConstants._HueSatCon, value);
			cmd.SetGlobalVector(ShaderConstants._Lift, value9);
			cmd.SetGlobalVector(ShaderConstants._Gamma, value10);
			cmd.SetGlobalVector(ShaderConstants._Gain, value11);
			cmd.SetGlobalVector(ShaderConstants._Shadows, value6);
			cmd.SetGlobalVector(ShaderConstants._Midtones, value7);
			cmd.SetGlobalVector(ShaderConstants._Highlights, value8);
			cmd.SetGlobalFloat(ShaderConstants._ACTChromaProtect, 1f);
			cmd.Blit(null, m_CharColorLutTexture, lutBuilderHdr, 1);
			cmd.SetGlobalVector(ShaderConstants._Lut_Params, new Vector4(1f / (float)num, 1f / (float)lutSize, (float)lutSize - 1f, 1f));
			cmd.SetGlobalFloat(ShaderConstants._CharPostExposure, Mathf.Pow(2f, charColorControl.postExposure.value));
			BindCachedLuts(cmd);
			m_LastState = m_PendingState;
			m_HasValidLut = true;
			m_ShouldRenderLut = false;
		}
	}

	public override void OnCameraCleanup(CommandBuffer cmd)
	{
	}

	public void Cleanup()
	{
		ReleaseCachedLuts();
		CoreUtils.Destroy(m_LutBuilderHdr);
	}
}
