namespace Sirenix.Serialization;

public sealed class SelfFormatterFormatter<T> : BaseFormatter<T> where T : ISelfFormatter
{
	protected override void DeserializeImplementation(ref T value, IDataReader reader)
	{
		value.Deserialize(reader);
	}

	protected override void SerializeImplementation(ref T value, IDataWriter writer)
	{
		value.Serialize(writer);
	}
}
