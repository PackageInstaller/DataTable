using System;
using System.Collections.Generic;
using Sirenix.Serialization;
using UnityEngine;

namespace ACT.World;

[CreateAssetMenu(fileName = "ScenePrefabGuidMap", menuName = "ACT/World/Scene Prefab Guid Map")]
public class ScenePrefabData : LuminSerializedScriptableObject
{
	[OdinSerialize]
	private Dictionary<string, string> entryMap = new Dictionary<string, string>(StringComparer.Ordinal);

	[NonSerialized]
	private Dictionary<string, string> _sceneGuidByPrefabGuid;

	public string GetPrefabGuid(string sceneGuid)
	{
		if (string.IsNullOrEmpty(sceneGuid))
		{
			return string.Empty;
		}
		if (!entryMap.TryGetValue(sceneGuid, out var value))
		{
			return string.Empty;
		}
		return value;
	}

	public string GetSceneGuid(string prefabGuid)
	{
		if (string.IsNullOrEmpty(prefabGuid))
		{
			return string.Empty;
		}
		EnsurePrefabGuidCache();
		if (!_sceneGuidByPrefabGuid.TryGetValue(prefabGuid, out var value))
		{
			return string.Empty;
		}
		return value;
	}

	public void SetMapping(string sceneGuid, string prefabGuid)
	{
		if (!string.IsNullOrEmpty(sceneGuid) && !string.IsNullOrEmpty(prefabGuid))
		{
			entryMap[sceneGuid] = prefabGuid;
			_sceneGuidByPrefabGuid = null;
		}
	}

	private void EnsurePrefabGuidCache()
	{
		if (_sceneGuidByPrefabGuid != null)
		{
			return;
		}
		Dictionary<string, string> dictionary = new Dictionary<string, string>(entryMap.Count, StringComparer.Ordinal);
		foreach (KeyValuePair<string, string> item in entryMap)
		{
			if (!string.IsNullOrEmpty(item.Key) && !string.IsNullOrEmpty(item.Value))
			{
				dictionary[item.Value] = item.Key;
			}
		}
		_sceneGuidByPrefabGuid = dictionary;
	}
}
