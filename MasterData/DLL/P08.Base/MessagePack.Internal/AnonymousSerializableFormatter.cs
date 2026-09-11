using MessagePack.Formatters;

namespace MessagePack.Internal;

internal class AnonymousSerializableFormatter<T> : IMessagePackFormatter<T>, IMessagePackFormatter
{
	private readonly byte[][] stringByteKeysField;

	private readonly object[] serializeCustomFormatters;

	private readonly object[] deserializeCustomFormatters;

	private readonly AnonymousSerializeFunc<T> serialize;

	private readonly AnonymousDeserializeFunc<T> deserialize;

	public AnonymousSerializableFormatter(byte[][] stringByteKeysField, object[] serializeCustomFormatters, object[] deserializeCustomFormatters, AnonymousSerializeFunc<T> serialize, AnonymousDeserializeFunc<T> deserialize)
	{
		this.stringByteKeysField = stringByteKeysField;
		this.serializeCustomFormatters = serializeCustomFormatters;
		this.deserializeCustomFormatters = deserializeCustomFormatters;
		this.serialize = serialize;
		this.deserialize = deserialize;
	}

	public void Serialize(ref MessagePackWriter writer, T value, MessagePackSerializerOptions options)
	{
		if (serialize == null)
		{
			throw new MessagePackSerializationException(GetType().Name + " does not support Serialize.");
		}
		serialize(stringByteKeysField, serializeCustomFormatters, ref writer, value, options);
	}

	public T Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (deserialize == null)
		{
			throw new MessagePackSerializationException(GetType().Name + " does not support Deserialize.");
		}
		return deserialize(deserializeCustomFormatters, ref reader, options);
	}
}
