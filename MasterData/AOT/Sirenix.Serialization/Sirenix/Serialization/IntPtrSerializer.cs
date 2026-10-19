using System;

namespace Sirenix.Serialization;

public sealed class IntPtrSerializer : Serializer<IntPtr>
{
	public override IntPtr ReadValue(IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var name);
		if (entryType == EntryType.Integer)
		{
			if (!reader.ReadInt64(out var value))
			{
				reader.Context.Config.DebugContext.LogWarning("Failed to read entry '" + name + "' of type " + entryType);
			}
			return new IntPtr(value);
		}
		reader.Context.Config.DebugContext.LogWarning("Expected entry of type " + EntryType.Integer.ToString() + ", but got entry '" + name + "' of type " + entryType);
		reader.SkipEntry();
		return (IntPtr)0;
	}

	public override void WriteValue(string name, IntPtr value, IDataWriter writer)
	{
		writer.WriteInt64(name, (long)value);
	}
}
