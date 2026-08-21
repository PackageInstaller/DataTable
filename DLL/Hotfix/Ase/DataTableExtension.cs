#define ENABLE_ERROR_AND_ABOVE_LOG
#define ENABLE_LOG
using System;
using System.Collections.Generic;
using System.IO;
using GameFramework;
using GameFramework.DataTable;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public static class DataTableExtension
{
	private const string DataRowClassPrefixName = "Ase.DR";

	public static readonly char[] DataSplitSeparators = new char[1] { '\t' };

	public static readonly char[] DataTrimSeparators = new char[1] { '"' };

	public static string DATA_TABLE_PREFIX_NAME = "Ase.DR";

	public static void LoadDataTable(this DataTableComponent dataTableComponent, string dataTableName, LoadType loadType, IPromise promise = null, object userData = null)
	{
		if (string.IsNullOrEmpty(dataTableName))
		{
			return;
		}
		string[] array = dataTableName.Split('_');
		if (array.Length > 2)
		{
			return;
		}
		Type type = Type.GetType("Ase.DR" + array[0]);
		if (!(type == null))
		{
			string tableName = ((array.Length > 1) ? array[1] : null);
			DataTableBase dataTableBase = dataTableComponent.CreateDataTable(type, tableName);
			dataTableBase.ReadData(AssetUtility.GetDataTableAsset(dataTableName, loadType), 100, userData, "DataTables");
			dataTableBase.ReadDataSuccess += delegate
			{
				promise?.SetResult(true);
			};
		}
	}

	public static string GetLanguageKeyword(string keyWorld, string typeName)
	{
		if (keyWorld.Equals("Enum"))
		{
			return typeName;
		}
		if (keyWorld.Equals("ListEnum"))
		{
			return "List<" + typeName + ">";
		}
		return keyWorld;
	}

	public static void DestroyDataTable(this DataTableComponent dataTableComponent, string dataTableName)
	{
		if (string.IsNullOrEmpty(dataTableName))
		{
			return;
		}
		string[] array = dataTableName.Split('_');
		if (array.Length <= 2)
		{
			Type type = Type.GetType(DATA_TABLE_PREFIX_NAME + array[0]);
			if (!(type == null))
			{
				dataTableComponent.DestroyDataTable(type, string.Empty);
			}
		}
	}

	public static Color32 ParseColor32(string value)
	{
		string[] array = value.Split(',');
		return new Color32(byte.Parse(array[0]), byte.Parse(array[1]), byte.Parse(array[2]), byte.Parse(array[3]));
	}

	public static Color ParseColor(string value)
	{
		string[] array = value.Split(',');
		return new Color(float.Parse(array[0]), float.Parse(array[1]), float.Parse(array[2]), float.Parse(array[3]));
	}

	public static Quaternion ParseQuaternion(string value)
	{
		string[] array = value.Split(',');
		return new Quaternion(float.Parse(array[0]), float.Parse(array[1]), float.Parse(array[2]), float.Parse(array[3]));
	}

	public static Rect ParseRect(string value)
	{
		string[] array = value.Split(',');
		return new Rect(float.Parse(array[0]), float.Parse(array[1]), float.Parse(array[2]), float.Parse(array[3]));
	}

	public static Vector2 ParseVector2(string value)
	{
		string[] array = value.Split(',');
		return new Vector2(float.Parse(array[0]), float.Parse(array[1]));
	}

	public static Vector3 ParseVector3(string value)
	{
		string[] array = value.Split(',');
		return new Vector3(float.Parse(array[0]), float.Parse(array[1]), float.Parse(array[2]));
	}

	public static Vector4 ParseVector4(string value)
	{
		string[] array = value.Split(',');
		return new Vector4(float.Parse(array[0]), float.Parse(array[1]), float.Parse(array[2]), float.Parse(array[3]));
	}

	public static List<int> ParseListInt(string value)
	{
		List<int> list = new List<int>();
		if (value == null || value.Trim() == string.Empty)
		{
			return list;
		}
		try
		{
			string[] array = value.Split(',');
			foreach (string s in array)
			{
				list.Add(int.Parse(s));
			}
			return list;
		}
		catch (Exception ex)
		{
			Log.Error("Parse List<int> error , content = " + value + " , msg:" + ex.Message);
			throw;
		}
	}

	public static List<bool> ParseListBool(string value)
	{
		List<bool> list = new List<bool>();
		if (value == null || value.Trim() == string.Empty)
		{
			return list;
		}
		try
		{
			string[] array = value.Split(',');
			foreach (string value2 in array)
			{
				list.Add(bool.Parse(value2));
			}
			return list;
		}
		catch (Exception ex)
		{
			Log.Error("Parse List<bool> error , content = " + value + " , msg:" + ex.Message);
			throw;
		}
	}

	public static T ParseEnum<T>(string value) where T : struct
	{
		if (Enum.TryParse<T>(value, out var result))
		{
			return result;
		}
		if (string.IsNullOrEmpty(value))
		{
			return (T)Enum.GetValues(typeof(T)).GetValue(0);
		}
		Log.Error($"Parse enum<{typeof(T)}> error. parse data = {value}");
		return (T)Enum.GetValues(typeof(T)).GetValue(0);
	}

	public static List<T> ParseListEnum<T>(string value) where T : struct
	{
		List<T> list = new List<T>();
		foreach (string item in ParseListString(value))
		{
			if (Enum.TryParse<T>(item, out var result))
			{
				list.Add(result);
				continue;
			}
			Log.Error($"Parse ListEnum<{typeof(T)}> error. parse data = {item}");
			list.Add((T)Enum.GetValues(typeof(T)).GetValue(0));
		}
		return list;
	}

	public static List<string> ParseListString(string content)
	{
		List<string> list = new List<string>();
		if (string.IsNullOrEmpty(content))
		{
			return list;
		}
		try
		{
			string[] array;
			if (content.EndsWith('|') && content.StartsWith('|'))
			{
				content = content.Trim('|');
				array = content.Split('|');
			}
			else
			{
				array = content.Split(',');
			}
			string[] array2 = array;
			foreach (string item in array2)
			{
				list.Add(item);
			}
			return list;
		}
		catch (Exception ex)
		{
			Log.Error("Parse List<string> error , content = " + content + ", msg:" + ex.Message);
			throw;
		}
	}

	public static List<float> ParseListFloat(string readString)
	{
		List<float> list = new List<float>();
		if (string.IsNullOrEmpty(readString))
		{
			return list;
		}
		try
		{
			string[] array = readString.Split(',');
			foreach (string s in array)
			{
				list.Add(float.Parse(s));
			}
			return list;
		}
		catch (Exception ex)
		{
			Log.Error("Parse List<float> error , content = " + readString + ", msg:" + ex.Message);
			throw;
		}
	}

	public static List<List<string>> ParseListStringList(string content)
	{
		List<List<string>> list = new List<List<string>>();
		if (string.IsNullOrEmpty(content))
		{
			return list;
		}
		try
		{
			string[] array = content.Split('|');
			for (int i = 0; i < array.Length; i++)
			{
				List<string> list2 = new List<string>();
				string[] array2 = array[i].Split(',');
				foreach (string item in array2)
				{
					list2.Add(item);
				}
				list.Add(list2);
			}
			return list;
		}
		catch (Exception ex)
		{
			Log.Error("Parse List<List<string>> error , content = " + content + ", msg:" + ex.Message);
			throw;
		}
	}

	public static List<List<string>> ParseListsSemicolonStringList(string content)
	{
		List<List<string>> list = new List<List<string>>();
		if (string.IsNullOrEmpty(content))
		{
			return list;
		}
		try
		{
			string[] array = content.Split(';');
			for (int i = 0; i < array.Length; i++)
			{
				List<string> list2 = new List<string>();
				string[] array2 = array[i].Split(',');
				foreach (string item in array2)
				{
					list2.Add(item);
				}
				list.Add(list2);
			}
			return list;
		}
		catch (Exception ex)
		{
			Log.Error("Parse List<List<string>> error , content = " + content + ", msg:" + ex.Message);
			throw;
		}
	}

	public static List<List<float>> ParseListsSemicolonFloatList(string content)
	{
		List<List<float>> list = new List<List<float>>();
		if (string.IsNullOrEmpty(content))
		{
			return list;
		}
		try
		{
			string[] array = content.Split(';');
			for (int i = 0; i < array.Length; i++)
			{
				List<float> list2 = new List<float>();
				string[] array2 = array[i].Split(',');
				foreach (string s in array2)
				{
					list2.Add(float.Parse(s));
				}
				list.Add(list2);
			}
			return list;
		}
		catch (Exception ex)
		{
			Log.Error("Parse List<List<string>> error , content = " + content + ", msg:" + ex.Message);
			throw;
		}
	}

	public static ConditionList<List<string>> ParseListsConditionStringList(string content)
	{
		ConditionList<List<string>> conditionList = new ConditionList<List<string>>();
		if (string.IsNullOrEmpty(content))
		{
			return conditionList;
		}
		try
		{
			char separator = '\0';
			for (int i = 0; i < content.Length; i++)
			{
				if ('|'.Equals(content[i]))
				{
					separator = '|';
					conditionList.conditionEnum = ConditionEnum.Or;
					break;
				}
				if ('&'.Equals(content[i]))
				{
					separator = '&';
					conditionList.conditionEnum = ConditionEnum.And;
					break;
				}
			}
			string[] array = content.Split(separator, StringSplitOptions.RemoveEmptyEntries);
			for (int j = 0; j < array.Length; j++)
			{
				conditionList.Add(new List<string>(array[j].Split(',', StringSplitOptions.RemoveEmptyEntries)));
			}
			return conditionList;
		}
		catch (Exception ex)
		{
			Log.Error("Parse ConditionList<List<string>> error , content = " + content + ", msg:" + ex.Message);
			throw;
		}
	}

	public static List<List<int>> ParseListIntList(string content)
	{
		List<List<int>> list = new List<List<int>>();
		if (string.IsNullOrEmpty(content))
		{
			return list;
		}
		try
		{
			string[] array = content.Split('|');
			for (int i = 0; i < array.Length; i++)
			{
				List<int> list2 = new List<int>();
				string[] array2 = array[i].Split(',');
				foreach (string s in array2)
				{
					list2.Add(int.Parse(s));
				}
				list.Add(list2);
			}
			return list;
		}
		catch (Exception ex)
		{
			Log.Error("Parse List<List<int>> error , content = " + content + ", msg:" + ex.Message);
			throw;
		}
	}

	public static List<List<float>> ParseListFloatList(string content)
	{
		List<List<float>> list = new List<List<float>>();
		if (string.IsNullOrEmpty(content))
		{
			return list;
		}
		try
		{
			string[] array = content.Split('|');
			for (int i = 0; i < array.Length; i++)
			{
				List<float> list2 = new List<float>();
				string[] array2 = array[i].Split(',');
				foreach (string s in array2)
				{
					list2.Add(float.Parse(s));
				}
				list.Add(list2);
			}
			return list;
		}
		catch (Exception ex)
		{
			Log.Error("Parse List<List<float>> error , content = " + content + ", msg:" + ex.Message);
			throw;
		}
	}

	public static Dictionary<int, int> ParseDictionaryIntInt(string content)
	{
		Dictionary<int, int> dictionary = new Dictionary<int, int>();
		if (string.IsNullOrEmpty(content))
		{
			return dictionary;
		}
		string[] array = content.Split('|');
		for (int i = 0; i < array.Length; i++)
		{
			string text = array[i];
			string[] array2 = text.Split(',');
			if (array2.Length != 2)
			{
				Log.Error("Parse Dictionary<int,int> error , content = {0} , subStr = {1} , subList.Length = {2} , i = {3}", content, text, array2.Length, i);
				dictionary.Clear();
				return dictionary;
			}
			try
			{
				int key = int.Parse(array2[0]);
				int value = int.Parse(array2[1]);
				dictionary.Add(key, value);
			}
			catch (Exception arg)
			{
				Log.Error("Parse Dictionary<int,int> error , content = {0} , subStr = {1} , subList.Length = {2} , i = {3} , e = {4}", content, text, array2.Length, i, arg);
				dictionary.Clear();
				return dictionary;
			}
		}
		return dictionary;
	}

	public static T ReadEnum<T>(this BinaryReader binaryReader) where T : struct
	{
		return ParseEnum<T>(binaryReader.ReadString());
	}

	public static List<List<string>> ReadListStringList(this BinaryReader binaryReader)
	{
		return ParseListStringList(binaryReader.ReadString());
	}

	public static List<List<string>> ReadListsSemicolonStringList(this BinaryReader binaryReader)
	{
		return ParseListsSemicolonStringList(binaryReader.ReadString());
	}

	public static List<List<float>> ReadListsSemicolonFloatList(this BinaryReader binaryReader)
	{
		return ParseListsSemicolonFloatList(binaryReader.ReadString());
	}

	public static ConditionList<List<string>> ReadListsConditionStringList(this BinaryReader binaryReader)
	{
		return ParseListsConditionStringList(binaryReader.ReadString());
	}

	public static List<List<int>> ReadListIntList(this BinaryReader binaryReader)
	{
		return ParseListIntList(binaryReader.ReadString());
	}

	public static List<List<float>> ReadListFloatList(this BinaryReader binaryReader)
	{
		return ParseListFloatList(binaryReader.ReadString());
	}

	public static Dictionary<int, int> ReadDictionaryIntInt(this BinaryReader binaryReader)
	{
		return ParseDictionaryIntInt(binaryReader.ReadString());
	}
}
