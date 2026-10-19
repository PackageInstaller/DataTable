namespace Sirenix.Serialization;

public abstract class EasyBaseFormatter<T> : BaseFormatter<T>
{
	protected sealed override void DeserializeImplementation(ref T value, IDataReader reader)
	{
		int num = 0;
		EntryType entryType;
		string name;
		while ((entryType = reader.PeekEntry(out name)) != EntryType.EndOfNode && entryType != EntryType.EndOfArray && entryType != EntryType.EndOfStream)
		{
			ReadDataEntry(ref value, name, entryType, reader);
			num++;
			if (num > 1000)
			{
				reader.Context.Config.DebugContext.LogError("Breaking out of infinite reading loop!");
				break;
			}
		}
	}

	protected sealed override void SerializeImplementation(ref T value, IDataWriter writer)
	{
		WriteDataEntries(ref value, writer);
	}

	protected abstract void ReadDataEntry(ref T value, string entryName, EntryType entryType, IDataReader reader);

	protected abstract void WriteDataEntries(ref T value, IDataWriter writer);
}
