using System;
using System.Collections;
using System.Collections.Generic;
using Sirenix.Serialization.Utilities;

namespace Sirenix.Serialization;

public class WeakListFormatter : WeakBaseFormatter
{
	private readonly Serializer ElementSerializer;

	public WeakListFormatter(Type serializedType)
		: base(serializedType)
	{
		Type[] argumentsOfInheritedOpenGenericClass = serializedType.GetArgumentsOfInheritedOpenGenericClass(typeof(List<>));
		ElementSerializer = Serializer.Get(argumentsOfInheritedOpenGenericClass[0]);
	}

	protected override object GetUninitializedObject()
	{
		return null;
	}

	protected override void DeserializeImplementation(ref object value, IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var name);
		if (entryType == EntryType.StartOfArray)
		{
			try
			{
				reader.EnterArray(out var length);
				value = Activator.CreateInstance(SerializedType, (int)length);
				IList list = (IList)value;
				RegisterReferenceID(value, reader);
				for (int i = 0; i < length; i++)
				{
					if (reader.PeekEntry(out name) == EntryType.EndOfArray)
					{
						reader.Context.Config.DebugContext.LogError("Reached end of array after " + i + " elements, when " + length + " elements were expected.");
						break;
					}
					list.Add(ElementSerializer.ReadValueWeak(reader));
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

	protected override void SerializeImplementation(ref object value, IDataWriter writer)
	{
		try
		{
			IList list = (IList)value;
			writer.BeginArrayNode(list.Count);
			for (int i = 0; i < list.Count; i++)
			{
				try
				{
					ElementSerializer.WriteValueWeak(list[i], writer);
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
