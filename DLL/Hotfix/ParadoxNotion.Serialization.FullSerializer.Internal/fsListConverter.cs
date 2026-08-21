using System;
using System.Collections;
using System.Collections.Generic;

namespace ParadoxNotion.Serialization.FullSerializer.Internal;

public class fsListConverter : fsConverter
{
	public override bool CanProcess(Type type)
	{
		if (type.IsGenericType)
		{
			return type.GetGenericTypeDefinition() == typeof(List<>);
		}
		return false;
	}

	public override object CreateInstance(fsData data, Type storageType)
	{
		return fsMetaType.Get(storageType).CreateInstance();
	}

	public override fsResult TrySerialize(object instance_, out fsData serialized, Type storageType)
	{
		IList list = (IList)instance_;
		fsResult success = fsResult.Success;
		Type type = storageType.RTGetGenericArguments()[0];
		serialized = fsData.CreateList(list.Count);
		List<fsData> asList = serialized.AsList;
		for (int i = 0; i < list.Count; i++)
		{
			object obj = list[i];
			if (obj == null && type.RTIsDefined<fsAutoInstance>(inherited: true))
			{
				obj = (list[i] = fsMetaType.Get(type).CreateInstance());
			}
			fsResult result = Serializer.TrySerialize(type, obj, out var data);
			success.AddMessages(result);
			if (!result.Failed)
			{
				asList.Add(data);
			}
		}
		return success;
	}

	public override fsResult TryDeserialize(fsData data, ref object instance_, Type storageType)
	{
		IList list = (IList)instance_;
		fsResult success = fsResult.Success;
		fsResult fsResult2 = (success += CheckType(data, fsDataType.Array));
		if (fsResult2.Failed)
		{
			return success;
		}
		if (data.AsList.Count == 0)
		{
			return fsResult.Success;
		}
		Type type = storageType.RTGetGenericArguments()[0];
		if (list.Count == data.AsList.Count && fsMetaType.Get(type).DeserializeOverwriteRequest)
		{
			for (int i = 0; i < data.AsList.Count; i++)
			{
				object result = list[i];
				if (!Serializer.TryDeserialize(data.AsList[i], type, ref result).Failed)
				{
					list[i] = result;
				}
			}
			return fsResult.Success;
		}
		list.Clear();
		list.GetType().RTGetProperty("Capacity").SetValue(list, data.AsList.Count);
		for (int j = 0; j < data.AsList.Count; j++)
		{
			object result2 = null;
			if (!Serializer.TryDeserialize(data.AsList[j], type, ref result2).Failed)
			{
				list.Add(result2);
			}
		}
		return fsResult.Success;
	}
}
