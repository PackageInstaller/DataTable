using System;
using System.Collections.Generic;

namespace GameFramework.Runtime;

public abstract class Preferences
{
	protected static readonly string GLOBAL_NAME;

	protected const char ARRAY_SEPARATOR = '|';

	private static Dictionary<string, Preferences> cache;

	private static IFactory _defaultFactory;

	private static IFactory _factory;

	private string name;

	public string Name
	{
		get
		{
			return name;
		}
		protected set
		{
			name = value;
		}
	}

	static Preferences()
	{
		GLOBAL_NAME = "_GLOBAL_";
		cache = new Dictionary<string, Preferences>();
		_defaultFactory = new PlayerPrefsPreferencesFactory();
	}

	protected static IFactory GetFactory()
	{
		if (_factory != null)
		{
			return _factory;
		}
		return _defaultFactory;
	}

	public static Preferences GetGlobalPreferences()
	{
		return GetPreferences(GLOBAL_NAME);
	}

	public static Preferences GetPreferences(string name)
	{
		if (cache.TryGetValue(name, out var value))
		{
			return value;
		}
		value = GetFactory().Create(name);
		cache[name] = value;
		return value;
	}

	public static void Register(IFactory factory)
	{
		_factory = factory;
	}

	public static void SaveAll()
	{
		foreach (Preferences value in cache.Values)
		{
			value.Save();
		}
	}

	public static void DeleteAll()
	{
		foreach (Preferences value in cache.Values)
		{
			value.Delete();
		}
		cache.Clear();
	}

	public Preferences(string name)
	{
		this.name = name;
		if (string.IsNullOrEmpty(this.name))
		{
			this.name = GLOBAL_NAME;
		}
	}

	protected abstract void Load();

	public string GetString(string key)
	{
		return GetObject<string>(key, null);
	}

	public string GetString(string key, string defaultValue)
	{
		return GetObject(key, defaultValue);
	}

	public void SetString(string key, string value)
	{
		SetObject(key, value);
	}

	public float GetFloat(string key)
	{
		return GetObject(key, 0f);
	}

	public float GetFloat(string key, float defaultValue)
	{
		return GetObject(key, defaultValue);
	}

	public void SetFloat(string key, float value)
	{
		SetObject(key, value);
	}

	public double GetDouble(string key)
	{
		return GetObject(key, 0.0);
	}

	public double GetDouble(string key, double defaultValue)
	{
		return GetObject(key, defaultValue);
	}

	public void SetDouble(string key, double value)
	{
		SetObject(key, value);
	}

	public bool GetBool(string key)
	{
		return GetObject(key, defaultValue: false);
	}

	public bool GetBool(string key, bool defaultValue)
	{
		return GetObject(key, defaultValue);
	}

	public void SetBool(string key, bool value)
	{
		SetObject(key, value);
	}

	public int GetInt(string key)
	{
		return GetObject(key, 0);
	}

	public int GetInt(string key, int defaultValue)
	{
		return GetObject(key, defaultValue);
	}

	public void SetInt(string key, int value)
	{
		SetObject(key, value);
	}

	public long GetLong(string key)
	{
		return GetObject(key, 0L);
	}

	public long GetLong(string key, long defaultValue)
	{
		return GetObject(key, defaultValue);
	}

	public void SetLong(string key, long value)
	{
		SetObject(key, value);
	}

	public object GetObject(string key, Type type)
	{
		return GetObject(key, type, null);
	}

	public abstract object GetObject(string key, Type type, object defaultValue);

	public abstract void SetObject(string key, object value);

	public T GetObject<T>(string key)
	{
		return GetObject(key, default(T));
	}

	public abstract T GetObject<T>(string key, T defaultValue);

	public abstract void SetObject<T>(string key, T value);

	public object[] GetArray(string key, Type type)
	{
		return GetArray(key, type, null);
	}

	public abstract object[] GetArray(string key, Type type, object[] defaultValue);

	public abstract void SetArray(string key, object[] values);

	public T[] GetArray<T>(string key)
	{
		return GetArray<T>(key, null);
	}

	public abstract T[] GetArray<T>(string key, T[] defaultValue);

	public abstract void SetArray<T>(string key, T[] values);

	public abstract bool ContainsKey(string key);

	public abstract void Remove(string key);

	public abstract void RemoveAll();

	public abstract void Save();

	public abstract void Delete();
}
