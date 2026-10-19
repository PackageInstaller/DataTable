using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Sound;
using Newtonsoft.Json.Linq;
using UnityEngine;

namespace ACT.EventTrack;

public class SettingInfo : TrackBaseEvt<SettingInfo>
{
	private float volume;

	private float music_volume;

	private float sfx_volume;

	private float voice_volume;

	private bool main_volume_mute;

	private bool music_volume_mute;

	private bool sfx_volume_mute;

	private bool voice_volume_mute;

	private int graphics_quality;

	private int render_resolution;

	private int fps;

	private int anti_aliasing;

	private int bloom;

	private int distortion;

	private int pipeline_optimize;

	private int shadow_quality;

	private int mobile_fov;

	private int v_sync;

	private int v_temporalUpscalerQuality;

	private int v_screenSpaceOcclusion;

	private int v_screenSpaceReflection;

	private bool v_showFrameRate;

	private int v_resolution;

	private int v_windowStyle;

	private int v_textureQuality;

	private int operation_plan;

	private int joystick_mode;

	private int screen_shake;

	private bool display_detail;

	private float ui_border;

	private int language_voice;

	private int language_text;

	private SettingFloat mainVolume;

	private SettingFloat musicVolume;

	private SettingFloat effectVolume;

	private SettingFloat talkVolume;

	private SettingBool mainVolumeMute;

	private SettingBool musicVolumeMute;

	private SettingBool effectVolumeMute;

	private SettingBool talkVolumeMute;

	private SettingOptions graphicQuality;

	private SettingOptions renderScale;

	private SettingOptions frameRate;

	private SettingOptions antiAliasing;

	private SettingOptions grahicBloom;

	private SettingOptions graphicDistortion;

	private SettingOptions pipelineOptimize;

	private SettingOptions shadowQuality;

	private SettingOptions mobileFOV;

	private SettingOptions vsync;

	private SettingOptions temporalUpscalerQuality;

	private SettingOptions graphicScreenSpaceOcclusion;

	private SettingOptions graphicScreenSpaceReflection;

	private SettingBool showFrameRate;

	private SettingOptions resolution;

	private SettingOptions windowStyle;

	private SettingOptions textureQuality;

	private SettingInt cameraNoise;

	private SettingOptions joystickMode;

	private SettingInt btnScheme;

	private SettingBool showDetail;

	private SettingFloat uiBorder;

	private SettingOptions languageVoice;

	private SettingOptions languageText;

	private static readonly AudioLanguageType[] VoiceLanguageTypes = (AudioLanguageType[])Enum.GetValues(typeof(AudioLanguageType));

	public override bool SkipIfWorldNotStart => false;

	public void RecordBefore()
	{
		mainVolume = SettingsManager.Instance.RuntimeSettings.GetSettingFloat("Audio.Volume.Main");
		musicVolume = SettingsManager.Instance.RuntimeSettings.GetSettingFloat("Audio.Volume.Music");
		effectVolume = SettingsManager.Instance.RuntimeSettings.GetSettingFloat("Audio.Volume.Effect");
		talkVolume = SettingsManager.Instance.RuntimeSettings.GetSettingFloat("Audio.Volume.Talk");
		mainVolumeMute = SettingsManager.Instance.RuntimeSettings.GetSettingBool("Audio.Mute.Main");
		musicVolumeMute = SettingsManager.Instance.RuntimeSettings.GetSettingBool("Audio.Mute.Effect");
		effectVolumeMute = SettingsManager.Instance.RuntimeSettings.GetSettingBool("Audio.Mute.Music");
		talkVolumeMute = SettingsManager.Instance.RuntimeSettings.GetSettingBool("Audio.Mute.Talk");
		graphicQuality = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.Quality");
		renderScale = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.RenderScale");
		frameRate = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.FrameRate");
		antiAliasing = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.AntiAlias");
		grahicBloom = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.Bloom");
		graphicDistortion = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.Distortion");
		pipelineOptimize = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.PipelineOptimize");
		shadowQuality = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.ShadowQuality");
		mobileFOV = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.MobileFOV");
		temporalUpscalerQuality = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.TemporalUpscalerQuality");
		vsync = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.VSync");
		showFrameRate = SettingsManager.Instance.RuntimeSettings.GetSettingBool("Other.ShowFrameRate");
		resolution = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.Resolution");
		windowStyle = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.WindowStyle");
		textureQuality = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.TextureQuality");
		graphicScreenSpaceOcclusion = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.ScreenSpaceOcclusion");
		graphicScreenSpaceReflection = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.ScreenSpaceReflection");
		cameraNoise = SettingsManager.Instance.RuntimeSettings.GetSettingInt("Other.CameraNoise");
		btnScheme = SettingsManager.Instance.RuntimeSettings.GetSettingInt("Other.BtnScheme");
		joystickMode = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Other.JoystickMode");
		showDetail = SettingsManager.Instance.RuntimeSettings.GetSettingBool("Other.ShowDetail");
		uiBorder = SettingsManager.Instance.RuntimeSettings.GetSettingFloat("Other.UIBorder");
		languageVoice = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Language.Voice");
		languageText = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Language.Text");
		if (mainVolume != null)
		{
			volume = mainVolume.GetValue();
		}
		if (musicVolume != null)
		{
			music_volume = musicVolume.GetValue();
		}
		if (effectVolume != null)
		{
			sfx_volume = effectVolume.GetValue();
		}
		if (talkVolume != null)
		{
			voice_volume = talkVolume.GetValue();
		}
		if (mainVolumeMute != null)
		{
			main_volume_mute = mainVolumeMute.GetValue();
		}
		if (musicVolumeMute != null)
		{
			music_volume_mute = musicVolumeMute.GetValue();
		}
		if (effectVolumeMute != null)
		{
			sfx_volume_mute = effectVolumeMute.GetValue();
		}
		if (talkVolumeMute != null)
		{
			voice_volume_mute = talkVolumeMute.GetValue();
		}
		if (graphicQuality != null)
		{
			graphics_quality = graphicQuality.GetValue();
		}
		if (renderScale != null)
		{
			render_resolution = renderScale.GetValue();
		}
		if (frameRate != null)
		{
			fps = frameRate.GetValue();
		}
		if (antiAliasing != null)
		{
			anti_aliasing = antiAliasing.GetValue();
		}
		if (grahicBloom != null)
		{
			bloom = grahicBloom.GetValue();
		}
		if (graphicDistortion != null)
		{
			distortion = graphicDistortion.GetValue();
		}
		if (pipelineOptimize != null)
		{
			pipeline_optimize = pipelineOptimize.GetValue();
		}
		if (shadowQuality != null)
		{
			shadow_quality = shadowQuality.GetValue();
		}
		if (mobileFOV != null)
		{
			mobile_fov = mobileFOV.GetValue();
		}
		if (vsync != null)
		{
			v_sync = vsync.GetValue();
		}
		if (temporalUpscalerQuality != null)
		{
			v_temporalUpscalerQuality = temporalUpscalerQuality.GetValue();
		}
		if (graphicScreenSpaceOcclusion != null)
		{
			v_screenSpaceOcclusion = graphicScreenSpaceOcclusion.GetValue();
		}
		if (graphicScreenSpaceReflection != null)
		{
			v_screenSpaceReflection = graphicScreenSpaceReflection.GetValue();
		}
		if (showFrameRate != null)
		{
			v_showFrameRate = showFrameRate.GetValue();
		}
		if (resolution != null)
		{
			v_resolution = resolution.GetValue();
		}
		if (windowStyle != null)
		{
			v_windowStyle = windowStyle.GetValue();
		}
		if (textureQuality != null)
		{
			v_textureQuality = textureQuality.GetValue();
		}
		if (btnScheme != null)
		{
			operation_plan = btnScheme.GetValue();
		}
		if (joystickMode != null)
		{
			joystick_mode = joystickMode.GetValue();
		}
		if (cameraNoise != null)
		{
			screen_shake = cameraNoise.GetValue();
		}
		if (showDetail != null)
		{
			display_detail = showDetail.GetValue();
		}
		if (uiBorder != null)
		{
			ui_border = uiBorder.GetValue();
		}
		if (languageVoice != null)
		{
			language_voice = GetVoiceLanguageId(languageVoice.GetValue());
		}
		if (languageText != null)
		{
			language_text = GetTextLanguageId(languageText.GetValue());
		}
	}

	private static int GetVoiceLanguageId(int optionIndex)
	{
		Dictionary<int, VoiceLanguageData> dictionary = RuntimeConfigs.data?.voiceLanguageDatas;
		if (dictionary != null && optionIndex >= 0)
		{
			int num = 0;
			AudioLanguageType[] voiceLanguageTypes = VoiceLanguageTypes;
			for (int i = 0; i < voiceLanguageTypes.Length; i++)
			{
				int num2 = (int)voiceLanguageTypes[i];
				if (dictionary.TryGetValue(num2, out var value) && num++ == optionIndex)
				{
					return value?.id ?? num2;
				}
			}
		}
		if (optionIndex >= 0 && optionIndex < VoiceLanguageTypes.Length)
		{
			return (int)VoiceLanguageTypes[optionIndex];
		}
		return optionIndex;
	}

	private static int GetTextLanguageId(int optionIndex)
	{
		Dictionary<int, TextLanguageData> dictionary = RuntimeConfigs.data?.textLanguageDatas;
		if (dictionary == null || optionIndex < 0 || optionIndex >= dictionary.Count)
		{
			return optionIndex;
		}
		List<int> list = new List<int>(dictionary.Keys);
		list.Sort();
		int num = list[optionIndex];
		if (!dictionary.TryGetValue(num, out var value) || value == null)
		{
			return num;
		}
		return value.id;
	}

	private void RecordChanges(JArray array, string key, float value, float oldValue)
	{
		if (!Mathf.Approximately(oldValue, value))
		{
			JObject item = new JObject
			{
				["setting_name"] = key,
				["setting_before"] = oldValue,
				["setting_after"] = value
			};
			array.Add(item);
		}
	}

	private void RecordChanges(JArray array, string key, int value, int oldValue)
	{
		if (oldValue != value)
		{
			JObject item = new JObject
			{
				["setting_name"] = key,
				["setting_before"] = oldValue,
				["setting_after"] = value
			};
			array.Add(item);
		}
	}

	private void RecordChanges(JArray array, string key, bool value, bool oldValue)
	{
		if (oldValue != value)
		{
			JObject item = new JObject
			{
				["setting_name"] = key,
				["setting_before"] = (oldValue ? 1 : 0),
				["setting_after"] = (value ? 1 : 0)
			};
			array.Add(item);
		}
	}

	private static bool TryGetSettingValue(SettingFloat setting, out float value)
	{
		if (setting != null)
		{
			value = setting.GetValue();
			return true;
		}
		value = 0f;
		return false;
	}

	private static bool TryGetSettingValue(SettingInt setting, out int value)
	{
		if (setting != null)
		{
			value = setting.GetValue();
			return true;
		}
		value = 0;
		return false;
	}

	private static bool TryGetSettingValue(SettingOptions setting, out int value)
	{
		if (setting != null)
		{
			value = setting.GetValue();
			return true;
		}
		value = 0;
		return false;
	}

	private static bool TryGetSettingValue(SettingBool setting, out bool value)
	{
		if (setting != null)
		{
			value = setting.GetValue();
			return true;
		}
		value = false;
		return false;
	}

	public override void OnDispatch()
	{
		base.OnDispatch();
		JArray jArray = new JArray();
		JObject jObject = new JObject
		{
			["setting_page"] = "audio",
			["setting_info"] = jArray
		};
		if (TryGetSettingValue(mainVolume, out var value))
		{
			RecordChanges(jArray, "volume", value, volume);
		}
		if (TryGetSettingValue(musicVolume, out var value2))
		{
			RecordChanges(jArray, "music_volume", value2, music_volume);
		}
		if (TryGetSettingValue(effectVolume, out var value3))
		{
			RecordChanges(jArray, "sfx_volume", value3, sfx_volume);
		}
		if (TryGetSettingValue(talkVolume, out var value4))
		{
			RecordChanges(jArray, "voice_volume", value4, voice_volume);
		}
		if (TryGetSettingValue(mainVolumeMute, out var value5))
		{
			RecordChanges(jArray, "main_volume_mute", value5, main_volume_mute);
		}
		if (TryGetSettingValue(musicVolumeMute, out var value6))
		{
			RecordChanges(jArray, "music_volume_mute", value6, music_volume_mute);
		}
		if (TryGetSettingValue(effectVolumeMute, out var value7))
		{
			RecordChanges(jArray, "sfx_volume_mute", value7, sfx_volume_mute);
		}
		if (TryGetSettingValue(talkVolumeMute, out var value8))
		{
			RecordChanges(jArray, "voice_volume_mute", value8, voice_volume_mute);
		}
		JArray jArray2 = new JArray();
		JObject jObject2 = new JObject
		{
			["setting_page"] = "image",
			["setting_info"] = jArray2
		};
		if (TryGetSettingValue(graphicQuality, out var value9))
		{
			RecordChanges(jArray2, "graphics_quality", value9, graphics_quality);
		}
		if (TryGetSettingValue(renderScale, out var value10))
		{
			RecordChanges(jArray2, "render_resolution", value10, render_resolution);
		}
		if (TryGetSettingValue(vsync, out var value11))
		{
			RecordChanges(jArray2, "vsync", value11, v_sync);
		}
		if (TryGetSettingValue(frameRate, out var value12))
		{
			RecordChanges(jArray2, "fps", value12, fps);
		}
		if (TryGetSettingValue(antiAliasing, out var value13))
		{
			RecordChanges(jArray2, "anti_aliasing", value13, anti_aliasing);
		}
		if (TryGetSettingValue(grahicBloom, out var value14))
		{
			RecordChanges(jArray2, "bloom", value14, bloom);
		}
		if (TryGetSettingValue(graphicDistortion, out var value15))
		{
			RecordChanges(jArray2, "distortion", value15, distortion);
		}
		if (TryGetSettingValue(pipelineOptimize, out var value16))
		{
			RecordChanges(jArray2, "pipeline_optimize", value16, pipeline_optimize);
		}
		if (TryGetSettingValue(shadowQuality, out var value17))
		{
			RecordChanges(jArray2, "shadow_quality", value17, shadow_quality);
		}
		if (TryGetSettingValue(mobileFOV, out var value18))
		{
			RecordChanges(jArray2, "mobile_fov", value18, mobile_fov);
		}
		if (TryGetSettingValue(temporalUpscalerQuality, out var value19))
		{
			RecordChanges(jArray2, "temporal_upscaler_quality", value19, v_temporalUpscalerQuality);
		}
		if (TryGetSettingValue(graphicScreenSpaceOcclusion, out var value20))
		{
			RecordChanges(jArray2, "screen_space_occlusion", value20, v_screenSpaceOcclusion);
		}
		if (TryGetSettingValue(graphicScreenSpaceReflection, out var value21))
		{
			RecordChanges(jArray2, "screen_space_reflection", value21, v_screenSpaceReflection);
		}
		if (TryGetSettingValue(showFrameRate, out var value22))
		{
			RecordChanges(jArray2, "show_framerate", value22, v_showFrameRate);
		}
		if (resolution?.GetConnection() is ResolutionConnectionSO.Connection connection && TryGetSettingValue(resolution, out var value23))
		{
			Vector2Int resolutionValue = connection.GetResolutionValue(v_resolution);
			Vector2Int resolutionValue2 = connection.GetResolutionValue(value23);
			RecordChanges(jArray2, "image_resolution_x", resolutionValue2.x, resolutionValue.x);
			RecordChanges(jArray2, "image_resolution_y", resolutionValue2.y, resolutionValue.y);
		}
		if (TryGetSettingValue(windowStyle, out var value24))
		{
			RecordChanges(jArray2, "image_mode", value24, v_windowStyle);
		}
		if (TryGetSettingValue(textureQuality, out var value25))
		{
			RecordChanges(jArray2, "texture_quality", value25, v_textureQuality);
		}
		JArray jArray3 = new JArray();
		JObject jObject3 = new JObject
		{
			["setting_page"] = "operation",
			["setting_info"] = jArray3
		};
		if (TryGetSettingValue(btnScheme, out var value26))
		{
			RecordChanges(jArray3, "operation_plan", value26, operation_plan);
		}
		if (TryGetSettingValue(uiBorder, out var value27))
		{
			RecordChanges(jArray3, "ui_border", value27, ui_border);
		}
		if (TryGetSettingValue(cameraNoise, out var value28))
		{
			RecordChanges(jArray3, "screen_shake", value28, screen_shake);
		}
		if (TryGetSettingValue(joystickMode, out var value29))
		{
			RecordChanges(jArray3, "joystick_mode", value29, joystick_mode);
		}
		JArray jArray4 = new JArray();
		JObject jObject4 = new JObject
		{
			["setting_page"] = "language",
			["setting_info"] = jArray4
		};
		if (TryGetSettingValue(languageVoice, out var value30))
		{
			RecordChanges(jArray4, "language_voice", GetVoiceLanguageId(value30), language_voice);
		}
		if (TryGetSettingValue(languageText, out var value31))
		{
			RecordChanges(jArray4, "language_text", GetTextLanguageId(value31), language_text);
		}
		if (jArray.Count > 0)
		{
			send(jObject);
		}
		if (jArray2.Count > 0)
		{
			send(jObject2);
		}
		if (jArray3.Count > 0)
		{
			send(jObject3);
		}
		if (jArray4.Count > 0)
		{
			send(jObject4);
		}
		if (jArray.Count < 1 && jArray2.Count < 1 && jArray3.Count < 1 && jArray4.Count < 1 && display_detail != showDetail.GetValue())
		{
			JObject jObject5 = new JObject { ["display_detail"] = display_detail };
			send(jObject5);
		}
		void send(JObject jObject6)
		{
			jObject6["display_detail"] = display_detail;
			jObject6["setting_load"] = SettingsManager.Instance.RuntimeSettings.EvaluatePerformance();
			jObject6["is_default"] = false;
			jObject6["start_timestamp"] = LuminApplication.RuntimeInfo.SessionStartUnixSeconds;
			Send("setting_info", jObject6);
		}
	}
}
