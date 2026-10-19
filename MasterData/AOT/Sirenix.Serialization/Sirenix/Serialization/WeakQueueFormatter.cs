using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using Sirenix.Serialization.Utilities;

namespace Sirenix.Serialization;

public class WeakQueueFormatter : WeakBaseFormatter
{
	private readonly Serializer ElementSerializer;

	private readonly bool IsPlainQueue;

	private MethodInfo EnqueueMethod;

	public WeakQueueFormatter(Type serializedType)
		: base(serializedType)
	{
		Type[] argumentsOfInheritedOpenGenericClass = serializedType.GetArgumentsOfInheritedOpenGenericClass(typeof(Queue<>));
		ElementSerializer = Serializer.Get(argumentsOfInheritedOpenGenericClass[0]);
		IsPlainQueue = serializedType.IsGenericType && serializedType.GetGenericTypeDefinition() == typeof(Queue<>);
		EnqueueMethod = serializedType.GetMethod("Enqueue", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic, null, new Type[1] { argumentsOfInheritedOpenGenericClass[0] }, null);
		if (EnqueueMethod == null)
		{
			throw new SerializationAbortException("Can't serialize type '" + serializedType.GetNiceFullName() + "' because no proper Enqueue method was found.");
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
				if (IsPlainQueue)
				{
					value = Activator.CreateInstance(SerializedType, (int)length);
				}
				else
				{
					value = Activator.CreateInstance(SerializedType);
				}
				ICollection collection = (ICollection)value;
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
					EnqueueMethod.Invoke(value, array);
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
			ICollection collection = (ICollection)value;
			writer.BeginArrayNode(collection.Count);
			foreach (object item in collection)
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
