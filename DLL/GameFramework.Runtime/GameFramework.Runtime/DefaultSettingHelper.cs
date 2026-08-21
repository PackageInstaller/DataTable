using System;
using UnityEngine;

namespace GameFramework.Runtime;

public class DefaultSettingHelper : SettingHelperBase
{
	public override bool Load()
	{
		return true;
	}

	public override bool Save()
	{
		PlayerPrefs.Save();
		return true;
	}

	public override bool HasSetting(string settingName)
	{
		return PlayerPrefs.HasKey(settingName);
	}

	public override void RemoveSetting(string settingName)
	{
		PlayerPrefs.DeleteKey(settingName);
	}

	public override void RemoveAllSettings()
	{
		PlayerPrefs.DeleteAll();
	}

	public override bool GetBool(string settingName)
	{
		return PlayerPrefs.GetInt(settingName) != 0;
	}

	public override bool GetBool(string settingName, bool defaultValue)
	{
		return PlayerPrefs.GetInt(settingName, defaultValue ? 1 : 0) != 0;
	}

	public override void SetBool(string settingName, bool value)
	{
		PlayerPrefs.SetInt(settingName, value ? 1 : 0);
	}

	public override int GetInt(string settingName)
	{
		return PlayerPrefs.GetInt(settingName);
	}

	public override int GetInt(string settingName, int defaultValue)
	{
		return PlayerPrefs.GetInt(settingName, defaultValue);
	}

	public override void SetInt(string settingName, int value)
	{
		PlayerPrefs.SetInt(settingName, value);
	}

	public override float GetFloat(string settingName)
	{
		return PlayerPrefs.GetFloat(settingName);
	}

	public override float GetFloat(string settingName, float defaultValue)
	{
		return PlayerPrefs.GetFloat(settingName, defaultValue);
	}

	public override void SetFloat(string settingName, float value)
	{
		PlayerPrefs.SetFloat(settingName, value);
	}

	public override string GetString(string settingName)
	{
		return PlayerPrefs.GetString(settingName);
	}

	public override string GetString(string settingName, string defaultValue)
	{
		return PlayerPrefs.GetString(settingName, defaultValue);
	}

	public override void SetString(string settingName, string value)
	{
		PlayerPrefs.SetString(settingName, value);
	}

	public override T GetObject<T>(string settingName)
	{
		return Utility.Json.ToObject<T>(PlayerPrefs.GetString(settingName));
	}

	public override object GetObject(Type objectType, string settingName)
	{
		return Utility.Json.ToObject(objectType, PlayerPrefs.GetString(settingName));
	}

	public override T GetObject<T>(string settingName, T defaultObj)
	{
		string text = PlayerPrefs.GetString(settingName, null);
		if (text == null)
		{
			return defaultObj;
		}
		return Utility.Json.ToObject<T>(text);
	}

	public override object GetObject(Type objectType, string settingName, object defaultObj)
	{
		string text = PlayerPrefs.GetString(settingName, null);
		if (text == null)
		{
			return defaultObj;
		}
		return Utility.Json.ToObject(objectType, text);
	}

	public override void SetObject<T>(string settingName, T obj)
	{
		PlayerPrefs.SetString(settingName, Utility.Json.ToJson(obj));
	}

	public override void SetObject(string settingName, object obj)
	{
		PlayerPrefs.SetString(settingName, Utility.Json.ToJson(obj));
	}
}
