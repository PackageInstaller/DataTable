using System;
using System.Globalization;

namespace UnityEngine.Localization.Settings;

[Serializable]
public class SystemLocaleSelector : IStartupLocaleSelector
{
	public Locale GetStartupLocale(ILocalesProvider availableLocales)
	{
		Locale locale = null;
		locale = FindLocaleOrFallback(GetAndroidDeviceLanguage(), availableLocales);
		if (locale != null)
		{
			return locale;
		}
		locale = FindLocaleOrFallback(GetSystemCulture(), availableLocales);
		SystemLanguage applicationSystemLanguage = GetApplicationSystemLanguage();
		if (locale == null && applicationSystemLanguage != SystemLanguage.Unknown)
		{
			locale = FindLocaleOrFallback(applicationSystemLanguage, availableLocales);
		}
		return locale;
	}

	private static Locale FindLocaleOrFallback(LocaleIdentifier localeIdentifier, ILocalesProvider availableLocales)
	{
		CultureInfo cultureInfo = localeIdentifier.CultureInfo;
		if (cultureInfo == null)
		{
			return null;
		}
		Locale locale = availableLocales.GetLocale(cultureInfo);
		if (locale == null)
		{
			cultureInfo = cultureInfo.Parent;
			while (cultureInfo != CultureInfo.InvariantCulture && locale == null)
			{
				locale = availableLocales.GetLocale(cultureInfo);
				cultureInfo = cultureInfo.Parent;
			}
			if (locale != null)
			{
				Debug.Log($"The Locale '{localeIdentifier}' is not available, however the parent locale '{locale.Identifier}' is available.");
			}
		}
		return locale;
	}

	protected virtual CultureInfo GetSystemCulture()
	{
		return CultureInfo.CurrentUICulture;
	}

	protected virtual SystemLanguage GetApplicationSystemLanguage()
	{
		return Application.systemLanguage;
	}

	private static string GetAndroidDeviceLanguage()
	{
		using (AndroidJavaClass androidJavaClass = new AndroidJavaClass("java.util.Locale"))
		{
			if (androidJavaClass != null)
			{
				using AndroidJavaObject androidJavaObject = androidJavaClass.CallStatic<AndroidJavaObject>("getDefault", Array.Empty<object>());
				if (androidJavaObject != null)
				{
					return androidJavaObject.Call<string>("toLanguageTag", Array.Empty<object>());
				}
			}
		}
		return null;
	}
}
