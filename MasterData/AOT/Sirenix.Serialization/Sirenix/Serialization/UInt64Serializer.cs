namespace Sirenix.Serialization;

public sealed class UInt64Serializer : Serializer<ulong>
{
	public override ulong ReadValue(IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var name);
		if (entryType == EntryType.Integer)
		{
			if (!reader.ReadUInt64(out var value))
			{
				reader.Context.Config.DebugContext.LogWarning("Failed to read entry '" + name + "' of type " + entryType);
			}
			return value;
		}
		reader.Context.Config.DebugContext.LogWarning("Expected entry of type " + EntryType.Integer.ToString() + ", but got entry '" + name + "' of type " + entryType);
		reader.SkipEntry();
		return 0uL;
	}

	public override void WriteValue(string name, ulong value, IDataWriter writer)
	{
		writer.WriteUInt64(name, value);
	}
}
