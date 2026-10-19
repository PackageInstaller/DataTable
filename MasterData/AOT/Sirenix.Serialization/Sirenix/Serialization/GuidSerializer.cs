using System;

namespace Sirenix.Serialization;

public sealed class GuidSerializer : Serializer<Guid>
{
	public override Guid ReadValue(IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var name);
		if (entryType == EntryType.Guid)
		{
			if (!reader.ReadGuid(out var value))
			{
				reader.Context.Config.DebugContext.LogWarning("Failed to read entry '" + name + "' of type " + entryType);
			}
			return value;
		}
		reader.Context.Config.DebugContext.LogWarning("Expected entry of type " + EntryType.Guid.ToString() + ", but got entry '" + name + "' of type " + entryType);
		reader.SkipEntry();
		return default;
	}

	public override void WriteValue(string name, Guid value, IDataWriter writer)
	{
		writer.WriteGuid(name, value);
	}
}
