using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using Sirenix.Serialization.Utilities;

namespace Sirenix.Serialization;

internal sealed class WeakDictionaryFormatter : WeakBaseFormatter
{
	private readonly bool KeyIsValueType;

	private readonly Serializer EqualityComparerSerializer;

	private readonly Serializer KeyReaderWriter;

	private readonly Serializer ValueReaderWriter;

	private readonly ConstructorInfo ComparerConstructor;

	private readonly PropertyInfo ComparerProperty;

	private readonly PropertyInfo CountProperty;

	private readonly Type KeyType;

	private readonly Type ValueType;

	public WeakDictionaryFormatter(Type serializedType)
		: base(serializedType)
	{
		Type[] argumentsOfInheritedOpenGenericClass = serializedType.GetArgumentsOfInheritedOpenGenericClass(typeof(Dictionary<, >));
		KeyType = argumentsOfInheritedOpenGenericClass[0];
		ValueType = argumentsOfInheritedOpenGenericClass[1];
		KeyIsValueType = KeyType.IsValueType;
		KeyReaderWriter = Serializer.Get(KeyType);
		ValueReaderWriter = Serializer.Get(ValueType);
		CountProperty = serializedType.GetProperty("Count");
		if (CountProperty == null)
		{
			throw new SerializationAbortException("Can't serialize/deserialize the type " + serializedType.GetNiceFullName() + " because it has no accessible Count property.");
		}
		try
		{
			Type type = typeof(IEqualityComparer<>).MakeGenericType(KeyType);
			EqualityComparerSerializer = Serializer.Get(type);
			ComparerConstructor = serializedType.GetConstructor(new Type[1] { type });
			ComparerProperty = serializedType.GetProperty("Comparer");
		}
		catch (Exception)
		{
			EqualityComparerSerializer = Serializer.Get<object>();
			ComparerConstructor = null;
			ComparerProperty = null;
		}
	}

	protected override object GetUninitializedObject()
	{
		return null;
	}

	protected override void DeserializeImplementation(ref object value, IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var name);
		object obj = null;
		if (name == "comparer" || entryType == EntryType.StartOfNode)
		{
			obj = EqualityComparerSerializer.ReadValueWeak(reader);
			entryType = reader.PeekEntry(out name);
		}
		if (entryType == EntryType.StartOfArray)
		{
			try
			{
				reader.EnterArray(out var length);
				if (obj != null && ComparerConstructor != null)
				{
					value = ComparerConstructor.Invoke(new object[1] { obj });
				}
				else
				{
					value = Activator.CreateInstance(SerializedType);
				}
				IDictionary dictionary = (IDictionary)value;
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
						object obj2 = KeyReaderWriter.ReadValueWeak(reader);
						object value2 = ValueReaderWriter.ReadValueWeak(reader);
						if (!KeyIsValueType && obj2 == null)
						{
							reader.Context.Config.DebugContext.LogWarning("Dictionary key of type '" + KeyType.FullName + "' was null upon deserialization. A key has gone missing.");
							continue;
						}
						dictionary[obj2] = value2;
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

	protected override void SerializeImplementation(ref object value, IDataWriter writer)
	{
		try
		{
			IDictionary dictionary = (IDictionary)value;
			if (ComparerProperty != null)
			{
				object value2 = ComparerProperty.GetValue(value, null);
				if (value2 != null)
				{
					EqualityComparerSerializer.WriteValueWeak("comparer", value2, writer);
				}
			}
			writer.BeginArrayNode((int)CountProperty.GetValue(value, null));
			IDictionaryEnumerator enumerator = dictionary.GetEnumerator();
			try
			{
				while (enumerator.MoveNext())
				{
					bool flag = true;
					try
					{
						writer.BeginStructNode(null, null);
						KeyReaderWriter.WriteValueWeak("$k", enumerator.Key, writer);
						ValueReaderWriter.WriteValueWeak("$v", enumerator.Value, writer);
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
				enumerator.Reset();
				if (enumerator is IDisposable disposable)
				{
					disposable.Dispose();
				}
			}
		}
		finally
		{
			writer.EndArrayNode();
		}
	}
}
