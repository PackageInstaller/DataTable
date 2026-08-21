using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine;

namespace GameFramework.Runtime;

public class PlayerPrefsPreferences : Preferences
{
	protected static readonly string KEYS = "_KEYS_";

	protected readonly ISerializer serializer;

	protected readonly IEncryptor encryptor;

	protected readonly List<string> keys = new List<string>();

	public PlayerPrefsPreferences(string name, ISerializer serializer, IEncryptor encryptor)
		: base(name)
	{
		this.serializer = serializer;
		this.encryptor = encryptor;
		Load();
	}

	protected override void Load()
	{
		LoadKeys();
	}

	protected string Key(string key)
	{
		StringBuilder stringBuilder = new StringBuilder(base.Name);
		stringBuilder.Append(".").Append(key);
		return stringBuilder.ToString();
	}

	protected virtual void LoadKeys()
	{
		if (!PlayerPrefs.HasKey(Key(KEYS)))
		{
			return;
		}
		string text = PlayerPrefs.GetString(Key(KEYS));
		if (string.IsNullOrEmpty(text))
		{
			return;
		}
		string[] array = text.Split(new string[1] { "," }, StringSplitOptions.RemoveEmptyEntries);
		string[] array2 = array;
		foreach (string text2 in array2)
		{
			if (!string.IsNullOrEmpty(text2))
			{
				keys.Add(text2);
			}
		}
	}

	protected virtual void SaveKeys()
	{
		if (keys == null || keys.Count <= 0)
		{
			PlayerPrefs.DeleteKey(Key(KEYS));
			return;
		}
		string[] array = keys.ToArray();
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < array.Length; i++)
		{
			if (!string.IsNullOrEmpty(array[i]))
			{
				stringBuilder.Append(array[i]);
				if (i < array.Length - 1)
				{
					stringBuilder.Append(",");
				}
			}
		}
		PlayerPrefs.SetString(Key(KEYS), stringBuilder.ToString());
	}

	public override object GetObject(string key, Type type, object defaultValue)
	{
		if (!PlayerPrefs.HasKey(Key(key)))
		{
			return defaultValue;
		}
		string text = PlayerPrefs.GetString(Key(key));
		if (string.IsNullOrEmpty(text))
		{
			return defaultValue;
		}
		if (encryptor != null)
		{
			byte[] cipherData = Convert.FromBase64String(text);
			cipherData = encryptor.Decode(cipherData);
			text = Encoding.UTF8.GetString(cipherData);
		}
		return serializer.Deserialize(text, type);
	}

	public override void SetObject(string key, object value)
	{
		string text = ((value == null) ? "" : serializer.Serialize(value));
		if (encryptor != null)
		{
			byte[] bytes = Encoding.UTF8.GetBytes(text);
			bytes = encryptor.Encode(bytes);
			text = Convert.ToBase64String(bytes);
		}
		PlayerPrefs.SetString(Key(key), text);
		if (!keys.Contains(key))
		{
			keys.Add(key);
			SaveKeys();
		}
	}

	public override T GetObject<T>(string key, T defaultValue)
	{
		if (!PlayerPrefs.HasKey(Key(key)))
		{
			return defaultValue;
		}
		string text = PlayerPrefs.GetString(Key(key));
		if (string.IsNullOrEmpty(text))
		{
			return defaultValue;
		}
		if (encryptor != null)
		{
			byte[] cipherData = Convert.FromBase64String(text);
			cipherData = encryptor.Decode(cipherData);
			text = Encoding.UTF8.GetString(cipherData);
		}
		return (T)serializer.Deserialize(text, typeof(T));
	}

	public override void SetObject<T>(string key, T value)
	{
		string text = ((value == null) ? "" : serializer.Serialize(value));
		if (encryptor != null)
		{
			byte[] bytes = Encoding.UTF8.GetBytes(text);
			bytes = encryptor.Encode(bytes);
			text = Convert.ToBase64String(bytes);
		}
		PlayerPrefs.SetString(Key(key), text);
		if (!keys.Contains(key))
		{
			keys.Add(key);
			SaveKeys();
		}
	}

	public override object[] GetArray(string key, Type type, object[] defaultValue)
	{
		if (!PlayerPrefs.HasKey(Key(key)))
		{
			return defaultValue;
		}
		string text = PlayerPrefs.GetString(Key(key));
		if (string.IsNullOrEmpty(text))
		{
			return defaultValue;
		}
		if (encryptor != null)
		{
			byte[] cipherData = Convert.FromBase64String(text);
			cipherData = encryptor.Decode(cipherData);
			text = Encoding.UTF8.GetString(cipherData);
		}
		string[] array = text.Split(new char[1] { '|' });
		List<object> list = new List<object>();
		for (int i = 0; i < array.Length; i++)
		{
			string value = array[i];
			if (string.IsNullOrEmpty(value))
			{
				list.Add(null);
			}
			else
			{
				list.Add(serializer.Deserialize(array[i], type));
			}
		}
		return list.ToArray();
	}

	public override void SetArray(string key, object[] values)
	{
		StringBuilder stringBuilder = new StringBuilder();
		if (values != null && values.Length != 0)
		{
			for (int i = 0; i < values.Length; i++)
			{
				object value = values[i];
				stringBuilder.Append(serializer.Serialize(value));
				if (i < values.Length - 1)
				{
					stringBuilder.Append('|');
				}
			}
		}
		string text = stringBuilder.ToString();
		if (encryptor != null)
		{
			byte[] bytes = Encoding.UTF8.GetBytes(text);
			bytes = encryptor.Encode(bytes);
			text = Convert.ToBase64String(bytes);
		}
		PlayerPrefs.SetString(Key(key), text);
		if (!keys.Contains(key))
		{
			keys.Add(key);
			SaveKeys();
		}
	}

	public override T[] GetArray<T>(string key, T[] defaultValue)
	{
		if (!PlayerPrefs.HasKey(Key(key)))
		{
			return defaultValue;
		}
		string text = PlayerPrefs.GetString(Key(key));
		if (string.IsNullOrEmpty(text))
		{
			return defaultValue;
		}
		if (encryptor != null)
		{
			byte[] cipherData = Convert.FromBase64String(text);
			cipherData = encryptor.Decode(cipherData);
			text = Encoding.UTF8.GetString(cipherData);
		}
		string[] array = text.Split(new char[1] { '|' });
		List<T> list = new List<T>();
		for (int i = 0; i < array.Length; i++)
		{
			string value = array[i];
			if (string.IsNullOrEmpty(value))
			{
				list.Add(default(T));
			}
			else
			{
				list.Add((T)serializer.Deserialize(array[i], typeof(T)));
			}
		}
		return list.ToArray();
	}

	public override void SetArray<T>(string key, T[] values)
	{
		StringBuilder stringBuilder = new StringBuilder();
		if (values != null && values.Length != 0)
		{
			for (int i = 0; i < values.Length; i++)
			{
				T val = values[i];
				stringBuilder.Append(serializer.Serialize(val));
				if (i < values.Length - 1)
				{
					stringBuilder.Append('|');
				}
			}
		}
		string text = stringBuilder.ToString();
		if (encryptor != null)
		{
			byte[] bytes = Encoding.UTF8.GetBytes(text);
			bytes = encryptor.Encode(bytes);
			text = Convert.ToBase64String(bytes);
		}
		PlayerPrefs.SetString(Key(key), text);
		if (!keys.Contains(key))
		{
			keys.Add(key);
			SaveKeys();
		}
	}

	public override bool ContainsKey(string key)
	{
		return PlayerPrefs.HasKey(Key(key));
	}

	public override void Remove(string key)
	{
		PlayerPrefs.DeleteKey(Key(key));
		if (keys.Contains(key))
		{
			keys.Remove(key);
			SaveKeys();
		}
	}

	public override void RemoveAll()
	{
		foreach (string key in keys)
		{
			PlayerPrefs.DeleteKey(Key(key));
		}
		PlayerPrefs.DeleteKey(Key(KEYS));
		keys.Clear();
	}

	public override void Save()
	{
		PlayerPrefs.Save();
	}

	public override void Delete()
	{
		RemoveAll();
		PlayerPrefs.Save();
	}
}
