using System;
using System.Collections;
using System.Collections.Generic;

namespace ParadoxNotion.Serialization.FullSerializer.Internal;

public class fsArrayConverter : fsConverter
{
	public override bool CanProcess(Type type)
	{
		return type.IsArray;
	}

	public override bool RequestCycleSupport(Type storageType)
	{
		return false;
	}

	public override bool RequestInheritanceSupport(Type storageType)
	{
		return false;
	}

	public override fsResult TrySerialize(object instance, out fsData serialized, Type storageType)
	{
		IList list = (Array)instance;
		Type elementType = storageType.GetElementType();
		fsResult success = fsResult.Success;
		serialized = fsData.CreateList(list.Count);
		List<fsData> asList = serialized.AsList;
		for (int i = 0; i < list.Count; i++)
		{
			object instance2 = list[i];
			fsResult result = Serializer.TrySerialize(elementType, instance2, out var data);
			success.AddMessages(result);
			if (!result.Failed)
			{
				asList.Add(data);
			}
		}
		return success;
	}

	public override fsResult TryDeserialize(fsData data, ref object instance, Type storageType)
	{
		fsResult success = fsResult.Success;
		fsResult fsResult2 = (success += CheckType(data, fsDataType.Array));
		if (fsResult2.Failed)
		{
			return success;
		}
		Type elementType = storageType.GetElementType();
		List<fsData> asList = data.AsList;
		ArrayList arrayList = new ArrayList(asList.Count);
		int count = arrayList.Count;
		for (int i = 0; i < asList.Count; i++)
		{
			fsData data2 = asList[i];
			object result = null;
			if (i < count)
			{
				result = arrayList[i];
			}
			fsResult result2 = Serializer.TryDeserialize(data2, elementType, ref result);
			success.AddMessages(result2);
			if (!result2.Failed)
			{
				if (i < count)
				{
					arrayList[i] = result;
				}
				else
				{
					arrayList.Add(result);
				}
			}
		}
		instance = arrayList.ToArray(elementType);
		return success;
	}

	public override object CreateInstance(fsData data, Type storageType)
	{
		return fsMetaType.Get(storageType).CreateInstance();
	}
}
