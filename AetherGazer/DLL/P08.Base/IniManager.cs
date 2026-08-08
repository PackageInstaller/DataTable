using System;
using System.IO;
using UnityEngine;

public class IniManager
{
	private static bool ready;

	private static IniInfoNew _iniInfo;

	public static bool GetReady()
	{
		return ready;
	}

	public static void Initialize()
	{
		if (!ready)
		{
			InitSystemIni();
			ready = true;
		}
	}

	private static string GetSystemIniFileName()
	{
		return Path.Combine(Application.persistentDataPath, "sys_config.ini");
	}

	private static void InitSystemIni()
	{
		if (!File.Exists(GetSystemIniFileName()))
		{
			_iniInfo = new IniInfoNew();
			try
			{
				Platform.SaveJsonFile(_iniInfo, GetSystemIniFileName());
			}
			catch
			{
			}
		}
		else
		{
			try
			{
				IniInfo jsonFile = Platform.GetJsonFile<IniInfo>(GetSystemIniFileName());
				if (jsonFile != null && !jsonFile.isNaiveAngle)
				{
					_iniInfo = new IniInfoNew();
					_iniInfo.isLocalization = !jsonFile.isNaiveAngle;
				}
				else
				{
					_iniInfo = Platform.GetJsonFile<IniInfoNew>(GetSystemIniFileName());
				}
			}
			catch (Exception ex)
			{
				Debug.LogError(ex.Message);
				_iniInfo = new IniInfoNew();
			}
		}
		if (_iniInfo == null)
		{
			_iniInfo = new IniInfoNew();
		}
		InitNaiveConfig();
	}

	private static void InitNaiveConfig()
	{
		if (_iniInfo.isLocalization)
		{
			PlayerPrefs.SetString("naive_angle_mode_key", string.Empty);
		}
		else
		{
			PlayerPrefs.SetString("naive_angle_mode_key", "naive");
		}
		try
		{
			Platform.SaveJsonFile(_iniInfo, GetSystemIniFileName());
		}
		catch
		{
		}
	}
}
