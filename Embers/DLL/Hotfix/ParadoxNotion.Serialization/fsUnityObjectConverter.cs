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
		List<UnityEngine.Object> referencesDatabase = Serializer.ReferencesDatabase;
		if (referencesDatabase == null)
		{
			serialized = new fsData();
			return fsResult.Success;
		}
		if (!(instance is UnityEngine.Object obj))
		{
			serialized = new fsData(0L);
			return fsResult.Success;
		}
		if (referencesDatabase.Count == 0)
		{
			referencesDatabase.Add(null);
		}
		int num = -1;
		for (int i = 0; i < referencesDatabase.Count; i++)
		{
			if ((object)referencesDatabase[i] == obj)
			{
				num = i;
				break;
			}
		}
		if (num <= 0)
		{
			num = referencesDatabase.Count;
			referencesDatabase.Add(obj);
		}
		serialized = new fsData(num);
		return fsResult.Success;
	}

	public override fsResult TryDeserialize(fsData data, ref object instance, Type storageType)
	{
		List<UnityEngine.Object> referencesDatabase = Serializer.ReferencesDatabase;
		if (referencesDatabase == null)
		{
			return fsResult.Warn("A Unity Object reference has not been deserialized because no database references was provided.");
		}
		int num = (int)data.AsInt64;
		if (num >= referencesDatabase.Count)
		{
			return fsResult.Warn("A Unity Object reference has not been deserialized because no database entry was found in provided database references.");
		}
		UnityEngine.Object obj = referencesDatabase[num];
		if ((object)obj == null || storageType.RTIsAssignableFrom(obj.GetType()))
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
