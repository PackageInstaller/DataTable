using System;
using System.Globalization;
using System.Text;

namespace Sirenix.Serialization;

public sealed class MultiDimensionalArrayFormatter<TArray, TElement> : BaseFormatter<TArray> where TArray : class
{
	private const string RANKS_NAME = "ranks";

	private const char RANKS_SEPARATOR = '|';

	private static readonly int ArrayRank;

	private static readonly Serializer<TElement> ValueReaderWriter;

	static MultiDimensionalArrayFormatter()
	{
		ValueReaderWriter = Serializer.Get<TElement>();
		if (!typeof(TArray).IsArray)
		{
			throw new ArgumentException("Type " + typeof(TArray).Name + " is not an array.");
		}
		if (typeof(TArray).GetElementType() != typeof(TElement))
		{
			throw new ArgumentException("Array of type " + typeof(TArray).Name + " does not have the required element type of " + typeof(TElement).Name + ".");
		}
		ArrayRank = typeof(TArray).GetArrayRank();
		if (ArrayRank <= 1)
		{
			throw new ArgumentException("Array of type " + typeof(TArray).Name + " only has one rank.");
		}
	}

	protected override TArray GetUninitializedObject()
	{
		return null;
	}

	protected override void DeserializeImplementation(ref TArray value, IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var name);
		if (entryType == EntryType.StartOfArray)
		{
			reader.EnterArray(out var length);
			entryType = reader.PeekEntry(out name);
			if (entryType != EntryType.String || name != "ranks")
			{
				value = null;
				reader.SkipEntry();
				return;
			}
			reader.ReadString(out var value2);
			string[] array = value2.Split(new char[1] { '|' });
			if (array.Length != ArrayRank)
			{
				value = null;
				reader.SkipEntry();
				return;
			}
			int[] array2 = new int[array.Length];
			for (int i = 0; i < array.Length; i++)
			{
				if (int.TryParse(array[i], out var result))
				{
					array2[i] = result;
					continue;
				}
				value = null;
				reader.SkipEntry();
				return;
			}
			long num = array2[0];
			for (int j = 1; j < array2.Length; j++)
			{
				num *= array2[j];
			}
			if (num != length)
			{
				value = null;
				reader.SkipEntry();
				return;
			}
			value = (TArray)(object)Array.CreateInstance(typeof(TElement), array2);
			RegisterReferenceID(value, reader);
			int elements = 0;
			try
			{
				IterateArrayWrite((Array)(object)value, () =>
				{
					if (reader.PeekEntry(out name) == EntryType.EndOfArray)
					{
						reader.Context.Config.DebugContext.LogError("Reached end of array after " + elements + " elements, when " + length + " elements were expected.");
						throw new InvalidOperationException();
					}
					TElement result2 = ValueReaderWriter.ReadValue(reader);
					if (!reader.IsInArrayNode)
					{
						reader.Context.Config.DebugContext.LogError("Reading array went wrong. Data dump: " + reader.GetDataDump());
						throw new InvalidOperationException();
					}
					elements++;
					return result2;
				});
			}
			catch (InvalidOperationException)
			{
			}
			catch (Exception exception)
			{
				reader.Context.Config.DebugContext.LogException(exception);
			}
			reader.ExitArray();
		}
		else
		{
			value = null;
			reader.SkipEntry();
		}
	}

	protected override void SerializeImplementation(ref TArray value, IDataWriter writer)
	{
		Array array = value as Array;
		try
		{
			writer.BeginArrayNode(array.LongLength);
			int[] array2 = new int[ArrayRank];
			for (int i = 0; i < ArrayRank; i++)
			{
				array2[i] = array.GetLength(i);
			}
			StringBuilder stringBuilder = new StringBuilder();
			for (int j = 0; j < ArrayRank; j++)
			{
				if (j > 0)
				{
					stringBuilder.Append('|');
				}
				stringBuilder.Append(array2[j].ToString(CultureInfo.InvariantCulture));
			}
			string value2 = stringBuilder.ToString();
			writer.WriteString("ranks", value2);
			IterateArrayRead((Array)(object)value, (TElement v) =>
			{
				ValueReaderWriter.WriteValue(v, writer);
			});
		}
		finally
		{
			writer.EndArrayNode();
		}
	}

	private void IterateArrayWrite(Array a, Func<TElement> write)
	{
		int[] indices = new int[ArrayRank];
		IterateArrayWrite(a, 0, indices, write);
	}

	private void IterateArrayWrite(Array a, int rank, int[] indices, Func<TElement> write)
	{
		for (int i = 0; i < a.GetLength(rank); i++)
		{
			indices[rank] = i;
			if (rank + 1 < a.Rank)
			{
				IterateArrayWrite(a, rank + 1, indices, write);
			}
			else
			{
				a.SetValue(write(), indices);
			}
		}
	}

	private void IterateArrayRead(Array a, Action<TElement> read)
	{
		int[] indices = new int[ArrayRank];
		IterateArrayRead(a, 0, indices, read);
	}

	private void IterateArrayRead(Array a, int rank, int[] indices, Action<TElement> read)
	{
		for (int i = 0; i < a.GetLength(rank); i++)
		{
			indices[rank] = i;
			if (rank + 1 < a.Rank)
			{
				IterateArrayRead(a, rank + 1, indices, read);
			}
			else
			{
				read((TElement)a.GetValue(indices));
			}
		}
	}
}
