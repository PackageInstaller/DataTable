using System;
using System.Collections.Generic;

namespace ACT.Sound.Language;

public static class AudioLanguageManager
{
	private static AudioLanguageType _currentLanguage;

	private static AudioLanguageType[] _fallbackOrder = new AudioLanguageType[3]
	{
		AudioLanguageType.Chinese,
		AudioLanguageType.Japanese,
		AudioLanguageType.English
	};

	private static AudioConfig _config => AudioConfig.Instance;

	public static AudioLanguageType CurrentLanguageType
	{
		get
		{
			return _currentLanguage;
		}
		private set
		{
			if (_currentLanguage != value)
			{
				_currentLanguage = value;
				OnLanguageChanged?.Invoke(value);
			}
		}
	}

	public static event Action<AudioLanguageType> OnLanguageChanged;

	public static void SetLanguage(AudioLanguageType languageType)
	{
		CurrentLanguageType = languageType;
	}

	public static string GetEventPath(string eventKey)
	{
		if (string.IsNullOrEmpty(eventKey))
		{
			return string.Empty;
		}
		if (_config == null)
		{
			return eventKey;
		}
		string eventPath = _config.GetEventPath(eventKey, _currentLanguage);
		if (!string.IsNullOrEmpty(eventPath))
		{
			return eventPath;
		}
		AudioLanguageType[] fallbackOrder = _fallbackOrder;
		foreach (AudioLanguageType audioLanguageType in fallbackOrder)
		{
			if (audioLanguageType != _currentLanguage)
			{
				eventPath = _config.GetEventPath(eventKey, audioLanguageType);
				if (!string.IsNullOrEmpty(eventPath))
				{
					return eventPath;
				}
			}
		}
		return eventKey;
	}

	public static string GetEventPath(string eventKey, AudioLanguageType languageType)
	{
		if (string.IsNullOrEmpty(eventKey))
		{
			return string.Empty;
		}
		if (_config == null)
		{
			return eventKey;
		}
		string eventPath = _config.GetEventPath(eventKey, languageType);
		if (string.IsNullOrEmpty(eventPath))
		{
			return eventKey;
		}
		return eventPath;
	}

	public static bool HasLanguageSupport(string eventKey, AudioLanguageType languageType)
	{
		if (string.IsNullOrEmpty(eventKey) || _config == null)
		{
			return false;
		}
		return _config.HasEvent(eventKey, languageType);
	}

	public static List<AudioLanguageType> GetSupportedLanguages(string eventKey)
	{
		List<AudioLanguageType> list = new List<AudioLanguageType>();
		if (string.IsNullOrEmpty(eventKey) || _config == null)
		{
			return list;
		}
		if (_config.HasEvent(eventKey, AudioLanguageType.Chinese))
		{
			list.Add(AudioLanguageType.Chinese);
		}
		if (_config.HasEvent(eventKey, AudioLanguageType.English))
		{
			list.Add(AudioLanguageType.English);
		}
		if (_config.HasEvent(eventKey, AudioLanguageType.Japanese))
		{
			list.Add(AudioLanguageType.Japanese);
		}
		return list;
	}
}
