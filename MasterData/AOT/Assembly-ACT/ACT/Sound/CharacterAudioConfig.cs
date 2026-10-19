using System.Collections.Generic;
using UnityEngine;

namespace ACT.Sound;

[CreateAssetMenu(fileName = "CharacterAudioConfig", menuName = "Sound/CharacterAudioConfig")]
public class CharacterAudioConfig : LuminSerializedScriptableObject
{
	[SerializeField]
	private List<YooAssetReference> _fmodBanksAssetID = new List<YooAssetReference>();

	[SerializeField]
	private Dictionary<CommonAudioType, string> _commonAudioMap = new Dictionary<CommonAudioType, string>();

	[SerializeField]
	private Dictionary<int, string> _specialAudioMap = new Dictionary<int, string>();

	public IReadOnlyDictionary<CommonAudioType, string> CommonAudioMap => _commonAudioMap;

	public IReadOnlyDictionary<int, string> SpecialAudioMap => _specialAudioMap;

	public IReadOnlyList<YooAssetReference> FmodBanksAssetID => _fmodBanksAssetID;

	public Dictionary<int, string> ToVoiceMap()
	{
		Dictionary<int, string> dictionary = new Dictionary<int, string>();
		foreach (KeyValuePair<CommonAudioType, string> item in _commonAudioMap)
		{
			if (item.Key != CommonAudioType.None && !string.IsNullOrEmpty(item.Value))
			{
				dictionary[(int)item.Key] = item.Value;
			}
		}
		foreach (KeyValuePair<int, string> item2 in _specialAudioMap)
		{
			if (!string.IsNullOrEmpty(item2.Value))
			{
				dictionary[item2.Key] = item2.Value;
			}
		}
		return dictionary;
	}

	public void SetSpecialAudioMap(List<string> eventPaths)
	{
		if (eventPaths == null || eventPaths.Count == 0)
		{
			_specialAudioMap.Clear();
			return;
		}
		Dictionary<string, int> dictionary = new Dictionary<string, int>();
		foreach (KeyValuePair<int, string> item in _specialAudioMap)
		{
			if (!string.IsNullOrEmpty(item.Value))
			{
				dictionary[item.Value] = item.Key;
			}
		}
		_specialAudioMap.Clear();
		int num = 10000;
		foreach (int value2 in dictionary.Values)
		{
			if (value2 >= num)
			{
				num = value2 + 1;
			}
		}
		foreach (string eventPath in eventPaths)
		{
			if (!string.IsNullOrEmpty(eventPath))
			{
				if (dictionary.TryGetValue(eventPath, out var value))
				{
					_specialAudioMap[value] = eventPath;
					continue;
				}
				_specialAudioMap[num] = eventPath;
				num++;
			}
		}
	}
}
