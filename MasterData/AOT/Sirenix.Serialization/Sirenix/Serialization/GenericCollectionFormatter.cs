using System;
using System.Collections.Generic;
using Sirenix.Serialization.Utilities;

namespace Sirenix.Serialization;

public static class GenericCollectionFormatter
{
	public static bool CanFormat(Type type, out Type elementType)
	{
		if (type == null)
		{
			throw new ArgumentNullException();
		}
		if (type.IsAbstract || type.IsGenericTypeDefinition || type.IsInterface || type.GetConstructor(Type.EmptyTypes) == null || !type.ImplementsOpenGenericInterface(typeof(ICollection<>)))
		{
			elementType = null;
			return false;
		}
		elementType = type.GetArgumentsOfInheritedOpenGenericInterface(typeof(ICollection<>))[0];
		return true;
	}
}
public sealed class GenericCollectionFormatter<TCollection, TElement> : BaseFormatter<TCollection> where TCollection : ICollection<TElement>, new()
{
	private static Serializer<TElement> valueReaderWriter;

	static GenericCollectionFormatter()
	{
		valueReaderWriter = Serializer.Get<TElement>();
		if (!GenericCollectionFormatter.CanFormat(typeof(TCollection), out var elementType))
		{
			throw new ArgumentException("Cannot treat the type " + typeof(TCollection).Name + " as a generic collection.");
		}
		if (elementType != typeof(TElement))
		{
			throw new ArgumentException("Type " + typeof(TElement).Name + " is not the element type of the generic collection type " + typeof(TCollection).Name + ".");
		}
		new GenericCollectionFormatter<List<int>, int>();
	}

	protected override TCollection GetUninitializedObject()
	{
		return new TCollection();
	}

	protected override void DeserializeImplementation(ref TCollection value, IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var name);
		if (entryType == EntryType.StartOfArray)
		{
			try
			{
				reader.EnterArray(out var length);
				for (int i = 0; i < length; i++)
				{
					if (reader.PeekEntry(out name) == EntryType.EndOfArray)
					{
						reader.Context.Config.DebugContext.LogError("Reached end of array after " + i + " elements, when " + length + " elements were expected.");
						break;
					}
					try
					{
						value.Add(valueReaderWriter.ReadValue(reader));
					}
					catch (Exception exception)
					{
						reader.Context.Config.DebugContext.LogException(exception);
					}
					if (!reader.IsInArrayNode)
					{
						reader.Context.Config.DebugContext.LogError("Reading array went wrong. Data dump: " + reader.GetDataDump());
						break;
					}
				}
				return;
			}
			catch (Exception exception2)
			{
				reader.Context.Config.DebugContext.LogException(exception2);
				return;
			}
			finally
			{
				reader.ExitArray();
			}
		}
		reader.SkipEntry();
	}

	protected override void SerializeImplementation(ref TCollection value, IDataWriter writer)
	{
		try
		{
			writer.BeginArrayNode(value.Count);
			foreach (TElement item in value)
			{
				valueReaderWriter.WriteValue(item, writer);
			}
		}
		finally
		{
			writer.EndArrayNode();
		}
	}
}
