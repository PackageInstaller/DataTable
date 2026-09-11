using System;

namespace MessagePack.Formatters;

public sealed class TypeFormatter<T> : IMessagePackFormatter<T>, IMessagePackFormatter where T : Type
{
	public static readonly IMessagePackFormatter<T> Instance = new TypeFormatter<T>();

	private TypeFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, T value, MessagePackSerializerOptions options)
	{
		if ((object)value == null)
		{
			writer.WriteNil();
		}
		else
		{
			writer.Write(value.AssemblyQualifiedName);
		}
	}

	public T Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		return (T)Type.GetType(reader.ReadString(), throwOnError: true);
	}
}
