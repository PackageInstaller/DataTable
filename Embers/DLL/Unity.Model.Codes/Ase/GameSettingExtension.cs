using UnityEngine;

namespace Ase;

public static class GameSettingExtension
{
	public static void InitGraphicDefaultSetting(int graphicLevel, GraphicsData data)
	{
		if (data != null)
		{
			TryInitDefaultValue("画质预设", graphicLevel - 1);
			TryInitDefaultValue("帧率", data.FrameRataLock);
			TryInitDefaultValue("渲染精度", data.RenderAccuracy);
			TryInitDefaultValue("分辨率", data.Resolution);
			TryInitDefaultValue("抗锯齿", data.AntiAliasing);
			TryInitDefaultValue("Bloom", data.Bloom ? 1 : 0);
			TryInitDefaultValue("暗角", data.Vignette ? 1 : 0);
			TryInitDefaultValue("阴影", data.Shadow);
			TryInitDefaultValue("特效等级", data.EffectLevel);
			TryInitDefaultValue("HDR", data.HDR ? 1 : 0);
		}
	}

	public static void ApplyGraphicSetting(int graphicLevel, GraphicsData data)
	{
		if (data != null)
		{
			TryInitSetting("画质预设", graphicLevel - 1);
			TryInitSetting("帧率", data.FrameRataLock);
			TryInitSetting("渲染精度", data.RenderAccuracy);
			TryInitSetting("分辨率", data.Resolution);
			TryInitSetting("抗锯齿", data.AntiAliasing);
			TryInitSetting("Bloom", data.Bloom ? 1 : 0);
			TryInitSetting("暗角", data.Vignette ? 1 : 0);
			TryInitSetting("阴影", data.Shadow);
			TryInitSetting("特效等级", data.EffectLevel);
			TryInitSetting("HDR", data.HDR ? 1 : 0);
			GameEntry.Setting.Save();
		}
	}

	private static void TryInitDefaultValue(string key, float value)
	{
		if (GameSettingConfigHelper.Settings.TryGetValue(key, out var value2))
		{
			value2.Config.DefaultValue = value;
		}
	}

	private static void TryInitSetting(string key, float value)
	{
		if (GameSettingConfigHelper.Settings.TryGetValue(key, out var value2))
		{
			value2.SetValue(GetSettingIndex(key, value));
		}
	}

	public static float GetFloatRawValue(string settingName)
	{
		float num = GameEntry.Setting.GetFloat(settingName);
		if (GameSettingConfigHelper.SettingEnumValues.TryGetValue(settingName, out var value) && (float)value.Count > num)
		{
			return value[(int)num];
		}
		return num;
	}

	public static int GetIntRawValue(string settingName)
	{
		int num = GameEntry.Setting.GetInt(settingName);
		if (GameSettingConfigHelper.SettingEnumValues.TryGetValue(settingName, out var value) && value.Count > num)
		{
			return (int)value[num];
		}
		return num;
	}

	public static float GetSettingIndex(string settingName, float finalValue)
	{
		if (GameSettingConfigHelper.SettingEnumValues.TryGetValue(settingName, out var value))
		{
			return Mathf.Max(value.FindIndex((float p) => p.Equals(finalValue)), 0);
		}
		return finalValue;
	}

	public static GraphicsData GetGraphicsData()
	{
		return new GraphicsData
		{
			FrameRataLock = GetIntRawValue("帧率"),
			RenderAccuracy = GetFloatRawValue("渲染精度"),
			Resolution = GetIntRawValue("分辨率"),
			Shadow = GetIntRawValue("阴影"),
			EffectLevel = GetIntRawValue("特效等级"),
			AntiAliasing = GetIntRawValue("抗锯齿"),
			HDR = GameEntry.Setting.GetBool("HDR"),
			Bloom = GameEntry.Setting.GetBool("Bloom"),
			Vignette = GameEntry.Setting.GetBool("暗角")
		};
	}
}
