namespace Sirenix.Serialization;

public sealed class NullableFormatter<T> : BaseFormatter<T?> where T : struct
{
	private static readonly Serializer<T> TSerializer;

	static NullableFormatter()
	{
		TSerializer = Serializer.Get<T>();
		new NullableFormatter<int>();
	}

	protected override void DeserializeImplementation(ref T? value, IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var _);
		if (entryType == EntryType.Null)
		{
			value = null;
			reader.ReadNull();
		}
		else
		{
			value = TSerializer.ReadValue(reader);
		}
	}

	protected override void SerializeImplementation(ref T? value, IDataWriter writer)
	{
		if (value.HasValue)
		{
			TSerializer.WriteValue(value.Value, writer);
		}
		else
		{
			writer.WriteNull(null);
		}
	}
}
