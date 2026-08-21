using System;
using System.Collections;
using UnityEngine;

namespace ParadoxNotion.Serialization.FullSerializer.Internal;

public class fsReflectedConverter : fsConverter
{
	public override bool CanProcess(Type type)
	{
		if (type.Resolve().IsArray || typeof(ICollection).IsAssignableFrom(type))
		{
			return false;
		}
		return true;
	}

	public override fsResult TrySerialize(object instance, out fsData serialized, Type storageType)
	{
		serialized = fsData.CreateDictionary();
		fsResult success = fsResult.Success;
		fsMetaType fsMetaType2 = fsMetaType.Get(Serializer.Config, instance.GetType());
		fsMetaType2.EmitAotData();
		object obj = null;
		if (!fsGlobalConfig.SerializeDefaultValues && !(instance is UnityEngine.Object))
		{
			obj = fsMetaType2.CreateInstance();
		}
		for (int i = 0; i < fsMetaType2.Properties.Length; i++)
		{
			fsMetaProperty fsMetaProperty2 = fsMetaType2.Properties[i];
			if (fsMetaProperty2.CanRead && (fsGlobalConfig.SerializeDefaultValues || obj == null || !object.Equals(fsMetaProperty2.Read(instance), fsMetaProperty2.Read(obj))))
			{
				fsResult result = Serializer.TrySerialize(fsMetaProperty2.StorageType, fsMetaProperty2.OverrideConverterType, fsMetaProperty2.Read(instance), out var data);
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
		fsMetaType fsMetaType2 = fsMetaType.Get(Serializer.Config, storageType);
		fsMetaType2.EmitAotData();
		for (int i = 0; i < fsMetaType2.Properties.Length; i++)
		{
			fsMetaProperty fsMetaProperty2 = fsMetaType2.Properties[i];
			if (fsMetaProperty2.CanWrite && data.AsDictionary.TryGetValue(fsMetaProperty2.JsonName, out var value))
			{
				object result = null;
				fsResult result2 = Serializer.TryDeserialize(value, fsMetaProperty2.StorageType, fsMetaProperty2.OverrideConverterType, ref result);
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
		return fsMetaType.Get(Serializer.Config, storageType).CreateInstance();
	}
}
