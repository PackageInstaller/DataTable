namespace Sirenix.Serialization;

public sealed class SingleSerializer : Serializer<float>
{
	public override float ReadValue(IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var name);
		if (entryType == EntryType.FloatingPoint || entryType == EntryType.Integer)
		{
			if (!reader.ReadSingle(out var value))
			{
				reader.Context.Config.DebugContext.LogWarning("Failed to read entry '" + name + "' of type " + entryType);
			}
			return value;
		}
		reader.Context.Config.DebugContext.LogWarning("Expected entry of type " + EntryType.FloatingPoint.ToString() + " or " + EntryType.Integer.ToString() + ", but got entry '" + name + "' of type " + entryType);
		reader.SkipEntry();
		return 0f;
	}

	public override void WriteValue(string name, float value, IDataWriter writer)
	{
		writer.WriteSingle(name, value);
	}
}
