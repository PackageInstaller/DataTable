namespace UnityEngine.Localization.Settings;

public interface IStartupLocaleSelector
{
	Locale GetStartupLocale(ILocalesProvider availableLocales);
}
