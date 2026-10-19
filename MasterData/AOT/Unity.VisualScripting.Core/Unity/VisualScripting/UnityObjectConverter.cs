using System;
using System.Collections.Generic;
using Unity.VisualScripting.FullSerializer;
using UnityEngine;

namespace Unity.VisualScripting;

public class UnityObjectConverter : fsConverter
{
	private List<UnityEngine.Object> objectReferences => Serializer.Context.Get<List<UnityEngine.Object>>();

	public override bool CanProcess(Type type)
	{
		return typeof(UnityEngine.Object).IsAssignableFrom(type);
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
		UnityEngine.Object item = (UnityEngine.Object)instance;
		int count = objectReferences.Count;
		serialized = new fsData(count);
		objectReferences.Add(item);
		return fsResult.Success;
	}

	public override fsResult TryDeserialize(fsData storage, ref object instance, Type storageType)
	{
		int num = (int)storage.AsInt64;
		fsResult success = fsResult.Success;
		if (num >= 0 && num < objectReferences.Count)
		{
			UnityEngine.Object obj = (UnityEngine.Object)(instance = objectReferences[num]);
			if (instance != null && !storageType.IsInstanceOfType(instance))
			{
				if (obj.GetHashCode() != 0)
				{
					success.AddMessage($"Object reference at index #{num} does not match target type ({instance.GetType()} != {storageType}). Defaulting to null.");
				}
				instance = null;
			}
		}
		else
		{
			success.AddMessage($"No object reference provided at index #{num}. Defaulting to null.");
			instance = null;
		}
		return success;
	}

	public override object CreateInstance(fsData data, Type storageType)
	{
		return storageType;
	}
}
