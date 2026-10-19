using System.Collections.Generic;
using UnityEngine;

namespace ACT.Sound.Language;

public class AudioConfig : LuminSerializedScriptableObject
{
	private static AudioConfig _instance;

	[SerializeField]
	private Dictionary<string, string> _cnEventMap = new Dictionary<string, string>();

	[SerializeField]
	private Dictionary<string, string> _enEventMap = new Dictionary<string, string>();

	[SerializeField]
	private Dictionary<string, string> _jpEventMap = new Dictionary<string, string>();

	[SerializeField]
	private Dictionary<string, string> _eventToBankGuidMap = new Dictionary<string, string>();

	public static AudioConfig Instance
	{
		get
		{
			if (_instance == null)
			{
				_instance = AssetStationManager.Root.Load<AudioConfig>("Configs/AudioConfig").Result as AudioConfig;
			}
			return _instance;
		}
	}

	public IReadOnlyDictionary<string, string> CNEventMap => _cnEventMap;

	public IReadOnlyDictionary<string, string> ENEventMap => _enEventMap;

	public IReadOnlyDictionary<string, string> JPEventMap => _jpEventMap;

	public IReadOnlyDictionary<string, string> EventToBankGuidMap => _eventToBankGuidMap;

	public IReadOnlyDictionary<string, string> GetEventMap(AudioLanguageType languageType)
	{
		return languageType switch
		{
			AudioLanguageType.Chinese => (IReadOnlyDictionary<string, string>)_cnEventMap, 
			AudioLanguageType.English => _enEventMap, 
			AudioLanguageType.Japanese => _jpEventMap, 
			_ => _cnEventMap, 
		};
	}

	public string GetEventPath(string eventKey, AudioLanguageType languageType)
	{
		if (!GetEventMap(languageType).TryGetValue(eventKey, out var value))
		{
			return string.Empty;
		}
		return value;
	}

	public bool HasEvent(string eventKey, AudioLanguageType languageType)
	{
		return GetEventMap(languageType).ContainsKey(eventKey);
	}

	public string GetBankGuidForEvent(string eventPath)
	{
		if (string.IsNullOrEmpty(eventPath))
		{
			return null;
		}
		if (_eventToBankGuidMap.TryGetValue(eventPath, out var value))
		{
			return value;
		}
		return null;
	}

	public bool HasBankForEvent(string eventPath)
	{
		if (!string.IsNullOrEmpty(eventPath))
		{
			return _eventToBankGuidMap.ContainsKey(eventPath);
		}
		return false;
	}
}
