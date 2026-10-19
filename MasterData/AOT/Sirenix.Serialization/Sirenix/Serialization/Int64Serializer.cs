namespace Sirenix.Serialization;

public sealed class Int64Serializer : Serializer<long>
{
	public override long ReadValue(IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var name);
		if (entryType == EntryType.Integer)
		{
			if (!reader.ReadInt64(out var value))
			{
				reader.Context.Config.DebugContext.LogWarning("Failed to read entry '" + name + "' of type " + entryType);
			}
			return value;
		}
		reader.Context.Config.DebugContext.LogWarning("Expected entry of type " + EntryType.Integer.ToString() + ", but got entry '" + name + "' of type " + entryType);
		reader.SkipEntry();
		return 0L;
	}

	public override void WriteValue(string name, long value, IDataWriter writer)
	{
		writer.WriteInt64(name, value);
	}
}
