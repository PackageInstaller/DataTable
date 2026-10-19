using System;
using System.Collections;

namespace Sirenix.Serialization;

public class ArrayListFormatter : BaseFormatter<ArrayList>
{
	private static readonly Serializer<object> ObjectSerializer = Serializer.Get<object>();

	protected override ArrayList GetUninitializedObject()
	{
		return null;
	}

	protected override void DeserializeImplementation(ref ArrayList value, IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var name);
		if (entryType == EntryType.StartOfArray)
		{
			try
			{
				reader.EnterArray(out var length);
				value = new ArrayList((int)length);
				RegisterReferenceID(value, reader);
				for (int i = 0; i < length; i++)
				{
					if (reader.PeekEntry(out name) == EntryType.EndOfArray)
					{
						reader.Context.Config.DebugContext.LogError("Reached end of array after " + i + " elements, when " + length + " elements were expected.");
						break;
					}
					value.Add(ObjectSerializer.ReadValue(reader));
					if (!reader.IsInArrayNode)
					{
						reader.Context.Config.DebugContext.LogError("Reading array went wrong. Data dump: " + reader.GetDataDump());
						break;
					}
				}
				return;
			}
			finally
			{
				reader.ExitArray();
			}
		}
		reader.SkipEntry();
	}

	protected override void SerializeImplementation(ref ArrayList value, IDataWriter writer)
	{
		try
		{
			writer.BeginArrayNode(value.Count);
			for (int i = 0; i < value.Count; i++)
			{
				try
				{
					ObjectSerializer.WriteValue(value[i], writer);
				}
				catch (Exception exception)
				{
					writer.Context.Config.DebugContext.LogException(exception);
				}
			}
		}
		finally
		{
			writer.EndArrayNode();
		}
	}
}
