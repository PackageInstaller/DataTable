using System;

namespace Sirenix.Serialization;

public sealed class EnumSerializer<T> : Serializer<T>
{
	static EnumSerializer()
	{
		if (!typeof(T).IsEnum)
		{
			throw new Exception("Type " + typeof(T).Name + " is not an enum.");
		}
	}

	public override T ReadValue(IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var name);
		if (entryType == EntryType.Integer)
		{
			if (!reader.ReadUInt64(out var value))
			{
				reader.Context.Config.DebugContext.LogWarning("Failed to read entry '" + name + "' of type " + entryType);
			}
			return (T)Enum.ToObject(typeof(T), value);
		}
		reader.Context.Config.DebugContext.LogWarning("Expected entry of type " + EntryType.Integer.ToString() + ", but got entry '" + name + "' of type " + entryType);
		reader.SkipEntry();
		return default;
	}

	public override void WriteValue(string name, T value, IDataWriter writer)
	{
		ulong value2;
		try
		{
			value2 = Convert.ToUInt64(value as Enum);
		}
		catch (OverflowException)
		{
			value2 = (ulong)Convert.ToInt64(value as Enum);
		}
		writer.WriteUInt64(name, value2);
	}
}
