using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using Fundamental;
using UnityEngine;

namespace ACT.CharacterProperty;

public class RuntimeCharacterProperty
{
	private Dictionary<int, float> _properties;

	private bool isInitliazed;

	private Dictionary<int, float> _resultProperties;

	private Dictionary<int, float> _basePropertyValues;

	private Dictionary<long, float> _systemProperties;

	public Character beLongedCharacter { get; private set; }

	public Dictionary<int, float> properties => _properties;

	public Dictionary<int, float> resultProperties => _resultProperties;

	public float this[int propertyId, SystemPropertySource source]
	{
		get
		{
			return _systemProperties.GetValueOrDefault(MakeKey(propertyId, source), 0f);
		}
		set
		{
			_systemProperties[MakeKey(propertyId, source)] = value;
		}
	}

	private long MakeKey(int propertyId, SystemPropertySource source)
	{
		return ((long)propertyId << 32) | (uint)source;
	}

	private static SystemPropertySource GetSourceFromKey(long key)
	{
		return (SystemPropertySource)key;
	}

	private static int GetPropertyIdFromKey(long key)
	{
		return (int)(key >> 32);
	}

	private RuntimeCharacterProperty()
	{
		_properties = DictionaryPool<int, float>.Get();
		_systemProperties = DictionaryPool<long, float>.Get();
		_resultProperties = DictionaryPool<int, float>.Get();
		_basePropertyValues = DictionaryPool<int, float>.Get();
	}

	public RuntimeCharacterProperty(Character c)
		: this()
	{
		InitBaseProperty(c);
	}

	private void InitBaseProperty(Character c)
	{
		if (isInitliazed)
		{
			return;
		}
		isInitliazed = true;
		beLongedCharacter = c;
		EntityCharacterData entityCharacterData = RuntimeConfigs.data.entityCharacterDatas[c.Id];
		foreach (KeyValuePair<int, PropertyData> propertyData in RuntimeConfigs.data.propertyDatas)
		{
			_properties[propertyData.Key] = 0f;
			foreach (SystemPropertySource value in Enum.GetValues(typeof(SystemPropertySource)))
			{
				if (value != SystemPropertySource.None)
				{
					this[propertyData.Key, value] = 0f;
				}
			}
		}
		c.systemProperty = this;
		foreach (Properties item in entityCharacterData.characterPorpertyBase)
		{
			_properties[item.property] = item.value;
			PropertyData data = CoreUtils.GetData(item.property, RuntimeConfigs.data.propertyDatas);
			_resultProperties[data.propertyId] = item.value;
			_basePropertyValues[data.propertyId] = item.value;
			SystemPropertyChange evt = Singleton<EventManager>.instance.GetEvt<SystemPropertyChange>();
			evt.systemSource = SystemPropertySource.LevelUp;
			evt.propertyId = data.propertyId;
			evt.changeVal = item.value;
			evt.beLongCharacter = c;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.SystemPropertyChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	~RuntimeCharacterProperty()
	{
		isInitliazed = false;
		beLongedCharacter = null;
		DictionaryPool<int, float>.Release(_properties);
		DictionaryPool<int, float>.Release(_resultProperties);
		DictionaryPool<long, float>.Release(_systemProperties);
		DictionaryPool<int, float>.Release(_basePropertyValues);
	}

	public bool GetSystemPropertyValue(int propertyId, SystemPropertySource source, out float value)
	{
		return _systemProperties.TryGetValue(MakeKey(propertyId, source), out value);
	}

	public void ReplaceSystemProperty(int propertyId, float value, SystemPropertySource source)
	{
		if (source == SystemPropertySource.None)
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		if (CoreUtils.GetData(propertyId, RuntimeConfigs.data.propertyDatas) == null)
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		float before = this[propertyId, source];
		this[propertyId, source] = value;
		SetPropertyValue(source, propertyId, value, before);
	}

	public void CalSystemProperty(int propertyId, int source, float value, bool remove = false)
	{
		if (source == 0)
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		if (CoreUtils.GetData(propertyId, RuntimeConfigs.data.propertyDatas) == null)
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		float before = this[propertyId, (SystemPropertySource)source];
		float num = 0f;
		if (remove)
		{
			if (Mathf.Approximately(this[propertyId, (SystemPropertySource)source], 0f))
			{
				return;
			}
			num = (this[propertyId, (SystemPropertySource)source] -= value);
		}
		else
		{
			num = (this[propertyId, (SystemPropertySource)source] += value);
		}
		SetPropertyValue((SystemPropertySource)source, propertyId, num, before);
	}

	public void CalSystemProperties(Dictionary<int, float> changes, int source, bool remove = false)
	{
		if (changes == null || changes.Count <= 0)
		{
			return;
		}
		foreach (KeyValuePair<int, float> change in changes)
		{
			CalSystemProperty(change.Key, source, change.Value, remove);
		}
	}

	public void ReplaceSystemProperties(Dictionary<int, float> changes, SystemPropertySource source)
	{
		if (changes == null || changes.Count <= 0)
		{
			return;
		}
		foreach (KeyValuePair<int, float> change in changes)
		{
			ReplaceSystemProperty(change.Key, change.Value, source);
		}
	}

	private void SetPropertyValue(SystemPropertySource source, int propertyId, float val, float before)
	{
		if (before != 0f)
		{
			_properties[propertyId] -= before;
		}
		_properties[propertyId] += val;
		CalPropertiesResult(propertyId);
		SystemPropertyChange evt = Singleton<EventManager>.instance.GetEvt<SystemPropertyChange>();
		evt.systemSource = source;
		evt.propertyId = propertyId;
		evt.changeVal = MathF.Abs(val - before);
		evt.isReduce = before > val;
		evt.beLongCharacter = beLongedCharacter;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.SystemPropertyChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void CalPropertiesResult(int propertyId)
	{
		if (!_properties.ContainsKey(propertyId))
		{
			return;
		}
		PropertyData data = CoreUtils.GetData(propertyId, RuntimeConfigs.data.propertyDatas);
		if (data == null)
		{
			return;
		}
		int propertyId2 = data.propertyId;
		int key = propertyId2 * 100;
		if (!_properties.TryGetValue(key, out var value))
		{
			return;
		}
		float num = 0f;
		float num2 = 0f;
		foreach (KeyValuePair<int, PropertyData> propertyData in RuntimeConfigs.data.propertyDatas)
		{
			PropertyData value2 = propertyData.Value;
			if (value2.propertyId == propertyId2 && _properties.TryGetValue(propertyData.Key, out var value3))
			{
				switch (value2.subType)
				{
				case 1:
					num = value3;
					break;
				case 2:
					num2 = value3;
					break;
				}
			}
		}
		_basePropertyValues[propertyId2] = value;
		_resultProperties[propertyId2] = value * (1f + num2) + num;
	}

	public float GetBaseResultPropertyValue(int propertyTypeId)
	{
		if (!_basePropertyValues.TryGetValue(propertyTypeId, out var value))
		{
			return 0f;
		}
		return value;
	}

	public float GetResultPropertyValue(int propertyTypeId)
	{
		if (!resultProperties.TryGetValue(propertyTypeId, out var value))
		{
			return 0f;
		}
		return value;
	}

	public void GetAllSystemPropertiesWithoutZero(ref Dictionary<int, float> properties)
	{
		properties.Clear();
		foreach (KeyValuePair<int, float> property in _properties)
		{
			if (property.Value != 0f)
			{
				properties.Add(property.Key, property.Value);
			}
		}
	}

	public void ClearSystemPropertiesBySource(SystemPropertySource source)
	{
		if (source == SystemPropertySource.None)
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		List<long> list = ListPool<long>.Get();
		foreach (KeyValuePair<long, float> systemProperty in _systemProperties)
		{
			if (GetSourceFromKey(systemProperty.Key) == source && systemProperty.Value != 0f)
			{
				list.Add(systemProperty.Key);
			}
		}
		foreach (long item in list)
		{
			int propertyIdFromKey = GetPropertyIdFromKey(item);
			float before = _systemProperties[item];
			_systemProperties[item] = 0f;
			SetPropertyValue(source, propertyIdFromKey, 0f, before);
		}
		ListPool<long>.Release(list);
	}

	public void GetSystemPropertiesBySource(SystemPropertySource source, ref Dictionary<int, float> properties, bool withoutZero = false)
	{
		properties.Clear();
		foreach (KeyValuePair<long, float> systemProperty in _systemProperties)
		{
			if (GetSourceFromKey(systemProperty.Key) == source)
			{
				int propertyIdFromKey = GetPropertyIdFromKey(systemProperty.Key);
				if (!withoutZero || systemProperty.Value != 0f)
				{
					properties[propertyIdFromKey] = systemProperty.Value;
				}
			}
		}
	}

	public void GetPropertyTypesBySource(SystemPropertySource source, Dictionary<int, float> propertyTypesValues)
	{
		Dictionary<int, float> dictionary = DictionaryPool<int, float>.Get();
		GetSystemPropertiesBySource(source, ref dictionary);
		Dictionary<int, HashSet<int>> dictionary2 = DictionaryPool<int, HashSet<int>>.Get();
		foreach (KeyValuePair<int, PropertyData> propertyData in RuntimeConfigs.data.propertyDatas)
		{
			int propertyId = propertyData.Value.propertyId;
			if (!dictionary2.TryGetValue(propertyId, out var value))
			{
				value = (dictionary2[propertyId] = HashSetPool<int>.Get());
			}
			value.Add(propertyData.Key);
		}
		foreach (KeyValuePair<int, HashSet<int>> item in dictionary2)
		{
			int key = item.Key;
			float num = 0f;
			float num2 = 0f;
			float num3 = 0f;
			foreach (int item2 in item.Value)
			{
				float num4 = dictionary[item2];
				switch (CoreUtils.GetData(item2, RuntimeConfigs.data.propertyDatas).subType)
				{
				case 0:
					num = num4;
					break;
				case 1:
					num2 = num4;
					break;
				case 2:
					num3 = num4;
					break;
				}
			}
			float baseResultPropertyValue = GetBaseResultPropertyValue(item.Key);
			propertyTypesValues[key] = num + num2 + baseResultPropertyValue * num3;
		}
		foreach (KeyValuePair<int, HashSet<int>> item3 in dictionary2)
		{
			if (item3.Value != null)
			{
				HashSetPool<int>.Release(item3.Value);
			}
		}
		DictionaryPool<int, HashSet<int>>.Release(dictionary2);
		DictionaryPool<int, float>.Release(dictionary);
	}

	private void SendSystemPropertyChanged(int id, float value, bool isReduce)
	{
	}
}
