using System.Collections.Generic;
using ACT.UI;
using UnityEngine;

namespace ACT.Config;

public class ViewConfigs : ScriptableObject
{
	public List<ConfigData> viewConfigs = new List<ConfigData>();

	private Dictionary<UI_TYPE, ViewConfig> _configCache;

	private Dictionary<UI_TYPE, IBaseUIView> _uiCache = new Dictionary<UI_TYPE, IBaseUIView>();

	public ViewConfig GetViewConfig(UI_TYPE uiType)
	{
		if (_configCache == null)
		{
			_configCache = new Dictionary<UI_TYPE, ViewConfig>();
			foreach (ConfigData viewConfig in viewConfigs)
			{
				if (!_configCache.ContainsKey(viewConfig.UIType))
				{
					_configCache[viewConfig.UIType] = viewConfig.VConfig;
				}
			}
		}
		if (_configCache.TryGetValue(uiType, out var value))
		{
			return value;
		}
		return null;
	}

	public bool IsNeedBlackWhenOpen(UI_TYPE uiType)
	{
		ViewConfig viewConfig = GetViewConfig(uiType);
		if (viewConfig != null)
		{
			return viewConfig.IsNeedBlackWhenOpen;
		}
		return false;
	}

	public bool IsNeedBlurBackground(UI_TYPE uiType)
	{
		ViewConfig viewConfig = GetViewConfig(uiType);
		if (viewConfig != null)
		{
			return viewConfig.ISneedBlurBackground;
		}
		return false;
	}

	public void RefreshCache()
	{
		_configCache = null;
	}
}
