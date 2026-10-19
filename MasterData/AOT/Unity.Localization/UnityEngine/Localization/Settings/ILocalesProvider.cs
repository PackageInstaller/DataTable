using System.Collections.Generic;

namespace UnityEngine.Localization.Settings;

public interface ILocalesProvider
{
	List<Locale> Locales { get; }

	Locale GetLocale(LocaleIdentifier id);

	void AddLocale(Locale locale);

	bool RemoveLocale(Locale locale);
}
