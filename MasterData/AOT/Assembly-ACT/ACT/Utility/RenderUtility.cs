using UnityEngine.Rendering.Universal;

namespace ACT.Utility;

public static class RenderUtility
{
	public static void SetURPGraphicSettings(bool isColor, bool isDepth, bool isSkybox, bool isDistortion)
	{
		URPGraphicSettings.ToggleDepthSample(isDepth);
		URPGraphicSettings.ToggleSkyBox(isSkybox);
		URPGraphicSettings.SetDistortionLevel(isDistortion ? 1 : 0);
	}

	public static void ResetRenderFeature()
	{
		SettingOptions settingOptions = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.Distortion");
		URPGraphicSettings.ToggleSkyBox(enable: true);
		SettingOptions settingOptions2 = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.DepthSample");
		if (settingOptions2 != null)
		{
			URPGraphicSettings.ToggleDepthSample(settingOptions2.GetValue() == 1);
		}
		if (settingOptions != null)
		{
			URPGraphicSettings.SetDistortionLevel(settingOptions.GetValue());
		}
	}
}
