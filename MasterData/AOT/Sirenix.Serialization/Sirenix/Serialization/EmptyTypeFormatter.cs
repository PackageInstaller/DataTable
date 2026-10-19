namespace Sirenix.Serialization;

public class EmptyTypeFormatter<T> : EasyBaseFormatter<T>
{
	protected override void ReadDataEntry(ref T value, string entryName, EntryType entryType, IDataReader reader)
	{
		reader.SkipEntry();
	}

	protected override void WriteDataEntries(ref T value, IDataWriter writer)
	{
	}
}
