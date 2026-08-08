using System;
using System.Collections.Generic;
using ParadoxNotion.Serialization.FullSerializer;
using UnityEngine;

namespace ParadoxNotion.Serialization;

public class fsUnityObjectConverter : fsConverter
{
	public override bool CanProcess(Type type)
	{
		return typeof(UnityEngine.Object).RTIsAssignableFrom(type);
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
		List<UnityEngine.Object> list = Serializer.Context.Get<List<UnityEngine.Object>>();
		if (!(instance is UnityEngine.Object obj))
		{
			serialized = new fsData(0L);
			return fsResult.Success;
		}
		if (list.Count == 0)
		{
			list.Add(null);
		}
		int num = -1;
		for (int i = 0; i < list.Count; i++)
		{
			if ((object)list[i] == obj)
			{
				num = i;
				break;
			}
		}
		if (num <= 0)
		{
			num = list.Count;
			list.Add(obj);
		}
		serialized = new fsData(num);
		return fsResult.Success;
	}

	public override fsResult TryDeserialize(fsData data, ref object instance, Type storageType)
	{
		List<UnityEngine.Object> list = Serializer.Context.Get<List<UnityEngine.Object>>();
		int num = (int)data.AsInt64;
		if (num >= list.Count)
		{
			return fsResult.Warn("A Unity Object reference has not been deserialized");
		}
		UnityEngine.Object obj = list[num];
		if (obj == null || storageType.RTIsAssignableFrom(obj.GetType()))
		{
			instance = obj;
		}
		return fsResult.Success;
	}

	public override object CreateInstance(fsData data, Type storageType)
	{
		return null;
	}
}
