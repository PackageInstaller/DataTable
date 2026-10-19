using System;
using System.Collections.Generic;

namespace Sirenix.Serialization;

public class QueueFormatter<TQueue, TValue> : BaseFormatter<TQueue> where TQueue : Queue<TValue>, new()
{
	private static readonly Serializer<TValue> TSerializer;

	private static readonly bool IsPlainQueue;

	static QueueFormatter()
	{
		TSerializer = Serializer.Get<TValue>();
		IsPlainQueue = typeof(TQueue) == typeof(Queue<TValue>);
		new QueueFormatter<Queue<int>, int>();
	}

	protected override TQueue GetUninitializedObject()
	{
		return null;
	}

	protected override void DeserializeImplementation(ref TQueue value, IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var name);
		if (entryType == EntryType.StartOfArray)
		{
			try
			{
				reader.EnterArray(out var length);
				if (IsPlainQueue)
				{
					value = (TQueue)new Queue<TValue>((int)length);
				}
				else
				{
					value = new TQueue();
				}
				RegisterReferenceID(value, reader);
				for (int i = 0; i < length; i++)
				{
					if (reader.PeekEntry(out name) == EntryType.EndOfArray)
					{
						reader.Context.Config.DebugContext.LogError("Reached end of array after " + i + " elements, when " + length + " elements were expected.");
						break;
					}
					value.Enqueue(TSerializer.ReadValue(reader));
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

	protected override void SerializeImplementation(ref TQueue value, IDataWriter writer)
	{
		try
		{
			writer.BeginArrayNode(value.Count);
			foreach (TValue item in value)
			{
				try
				{
					TSerializer.WriteValue(item, writer);
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
