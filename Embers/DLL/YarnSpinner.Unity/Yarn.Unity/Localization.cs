using System;
using System.Collections.Generic;
using UnityEngine;

namespace Yarn.Unity;

public class Localization : ScriptableObject
{
	[Serializable]
	private class StringDictionary : SerializedDictionary<string, string>
	{
	}

	[Serializable]
	private class AssetDictionary : SerializedDictionary<string, UnityEngine.Object>
	{
	}

	[SerializeField]
	private string _LocaleCode;

	[SerializeField]
	private StringDictionary _stringTable = new StringDictionary();

	[SerializeField]
	private AssetDictionary _assetTable = new AssetDictionary();

	private Dictionary<string, string> _runtimeStringTable = new Dictionary<string, string>();

	[SerializeField]
	private bool _containsLocalizedAssets;

	[SerializeField]
	private bool _usesAddressableAssets;

	public string LocaleCode
	{
		get
		{
			return _LocaleCode;
		}
		set
		{
			_LocaleCode = value;
		}
	}

	public bool ContainsLocalizedAssets
	{
		get
		{
			return _containsLocalizedAssets;
		}
		internal set
		{
			_containsLocalizedAssets = value;
		}
	}

	public bool UsesAddressableAssets
	{
		get
		{
			return _usesAddressableAssets;
		}
		internal set
		{
			_usesAddressableAssets = value;
		}
	}

	internal static string GetAddressForLine(string lineID, string language)
	{
		return "line_" + language + "_" + lineID.Replace("line:", "");
	}

	public string GetLocalizedString(string key)
	{
		if (_runtimeStringTable.TryGetValue(key, out var value))
		{
			return value;
		}
		if (_stringTable.TryGetValue(key, out value))
		{
			return value;
		}
		return null;
	}

	public bool ContainsLocalizedString(string key)
	{
		if (!_runtimeStringTable.ContainsKey(key))
		{
			return _stringTable.ContainsKey(key);
		}
		return true;
	}

	internal void AddLocalisedStringToAsset(string key, string value)
	{
		_stringTable.Add(key, value);
	}

	public void AddLocalizedString(string key, string value)
	{
		_runtimeStringTable.Add(key, value);
	}

	public void AddLocalizedStrings(IEnumerable<KeyValuePair<string, string>> strings)
	{
		foreach (KeyValuePair<string, string> @string in strings)
		{
			AddLocalizedString(@string.Key, @string.Value);
		}
	}

	public void AddLocalizedStrings(IEnumerable<StringTableEntry> stringTableEntries)
	{
		foreach (StringTableEntry stringTableEntry in stringTableEntries)
		{
			AddLocalizedString(stringTableEntry.ID, stringTableEntry.Text);
		}
	}

	public T GetLocalizedObject<T>(string key) where T : UnityEngine.Object
	{
		if (_usesAddressableAssets)
		{
			Debug.LogWarning("Localization " + base.name + " uses addressable assets. Use the Addressable Assets API to load the asset.");
		}
		_assetTable.TryGetValue(key, out var value);
		if (value is T result)
		{
			return result;
		}
		return null;
	}

	public void SetLocalizedObject<T>(string key, T value) where T : UnityEngine.Object
	{
		_assetTable.Add(key, value);
	}

	public bool ContainsLocalizedObject<T>(string key) where T : UnityEngine.Object
	{
		if (_assetTable.ContainsKey(key))
		{
			return _assetTable[key] is T;
		}
		return false;
	}

	public void AddLocalizedObject<T>(string key, T value) where T : UnityEngine.Object
	{
		_assetTable.Add(key, value);
	}

	public void AddLocalizedObjects<T>(IEnumerable<KeyValuePair<string, T>> objects) where T : UnityEngine.Object
	{
		foreach (KeyValuePair<string, T> @object in objects)
		{
			_assetTable.Add(@object.Key, @object.Value);
		}
	}

	public virtual void Clear()
	{
		_stringTable.Clear();
		_assetTable.Clear();
		_runtimeStringTable.Clear();
	}

	public IEnumerable<string> GetLineIDs()
	{
		List<string> list = new List<string>();
		Dictionary<string, string>.KeyCollection keys = _runtimeStringTable.Keys;
		ICollection<string> keys2 = _stringTable.Keys;
		list.AddRange(keys);
		list.AddRange(keys2);
		return list;
	}
}
