using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using Sirenix.Serialization.Utilities;

namespace Sirenix.Serialization;

public class WeakStackFormatter : WeakBaseFormatter
{
	private readonly Serializer ElementSerializer;

	private readonly bool IsPlainStack;

	private readonly MethodInfo PushMethod;

	public WeakStackFormatter(Type serializedType)
		: base(serializedType)
	{
		Type[] argumentsOfInheritedOpenGenericClass = serializedType.GetArgumentsOfInheritedOpenGenericClass(typeof(Stack<>));
		ElementSerializer = Serializer.Get(argumentsOfInheritedOpenGenericClass[0]);
		IsPlainStack = serializedType.IsGenericType && serializedType.GetGenericTypeDefinition() == typeof(Stack<>);
		if (PushMethod == null)
		{
			throw new SerializationAbortException("Can't serialize type '" + serializedType.GetNiceFullName() + "' because no proper Push method was found.");
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
				if (IsPlainStack)
				{
					value = Activator.CreateInstance(SerializedType, (int)length);
				}
				else
				{
					value = Activator.CreateInstance(SerializedType);
				}
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
					PushMethod.Invoke(value, array);
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
			using Cache<List<object>> cache = Cache<List<object>>.Claim();
			List<object> value2 = cache.Value;
			value2.Clear();
			foreach (object item in collection)
			{
				value2.Add(item);
			}
			for (int num = value2.Count - 1; num >= 0; num--)
			{
				try
				{
					ElementSerializer.WriteValueWeak(value2[num], writer);
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
