using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Runtime.CompilerServices;

namespace MemoryPack.Formatters;

internal static class InterfaceCollectionFormatterUtils
{
	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static bool TrySerializeOptimized<TCollection, TElement>(ref MemoryPackWriter writer, [NotNullWhen(false)] ref TCollection? value) where TCollection : IEnumerable<TElement>
	{
		if (value == null)
		{
			writer.WriteNullCollectionHeader();
			return true;
		}
		if (value is TElement[] value2)
		{
			writer.WriteArray(value2);
			return true;
		}
		return false;
	}

	public static void SerializeCollection<TCollection, TElement>(ref MemoryPackWriter writer, ref TCollection? value) where TCollection : ICollection<TElement>
	{
		if (TrySerializeOptimized<TCollection, TElement>(ref writer, ref value))
		{
			return;
		}
		IMemoryPackFormatter<TElement> formatter = writer.GetFormatter<TElement>();
		writer.WriteCollectionHeader(value.Count);
		foreach (TElement item in value)
		{
			TElement value2 = item;
			formatter.Serialize(ref writer, ref value2);
		}
	}

	public static void SerializeReadOnlyCollection<TCollection, TElement>(ref MemoryPackWriter writer, ref TCollection? value) where TCollection : IReadOnlyCollection<TElement>
	{
		if (TrySerializeOptimized<TCollection, TElement>(ref writer, ref value))
		{
			return;
		}
		IMemoryPackFormatter<TElement> formatter = writer.GetFormatter<TElement>();
		writer.WriteCollectionHeader(value.Count);
		foreach (TElement item in value)
		{
			TElement value2 = item;
			formatter.Serialize(ref writer, ref value2);
		}
	}

	public static List<T?>? ReadList<T>(ref MemoryPackReader reader)
	{
		IMemoryPackFormatter<List<T>> formatter = reader.GetFormatter<List<T>>();
		List<T> value = null;
		formatter.Deserialize(ref reader, ref value);
		return value;
	}
}
