using System;
using Unity.VisualScripting.FullSerializer.Internal;

namespace Unity.VisualScripting.FullSerializer;

public class fsNullableConverter : fsConverter
{
	public override bool CanProcess(Type type)
	{
		if (type.Resolve().IsGenericType)
		{
			return type.GetGenericTypeDefinition() == typeof(Nullable<>);
		}
		return false;
	}

	public override fsResult TrySerialize(object instance, out fsData serialized, Type storageType)
	{
		return Serializer.TrySerialize(Nullable.GetUnderlyingType(storageType), instance, out serialized);
	}

	public override fsResult TryDeserialize(fsData data, ref object instance, Type storageType)
	{
		return Serializer.TryDeserialize(data, Nullable.GetUnderlyingType(storageType), ref instance);
	}

	public override object CreateInstance(fsData data, Type storageType)
	{
		return storageType;
	}
}
