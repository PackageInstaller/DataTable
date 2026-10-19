using System;
using System.Collections.Generic;
using System.Reflection;

namespace Sirenix.Serialization;

internal sealed class DerivedDictionaryFormatter<TDictionary, TKey, TValue> : BaseFormatter<TDictionary> where TDictionary : Dictionary<TKey, TValue>, new()
{
	private static readonly bool KeyIsValueType;

	private static readonly Serializer<IEqualityComparer<TKey>> EqualityComparerSerializer;

	private static readonly Serializer<TKey> KeyReaderWriter;

	private static readonly Serializer<TValue> ValueReaderWriter;

	private static readonly ConstructorInfo ComparerConstructor;

	static DerivedDictionaryFormatter()
	{
		KeyIsValueType = typeof(TKey).IsValueType;
		EqualityComparerSerializer = Serializer.Get<IEqualityComparer<TKey>>();
		KeyReaderWriter = Serializer.Get<TKey>();
		ValueReaderWriter = Serializer.Get<TValue>();
		ComparerConstructor = typeof(TDictionary).GetConstructor(new Type[1] { typeof(IEqualityComparer<TKey>) });
		new DerivedDictionaryFormatter<Dictionary<int, string>, int, string>();
	}

	protected override TDictionary GetUninitializedObject()
	{
		return null;
	}

	protected override void DeserializeImplementation(ref TDictionary value, IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var name);
		IEqualityComparer<TKey> equalityComparer = null;
		if (name == "comparer" || entryType == EntryType.StartOfNode)
		{
			equalityComparer = EqualityComparerSerializer.ReadValue(reader);
			entryType = reader.PeekEntry(out name);
		}
		if (entryType == EntryType.StartOfArray)
		{
			try
			{
				reader.EnterArray(out var length);
				if (equalityComparer != null && ComparerConstructor != null)
				{
					value = (TDictionary)ComparerConstructor.Invoke(new object[1] { equalityComparer });
				}
				else
				{
					value = new TDictionary();
				}
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
						TKey val = KeyReaderWriter.ReadValue(reader);
						TValue value2 = ValueReaderWriter.ReadValue(reader);
						if (!KeyIsValueType && val == null)
						{
							reader.Context.Config.DebugContext.LogWarning("Dictionary key of type '" + typeof(TKey).FullName + "' was null upon deserialization. A key has gone missing.");
							continue;
						}
						value[val] = value2;
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

	protected override void SerializeImplementation(ref TDictionary value, IDataWriter writer)
	{
		try
		{
			if (value.Comparer != null)
			{
				EqualityComparerSerializer.WriteValue("comparer", value.Comparer, writer);
			}
			writer.BeginArrayNode(value.Count);
			foreach (KeyValuePair<TKey, TValue> item in value)
			{
				bool flag = true;
				try
				{
					writer.BeginStructNode(null, null);
					KeyReaderWriter.WriteValue("$k", item.Key, writer);
					ValueReaderWriter.WriteValue("$v", item.Value, writer);
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
			writer.EndArrayNode();
		}
	}
}
