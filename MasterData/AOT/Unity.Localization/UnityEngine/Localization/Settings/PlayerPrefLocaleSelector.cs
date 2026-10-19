using System;

namespace UnityEngine.Localization.Settings;

[Serializable]
public class PlayerPrefLocaleSelector : IStartupLocaleSelector, IInitialize
{
	[SerializeField]
	private string m_PlayerPreferenceKey = "selected-locale";

	public string PlayerPreferenceKey
	{
		get
		{
			return m_PlayerPreferenceKey;
		}
		set
		{
			m_PlayerPreferenceKey = value;
		}
	}

	public void PostInitialization(LocalizationSettings settings)
	{
		if (Application.isPlaying)
		{
			Locale selectedLocale = settings.GetSelectedLocale();
			if (selectedLocale != null)
			{
				PlayerPrefs.SetString(PlayerPreferenceKey, selectedLocale.Identifier.Code);
			}
		}
	}

	public Locale GetStartupLocale(ILocalesProvider availableLocales)
	{
		if (PlayerPrefs.HasKey(PlayerPreferenceKey))
		{
			string text = PlayerPrefs.GetString(PlayerPreferenceKey);
			if (!string.IsNullOrEmpty(text))
			{
				return availableLocales.GetLocale(text);
			}
		}
		return null;
	}
}
