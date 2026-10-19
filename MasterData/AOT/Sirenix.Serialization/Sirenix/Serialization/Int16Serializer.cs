namespace Sirenix.Serialization;

public sealed class Int16Serializer : Serializer<short>
{
	public override short ReadValue(IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var name);
		if (entryType == EntryType.Integer)
		{
			if (!reader.ReadInt16(out var value))
			{
				reader.Context.Config.DebugContext.LogWarning("Failed to read entry '" + name + "' of type " + entryType);
			}
			return value;
		}
		reader.Context.Config.DebugContext.LogWarning("Expected entry of type " + EntryType.Integer.ToString() + ", but got entry '" + name + "' of type " + entryType);
		reader.SkipEntry();
		return 0;
	}

	public override void WriteValue(string name, short value, IDataWriter writer)
	{
		writer.WriteInt16(name, value);
	}
}
