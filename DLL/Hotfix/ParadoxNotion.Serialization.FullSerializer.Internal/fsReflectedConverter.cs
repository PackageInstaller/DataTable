using System;
using System.Collections;
using UnityEngine;

namespace ParadoxNotion.Serialization.FullSerializer.Internal;

public class fsReflectedConverter : fsConverter
{
	public override bool CanProcess(Type type)
	{
		if (type.IsArray || typeof(ICollection).IsAssignableFrom(type))
		{
			return false;
		}
		return true;
	}

	public override fsResult TrySerialize(object instance, out fsData serialized, Type storageType)
	{
		serialized = fsData.CreateDictionary();
		fsResult success = fsResult.Success;
		fsMetaType fsMetaType2 = fsMetaType.Get(instance.GetType());
		object obj = null;
		if (!fsGlobalConfig.SerializeDefaultValues && !(instance is UnityEngine.Object))
		{
			obj = fsMetaType2.GetDefaultInstance();
		}
		for (int i = 0; i < fsMetaType2.Properties.Length; i++)
		{
			fsMetaProperty fsMetaProperty2 = fsMetaType2.Properties[i];
			if (!fsMetaProperty2.WriteOnly && (!fsMetaProperty2.AsReference || !Serializer.IgnoreSerializeCycleReferences))
			{
				object obj2 = fsMetaProperty2.Read(instance);
				if (obj2 == null && fsMetaProperty2.AutoInstance)
				{
					obj2 = fsMetaType.Get(fsMetaProperty2.StorageType).CreateInstance();
					fsMetaProperty2.Write(instance, obj2);
				}
				else if (!fsGlobalConfig.SerializeDefaultValues && obj != null && object.Equals(obj2, fsMetaProperty2.Read(obj)))
				{
					continue;
				}
				fsResult result = Serializer.TrySerialize(fsMetaProperty2.StorageType, obj2, out var data);
				success.AddMessages(result);
				if (!result.Failed)
				{
					serialized.AsDictionary[fsMetaProperty2.JsonName] = data;
				}
			}
		}
		return success;
	}

	public override fsResult TryDeserialize(fsData data, ref object instance, Type storageType)
	{
		fsResult success = fsResult.Success;
		fsResult fsResult2 = (success += CheckType(data, fsDataType.Object));
		if (fsResult2.Failed)
		{
			return success;
		}
		if (data.AsDictionary.Count == 0)
		{
			return fsResult.Success;
		}
		fsMetaType fsMetaType2 = fsMetaType.Get(storageType);
		for (int i = 0; i < fsMetaType2.Properties.Length; i++)
		{
			fsMetaProperty fsMetaProperty2 = fsMetaType2.Properties[i];
			if (!fsMetaProperty2.ReadOnly && data.AsDictionary.TryGetValue(fsMetaProperty2.JsonName, out var value))
			{
				object result = null;
				if (fsGlobalConfig.SerializeDefaultValues && (fsMetaType2.DeserializeOverwriteRequest || typeof(ICollection).IsAssignableFrom(storageType)))
				{
					result = fsMetaProperty2.Read(instance);
				}
				fsResult result2 = Serializer.TryDeserialize(value, fsMetaProperty2.StorageType, ref result, null);
				success.AddMessages(result2);
				if (!result2.Failed)
				{
					fsMetaProperty2.Write(instance, result);
				}
			}
		}
		return success;
	}

	public override object CreateInstance(fsData data, Type storageType)
	{
		fsMetaType fsMetaType2 = fsMetaType.Get(storageType);
		if (storageType.IsInterface || storageType.IsAbstract)
		{
			return null;
		}
		return fsMetaType2.CreateInstance();
	}
}
