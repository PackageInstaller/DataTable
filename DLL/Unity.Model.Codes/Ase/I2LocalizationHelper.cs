#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using GameFramework.Localization;
using I2.Loc;
using UnityEngine;

namespace Ase;

public class I2LocalizationHelper : ILocalizationHelper
{
	private Language m_Language;

	public Language Language
	{
		get
		{
			return m_Language;
		}
		set
		{
			if (value == Language.Unspecified)
			{
				throw new GameFrameworkException("Language is invalid.");
			}
			m_Language = value;
			if (LocalizationManager.HasLanguage(LanguageName, true, true, true))
			{
				LocalizationManager.CurrentLanguage = LanguageName;
			}
			else
			{
				Log.Error("没有找到[" + LanguageName + "]的多语言配置.");
			}
		}
	}

	public Language SystemLanguage => Application.systemLanguage switch
	{
		UnityEngine.SystemLanguage.Afrikaans => Language.Afrikaans, 
		UnityEngine.SystemLanguage.Arabic => Language.Arabic, 
		UnityEngine.SystemLanguage.Basque => Language.Basque, 
		UnityEngine.SystemLanguage.Belarusian => Language.Belarusian, 
		UnityEngine.SystemLanguage.Bulgarian => Language.Bulgarian, 
		UnityEngine.SystemLanguage.Catalan => Language.Catalan, 
		UnityEngine.SystemLanguage.Chinese => Language.ChineseSimplified, 
		UnityEngine.SystemLanguage.ChineseSimplified => Language.ChineseSimplified, 
		UnityEngine.SystemLanguage.ChineseTraditional => Language.ChineseTraditional, 
		UnityEngine.SystemLanguage.Czech => Language.Czech, 
		UnityEngine.SystemLanguage.Danish => Language.Danish, 
		UnityEngine.SystemLanguage.Dutch => Language.Dutch, 
		UnityEngine.SystemLanguage.English => Language.English, 
		UnityEngine.SystemLanguage.Estonian => Language.Estonian, 
		UnityEngine.SystemLanguage.Faroese => Language.Faroese, 
		UnityEngine.SystemLanguage.Finnish => Language.Finnish, 
		UnityEngine.SystemLanguage.French => Language.French, 
		UnityEngine.SystemLanguage.German => Language.German, 
		UnityEngine.SystemLanguage.Greek => Language.Greek, 
		UnityEngine.SystemLanguage.Hebrew => Language.Hebrew, 
		UnityEngine.SystemLanguage.Hungarian => Language.Hungarian, 
		UnityEngine.SystemLanguage.Icelandic => Language.Icelandic, 
		UnityEngine.SystemLanguage.Indonesian => Language.Indonesian, 
		UnityEngine.SystemLanguage.Italian => Language.Italian, 
		UnityEngine.SystemLanguage.Japanese => Language.Japanese, 
		UnityEngine.SystemLanguage.Korean => Language.Korean, 
		UnityEngine.SystemLanguage.Latvian => Language.Latvian, 
		UnityEngine.SystemLanguage.Lithuanian => Language.Lithuanian, 
		UnityEngine.SystemLanguage.Norwegian => Language.Norwegian, 
		UnityEngine.SystemLanguage.Polish => Language.Polish, 
		UnityEngine.SystemLanguage.Portuguese => Language.PortuguesePortugal, 
		UnityEngine.SystemLanguage.Romanian => Language.Romanian, 
		UnityEngine.SystemLanguage.Russian => Language.Russian, 
		UnityEngine.SystemLanguage.SerboCroatian => Language.SerboCroatian, 
		UnityEngine.SystemLanguage.Slovak => Language.Slovak, 
		UnityEngine.SystemLanguage.Slovenian => Language.Slovenian, 
		UnityEngine.SystemLanguage.Spanish => Language.Spanish, 
		UnityEngine.SystemLanguage.Swedish => Language.Swedish, 
		UnityEngine.SystemLanguage.Thai => Language.Thai, 
		UnityEngine.SystemLanguage.Turkish => Language.Turkish, 
		UnityEngine.SystemLanguage.Ukrainian => Language.Ukrainian, 
		UnityEngine.SystemLanguage.Unknown => Language.Unspecified, 
		UnityEngine.SystemLanguage.Vietnamese => Language.Vietnamese, 
		_ => Language.Unspecified, 
	};

	private string LanguageName => m_Language switch
	{
		Language.ChineseSimplified => "Chinese", 
		Language.English => "English", 
		_ => "Chinese", 
	};

	public void Init()
	{
	}

	public string GetString(string key)
	{
		if (string.IsNullOrEmpty(key))
		{
			return string.Empty;
		}
		return LocalizationManager.GetTranslation(key, true, 0, true, false, (GameObject)null, (string)null, true);
	}

	public string GetString(string key, object arg0)
	{
		return Utility.Text.Format(GetString(key), arg0);
	}

	public string GetString(string key, object arg0, object arg1)
	{
		return Utility.Text.Format(GetString(key), arg0, arg1);
	}

	public string GetString(string key, object arg0, object arg1, object arg2)
	{
		return Utility.Text.Format(GetString(key), arg0, arg1, arg2);
	}

	public string GetString(string key, params object[] args)
	{
		return Utility.Text.Format(GetString(key), args);
	}
}
