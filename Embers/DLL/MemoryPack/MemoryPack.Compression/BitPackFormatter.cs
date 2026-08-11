using System;
using System.Runtime.CompilerServices;
using MemoryPack.Internal;

namespace MemoryPack.Compression;

[Preserve]
public sealed class BitPackFormatter : MemoryPackFormatter<bool[]>
{
	public static readonly BitPackFormatter Default = new BitPackFormatter();

	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref bool[]? value)
	{
		if (value == null)
		{
			writer.WriteNullCollectionHeader();
			return;
		}
		writer.WriteCollectionHeader(value.Length);
		if (value.Length == 0)
		{
			return;
		}
		int data = 0;
		ref bool reference = ref value[0];
		ref bool right = ref Unsafe.Add(ref reference, value.Length);
		int num = 0;
		while (Unsafe.IsAddressLessThan(ref reference, ref right))
		{
			Set(ref data, num, reference);
			reference = ref Unsafe.Add(ref reference, 1);
			num++;
			if (num == 32)
			{
				writer.WriteUnmanaged(in data);
				data = 0;
				num = 0;
			}
		}
		if (num != 0)
		{
			writer.WriteUnmanaged(in data);
		}
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref bool[]? value)
	{
		if (!reader.DangerousTryReadCollectionHeader(out var length))
		{
			value = null;
			return;
		}
		if (length == 0)
		{
			value = Array.Empty<bool>();
			return;
		}
		int num = ((length - 1) / 32 + 1) * 4;
		if (reader.Remaining < num)
		{
			MemoryPackSerializationException.ThrowInsufficientBufferUnless(length);
		}
		if (value == null || value.Length != length)
		{
			value = new bool[length];
		}
		int num2 = 0;
		int value2 = 0;
		for (int i = 0; i < value.Length; i++)
		{
			if (num2 == 0)
			{
				reader.ReadUnmanaged<int>(out value2);
			}
			value[i] = Get(value2, num2);
			num2++;
			if (num2 == 32)
			{
				value2 = 0;
				num2 = 0;
			}
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public bool Get(int data, int index)
	{
		return (data & (1 << index)) != 0;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void Set(ref int data, int index, bool value)
	{
		int num = 1 << index;
		if (value)
		{
			data |= num;
		}
		else
		{
			data &= ~num;
		}
	}
}
