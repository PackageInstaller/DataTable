using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using Sirenix.Serialization.Utilities;

namespace Sirenix.Serialization;

public class WeakHashSetFormatter : WeakBaseFormatter
{
	private readonly Serializer ElementSerializer;

	private readonly MethodInfo AddMethod;

	private readonly PropertyInfo CountProperty;

	public WeakHashSetFormatter(Type serializedType)
		: base(serializedType)
	{
		Type[] argumentsOfInheritedOpenGenericClass = serializedType.GetArgumentsOfInheritedOpenGenericClass(typeof(HashSet<>));
		ElementSerializer = Serializer.Get(argumentsOfInheritedOpenGenericClass[0]);
		AddMethod = serializedType.GetMethod("Add", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic, null, new Type[1] { argumentsOfInheritedOpenGenericClass[0] }, null);
		CountProperty = serializedType.GetProperty("Count", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
		if (AddMethod == null)
		{
			throw new SerializationAbortException("Can't serialize/deserialize hashset of type '" + serializedType.GetNiceFullName() + "' since a proper Add method wasn't found.");
		}
		if (CountProperty == null)
		{
			throw new SerializationAbortException("Can't serialize/deserialize hashset of type '" + serializedType.GetNiceFullName() + "' since a proper Count property wasn't found.");
		}
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
				value = Activator.CreateInstance(SerializedType);
				RegisterReferenceID(value, reader);
				object[] array = new object[1];
				for (int i = 0; i < length; i++)
				{
					if (reader.PeekEntry(out name) == EntryType.EndOfArray)
					{
						reader.Context.Config.DebugContext.LogError("Reached end of array after " + i + " elements, when " + length + " elements were expected.");
						break;
					}
					array[0] = ElementSerializer.ReadValueWeak(reader);
					AddMethod.Invoke(value, array);
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
			writer.BeginArrayNode((int)CountProperty.GetValue(value, null));
			foreach (object item in (IEnumerable)value)
			{
				try
				{
					ElementSerializer.WriteValueWeak(item, writer);
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
