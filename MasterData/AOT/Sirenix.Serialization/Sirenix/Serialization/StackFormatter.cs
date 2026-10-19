using System;
using System.Collections.Generic;
using Sirenix.Serialization.Utilities;

namespace Sirenix.Serialization;

public class StackFormatter<TStack, TValue> : BaseFormatter<TStack> where TStack : Stack<TValue>, new()
{
	private static readonly Serializer<TValue> TSerializer;

	private static readonly bool IsPlainStack;

	static StackFormatter()
	{
		TSerializer = Serializer.Get<TValue>();
		IsPlainStack = typeof(TStack) == typeof(Stack<TValue>);
		new StackFormatter<Stack<int>, int>();
	}

	protected override TStack GetUninitializedObject()
	{
		return null;
	}

	protected override void DeserializeImplementation(ref TStack value, IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var name);
		if (entryType == EntryType.StartOfArray)
		{
			try
			{
				reader.EnterArray(out var length);
				if (IsPlainStack)
				{
					value = (TStack)new Stack<TValue>((int)length);
				}
				else
				{
					value = new TStack();
				}
				RegisterReferenceID(value, reader);
				for (int i = 0; i < length; i++)
				{
					if (reader.PeekEntry(out name) == EntryType.EndOfArray)
					{
						reader.Context.Config.DebugContext.LogError("Reached end of array after " + i + " elements, when " + length + " elements were expected.");
						break;
					}
					value.Push(TSerializer.ReadValue(reader));
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

	protected override void SerializeImplementation(ref TStack value, IDataWriter writer)
	{
		try
		{
			writer.BeginArrayNode(value.Count);
			using Cache<List<TValue>> cache = Cache<List<TValue>>.Claim();
			List<TValue> value2 = cache.Value;
			value2.Clear();
			foreach (TValue item in value)
			{
				value2.Add(item);
			}
			for (int num = value2.Count - 1; num >= 0; num--)
			{
				try
				{
					TSerializer.WriteValue(value2[num], writer);
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
