namespace Sirenix.Serialization;

public sealed class UInt16Serializer : Serializer<ushort>
{
	public override ushort ReadValue(IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var name);
		if (entryType == EntryType.Integer)
		{
			if (!reader.ReadUInt16(out var value))
			{
				reader.Context.Config.DebugContext.LogWarning("Failed to read entry '" + name + "' of type " + entryType);
			}
			return value;
		}
		reader.Context.Config.DebugContext.LogWarning("Expected entry of type " + EntryType.Integer.ToString() + ", but got entry '" + name + "' of type " + entryType);
		reader.SkipEntry();
		return 0;
	}

	public override void WriteValue(string name, ushort value, IDataWriter writer)
	{
		writer.WriteUInt16(name, value);
	}
}
