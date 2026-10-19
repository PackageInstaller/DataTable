using System;
using System.Reflection;

namespace Sirenix.Serialization;

public sealed class WeakKeyValuePairFormatter : WeakBaseFormatter
{
	private readonly Serializer KeySerializer;

	private readonly Serializer ValueSerializer;

	private readonly PropertyInfo KeyProperty;

	private readonly PropertyInfo ValueProperty;

	public WeakKeyValuePairFormatter(Type serializedType)
		: base(serializedType)
	{
		Type[] genericArguments = serializedType.GetGenericArguments();
		KeySerializer = Serializer.Get(genericArguments[0]);
		ValueSerializer = Serializer.Get(genericArguments[1]);
		KeyProperty = serializedType.GetProperty("Key");
		ValueProperty = serializedType.GetProperty("Value");
	}

	protected override void SerializeImplementation(ref object value, IDataWriter writer)
	{
		KeySerializer.WriteValueWeak(KeyProperty.GetValue(value, null), writer);
		ValueSerializer.WriteValueWeak(ValueProperty.GetValue(value, null), writer);
	}

	protected override void DeserializeImplementation(ref object value, IDataReader reader)
	{
		value = Activator.CreateInstance(SerializedType, KeySerializer.ReadValueWeak(reader), ValueSerializer.ReadValueWeak(reader));
	}
}
