using System;
using System.Collections;
using System.Collections.Generic;
using Sirenix.Serialization.Utilities;

namespace Sirenix.Serialization;

internal sealed class WeakDoubleLookupDictionaryFormatter : WeakBaseFormatter
{
	private readonly Serializer PrimaryReaderWriter;

	private readonly Serializer InnerReaderWriter;

	public WeakDoubleLookupDictionaryFormatter(Type serializedType)
		: base(serializedType)
	{
		Type[] argumentsOfInheritedOpenGenericClass = serializedType.GetArgumentsOfInheritedOpenGenericClass(typeof(Dictionary<, >));
		PrimaryReaderWriter = Serializer.Get(argumentsOfInheritedOpenGenericClass[0]);
		InnerReaderWriter = Serializer.Get(argumentsOfInheritedOpenGenericClass[1]);
	}

	protected override object GetUninitializedObject()
	{
		return null;
	}

	protected override void SerializeImplementation(ref object value, IDataWriter writer)
	{
		try
		{
			IDictionary dictionary = (IDictionary)value;
			writer.BeginArrayNode(dictionary.Count);
			bool flag = true;
			IDictionaryEnumerator enumerator = dictionary.GetEnumerator();
			try
			{
				while (enumerator.MoveNext())
				{
					try
					{
						writer.BeginStructNode(null, null);
						PrimaryReaderWriter.WriteValueWeak("$k", enumerator.Key, writer);
						InnerReaderWriter.WriteValueWeak("$v", enumerator.Value, writer);
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

	protected override void DeserializeImplementation(ref object value, IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var name);
		if (entryType == EntryType.StartOfArray)
		{
			try
			{
				reader.EnterArray(out var length);
				value = Activator.CreateInstance(SerializedType);
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
						object key = PrimaryReaderWriter.ReadValueWeak(reader);
						object value2 = InnerReaderWriter.ReadValueWeak(reader);
						dictionary.Add(key, value2);
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
