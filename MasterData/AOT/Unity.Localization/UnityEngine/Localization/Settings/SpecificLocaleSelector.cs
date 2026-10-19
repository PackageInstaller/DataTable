using System;

namespace UnityEngine.Localization.Settings;

[Serializable]
public class SpecificLocaleSelector : IStartupLocaleSelector
{
	[SerializeField]
	private LocaleIdentifier m_LocaleId = new LocaleIdentifier(SystemLanguage.English);

	public LocaleIdentifier LocaleId
	{
		get
		{
			return m_LocaleId;
		}
		set
		{
			m_LocaleId = value;
		}
	}

	public Locale GetStartupLocale(ILocalesProvider availableLocales)
	{
		return availableLocales.GetLocale(LocaleId);
	}
}
