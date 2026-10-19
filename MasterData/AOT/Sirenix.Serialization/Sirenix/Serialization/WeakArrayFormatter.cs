using System;

namespace Sirenix.Serialization;

public sealed class WeakArrayFormatter : WeakBaseFormatter
{
	private readonly Serializer ValueReaderWriter;

	private readonly Type ElementType;

	public WeakArrayFormatter(Type arrayType, Type elementType)
		: base(arrayType)
	{
		ValueReaderWriter = Serializer.Get(elementType);
		ElementType = elementType;
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
			reader.EnterArray(out var length);
			Array array = (Array)(value = Array.CreateInstance(ElementType, length));
			RegisterReferenceID(value, reader);
			for (int i = 0; i < length; i++)
			{
				if (reader.PeekEntry(out name) == EntryType.EndOfArray)
				{
					reader.Context.Config.DebugContext.LogError("Reached end of array after " + i + " elements, when " + length + " elements were expected.");
					break;
				}
				array.SetValue(ValueReaderWriter.ReadValueWeak(reader), i);
				if (reader.PeekEntry(out name) == EntryType.EndOfStream)
				{
					break;
				}
			}
			reader.ExitArray();
		}
		else
		{
			reader.SkipEntry();
		}
	}

	protected override void SerializeImplementation(ref object value, IDataWriter writer)
	{
		Array array = (Array)value;
		try
		{
			int length = array.Length;
			writer.BeginArrayNode(length);
			for (int i = 0; i < length; i++)
			{
				ValueReaderWriter.WriteValueWeak(array.GetValue(i), writer);
			}
		}
		finally
		{
			writer.EndArrayNode();
		}
	}
}
