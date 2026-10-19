using System.Collections.Generic;

namespace Sirenix.Serialization;

public sealed class KeyValuePairFormatter<TKey, TValue> : BaseFormatter<KeyValuePair<TKey, TValue>>
{
	private static readonly Serializer<TKey> KeySerializer = Serializer.Get<TKey>();

	private static readonly Serializer<TValue> ValueSerializer = Serializer.Get<TValue>();

	protected override void SerializeImplementation(ref KeyValuePair<TKey, TValue> value, IDataWriter writer)
	{
		KeySerializer.WriteValue(value.Key, writer);
		ValueSerializer.WriteValue(value.Value, writer);
	}

	protected override void DeserializeImplementation(ref KeyValuePair<TKey, TValue> value, IDataReader reader)
	{
		value = new KeyValuePair<TKey, TValue>(KeySerializer.ReadValue(reader), ValueSerializer.ReadValue(reader));
	}
}
