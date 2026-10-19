using System;

namespace Sirenix.Serialization;

public sealed class WeakSelfFormatterFormatter : WeakBaseFormatter
{
	public WeakSelfFormatterFormatter(Type serializedType)
		: base(serializedType)
	{
	}

	protected override void DeserializeImplementation(ref object value, IDataReader reader)
	{
		((ISelfFormatter)value).Deserialize(reader);
	}

	protected override void SerializeImplementation(ref object value, IDataWriter writer)
	{
		((ISelfFormatter)value).Serialize(writer);
	}
}
