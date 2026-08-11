using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;

namespace Ase;

public static class ViewConfigSetting
{
	private static ViewConfigSettingData viewConfigSettingData;

	public static async UniTask Init()
	{
		viewConfigSettingData = await GameEntry.Resource.LoadAssetAsync<ViewConfigSettingData>("Assets/Art/Configs/ViewConfigSettingData.asset");
	}

	public static ViewConfig[] GetViewConfigs(Predicate<ViewConfig> condition)
	{
		if (condition == null)
		{
			throw new GameFrameworkException("Condition is invalid.");
		}
		List<ViewConfig> list = new List<ViewConfig>();
		foreach (KeyValuePair<int, ViewConfig> viewConfig in viewConfigSettingData.ViewConfigs)
		{
			if (condition(viewConfig.Value))
			{
				list.Add(viewConfig.Value);
			}
		}
		return list.ToArray();
	}

	public static ViewConfig? GetViewConfig(Predicate<ViewConfig> condition)
	{
		if (condition == null)
		{
			throw new GameFrameworkException("Condition is invalid.");
		}
		foreach (KeyValuePair<int, ViewConfig> viewConfig in viewConfigSettingData.ViewConfigs)
		{
			if (condition(viewConfig.Value))
			{
				return viewConfig.Value;
			}
		}
		return null;
	}
}
