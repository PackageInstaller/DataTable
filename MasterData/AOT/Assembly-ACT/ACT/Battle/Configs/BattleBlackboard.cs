using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

public class BattleBlackboard
{
	private readonly Dictionary<string, object> values = new Dictionary<string, object>();

	private readonly Dictionary<string, AbilityBlackboardValueType> valueTypes = new Dictionary<string, AbilityBlackboardValueType>();

	public bool TryGet<T>(string key, out T value)
	{
		value = default;
		if (string.IsNullOrEmpty(key))
		{
			return false;
		}
		if (!values.TryGetValue(key, out var value2) || !(value2 is T val))
		{
			return false;
		}
		value = val;
		return true;
	}

	public T Get<T>(string key, T fallback = default(T))
	{
		if (!TryGet<T>(key, out var value))
		{
			return fallback;
		}
		return value;
	}

	public bool Set<T>(string key, T value)
	{
		if (string.IsNullOrEmpty(key))
		{
			Debug.LogError(GetType().Name + " failed to write an empty key.");
			return false;
		}
		AbilityBlackboardValueType? valueType = GetValueType<T>();
		if (!valueType.HasValue)
		{
			Debug.LogError(GetType().Name + " key '" + key + "' does not support value type " + typeof(T).Name + ".");
			return false;
		}
		if (valueTypes.TryGetValue(key, out var value2) && value2 != valueType.Value)
		{
			Debug.LogError($"{GetType().Name} key '{key}' type conflict. Existing: {value2}, attempted: {valueType.Value}.");
			return false;
		}
		values[key] = value;
		valueTypes[key] = valueType.Value;
		return true;
	}

	public bool Contains(string key)
	{
		if (!string.IsNullOrEmpty(key))
		{
			return values.ContainsKey(key);
		}
		return false;
	}

	public IEnumerable<KeyValuePair<string, object>> EnumerateEntries()
	{
		foreach (KeyValuePair<string, object> value in values)
		{
			yield return value;
		}
	}

	public bool TryGetValueType(string key, out AbilityBlackboardValueType valueType)
	{
		if (string.IsNullOrEmpty(key))
		{
			valueType = AbilityBlackboardValueType.Float;
			return false;
		}
		return valueTypes.TryGetValue(key, out valueType);
	}

	public void Clear()
	{
		values.Clear();
		valueTypes.Clear();
	}

	protected bool SetInitialValue(string key, AbilityBlackboardValueType valueType, object value)
	{
		if (string.IsNullOrEmpty(key))
		{
			return false;
		}
		if (valueTypes.TryGetValue(key, out var value2) && value2 != valueType)
		{
			Debug.LogError($"{GetType().Name} key '{key}' type conflict. Existing: {value2}, attempted: {valueType}.");
			return false;
		}
		values[key] = value;
		valueTypes[key] = valueType;
		return true;
	}

	private static AbilityBlackboardValueType? GetValueType<T>()
	{
		Type typeFromHandle = typeof(T);
		if (typeFromHandle == typeof(float))
		{
			return AbilityBlackboardValueType.Float;
		}
		if (typeFromHandle == typeof(int))
		{
			return AbilityBlackboardValueType.Int;
		}
		if (typeFromHandle == typeof(bool))
		{
			return AbilityBlackboardValueType.Bool;
		}
		if (typeFromHandle == typeof(string))
		{
			return AbilityBlackboardValueType.String;
		}
		if (typeFromHandle == typeof(Vector3))
		{
			return AbilityBlackboardValueType.Vector3;
		}
		if (typeFromHandle == typeof(EntityReference[]))
		{
			return AbilityBlackboardValueType.EntityReferenceArray;
		}
		return null;
	}
}
