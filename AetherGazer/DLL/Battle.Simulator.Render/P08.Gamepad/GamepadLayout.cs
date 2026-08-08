using System;
using System.Collections.Generic;
using UnityEngine;

namespace P08.Gamepad;

[Serializable]
public class GamepadLayout
{
	public static string[] m_halfAixsNames = new string[56]
	{
		"Axis1P", "Axis1N", "Axis2P", "Axis2N", "Axis3P", "Axis3N", "Axis4P", "Axis4N", "Axis5P", "Axis5N",
		"Axis6P", "Axis6N", "Axis7P", "Axis7N", "Axis8P", "Axis8N", "Axis9P", "Axis9N", "Axis10P", "Axis10N",
		"Axis11P", "Axis11N", "Axis12P", "Axis12N", "Axis13P", "Axis13N", "Axis14P", "Axis14N", "Axis15P", "Axis15N",
		"Axis16P", "Axis16N", "Axis17P", "Axis17N", "Axis18P", "Axis18N", "Axis19P", "Axis19N", "Axis20P", "Axis20N",
		"Axis21P", "Axis21N", "Axis22P", "Axis22N", "Axis23P", "Axis23N", "Axis24P", "Axis24N", "Axis25P", "Axis25N",
		"Axis26P", "Axis26N", "Axis27P", "Axis27N", "Axis28P", "Axis28N"
	};

	public const string FORMAT_VERSION_KEY = "fileFormateVersionKey";

	public const int USE_FILE_FORMAT_VERSION = 2;

	public const string VERSION_PARAMETER_NAME = "m_fileFormatVersion";

	public int m_fileFormatVersion;

	public List<ButtonParameter> m_buttonMapLayouts;

	public int m_cameraSensitivity = 50;

	public int m_cursorSensitivity = 50;

	public void AddButtonParameter(En_ButtonType pEn_ButtonType, KeyCode pKeyCode)
	{
		if (m_buttonMapLayouts == null)
		{
			m_buttonMapLayouts = new List<ButtonParameter>();
		}
		List<ButtonParameter> buttonMapLayouts = m_buttonMapLayouts;
		ButtonParameter obj = new ButtonParameter
		{
			m_buttonType = pEn_ButtonType
		};
		int num = (int)pKeyCode;
		obj.m_value = num.ToString();
		buttonMapLayouts.Add(obj);
	}

	public void AddButtonParameter(En_ButtonType pEn_ButtonType, string pAxisName)
	{
		if (m_buttonMapLayouts == null)
		{
			m_buttonMapLayouts = new List<ButtonParameter>();
		}
		m_buttonMapLayouts.Add(new ButtonParameter
		{
			m_buttonType = pEn_ButtonType,
			m_value = pAxisName
		});
	}

	public override string ToString()
	{
		return JsonUtility.ToJson(this);
	}

	public static string GetLayoutJsonFormConfig(string pKey, string pDefaultFileName)
	{
		string text = string.Empty;
		if (PlayerPrefs.HasKey(pKey))
		{
			text = PlayerPrefs.GetString(pKey);
		}
		else if (!string.IsNullOrEmpty(pDefaultFileName))
		{
			text = GetLayoutJsonFromFile(pDefaultFileName);
		}
		if (string.IsNullOrEmpty(text) && pKey == "OtherLayout")
		{
			text = new OtherLayout().ToString();
		}
		return text;
	}

	public static string GetLayoutJsonFromFile(string fileName)
	{
		return Asset.Load<TextAsset>("GamepadConfig/" + fileName)?.text ?? string.Empty;
	}

	public static GamepadLayout GetLayout(string pJson)
	{
		if (string.IsNullOrEmpty(pJson))
		{
			return null;
		}
		GamepadLayout gamepadLayout = JsonUtility.FromJson<GamepadLayout>(pJson);
		if (gamepadLayout != null && gamepadLayout.m_fileFormatVersion == 2)
		{
			return gamepadLayout;
		}
		int num = pJson.IndexOf("m_fileFormatVersion");
		if (num == -1)
		{
			return null;
		}
		int num2 = pJson.IndexOf(":", num) + 1;
		int num3 = pJson.IndexOf(",", num);
		if (num3 > num2 && int.TryParse(pJson.Substring(num2, num3 - num2), out var result))
		{
			return ConvertJson(result, 2);
		}
		return null;
	}

	public static GamepadLayout ConvertJson(int lastVersion, int nextVersion)
	{
		Debug.Log($"=====>>>>> 进行版本转换, json版本:{lastVersion}, 新版本:{nextVersion}");
		return null;
	}

	public static void SaveLayoutJson(string pKey, string pJson)
	{
		if (!string.IsNullOrEmpty(pJson))
		{
			PlayerPrefs.SetString(pKey, pJson);
		}
	}

	public static void DeleteLayoutJson(string pKey)
	{
		if (!string.IsNullOrEmpty(pKey))
		{
			PlayerPrefs.DeleteKey(pKey);
		}
	}

	public static string GetDefaultLayoutFileName(string pKey)
	{
		string result = string.Empty;
		switch (pKey)
		{
		case "KeyboardLayout":
			result = "KeyboardPCLayout";
			break;
		case "KeyMouseLayout":
			result = "KeyMousePCLayout";
			break;
		case "XboxLayout":
			result = "XboxOnePCLayout";
			break;
		case "PS4Layout":
			result = "Dualshock4PCLayout";
			break;
		default:
			_ = pKey == "OtherLayout";
			break;
		}
		return result;
	}
}
