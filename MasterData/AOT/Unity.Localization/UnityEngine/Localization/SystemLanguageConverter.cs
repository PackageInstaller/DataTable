namespace UnityEngine.Localization;

internal static class SystemLanguageConverter
{
	internal static string GetSystemLanguageCultureCode(SystemLanguage lang)
	{
		return lang switch
		{
			SystemLanguage.Afrikaans => "af", 
			SystemLanguage.Arabic => "ar", 
			SystemLanguage.Basque => "eu", 
			SystemLanguage.Belarusian => "be", 
			SystemLanguage.Bulgarian => "bg", 
			SystemLanguage.Catalan => "ca", 
			SystemLanguage.Chinese => "zh-CN", 
			SystemLanguage.ChineseSimplified => "zh-hans", 
			SystemLanguage.ChineseTraditional => "zh-hant", 
			SystemLanguage.SerboCroatian => "hr", 
			SystemLanguage.Czech => "cs", 
			SystemLanguage.Danish => "da", 
			SystemLanguage.Dutch => "nl", 
			SystemLanguage.English => "en", 
			SystemLanguage.Estonian => "et", 
			SystemLanguage.Faroese => "fo", 
			SystemLanguage.Finnish => "fi", 
			SystemLanguage.French => "fr", 
			SystemLanguage.German => "de", 
			SystemLanguage.Greek => "el", 
			SystemLanguage.Hebrew => "he", 
			SystemLanguage.Hungarian => "hu", 
			SystemLanguage.Icelandic => "is", 
			SystemLanguage.Indonesian => "id", 
			SystemLanguage.Italian => "it", 
			SystemLanguage.Japanese => "ja", 
			SystemLanguage.Korean => "ko", 
			SystemLanguage.Latvian => "lv", 
			SystemLanguage.Lithuanian => "lt", 
			SystemLanguage.Norwegian => "no", 
			SystemLanguage.Polish => "pl", 
			SystemLanguage.Portuguese => "pt", 
			SystemLanguage.Romanian => "ro", 
			SystemLanguage.Russian => "ru", 
			SystemLanguage.Slovak => "sk", 
			SystemLanguage.Slovenian => "sl", 
			SystemLanguage.Spanish => "es", 
			SystemLanguage.Swedish => "sv", 
			SystemLanguage.Thai => "th", 
			SystemLanguage.Turkish => "tr", 
			SystemLanguage.Ukrainian => "uk", 
			SystemLanguage.Vietnamese => "vi", 
			_ => "", 
		};
	}
}
