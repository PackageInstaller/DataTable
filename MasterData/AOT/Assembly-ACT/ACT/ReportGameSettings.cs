using System;
using ACT.EventTrack;
using Newtonsoft.Json.Linq;
using UnityEngine;

namespace ACT;

internal class ReportGameSettings : WorldLoadStepOperation
{
	private class ClientImageSettingInfo : TrackBaseEvt<ClientImageSettingInfo>
	{
		public override void OnDispatch()
		{
			SettingOptions settingOptions = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.Resolution");
			SettingOptions settingOptions2 = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.WindowStyle");
			SettingOptions settingOptions3 = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.ScreenSpaceOcclusion");
			SettingOptions settingOptions4 = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.ScreenSpaceReflection");
			SettingOptions settingOptions5 = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.Quality");
			SettingOptions settingOptions6 = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.FrameRate");
			SettingOptions settingOptions7 = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.RenderScale");
			SettingOptions settingOptions8 = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.TextureQuality");
			SettingOptions settingOptions9 = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.AntiAlias");
			SettingOptions settingOptions10 = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.TemporalUpscalerQuality");
			SettingOptions settingOptions11 = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.Bloom");
			SettingOptions settingOptions12 = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.ShadowQuality");
			SettingOptions settingOptions13 = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.Distortion");
			SettingOptions settingOptions14 = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.MobileFOV");
			SettingOptions settingOptions15 = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.VSync");
			SettingOptions settingOptions16 = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.PipelineOptimize");
			JArray jArray = new JArray();
			AppendResolutionOptions(jArray, settingOptions);
			AppendReportOptions(jArray, "graphics_quality", settingOptions5);
			AppendReportOptions(jArray, "renderResolution", settingOptions7);
			AppendReportOptions(jArray, "vsync", settingOptions15);
			AppendReportOptions(jArray, "fps", settingOptions6);
			AppendReportOptions(jArray, "anti_aliasing", settingOptions9);
			AppendReportOptions(jArray, "bloom", settingOptions11);
			AppendReportOptions(jArray, "distortion", settingOptions13);
			AppendReportOptions(jArray, "pipeline_optimize", settingOptions16);
			AppendReportOptions(jArray, "shadow_quality", settingOptions12);
			AppendReportOptions(jArray, "mobile_fov", settingOptions14);
			AppendReportOptions(jArray, "screen_space_occlusion", settingOptions3);
			AppendReportOptions(jArray, "screen_space_reflection", settingOptions4);
			AppendReportOptions(jArray, "image_mode", settingOptions2);
			AppendReportOptions(jArray, "texture_quality", settingOptions8);
			AppendReportOptions(jArray, "temporal_upscaler_quality", settingOptions10);
			JObject properties = new JObject
			{
				["start_timestamp"] = LuminApplication.RuntimeInfo.SessionStartUnixSeconds,
				["setting_info"] = jArray
			};
			Send("client_image_setting_info", properties);
		}

		private void AppendReportOptions(JArray arr, string key, int value)
		{
			JObject item = new JObject
			{
				{ "setting_before", value },
				{ "setting_after", value },
				{ "setting_name", key }
			};
			arr.Add(item);
		}

		private void AppendResolutionOptions(JArray arr, SettingOptions options)
		{
			if (options?.GetConnection() is ResolutionConnectionSO.Connection connection)
			{
				Vector2Int resolutionValue = connection.GetResolutionValue(options.GetValue());
				AppendReportOptions(arr, "image_resolution_x", resolutionValue.x);
				AppendReportOptions(arr, "image_resolution_y", resolutionValue.y);
			}
		}

		private void AppendReportOptions(JArray arr, string key, SettingOptions options)
		{
			if (options != null)
			{
				AppendReportOptions(arr, key, options.GetValue());
			}
		}
	}

	internal override void OnStart()
	{
		try
		{
			new ClientImageSettingInfo().OnDispatch();
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
		State = OptionState.Succeed;
	}

	internal override void OnUpdate()
	{
	}
}
