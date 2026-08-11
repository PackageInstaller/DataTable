using System;
using GameFramework.Setting;
using UnityEngine;

namespace GameFramework.Runtime;

public abstract class SettingHelperBase : MonoBehaviour, ISettingHelper
{
	public abstract bool Load();

	public abstract bool Save();

	public abstract bool HasSetting(string settingName);

	public abstract void RemoveSetting(string settingName);

	public abstract void RemoveAllSettings();

	public abstract bool GetBool(string settingName);

	public abstract bool GetBool(string settingName, bool defaultValue);

	public abstract void SetBool(string settingName, bool value);

	public abstract int GetInt(string settingName);

	public abstract int GetInt(string settingName, int defaultValue);

	public abstract void SetInt(string settingName, int value);

	public abstract float GetFloat(string settingName);

	public abstract float GetFloat(string settingName, float defaultValue);

	public abstract void SetFloat(string settingName, float value);

	public abstract string GetString(string settingName);

	public abstract string GetString(string settingName, string defaultValue);

	public abstract void SetString(string settingName, string value);

	public abstract T GetObject<T>(string settingName);

	public abstract object GetObject(Type objectType, string settingName);

	public abstract T GetObject<T>(string settingName, T defaultObj);

	public abstract object GetObject(Type objectType, string settingName, object defaultObj);

	public abstract void SetObject<T>(string settingName, T obj);

	public abstract void SetObject(string settingName, object obj);
}
