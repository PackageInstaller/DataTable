using System;
using System.Collections;
using System.Collections.Generic;

namespace ParadoxNotion.Serialization.FullSerializer.Internal;

public class fsDictionaryConverter : fsConverter
{
	public override bool CanProcess(Type type)
	{
		if (type.IsGenericType)
		{
			return type.GetGenericTypeDefinition() == typeof(Dictionary<, >);
		}
		return false;
	}

	public override object CreateInstance(fsData data, Type storageType)
	{
		return fsMetaType.Get(storageType).CreateInstance();
	}

	public override fsResult TrySerialize(object instance_, out fsData serialized, Type storageType)
	{
		serialized = fsData.Null;
		fsResult success = fsResult.Success;
		IDictionary obj = (IDictionary)instance_;
		Type[] array = obj.GetType().RTGetGenericArguments();
		Type storageType2 = array[0];
		Type storageType3 = array[1];
		bool flag = true;
		List<fsData> list = new List<fsData>(obj.Count);
		List<fsData> list2 = new List<fsData>(obj.Count);
		IDictionaryEnumerator enumerator = obj.GetEnumerator();
		while (enumerator.MoveNext())
		{
			if ((success += Serializer.TrySerialize(storageType2, enumerator.Key, out var data)).Failed)
			{
				return success;
			}
			if ((success += Serializer.TrySerialize(storageType3, enumerator.Value, out var data2)).Failed)
			{
				return success;
			}
			list.Add(data);
			list2.Add(data2);
			flag &= data.IsString;
		}
		if (flag)
		{
			serialized = fsData.CreateDictionary();
			Dictionary<string, fsData> asDictionary = serialized.AsDictionary;
			for (int i = 0; i < list.Count; i++)
			{
				fsData fsData2 = list[i];
				fsData value = list2[i];
				asDictionary[fsData2.AsString] = value;
			}
		}
		else
		{
			serialized = fsData.CreateList(list.Count);
			List<fsData> asList = serialized.AsList;
			for (int j = 0; j < list.Count; j++)
			{
				fsData value2 = list[j];
				fsData value3 = list2[j];
				Dictionary<string, fsData> dictionary = new Dictionary<string, fsData>();
				dictionary["Key"] = value2;
				dictionary["Value"] = value3;
				asList.Add(new fsData(dictionary));
			}
		}
		return success;
	}

	public override fsResult TryDeserialize(fsData data, ref object instance_, Type storageType)
	{
		IDictionary dictionary = (IDictionary)instance_;
		fsResult success = fsResult.Success;
		Type[] array = dictionary.GetType().RTGetGenericArguments();
		Type storageType2 = array[0];
		Type storageType3 = array[1];
		dictionary.Clear();
		if (data.IsDictionary)
		{
			fsResult result3;
			using (Dictionary<string, fsData>.Enumerator enumerator = data.AsDictionary.GetEnumerator())
			{
				while (true)
				{
					if (enumerator.MoveNext())
					{
						KeyValuePair<string, fsData> current = enumerator.Current;
						if (!fsSerializer.IsReservedKeyword(current.Key))
						{
							fsData data2 = new fsData(current.Key);
							fsData value = current.Value;
							object result = null;
							object result2 = null;
							result3 = (success += Serializer.TryDeserialize(data2, storageType2, ref result));
							if (result3.Failed)
							{
								result3 = success;
								break;
							}
							if ((success += Serializer.TryDeserialize(value, storageType3, ref result2)).Failed)
							{
								result3 = success;
								break;
							}
							dictionary.Add(result, result2);
						}
						continue;
					}
					return success;
				}
			}
			return result3;
		}
		if (data.IsList)
		{
			List<fsData> asList = data.AsList;
			for (int i = 0; i < asList.Count; i++)
			{
				fsData data3 = asList[i];
				if ((success += CheckType(data3, fsDataType.Object)).Failed)
				{
					return success;
				}
				if ((success += CheckKey(data3, "Key", out var subitem)).Failed)
				{
					return success;
				}
				if ((success += CheckKey(data3, "Value", out var subitem2)).Failed)
				{
					return success;
				}
				object result4 = null;
				object result5 = null;
				if ((success += Serializer.TryDeserialize(subitem, storageType2, ref result4)).Failed)
				{
					return success;
				}
				if ((success += Serializer.TryDeserialize(subitem2, storageType3, ref result5)).Failed)
				{
					return success;
				}
				dictionary.Add(result4, result5);
			}
			return success;
		}
		return FailExpectedType(data, fsDataType.Array, fsDataType.Object);
	}
}
