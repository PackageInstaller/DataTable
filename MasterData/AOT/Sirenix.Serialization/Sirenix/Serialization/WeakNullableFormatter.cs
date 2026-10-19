using System;

namespace Sirenix.Serialization;

public sealed class WeakNullableFormatter : WeakBaseFormatter
{
	private readonly Serializer ValueSerializer;

	public WeakNullableFormatter(Type nullableType)
		: base(nullableType)
	{
		Type[] genericArguments = nullableType.GetGenericArguments();
		ValueSerializer = Serializer.Get(genericArguments[0]);
	}

	protected override void DeserializeImplementation(ref object value, IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var _);
		if (entryType == EntryType.Null)
		{
			value = null;
			reader.ReadNull();
		}
		else
		{
			value = ValueSerializer.ReadValueWeak(reader);
		}
	}

	protected override void SerializeImplementation(ref object value, IDataWriter writer)
	{
		if (value != null)
		{
			ValueSerializer.WriteValueWeak(value, writer);
		}
		else
		{
			writer.WriteNull(null);
		}
	}

	protected override object GetUninitializedObject()
	{
		return null;
	}
}
