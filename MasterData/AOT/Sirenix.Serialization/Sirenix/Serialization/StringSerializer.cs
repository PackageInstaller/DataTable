namespace Sirenix.Serialization;

public sealed class StringSerializer : Serializer<string>
{
	public override string ReadValue(IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var name);
		switch (entryType)
		{
		case EntryType.String:
		{
			if (!reader.ReadString(out var value))
			{
				reader.Context.Config.DebugContext.LogWarning("Failed to read entry '" + name + "' of type " + entryType);
			}
			return value;
		}
		case EntryType.Null:
			if (!reader.ReadNull())
			{
				reader.Context.Config.DebugContext.LogWarning("Failed to read entry '" + name + "' of type " + entryType);
			}
			return null;
		default:
			reader.Context.Config.DebugContext.LogWarning("Expected entry of type " + EntryType.String.ToString() + " or " + EntryType.Null.ToString() + ", but got entry '" + name + "' of type " + entryType);
			reader.SkipEntry();
			return null;
		}
	}

	public override void WriteValue(string name, string value, IDataWriter writer)
	{
		if (value == null)
		{
			writer.WriteNull(name);
		}
		else
		{
			writer.WriteString(name, value);
		}
	}
}
