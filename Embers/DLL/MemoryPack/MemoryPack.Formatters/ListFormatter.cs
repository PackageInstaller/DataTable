using System.Collections.Generic;
using System.Runtime.CompilerServices;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public static class ListFormatter
{
	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	[Preserve]
	public static void SerializePackable<T>(ref MemoryPackWriter writer, ref List<T?>? value) where T : IMemoryPackable<T>
	{
		if (value == null)
		{
			writer.WriteNullCollectionHeader();
			return;
		}
		IMemoryPackFormatter<T> formatter = writer.GetFormatter<T>();
		writer.WriteCollectionHeader(value.Count);
		foreach (T item in value)
		{
			T value2 = item;
			formatter.Serialize(ref writer, ref value2);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	[Preserve]
	public static List<T?>? DeserializePackable<T>(ref MemoryPackReader reader) where T : IMemoryPackable<T>
	{
		List<T> value = null;
		DeserializePackable(ref reader, ref value);
		return value;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	[Preserve]
	public static void DeserializePackable<T>(ref MemoryPackReader reader, ref List<T?>? value) where T : IMemoryPackable<T>
	{
		if (!reader.TryReadCollectionHeader(out var length))
		{
			value = null;
			return;
		}
		if (value == null)
		{
			value = new List<T>(length);
		}
		else
		{
			value.Clear();
		}
		IMemoryPackFormatter<T> formatter = reader.GetFormatter<T>();
		for (int i = 0; i < length; i++)
		{
			T value2 = default(T);
			formatter.Deserialize(ref reader, ref value2);
			value.Add(value2);
		}
	}
}
[Preserve]
public sealed class ListFormatter<T> : MemoryPackFormatter<List<T?>>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref List<T?>? value)
	{
		if (value == null)
		{
			writer.WriteNullCollectionHeader();
			return;
		}
		IMemoryPackFormatter<T> formatter = writer.GetFormatter<T>();
		writer.WriteCollectionHeader(value.Count);
		foreach (T item in value)
		{
			T value2 = item;
			formatter.Serialize(ref writer, ref value2);
		}
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref List<T?>? value)
	{
		if (!reader.TryReadCollectionHeader(out var length))
		{
			value = null;
			return;
		}
		if (value == null)
		{
			value = new List<T>(length);
		}
		else
		{
			value.Clear();
		}
		IMemoryPackFormatter<T> formatter = reader.GetFormatter<T>();
		for (int i = 0; i < length; i++)
		{
			T value2 = default(T);
			formatter.Deserialize(ref reader, ref value2);
			value.Add(value2);
		}
	}
}
