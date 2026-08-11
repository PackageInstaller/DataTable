#define ENABLE_DEBUG_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using UnityEngine;

namespace GameFramework.Runtime;

public class BinaryFilePreferences : Preferences
{
	private string root;

	protected readonly Dictionary<string, string> dict = new Dictionary<string, string>();

	protected readonly ISerializer serializer;

	protected readonly IEncryptor encryptor;

	public BinaryFilePreferences(string name, ISerializer serializer, IEncryptor encryptor)
		: base(name)
	{
		root = Application.persistentDataPath;
		this.serializer = serializer;
		this.encryptor = encryptor;
		Load();
	}

	public virtual StringBuilder GetDirectory()
	{
		StringBuilder stringBuilder = new StringBuilder(root);
		stringBuilder.Append("/").Append(base.Name).Append("/");
		return stringBuilder;
	}

	public virtual StringBuilder GetFullFileName()
	{
		return GetDirectory().Append("prefs.dat");
	}

	protected override void Load()
	{
		try
		{
			string path = GetFullFileName().ToString();
			if (!File.Exists(path))
			{
				return;
			}
			byte[] array = File.ReadAllBytes(path);
			if (array == null || array.Length == 0)
			{
				return;
			}
			if (encryptor != null)
			{
				array = encryptor.Decode(array);
			}
			dict.Clear();
			using MemoryStream input = new MemoryStream(array);
			using BinaryReader binaryReader = new BinaryReader(input);
			int num = binaryReader.ReadInt32();
			for (int i = 0; i < num; i++)
			{
				string key = binaryReader.ReadString();
				string value = binaryReader.ReadString();
				dict.Add(key, value);
			}
		}
		catch (Exception arg)
		{
			Log.Warning("Load failed,{0}", arg);
		}
	}

	public override object GetObject(string key, Type type, object defaultValue)
	{
		if (!dict.ContainsKey(key))
		{
			return defaultValue;
		}
		string text = dict[key];
		if (string.IsNullOrEmpty(text))
		{
			return defaultValue;
		}
		return serializer.Deserialize(text, type);
	}

	public override void SetObject(string key, object value)
	{
		if (value == null)
		{
			dict.Remove(key);
		}
		else
		{
			dict[key] = serializer.Serialize(value);
		}
	}

	public override T GetObject<T>(string key, T defaultValue)
	{
		if (!dict.ContainsKey(key))
		{
			return defaultValue;
		}
		string text = dict[key];
		if (string.IsNullOrEmpty(text))
		{
			return defaultValue;
		}
		return (T)serializer.Deserialize(text, typeof(T));
	}

	public override void SetObject<T>(string key, T value)
	{
		if (value == null)
		{
			dict.Remove(key);
		}
		else
		{
			dict[key] = serializer.Serialize(value);
		}
	}

	public override object[] GetArray(string key, Type type, object[] defaultValue)
	{
		if (!dict.ContainsKey(key))
		{
			return defaultValue;
		}
		string text = dict[key];
		if (string.IsNullOrEmpty(text))
		{
			return defaultValue;
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
		if (values == null || values.Length == 0)
		{
			dict.Remove(key);
			return;
		}
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < values.Length; i++)
		{
			object value = values[i];
			stringBuilder.Append(serializer.Serialize(value));
			if (i < values.Length - 1)
			{
				stringBuilder.Append('|');
			}
		}
		dict[key] = stringBuilder.ToString();
	}

	public override T[] GetArray<T>(string key, T[] defaultValue)
	{
		if (!dict.ContainsKey(key))
		{
			return defaultValue;
		}
		string text = dict[key];
		if (string.IsNullOrEmpty(text))
		{
			return defaultValue;
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
		if (values == null || values.Length == 0)
		{
			dict.Remove(key);
			return;
		}
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < values.Length; i++)
		{
			T val = values[i];
			stringBuilder.Append(serializer.Serialize(val));
			if (i < values.Length - 1)
			{
				stringBuilder.Append('|');
			}
		}
		dict[key] = stringBuilder.ToString();
	}

	public override bool ContainsKey(string key)
	{
		return dict.ContainsKey(key);
	}

	public override void Remove(string key)
	{
		if (dict.ContainsKey(key))
		{
			dict.Remove(key);
		}
	}

	public override void RemoveAll()
	{
		dict.Clear();
	}

	public override void Save()
	{
		if (dict.Count <= 0)
		{
			Delete();
			return;
		}
		Directory.CreateDirectory(GetDirectory().ToString());
		using MemoryStream memoryStream = new MemoryStream();
		using (BinaryWriter binaryWriter = new BinaryWriter(memoryStream))
		{
			binaryWriter.Write(dict.Count);
			foreach (KeyValuePair<string, string> item in dict)
			{
				binaryWriter.Write(item.Key);
				binaryWriter.Write(item.Value);
			}
			binaryWriter.Flush();
		}
		byte[] array = memoryStream.ToArray();
		if (encryptor != null)
		{
			array = encryptor.Encode(array);
		}
		string path = GetFullFileName().ToString();
		File.WriteAllBytes(path, array);
	}

	public override void Delete()
	{
		dict.Clear();
		string path = GetFullFileName().ToString();
		if (File.Exists(path))
		{
			File.Delete(path);
		}
	}
}
