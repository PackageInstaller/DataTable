namespace Sirenix.Serialization;

public sealed class PrimitiveArrayFormatter<T> : MinimalBaseFormatter<T[]> where T : struct
{
	protected override T[] GetUninitializedObject()
	{
		return null;
	}

	protected override void Read(ref T[] value, IDataReader reader)
	{
		if (reader.PeekEntry(out var _) == EntryType.PrimitiveArray)
		{
			reader.ReadPrimitiveArray<T>(out value);
			RegisterReferenceID(value, reader);
		}
		else
		{
			reader.SkipEntry();
		}
	}

	protected override void Write(ref T[] value, IDataWriter writer)
	{
		writer.WritePrimitiveArray(value);
	}
}
