using System;
using System.Collections.Generic;
using Sirenix.Serialization.Utilities;

namespace Sirenix.Serialization;

internal sealed class DoubleLookupDictionaryFormatter<TPrimary, TSecondary, TValue> : BaseFormatter<DoubleLookupDictionary<TPrimary, TSecondary, TValue>>
{
	private static readonly Serializer<TPrimary> PrimaryReaderWriter;

	private static readonly Serializer<Dictionary<TSecondary, TValue>> InnerReaderWriter;

	static DoubleLookupDictionaryFormatter()
	{
		PrimaryReaderWriter = Serializer.Get<TPrimary>();
		InnerReaderWriter = Serializer.Get<Dictionary<TSecondary, TValue>>();
		new DoubleLookupDictionaryFormatter<int, int, string>();
	}

	protected override DoubleLookupDictionary<TPrimary, TSecondary, TValue> GetUninitializedObject()
	{
		return null;
	}

	protected override void SerializeImplementation(ref DoubleLookupDictionary<TPrimary, TSecondary, TValue> value, IDataWriter writer)
	{
		try
		{
			writer.BeginArrayNode(value.Count);
			bool flag = true;
			foreach (KeyValuePair<TPrimary, Dictionary<TSecondary, TValue>> item in value)
			{
				try
				{
					writer.BeginStructNode(null, null);
					PrimaryReaderWriter.WriteValue("$k", item.Key, writer);
					InnerReaderWriter.WriteValue("$v", item.Value, writer);
				}
				catch (SerializationAbortException ex)
				{
					flag = false;
					throw ex;
				}
				catch (Exception exception)
				{
					writer.Context.Config.DebugContext.LogException(exception);
				}
				finally
				{
					if (flag)
					{
						writer.EndNode(null);
					}
				}
			}
		}
		finally
		{
			writer.EndArrayNode();
		}
	}

	protected override void DeserializeImplementation(ref DoubleLookupDictionary<TPrimary, TSecondary, TValue> value, IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var name);
		if (entryType == EntryType.StartOfArray)
		{
			try
			{
				reader.EnterArray(out var length);
				value = new DoubleLookupDictionary<TPrimary, TSecondary, TValue>();
				RegisterReferenceID(value, reader);
				for (int i = 0; i < length; i++)
				{
					if (reader.PeekEntry(out name) == EntryType.EndOfArray)
					{
						reader.Context.Config.DebugContext.LogError("Reached end of array after " + i + " elements, when " + length + " elements were expected.");
						break;
					}
					bool flag = true;
					try
					{
						reader.EnterNode(out var _);
						TPrimary key = PrimaryReaderWriter.ReadValue(reader);
						Dictionary<TSecondary, TValue> value2 = InnerReaderWriter.ReadValue(reader);
						value.Add(key, value2);
					}
					catch (SerializationAbortException ex)
					{
						flag = false;
						throw ex;
					}
					catch (Exception exception)
					{
						reader.Context.Config.DebugContext.LogException(exception);
					}
					finally
					{
						if (flag)
						{
							reader.ExitNode();
						}
					}
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
}
