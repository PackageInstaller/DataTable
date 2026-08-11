using System;
using System.Buffers;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;
using MemoryPack.Internal;

namespace MemoryPack;

[StructLayout(LayoutKind.Auto)]
public ref struct MemoryPackWriter
{
	private const int DepthLimit = 1000;

	private IBufferWriter<byte> bufferWriter;

	private Span<byte> bufferReference;

	private int bufferLength;

	private int advancedCount;

	private int depth;

	private int writtenCount;

	private readonly bool serializeStringAsUtf8;

	private readonly MemoryPackWriterOptionalState optionalState;

	public int WrittenCount => writtenCount;

	public int BufferLength => bufferLength;

	public MemoryPackWriterOptionalState OptionalState => optionalState;

	public MemoryPackSerializerOptions Options => optionalState.Options;

	public void WriteVarInt(byte x)
	{
		if (x <= 127)
		{
			WriteUnmanaged<sbyte>((sbyte)x);
		}
		else
		{
			WriteUnmanaged<sbyte, byte>((sbyte)(-121), in x);
		}
	}

	public void WriteVarInt(sbyte x)
	{
		if (-120 <= x)
		{
			WriteUnmanaged(in x);
		}
		else
		{
			WriteUnmanaged<sbyte, sbyte>((sbyte)(-122), in x);
		}
	}

	public void WriteVarInt(ushort x)
	{
		if (x <= 127)
		{
			WriteUnmanaged<sbyte>((sbyte)x);
			return;
		}
		sbyte value = -123;
		ushort value2 = x;
		WriteUnmanaged(in value, in value2);
	}

	public void WriteVarInt(short x)
	{
		if (0 <= x)
		{
			if (x <= 127)
			{
				WriteUnmanaged<sbyte>((sbyte)x);
				return;
			}
			sbyte value = -124;
			short value2 = x;
			WriteUnmanaged(in value, in value2);
		}
		else if (-120 <= x)
		{
			WriteUnmanaged<sbyte>((sbyte)x);
		}
		else if (-128 <= x)
		{
			WriteUnmanaged<sbyte, sbyte>((sbyte)(-122), (sbyte)x);
		}
		else
		{
			sbyte value = -124;
			short value2 = x;
			WriteUnmanaged(in value, in value2);
		}
	}

	public void WriteVarInt(uint x)
	{
		if (x <= 127)
		{
			WriteUnmanaged<sbyte>((sbyte)x);
			return;
		}
		if (x <= 65535)
		{
			WriteUnmanaged<sbyte, ushort>((sbyte)(-123), (ushort)x);
			return;
		}
		sbyte value = -125;
		uint value2 = x;
		WriteUnmanaged(in value, in value2);
	}

	public void WriteVarInt(int x)
	{
		if (0 <= x)
		{
			if (x <= 127)
			{
				WriteUnmanaged<sbyte>((sbyte)x);
				return;
			}
			if (x <= 32767)
			{
				WriteUnmanaged<sbyte, short>((sbyte)(-124), (short)x);
				return;
			}
			sbyte value = -126;
			int value2 = x;
			WriteUnmanaged(in value, in value2);
		}
		else if (-120 <= x)
		{
			WriteUnmanaged<sbyte>((sbyte)x);
		}
		else if (-128 <= x)
		{
			WriteUnmanaged<sbyte, sbyte>((sbyte)(-122), (sbyte)x);
		}
		else if (-32768 <= x)
		{
			WriteUnmanaged<sbyte, short>((sbyte)(-124), (short)x);
		}
		else
		{
			sbyte value = -126;
			int value2 = x;
			WriteUnmanaged(in value, in value2);
		}
	}

	public void WriteVarInt(ulong x)
	{
		if (x <= 127)
		{
			WriteUnmanaged<sbyte>((sbyte)x);
			return;
		}
		if (x <= 65535)
		{
			WriteUnmanaged<sbyte, ushort>((sbyte)(-123), (ushort)x);
			return;
		}
		if (x <= uint.MaxValue)
		{
			WriteUnmanaged<sbyte, uint>((sbyte)(-125), (uint)x);
			return;
		}
		sbyte value = -127;
		ulong value2 = x;
		WriteUnmanaged(in value, in value2);
	}

	public void WriteVarInt(long x)
	{
		if (0 <= x)
		{
			if (x <= 127)
			{
				WriteUnmanaged<sbyte>((sbyte)x);
				return;
			}
			if (x <= 32767)
			{
				WriteUnmanaged<sbyte, short>((sbyte)(-124), (short)x);
				return;
			}
			if (x <= int.MaxValue)
			{
				WriteUnmanaged<sbyte, int>((sbyte)(-126), (int)x);
				return;
			}
			sbyte value = sbyte.MinValue;
			long value2 = x;
			WriteUnmanaged(in value, in value2);
		}
		else if (-120 <= x)
		{
			WriteUnmanaged<sbyte>((sbyte)x);
		}
		else if (-128 <= x)
		{
			WriteUnmanaged<sbyte, sbyte>((sbyte)(-122), (sbyte)x);
		}
		else if (-32768 <= x)
		{
			WriteUnmanaged<sbyte, short>((sbyte)(-124), (short)x);
		}
		else if (int.MinValue <= x)
		{
			WriteUnmanaged<sbyte, int>((sbyte)(-126), (int)x);
		}
		else
		{
			sbyte value = sbyte.MinValue;
			long value2 = x;
			WriteUnmanaged(in value, in value2);
		}
	}

	public MemoryPackWriter(ref IBufferWriter<byte> writer, MemoryPackWriterOptionalState optionalState)
	{
		bufferWriter = writer;
		bufferReference = default(Span<byte>);
		bufferLength = 0;
		advancedCount = 0;
		writtenCount = 0;
		depth = 0;
		serializeStringAsUtf8 = optionalState.Options.StringEncoding == StringEncoding.Utf8;
		this.optionalState = optionalState;
	}

	public MemoryPackWriter(ref IBufferWriter<byte> writer, byte[] firstBufferOfWriter, MemoryPackWriterOptionalState optionalState)
	{
		bufferWriter = writer;
		bufferReference = MemoryExtensions.AsSpan(firstBufferOfWriter);
		bufferLength = firstBufferOfWriter.Length;
		advancedCount = 0;
		writtenCount = 0;
		depth = 0;
		serializeStringAsUtf8 = optionalState.Options.StringEncoding == StringEncoding.Utf8;
		this.optionalState = optionalState;
	}

	public MemoryPackWriter(ref IBufferWriter<byte> writer, Span<byte> firstBufferOfWriter, MemoryPackWriterOptionalState optionalState)
	{
		bufferWriter = writer;
		bufferReference = firstBufferOfWriter;
		bufferLength = firstBufferOfWriter.Length;
		advancedCount = 0;
		writtenCount = 0;
		depth = 0;
		serializeStringAsUtf8 = optionalState.Options.StringEncoding == StringEncoding.Utf8;
		this.optionalState = optionalState;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public ref byte GetSpanReference(int sizeHint)
	{
		if (bufferLength < sizeHint)
		{
			RequestNewBuffer(sizeHint);
		}
		return ref MemoryMarshal.GetReference(bufferReference);
	}

	[MethodImpl(MethodImplOptions.NoInlining)]
	private void RequestNewBuffer(int sizeHint)
	{
		if (advancedCount != 0)
		{
			bufferWriter.Advance(advancedCount);
			advancedCount = 0;
		}
		Span<byte> span = (bufferReference = bufferWriter.GetSpan(sizeHint));
		bufferLength = span.Length;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void Advance(int count)
	{
		if (count != 0)
		{
			int num = bufferLength - count;
			if (num < 0)
			{
				MemoryPackSerializationException.ThrowInvalidAdvance();
			}
			bufferLength = num;
			bufferReference = bufferReference.Slice(count);
			advancedCount += count;
			writtenCount += count;
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void Flush()
	{
		if (advancedCount != 0)
		{
			bufferWriter.Advance(advancedCount);
			advancedCount = 0;
		}
		bufferReference = default(Span<byte>);
		bufferLength = 0;
		writtenCount = 0;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public IMemoryPackFormatter GetFormatter(Type type)
	{
		return MemoryPackFormatterProvider.GetFormatter(type);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public IMemoryPackFormatter<T> GetFormatter<T>()
	{
		return MemoryPackFormatterProvider.GetFormatter<T>();
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public int GetStringWriteLength(string? value)
	{
		if (value == null || value.Length == 0)
		{
			return 4;
		}
		if (serializeStringAsUtf8)
		{
			return Encoding.UTF8.GetByteCount(value) + 8;
		}
		return checked(value.Length * 2) + 4;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public int GetUnmanageArrayWriteLength<T>(T[]? value) where T : unmanaged
	{
		if (value == null || value.Length == 0)
		{
			return 4;
		}
		return Unsafe.SizeOf<T>() * value.Length + 4;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteObjectHeader(byte memberCount)
	{
		if (memberCount >= 250)
		{
			MemoryPackSerializationException.ThrowWriteInvalidMemberCount(memberCount);
		}
		GetSpanReference(1) = memberCount;
		Advance(1);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteNullObjectHeader()
	{
		GetSpanReference(1) = byte.MaxValue;
		Advance(1);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteObjectReferenceId(uint referenceId)
	{
		GetSpanReference(1) = 250;
		Advance(1);
		WriteVarInt(referenceId);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnionHeader(ushort tag)
	{
		if (tag < 250)
		{
			GetSpanReference(1) = (byte)tag;
			Advance(1);
			return;
		}
		ref byte spanReference = ref GetSpanReference(3);
		Unsafe.WriteUnaligned(ref spanReference, (byte)250);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), tag);
		Advance(3);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteNullUnionHeader()
	{
		WriteNullObjectHeader();
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteCollectionHeader(int length)
	{
		Unsafe.WriteUnaligned(ref GetSpanReference(4), length);
		Advance(4);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteNullCollectionHeader()
	{
		Unsafe.WriteUnaligned(ref GetSpanReference(4), -1);
		Advance(4);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteString(string? value)
	{
		if (serializeStringAsUtf8)
		{
			WriteUtf8(value);
		}
		else
		{
			WriteUtf16(value);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUtf16(string? value)
	{
		if (value == null)
		{
			WriteNullCollectionHeader();
			return;
		}
		if (value.Length == 0)
		{
			WriteCollectionHeader(0);
			return;
		}
		int num = checked(value.Length * 2);
		ref byte spanReference = ref GetSpanReference(num + 4);
		Unsafe.WriteUnaligned(ref spanReference, value.Length);
		MemoryMarshal.AsBytes(MemoryExtensions.AsSpan(value)).CopyTo(MemoryMarshal.CreateSpan(ref Unsafe.Add(ref spanReference, 4), num));
		Advance(num + 4);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUtf16(ReadOnlySpan<char> value)
	{
		if (value.Length == 0)
		{
			WriteCollectionHeader(0);
			return;
		}
		int num = checked(value.Length * 2);
		ref byte spanReference = ref GetSpanReference(num + 4);
		Unsafe.WriteUnaligned(ref spanReference, value.Length);
		MemoryMarshal.AsBytes(value).CopyTo(MemoryMarshal.CreateSpan(ref Unsafe.Add(ref spanReference, 4), num));
		Advance(num + 4);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUtf8(string? value)
	{
		if (value == null)
		{
			WriteNullCollectionHeader();
			return;
		}
		if (value.Length == 0)
		{
			WriteCollectionHeader(0);
			return;
		}
		ReadOnlySpan<char> readOnlySpan = MemoryExtensions.AsSpan(value);
		int num = (readOnlySpan.Length + 1) * 3;
		ref byte spanReference = ref GetSpanReference(num + 8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 4), readOnlySpan.Length);
		Span<byte> bytes = MemoryMarshal.CreateSpan(ref Unsafe.Add(ref spanReference, 8), num);
		int bytes2 = Encoding.UTF8.GetBytes(value, bytes);
		Unsafe.WriteUnaligned(ref spanReference, ~bytes2);
		Advance(bytes2 + 8);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUtf8(ReadOnlySpan<byte> utf8Value, int utf16Length = -1)
	{
		if (utf8Value.Length == 0)
		{
			WriteCollectionHeader(0);
			return;
		}
		ref byte spanReference = ref GetSpanReference(utf8Value.Length + 8);
		Unsafe.WriteUnaligned(ref spanReference, ~utf8Value.Length);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 4), utf16Length);
		Span<byte> destination = MemoryMarshal.CreateSpan(ref Unsafe.Add(ref spanReference, 8), utf8Value.Length);
		utf8Value.CopyTo(destination);
		Advance(utf8Value.Length + 8);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WritePackable<T>(in T? value) where T : IMemoryPackable<T>
	{
		WriteValue(in value);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteValue<T>(in T? value)
	{
		depth++;
		if (depth == 1000)
		{
			MemoryPackSerializationException.ThrowReachedDepthLimit(typeof(T));
		}
		GetFormatter<T>().Serialize(ref this, ref Unsafe.AsRef(in value));
		depth--;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteValue(Type type, object? value)
	{
		depth++;
		if (depth == 1000)
		{
			MemoryPackSerializationException.ThrowReachedDepthLimit(type);
		}
		GetFormatter(type).Serialize(ref this, ref value);
		depth--;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteValueWithFormatter<TFormatter, T>(TFormatter formatter, in T? value) where TFormatter : IMemoryPackFormatter<T>
	{
		depth++;
		formatter.Serialize(ref this, ref Unsafe.AsRef(in value));
		depth--;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteArray<T>(T?[]? value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			DangerousWriteUnmanagedArray(value);
			return;
		}
		if (value == null)
		{
			WriteNullCollectionHeader();
			return;
		}
		IMemoryPackFormatter<T> formatter = GetFormatter<T>();
		WriteCollectionHeader(value.Length);
		for (int i = 0; i < value.Length; i++)
		{
			formatter.Serialize(ref this, ref value[i]);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteSpan<T>(Span<T?> value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			DangerousWriteUnmanagedSpan(value);
			return;
		}
		IMemoryPackFormatter<T> formatter = GetFormatter<T>();
		WriteCollectionHeader(value.Length);
		for (int i = 0; i < value.Length; i++)
		{
			formatter.Serialize(ref this, ref value[i]);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteSpan<T>(ReadOnlySpan<T?> value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			DangerousWriteUnmanagedSpan(value);
			return;
		}
		IMemoryPackFormatter<T> formatter = GetFormatter<T>();
		WriteCollectionHeader(value.Length);
		for (int i = 0; i < value.Length; i++)
		{
			formatter.Serialize(ref this, ref Unsafe.AsRef(in value[i]));
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WritePackableArray<T>(T?[]? value) where T : IMemoryPackable<T>
	{
		WriteArray(value);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WritePackableSpan<T>(Span<T?> value) where T : IMemoryPackable<T>
	{
		WriteSpan(value);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WritePackableSpan<T>(ReadOnlySpan<T?> value) where T : IMemoryPackable<T>
	{
		WriteSpan(value);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanagedArray<T>(T[]? value) where T : unmanaged
	{
		DangerousWriteUnmanagedArray(value);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanagedSpan<T>(Span<T> value) where T : unmanaged
	{
		DangerousWriteUnmanagedSpan(value);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanagedSpan<T>(ReadOnlySpan<T> value) where T : unmanaged
	{
		DangerousWriteUnmanagedSpan(value);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanagedArray<T>(T[]? value)
	{
		if (value == null)
		{
			WriteNullCollectionHeader();
			return;
		}
		if (value.Length == 0)
		{
			WriteCollectionHeader(0);
			return;
		}
		int num = Unsafe.SizeOf<T>() * value.Length;
		int num2 = num + 4;
		ref byte spanReference = ref GetSpanReference(num2);
		ref byte source = ref Unsafe.As<T, byte>(ref MemoryMarshalEx.GetArrayDataReference(value));
		Unsafe.WriteUnaligned(ref spanReference, value.Length);
		Unsafe.CopyBlockUnaligned(ref Unsafe.Add(ref spanReference, 4), ref source, (uint)num);
		Advance(num2);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanagedSpan<T>(Span<T> value)
	{
		if (value.Length == 0)
		{
			WriteCollectionHeader(0);
			return;
		}
		int num = Unsafe.SizeOf<T>() * value.Length;
		int num2 = num + 4;
		ref byte spanReference = ref GetSpanReference(num2);
		ref byte source = ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(value));
		Unsafe.WriteUnaligned(ref spanReference, value.Length);
		Unsafe.CopyBlockUnaligned(ref Unsafe.Add(ref spanReference, 4), ref source, (uint)num);
		Advance(num2);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanagedSpan<T>(ReadOnlySpan<T> value)
	{
		if (value.Length == 0)
		{
			WriteCollectionHeader(0);
			return;
		}
		int num = Unsafe.SizeOf<T>() * value.Length;
		int num2 = num + 4;
		ref byte spanReference = ref GetSpanReference(num2);
		ref byte source = ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(value));
		Unsafe.WriteUnaligned(ref spanReference, value.Length);
		Unsafe.CopyBlockUnaligned(ref Unsafe.Add(ref spanReference, 4), ref source, (uint)num);
		Advance(num2);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteSpanWithoutLengthHeader<T>(ReadOnlySpan<T?> value)
	{
		if (value.Length == 0)
		{
			return;
		}
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			int num = Unsafe.SizeOf<T>() * value.Length;
			Unsafe.CopyBlockUnaligned(ref GetSpanReference(num), ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(value)), (uint)num);
			Advance(num);
			return;
		}
		IMemoryPackFormatter<T> formatter = GetFormatter<T>();
		for (int i = 0; i < value.Length; i++)
		{
			formatter.Serialize(ref this, ref Unsafe.AsRef(in value[i]));
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanaged<T1>(in T1 value1) where T1 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>();
		Unsafe.WriteUnaligned(ref GetSpanReference(num), value1);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanagedWithObjectHeader<T1>(byte propertyCount, in T1 value1) where T1 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanaged<T1, T2>(in T1 value1, in T2 value2) where T1 : unmanaged where T2 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanagedWithObjectHeader<T1, T2>(byte propertyCount, in T1 value1, in T2 value2) where T1 : unmanaged where T2 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanaged<T1, T2, T3>(in T1 value1, in T2 value2, in T3 value3) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanagedWithObjectHeader<T1, T2, T3>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanaged<T1, T2, T3, T4>(in T1 value1, in T2 value2, in T3 value3, in T4 value4) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanagedWithObjectHeader<T1, T2, T3, T4>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanaged<T1, T2, T3, T4, T5>(in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()), value5);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanagedWithObjectHeader<T1, T2, T3, T4, T5>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1), value5);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanaged<T1, T2, T3, T4, T5, T6>(in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()), value6);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanagedWithObjectHeader<T1, T2, T3, T4, T5, T6>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + 1), value6);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanaged<T1, T2, T3, T4, T5, T6, T7>(in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()), value7);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanagedWithObjectHeader<T1, T2, T3, T4, T5, T6, T7>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + 1), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + 1), value7);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8>(in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()), value8);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanagedWithObjectHeader<T1, T2, T3, T4, T5, T6, T7, T8>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + 1), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + 1), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + 1), value8);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9>(in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged where T9 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()), value9);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanagedWithObjectHeader<T1, T2, T3, T4, T5, T6, T7, T8, T9>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged where T9 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + 1), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + 1), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + 1), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + 1), value9);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged where T9 : unmanaged where T10 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()), value10);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanagedWithObjectHeader<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged where T9 : unmanaged where T10 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + 1), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + 1), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + 1), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + 1), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + 1), value10);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10, in T11 value11) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged where T9 : unmanaged where T10 : unmanaged where T11 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()), value10);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>()), value11);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanagedWithObjectHeader<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10, in T11 value11) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged where T9 : unmanaged where T10 : unmanaged where T11 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + 1), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + 1), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + 1), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + 1), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + 1), value10);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + 1), value11);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10, in T11 value11, in T12 value12) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged where T9 : unmanaged where T10 : unmanaged where T11 : unmanaged where T12 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()), value10);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>()), value11);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>()), value12);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanagedWithObjectHeader<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10, in T11 value11, in T12 value12) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged where T9 : unmanaged where T10 : unmanaged where T11 : unmanaged where T12 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + 1), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + 1), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + 1), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + 1), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + 1), value10);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + 1), value11);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + 1), value12);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10, in T11 value11, in T12 value12, in T13 value13) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged where T9 : unmanaged where T10 : unmanaged where T11 : unmanaged where T12 : unmanaged where T13 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()), value10);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>()), value11);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>()), value12);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>()), value13);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanagedWithObjectHeader<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10, in T11 value11, in T12 value12, in T13 value13) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged where T9 : unmanaged where T10 : unmanaged where T11 : unmanaged where T12 : unmanaged where T13 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + 1), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + 1), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + 1), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + 1), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + 1), value10);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + 1), value11);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + 1), value12);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + 1), value13);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10, in T11 value11, in T12 value12, in T13 value13, in T14 value14) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged where T9 : unmanaged where T10 : unmanaged where T11 : unmanaged where T12 : unmanaged where T13 : unmanaged where T14 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + Unsafe.SizeOf<T14>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()), value10);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>()), value11);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>()), value12);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>()), value13);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>()), value14);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanagedWithObjectHeader<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10, in T11 value11, in T12 value12, in T13 value13, in T14 value14) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged where T9 : unmanaged where T10 : unmanaged where T11 : unmanaged where T12 : unmanaged where T13 : unmanaged where T14 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + Unsafe.SizeOf<T14>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + 1), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + 1), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + 1), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + 1), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + 1), value10);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + 1), value11);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + 1), value12);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + 1), value13);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + 1), value14);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10, in T11 value11, in T12 value12, in T13 value13, in T14 value14, in T15 value15) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged where T9 : unmanaged where T10 : unmanaged where T11 : unmanaged where T12 : unmanaged where T13 : unmanaged where T14 : unmanaged where T15 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + Unsafe.SizeOf<T14>() + Unsafe.SizeOf<T15>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()), value10);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>()), value11);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>()), value12);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>()), value13);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>()), value14);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + Unsafe.SizeOf<T14>()), value15);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void WriteUnmanagedWithObjectHeader<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10, in T11 value11, in T12 value12, in T13 value13, in T14 value14, in T15 value15) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged where T9 : unmanaged where T10 : unmanaged where T11 : unmanaged where T12 : unmanaged where T13 : unmanaged where T14 : unmanaged where T15 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + Unsafe.SizeOf<T14>() + Unsafe.SizeOf<T15>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + 1), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + 1), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + 1), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + 1), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + 1), value10);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + 1), value11);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + 1), value12);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + 1), value13);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + 1), value14);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + Unsafe.SizeOf<T14>() + 1), value15);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanaged<T1>(in T1 value1)
	{
		int num = Unsafe.SizeOf<T1>();
		Unsafe.WriteUnaligned(ref GetSpanReference(num), value1);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanagedWithObjectHeader<T1>(byte propertyCount, in T1 value1)
	{
		int num = Unsafe.SizeOf<T1>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanaged<T1, T2>(in T1 value1, in T2 value2)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanagedWithObjectHeader<T1, T2>(byte propertyCount, in T1 value1, in T2 value2)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanaged<T1, T2, T3>(in T1 value1, in T2 value2, in T3 value3)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanagedWithObjectHeader<T1, T2, T3>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanaged<T1, T2, T3, T4>(in T1 value1, in T2 value2, in T3 value3, in T4 value4)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanagedWithObjectHeader<T1, T2, T3, T4>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanaged<T1, T2, T3, T4, T5>(in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()), value5);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanagedWithObjectHeader<T1, T2, T3, T4, T5>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1), value5);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanaged<T1, T2, T3, T4, T5, T6>(in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()), value6);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanagedWithObjectHeader<T1, T2, T3, T4, T5, T6>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + 1), value6);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanaged<T1, T2, T3, T4, T5, T6, T7>(in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()), value7);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanagedWithObjectHeader<T1, T2, T3, T4, T5, T6, T7>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + 1), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + 1), value7);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8>(in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()), value8);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanagedWithObjectHeader<T1, T2, T3, T4, T5, T6, T7, T8>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + 1), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + 1), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + 1), value8);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9>(in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()), value9);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanagedWithObjectHeader<T1, T2, T3, T4, T5, T6, T7, T8, T9>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + 1), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + 1), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + 1), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + 1), value9);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()), value10);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanagedWithObjectHeader<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + 1), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + 1), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + 1), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + 1), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + 1), value10);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10, in T11 value11)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()), value10);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>()), value11);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanagedWithObjectHeader<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10, in T11 value11)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + 1), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + 1), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + 1), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + 1), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + 1), value10);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + 1), value11);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10, in T11 value11, in T12 value12)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()), value10);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>()), value11);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>()), value12);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanagedWithObjectHeader<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10, in T11 value11, in T12 value12)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + 1), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + 1), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + 1), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + 1), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + 1), value10);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + 1), value11);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + 1), value12);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10, in T11 value11, in T12 value12, in T13 value13)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()), value10);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>()), value11);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>()), value12);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>()), value13);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanagedWithObjectHeader<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10, in T11 value11, in T12 value12, in T13 value13)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + 1), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + 1), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + 1), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + 1), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + 1), value10);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + 1), value11);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + 1), value12);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + 1), value13);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10, in T11 value11, in T12 value12, in T13 value13, in T14 value14)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + Unsafe.SizeOf<T14>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()), value10);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>()), value11);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>()), value12);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>()), value13);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>()), value14);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanagedWithObjectHeader<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10, in T11 value11, in T12 value12, in T13 value13, in T14 value14)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + Unsafe.SizeOf<T14>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + 1), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + 1), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + 1), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + 1), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + 1), value10);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + 1), value11);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + 1), value12);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + 1), value13);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + 1), value14);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10, in T11 value11, in T12 value12, in T13 value13, in T14 value14, in T15 value15)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + Unsafe.SizeOf<T14>() + Unsafe.SizeOf<T15>();
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()), value10);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>()), value11);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>()), value12);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>()), value13);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>()), value14);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + Unsafe.SizeOf<T14>()), value15);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousWriteUnmanagedWithObjectHeader<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(byte propertyCount, in T1 value1, in T2 value2, in T3 value3, in T4 value4, in T5 value5, in T6 value6, in T7 value7, in T8 value8, in T9 value9, in T10 value10, in T11 value11, in T12 value12, in T13 value13, in T14 value14, in T15 value15)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + Unsafe.SizeOf<T14>() + Unsafe.SizeOf<T15>() + 1;
		ref byte spanReference = ref GetSpanReference(num);
		Unsafe.WriteUnaligned(ref spanReference, propertyCount);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 1), value1);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + 1), value2);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + 1), value3);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + 1), value4);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + 1), value5);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + 1), value6);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + 1), value7);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + 1), value8);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + 1), value9);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + 1), value10);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + 1), value11);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + 1), value12);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + 1), value13);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + 1), value14);
		Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + Unsafe.SizeOf<T14>() + 1), value15);
		Advance(num);
	}
}
