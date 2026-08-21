using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using Google.Protobuf;
using UnityEngine;

public class ConfigHelper
{
	private class ConfigKeyComparer : IEqualityComparer<int>
	{
		public bool Equals(int x, int y)
		{
			return x == y;
		}

		public int GetHashCode(int obj)
		{
			return obj;
		}
	}

	private static ConfigHelper _instance;

	public bool gcWhileParseFromData;

	private Dictionary<Type, Dictionary<int, LineData>> _data = new Dictionary<Type, Dictionary<int, LineData>>();

	public Dictionary<Type, TableData> cachedBytes = new Dictionary<Type, TableData>();

	public static ConfigHelper GetInstance()
	{
		if (_instance == null)
		{
			_instance = new ConfigHelper();
		}
		return _instance;
	}

	public void Initialize(string path)
	{
		BinaryReader binaryReader = null;
		using FileStream input = new FileStream(path, FileMode.Open);
		binaryReader = new BinaryReader(input);
		Initialize(binaryReader);
	}

	public void Initialize(BinaryReader binaryReader)
	{
		int num = binaryReader.ReadInt32();
		for (int i = 0; i < num; i++)
		{
			if (gcWhileParseFromData)
			{
				GC.Collect();
			}
			int count = binaryReader.ReadInt32();
			byte[] array = binaryReader.ReadBytes(count);
			BinaryReader binaryReader2 = new BinaryReader(new MemoryStream(array));
			int num2 = binaryReader2.ReadInt32();
			if (0 < num2)
			{
				int count2 = binaryReader2.ReadInt32();
				string text = new string(binaryReader2.ReadChars(count2));
				string typeName = "Config." + text;
				Type type = Type.GetType(typeName);
				PropertyInfo property = type.GetProperty("Parser");
				MessageParser parser = property.GetValue(null) as MessageParser;
				TableData tableData = new TableData();
				tableData.parser = parser;
				tableData.bytes = array;
				cachedBytes[type] = tableData;
			}
		}
	}

	public void ParseTargetType(Type t)
	{
		if (_data.ContainsKey(t))
		{
			return;
		}
		if (!cachedBytes.TryGetValue(t, out var value) || value.bytes == null)
		{
			return;
		}
		if (gcWhileParseFromData)
		{
			GC.Collect();
		}
		Dictionary<int, LineData> dictionary = new Dictionary<int, LineData>(new IntComparer());
		using (MemoryStream input = new MemoryStream(value.bytes))
		{
			using BinaryReader binaryReader = new BinaryReader(input);
			int num = binaryReader.ReadInt32();
			if (0 >= num)
			{
				return;
			}
			int count = binaryReader.ReadInt32();
			binaryReader.ReadChars(count);
			for (int i = 0; i < num; i++)
			{
				int num2 = binaryReader.ReadInt32();
				int count2 = binaryReader.ReadInt32();
				byte[] bytes = binaryReader.ReadBytes(count2);
				try
				{
					int key = num2;
					dictionary[key] = new LineData(bytes);
				}
				catch (Exception ex)
				{
					Debug.LogError((object)(ex.StackTrace + ex.Message));
				}
			}
		}
		_data[t] = dictionary;
	}

	public void ClearData()
	{
		_data.Clear();
	}

	public Dictionary<Type, Dictionary<int, LineData>> GetData()
	{
		return _data;
	}

	public void RemoveType(Type t)
	{
		if (_data.ContainsKey(t))
		{
			_data.Remove(t);
		}
	}

	public T GetConfig<T>(int id) where T : IMessage
	{
		Type typeFromHandle = typeof(T);
		ParseTargetType(typeFromHandle);
		if (_data.TryGetValue(typeFromHandle, out var value) && value.TryGetValue(id, out var value2))
		{
			return (T)value2.GetMessage(cachedBytes[typeFromHandle].parser, gcWhileParseFromData);
		}
		Debug.LogError((object)(typeof(T)?.ToString() + "'s ID: " + id + " don't exist!!"));
		return default(T);
	}

	public bool TryGetConfig<T>(int id, out T config) where T : IMessage
	{
		config = default(T);
		Type typeFromHandle = typeof(T);
		ParseTargetType(typeFromHandle);
		if (_data.TryGetValue(typeFromHandle, out var value) && value.TryGetValue(id, out var value2))
		{
			config = (T)value2.GetMessage(cachedBytes[typeFromHandle].parser, gcWhileParseFromData);
			return true;
		}
		return false;
	}

	public bool HasConfig<T>(int id) where T : IMessage
	{
		Type typeFromHandle = typeof(T);
		ParseTargetType(typeFromHandle);
		Dictionary<int, LineData> value = null;
		LineData value2 = null;
		if (_data.TryGetValue(typeFromHandle, out value))
		{
			return value.TryGetValue(id, out value2);
		}
		return false;
	}

	public Dictionary<int, IMessage> GetAllConfig(Type t, Dictionary<int, IMessage> inputDict = null)
	{
		ParseTargetType(t);
		_data.TryGetValue(t, out var value);
		if (inputDict == null)
		{
			inputDict = new Dictionary<int, IMessage>();
		}
		if (gcWhileParseFromData)
		{
			GC.Collect();
		}
		if (value != null && value.Count > 0)
		{
			inputDict.Clear();
			MessageParser parser = cachedBytes[t].parser;
			foreach (KeyValuePair<int, LineData> item in value)
			{
				inputDict.Add(item.Key, item.Value.GetMessage(parser));
			}
		}
		return inputDict;
	}
}
