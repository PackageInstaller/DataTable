using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class GameSettingHelper : SettingHelperBase
{
	private IMessenger _messenger;

	private IMessenger Messenger
	{
		get
		{
			if (_messenger == null)
			{
				_messenger = Context.GetApplicationContext().GetService<IMessenger>();
			}
			return _messenger;
		}
	}

	public Dictionary<string, GameSettingConfigHelper.SettingData> Settings => GameSettingConfigHelper.Settings;

	public override bool Load()
	{
		_messenger = Context.GetApplicationContext().GetService<IMessenger>();
		GameSettingConfigHelper.Settings.Clear();
		foreach (KeyValuePair<string, GameSettingConfig> gameSettingConfig in GameSettingConfigHelper.gameSettingConfigs)
		{
			GameSettingConfigHelper.SettingData settingData = new GameSettingConfigHelper.SettingData(gameSettingConfig.Value);
			settingData.LoadCacheSetting();
			GameSettingConfigHelper.Settings.TryAdd(gameSettingConfig.Key, settingData);
		}
		return true;
	}

	public override bool Save()
	{
		bool flag = false;
		foreach (GameSettingConfigHelper.SettingData value in GameSettingConfigHelper.Settings.Values)
		{
			if (value.Modifyed)
			{
				if (!flag && GameSettingConfigHelper.SettingEnum[SettingTypeEnum.GraphicsSetting].Contains(value.Config.Name))
				{
					flag = true;
				}
				if (Messenger != null)
				{
					Messenger.Publish("GameSetting_" + value.Config.Name, value);
				}
			}
			value.SaveCacheSetting();
		}
		if (flag)
		{
			GraphicsData graphicsData = GameSettingExtension.GetGraphicsData();
			Messenger.Publish("GameSetting_" + SettingTypeEnum.GraphicsSetting, graphicsData);
		}
		PlayerPrefs.Save();
		return true;
	}

	public override bool HasSetting(string settingName)
	{
		return GameSettingConfigHelper.Settings.ContainsKey(settingName);
	}

	public override void RemoveSetting(string settingName)
	{
		if (GameSettingConfigHelper.Settings.TryGetValue(settingName, out var value))
		{
			value.ResetSetting();
		}
	}

	public override void RemoveAllSettings()
	{
		foreach (KeyValuePair<string, GameSettingConfigHelper.SettingData> setting in GameSettingConfigHelper.Settings)
		{
			setting.Value.ResetSetting();
		}
	}

	public override bool GetBool(string settingName)
	{
		if (GameSettingConfigHelper.Settings.TryGetValue(settingName, out var value))
		{
			return value.Value > 0f;
		}
		return false;
	}

	public override bool GetBool(string settingName, bool defaultValue)
	{
		if (GameSettingConfigHelper.Settings.TryGetValue(settingName, out var value))
		{
			return value.Value > 0f;
		}
		return defaultValue;
	}

	public override float GetFloat(string settingName)
	{
		if (GameSettingConfigHelper.Settings.TryGetValue(settingName, out var value))
		{
			return value.Value;
		}
		return 0f;
	}

	public override float GetFloat(string settingName, float defaultValue)
	{
		if (GameSettingConfigHelper.Settings.TryGetValue(settingName, out var value))
		{
			return value.Value;
		}
		return defaultValue;
	}

	public override int GetInt(string settingName)
	{
		if (GameSettingConfigHelper.Settings.TryGetValue(settingName, out var value))
		{
			return (int)value.Value;
		}
		return 0;
	}

	public override int GetInt(string settingName, int defaultValue)
	{
		if (GameSettingConfigHelper.Settings.TryGetValue(settingName, out var value))
		{
			return (int)value.Value;
		}
		return defaultValue;
	}

	[Obsolete]
	public override T GetObject<T>(string settingName)
	{
		throw new NotImplementedException();
	}

	[Obsolete]
	public override object GetObject(Type objectType, string settingName)
	{
		throw new NotImplementedException();
	}

	[Obsolete]
	public override T GetObject<T>(string settingName, T defaultObj)
	{
		throw new NotImplementedException();
	}

	[Obsolete]
	public override object GetObject(Type objectType, string settingName, object defaultObj)
	{
		throw new NotImplementedException();
	}

	public override string GetString(string settingName)
	{
		return PlayerPrefs.GetString(settingName, string.Empty);
	}

	public override string GetString(string settingName, string defaultValue)
	{
		return PlayerPrefs.GetString(settingName, defaultValue);
	}

	public override void SetBool(string settingName, bool value)
	{
		if (GameSettingConfigHelper.Settings.TryGetValue(settingName, out var value2))
		{
			value2.SetValue(value ? 1 : 0);
		}
	}

	public override void SetFloat(string settingName, float value)
	{
		if (GameSettingConfigHelper.Settings.TryGetValue(settingName, out var value2))
		{
			value2.SetValue(value);
		}
	}

	public override void SetInt(string settingName, int value)
	{
		if (GameSettingConfigHelper.Settings.TryGetValue(settingName, out var value2))
		{
			value2.SetValue(value);
		}
	}

	[Obsolete]
	public override void SetObject<T>(string settingName, T obj)
	{
		throw new NotImplementedException();
	}

	[Obsolete]
	public override void SetObject(string settingName, object obj)
	{
		throw new NotImplementedException();
	}

	[Obsolete]
	public override void SetString(string settingName, string value)
	{
		PlayerPrefs.SetString(settingName, value);
	}
}
