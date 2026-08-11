#define ENABLE_FATAL_AND_ABOVE_LOG
using GameFramework.Localization;
using UnityEngine;

namespace GameFramework.Runtime;

public class DefaultLocalizationHelper : ILocalizationHelper
{
	private ResourceComponent m_ResourceComponent = null;

	private ILocalizationManager m_LocalizationManager = null;

	public Language Language { get; set; }

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

	public string GetString(string key)
	{
		return string.Empty;
	}

	public string GetString(string key, object arg0)
	{
		return string.Empty;
	}

	public string GetString(string key, object arg0, object arg1)
	{
		return string.Empty;
	}

	public string GetString(string key, object arg0, object arg1, object arg2)
	{
		return string.Empty;
	}

	public string GetString(string key, params object[] args)
	{
		return string.Empty;
	}

	public void Init()
	{
		m_ResourceComponent = GameEntryRuntime.GetComponent<ResourceComponent>();
		if (m_ResourceComponent == null)
		{
			Log.Fatal("Resource component is invalid.");
			return;
		}
		m_LocalizationManager = GameFrameworkEntry.GetModule<ILocalizationManager>();
		if (m_LocalizationManager == null)
		{
			Log.Fatal("Localization manager is invalid.");
		}
	}
}
