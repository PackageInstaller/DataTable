using System.ComponentModel;

namespace MessagePack.Formatters;

[EditorBrowsable(EditorBrowsableState.Never)]
public interface IMessagePackFormatter
{
}
public interface IMessagePackFormatter<T> : IMessagePackFormatter
{
	void Serialize(ref MessagePackWriter writer, T value, MessagePackSerializerOptions options);

	T Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options);
}
