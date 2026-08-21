using System;
using System.Buffers;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;
using MemoryPack.Internal;

namespace MemoryPack;

[StructLayout(LayoutKind.Auto)]
public ref struct MemoryPackReader
{
	private ReadOnlySequence<byte> bufferSource;

	private readonly long totalLength;

	private ReadOnlySpan<byte> bufferReference;

	private int bufferLength;

	private byte[]? rentBuffer;

	private int advancedCount;

	private int consumed;

	private readonly MemoryPackReaderOptionalState optionalState;

	public int Consumed => consumed;

	public long Remaining => totalLength - consumed;

	public MemoryPackReaderOptionalState OptionalState => optionalState;

	public MemoryPackSerializerOptions Options => optionalState.Options;

	public MemoryPackReader(in ReadOnlySequence<byte> sequence, MemoryPackReaderOptionalState optionalState)
	{
		bufferSource = (sequence.IsSingleSegment ? ReadOnlySequence<byte>.Empty : sequence);
		ReadOnlySpan<byte> readOnlySpan = (bufferReference = sequence.FirstSpan);
		bufferLength = readOnlySpan.Length;
		advancedCount = 0;
		consumed = 0;
		rentBuffer = null;
		totalLength = sequence.Length;
		this.optionalState = optionalState;
	}

	public MemoryPackReader(ReadOnlySpan<byte> buffer, MemoryPackReaderOptionalState optionalState)
	{
		bufferSource = ReadOnlySequence<byte>.Empty;
		bufferReference = buffer;
		bufferLength = buffer.Length;
		advancedCount = 0;
		consumed = 0;
		rentBuffer = null;
		totalLength = buffer.Length;
		this.optionalState = optionalState;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public ref byte GetSpanReference(int sizeHint)
	{
		if (sizeHint <= bufferLength)
		{
			return ref MemoryMarshal.GetReference(bufferReference);
		}
		return ref GetNextSpan(sizeHint);
	}

	[MethodImpl(MethodImplOptions.NoInlining)]
	private ref byte GetNextSpan(int sizeHint)
	{
		if (rentBuffer != null)
		{
			ArrayPool<byte>.Shared.Return(rentBuffer);
			rentBuffer = null;
		}
		if (Remaining == 0L)
		{
			MemoryPackSerializationException.ThrowSequenceReachedEnd();
		}
		try
		{
			bufferSource = bufferSource.Slice(advancedCount);
		}
		catch (ArgumentOutOfRangeException)
		{
			MemoryPackSerializationException.ThrowSequenceReachedEnd();
		}
		advancedCount = 0;
		if (sizeHint <= Remaining)
		{
			if (sizeHint <= bufferSource.FirstSpan.Length)
			{
				bufferReference = bufferSource.FirstSpan;
				bufferLength = bufferSource.FirstSpan.Length;
				return ref MemoryMarshal.GetReference(bufferReference);
			}
			rentBuffer = ArrayPool<byte>.Shared.Rent(sizeHint);
			bufferSource.Slice(0, sizeHint).CopyTo(rentBuffer);
			Span<byte> span = MemoryExtensions.AsSpan(rentBuffer, 0, sizeHint);
			bufferReference = span;
			bufferLength = span.Length;
			return ref MemoryMarshal.GetReference(bufferReference);
		}
		MemoryPackSerializationException.ThrowSequenceReachedEnd();
		return ref MemoryMarshal.GetReference(bufferReference);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void Advance(int count)
	{
		if (count != 0)
		{
			int num = bufferLength - count;
			if (num >= 0 || !TryAdvanceSequence(count))
			{
				bufferLength = num;
				bufferReference = bufferReference.Slice(count);
				advancedCount += count;
				consumed += count;
			}
		}
	}

	[MethodImpl(MethodImplOptions.NoInlining)]
	private bool TryAdvanceSequence(int count)
	{
		if (bufferSource.Length - count < 0)
		{
			MemoryPackSerializationException.ThrowInvalidAdvance();
		}
		bufferSource = bufferSource.Slice(advancedCount + count);
		bufferReference = bufferSource.FirstSpan;
		bufferLength = bufferSource.FirstSpan.Length;
		advancedCount = 0;
		consumed += count;
		return true;
	}

	public void GetRemainingSource(out ReadOnlySpan<byte> singleSource, out ReadOnlySequence<byte> remainingSource)
	{
		if (bufferSource.IsEmpty)
		{
			remainingSource = ReadOnlySequence<byte>.Empty;
			singleSource = bufferReference;
			return;
		}
		if (bufferSource.IsSingleSegment)
		{
			remainingSource = ReadOnlySequence<byte>.Empty;
			singleSource = bufferSource.FirstSpan.Slice(advancedCount);
			return;
		}
		singleSource = default(ReadOnlySpan<byte>);
		remainingSource = bufferSource.Slice(advancedCount);
		if (remainingSource.IsSingleSegment)
		{
			singleSource = remainingSource.FirstSpan;
			remainingSource = ReadOnlySequence<byte>.Empty;
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void Dispose()
	{
		if (rentBuffer != null)
		{
			ArrayPool<byte>.Shared.Return(rentBuffer);
		}
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
	public bool TryReadObjectHeader(out byte memberCount)
	{
		memberCount = GetSpanReference(1);
		Advance(1);
		return memberCount != byte.MaxValue;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public bool TryReadUnionHeader(out ushort tag)
	{
		byte spanReference = GetSpanReference(1);
		Advance(1);
		if (spanReference < 250)
		{
			tag = spanReference;
			return true;
		}
		if (spanReference == 250)
		{
			ReadUnmanaged<ushort>(out tag);
			return true;
		}
		tag = 0;
		return false;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public bool TryReadCollectionHeader(out int length)
	{
		length = Unsafe.ReadUnaligned<int>(ref GetSpanReference(4));
		Advance(4);
		if (Remaining < length)
		{
			MemoryPackSerializationException.ThrowInsufficientBufferUnless(length);
		}
		return length != -1;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public bool PeekIsNull()
	{
		return GetSpanReference(1) == byte.MaxValue;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public bool TryPeekObjectHeader(out byte memberCount)
	{
		memberCount = GetSpanReference(1);
		return memberCount != byte.MaxValue;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public bool TryPeekUnionHeader(out ushort tag)
	{
		byte spanReference = GetSpanReference(1);
		if (spanReference < 250)
		{
			tag = spanReference;
			return true;
		}
		if (spanReference == 250)
		{
			tag = Unsafe.ReadUnaligned<ushort>(ref Unsafe.Add(ref GetSpanReference(3), 1));
			return true;
		}
		tag = 0;
		return false;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public bool TryPeekCollectionHeader(out int length)
	{
		length = Unsafe.ReadUnaligned<int>(ref GetSpanReference(4));
		if (Remaining < length)
		{
			MemoryPackSerializationException.ThrowInsufficientBufferUnless(length);
		}
		return length != -1;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public bool DangerousTryReadCollectionHeader(out int length)
	{
		length = Unsafe.ReadUnaligned<int>(ref GetSpanReference(4));
		Advance(4);
		return length != -1;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public string? ReadString()
	{
		if (!TryReadCollectionHeader(out var length))
		{
			return null;
		}
		if (length == 0)
		{
			return "";
		}
		if (length > 0)
		{
			return ReadUtf16(length);
		}
		return ReadUtf8(length);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	private string ReadUtf16(int length)
	{
		int num = checked(length * 2);
		string result = new string(MemoryMarshal.CreateReadOnlySpan(ref Unsafe.As<byte, char>(ref GetSpanReference(num)), length));
		Advance(num);
		return result;
	}

	[MethodImpl(MethodImplOptions.NoInlining)]
	private string ReadUtf8(int utf8Length)
	{
		utf8Length = ~utf8Length;
		ref byte spanReference = ref GetSpanReference(utf8Length + 4);
		int num = Unsafe.ReadUnaligned<int>(ref spanReference);
		string result;
		if (num <= 0)
		{
			ReadOnlySpan<byte> bytes = MemoryMarshal.CreateReadOnlySpan(ref Unsafe.Add(ref spanReference, 4), utf8Length);
			result = Encoding.UTF8.GetString(bytes);
		}
		else
		{
			long num2 = (Remaining + 1) * 3;
			if (num2 < 0)
			{
				num2 = 2147483647L;
			}
			if (num2 < num)
			{
				MemoryPackSerializationException.ThrowInsufficientBufferUnless(utf8Length);
			}
			ReadOnlySpan<byte> bytes2 = MemoryMarshal.CreateReadOnlySpan(ref Unsafe.Add(ref spanReference, 4), utf8Length);
			result = Encoding.UTF8.GetString(bytes2);
		}
		Advance(utf8Length + 4);
		return result;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public T1 ReadUnmanaged<T1>() where T1 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>();
		T1 result = Unsafe.ReadUnaligned<T1>(ref GetSpanReference(num));
		Advance(num);
		return result;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadPackable<T>(ref T? value) where T : IMemoryPackable<T>
	{
		ReadValue(ref value);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public T? ReadPackable<T>() where T : IMemoryPackable<T>
	{
		return ReadValue<T>();
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadValue<T>(ref T? value)
	{
		GetFormatter<T>().Deserialize(ref this, ref value);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public T? ReadValue<T>()
	{
		T value = default(T);
		GetFormatter<T>().Deserialize(ref this, ref value);
		return value;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadValue(Type type, ref object? value)
	{
		GetFormatter(type).Deserialize(ref this, ref value);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public object? ReadValue(Type type)
	{
		object value = null;
		GetFormatter(type).Deserialize(ref this, ref value);
		return value;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadValueWithFormatter<TFormatter, T>(TFormatter formatter, ref T? value) where TFormatter : IMemoryPackFormatter<T>
	{
		formatter.Deserialize(ref this, ref value);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public T? ReadValueWithFormatter<TFormatter, T>(TFormatter formatter) where TFormatter : IMemoryPackFormatter<T>
	{
		T value = default(T);
		formatter.Deserialize(ref this, ref value);
		return value;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public T?[]? ReadArray<T>()
	{
		T[] value = null;
		ReadArray(ref value);
		return value;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadArray<T>(ref T?[]? value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			DangerousReadUnmanagedArray(ref value);
			return;
		}
		if (!TryReadCollectionHeader(out var length))
		{
			value = null;
			return;
		}
		if (length == 0)
		{
			value = Array.Empty<T>();
			return;
		}
		if (value == null || value.Length != length)
		{
			value = new T[length];
		}
		IMemoryPackFormatter<T> formatter = GetFormatter<T>();
		for (int i = 0; i < length; i++)
		{
			formatter.Deserialize(ref this, ref value[i]);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadSpan<T>(ref Span<T?> value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			DangerousReadUnmanagedSpan(ref value);
			return;
		}
		if (!TryReadCollectionHeader(out var length))
		{
			value = default(Span<T>);
			return;
		}
		if (length == 0)
		{
			value = Array.Empty<T>();
			return;
		}
		if (value.Length != length)
		{
			value = new T[length];
		}
		IMemoryPackFormatter<T> formatter = GetFormatter<T>();
		for (int i = 0; i < length; i++)
		{
			formatter.Deserialize(ref this, ref value[i]);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public T?[]? ReadPackableArray<T>() where T : IMemoryPackable<T>
	{
		T[] value = null;
		ReadPackableArray(ref value);
		return value;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadPackableArray<T>(ref T?[]? value) where T : IMemoryPackable<T>
	{
		ReadArray(ref value);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadPackableSpan<T>(ref Span<T?> value) where T : IMemoryPackable<T>
	{
		ReadSpan(ref value);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public T[]? ReadUnmanagedArray<T>() where T : unmanaged
	{
		return DangerousReadUnmanagedArray<T>();
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadUnmanagedArray<T>(ref T[]? value) where T : unmanaged
	{
		DangerousReadUnmanagedArray(ref value);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadUnmanagedSpan<T>(ref Span<T> value) where T : unmanaged
	{
		DangerousReadUnmanagedSpan(ref value);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public T[]? DangerousReadUnmanagedArray<T>()
	{
		if (!TryReadCollectionHeader(out var length))
		{
			return null;
		}
		if (length == 0)
		{
			return Array.Empty<T>();
		}
		int num = length * Unsafe.SizeOf<T>();
		ref byte spanReference = ref GetSpanReference(num);
		T[] array = MemoryMarshalEx.AllocateUninitializedArray<T>(length);
		Unsafe.CopyBlockUnaligned(ref Unsafe.As<T, byte>(ref MemoryMarshalEx.GetArrayDataReference(array)), ref spanReference, (uint)num);
		Advance(num);
		return array;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousReadUnmanagedArray<T>(ref T[]? value)
	{
		if (!TryReadCollectionHeader(out var length))
		{
			value = null;
			return;
		}
		if (length == 0)
		{
			value = Array.Empty<T>();
			return;
		}
		int num = length * Unsafe.SizeOf<T>();
		ref byte spanReference = ref GetSpanReference(num);
		if (value == null || value.Length != length)
		{
			value = MemoryMarshalEx.AllocateUninitializedArray<T>(length);
		}
		Unsafe.CopyBlockUnaligned(ref Unsafe.As<T, byte>(ref MemoryMarshalEx.GetArrayDataReference(value)), ref spanReference, (uint)num);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousReadUnmanagedSpan<T>(ref Span<T> value)
	{
		if (!TryReadCollectionHeader(out var length))
		{
			value = default(Span<T>);
			return;
		}
		if (length == 0)
		{
			value = Array.Empty<T>();
			return;
		}
		int num = length * Unsafe.SizeOf<T>();
		ref byte spanReference = ref GetSpanReference(num);
		if (value == null || value.Length != length)
		{
			value = MemoryMarshalEx.AllocateUninitializedArray<T>(length);
		}
		Unsafe.CopyBlockUnaligned(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(value)), ref spanReference, (uint)num);
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadSpanWithoutReadLengthHeader<T>(int length, ref Span<T?> value)
	{
		if (length == 0)
		{
			value = Array.Empty<T>();
		}
		else if (!RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			if (value.Length != length)
			{
				value = MemoryMarshalEx.AllocateUninitializedArray<T>(length);
			}
			int num = length * Unsafe.SizeOf<T>();
			ref byte spanReference = ref GetSpanReference(num);
			Unsafe.CopyBlockUnaligned(ref Unsafe.As<T, byte>(ref MemoryMarshal.GetReference(value)), ref spanReference, (uint)num);
			Advance(num);
		}
		else
		{
			if (value.Length != length)
			{
				value = new T[length];
			}
			IMemoryPackFormatter<T> formatter = GetFormatter<T>();
			for (int i = 0; i < length; i++)
			{
				formatter.Deserialize(ref this, ref value[i]);
			}
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadPackableSpanWithoutReadLengthHeader<T>(int length, ref Span<T?> value) where T : IMemoryPackable<T>
	{
		ReadSpanWithoutReadLengthHeader(length, ref value);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousReadUnmanagedSpanView<T>(out bool isNull, out ReadOnlySpan<byte> view)
	{
		if (!TryReadCollectionHeader(out var length))
		{
			isNull = true;
			view = default(ReadOnlySpan<byte>);
			return;
		}
		isNull = false;
		if (length == 0)
		{
			view = Array.Empty<byte>();
			return;
		}
		int num = length * Unsafe.SizeOf<T>();
		ReadOnlySpan<byte> readOnlySpan = MemoryMarshal.CreateReadOnlySpan(ref GetSpanReference(num), num);
		Advance(num);
		view = readOnlySpan;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadUnmanaged<T1>(out T1 value1) where T1 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>();
		value1 = Unsafe.ReadUnaligned<T1>(ref GetSpanReference(num));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadUnmanaged<T1, T2>(out T1 value1, out T2 value2) where T1 : unmanaged where T2 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadUnmanaged<T1, T2, T3>(out T1 value1, out T2 value2, out T3 value3) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadUnmanaged<T1, T2, T3, T4>(out T1 value1, out T2 value2, out T3 value3, out T4 value4) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadUnmanaged<T1, T2, T3, T4, T5>(out T1 value1, out T2 value2, out T3 value3, out T4 value4, out T5 value5) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		value5 = Unsafe.ReadUnaligned<T5>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadUnmanaged<T1, T2, T3, T4, T5, T6>(out T1 value1, out T2 value2, out T3 value3, out T4 value4, out T5 value5, out T6 value6) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		value5 = Unsafe.ReadUnaligned<T5>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()));
		value6 = Unsafe.ReadUnaligned<T6>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadUnmanaged<T1, T2, T3, T4, T5, T6, T7>(out T1 value1, out T2 value2, out T3 value3, out T4 value4, out T5 value5, out T6 value6, out T7 value7) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		value5 = Unsafe.ReadUnaligned<T5>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()));
		value6 = Unsafe.ReadUnaligned<T6>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()));
		value7 = Unsafe.ReadUnaligned<T7>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8>(out T1 value1, out T2 value2, out T3 value3, out T4 value4, out T5 value5, out T6 value6, out T7 value7, out T8 value8) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		value5 = Unsafe.ReadUnaligned<T5>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()));
		value6 = Unsafe.ReadUnaligned<T6>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()));
		value7 = Unsafe.ReadUnaligned<T7>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()));
		value8 = Unsafe.ReadUnaligned<T8>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9>(out T1 value1, out T2 value2, out T3 value3, out T4 value4, out T5 value5, out T6 value6, out T7 value7, out T8 value8, out T9 value9) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged where T9 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		value5 = Unsafe.ReadUnaligned<T5>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()));
		value6 = Unsafe.ReadUnaligned<T6>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()));
		value7 = Unsafe.ReadUnaligned<T7>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()));
		value8 = Unsafe.ReadUnaligned<T8>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()));
		value9 = Unsafe.ReadUnaligned<T9>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(out T1 value1, out T2 value2, out T3 value3, out T4 value4, out T5 value5, out T6 value6, out T7 value7, out T8 value8, out T9 value9, out T10 value10) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged where T9 : unmanaged where T10 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		value5 = Unsafe.ReadUnaligned<T5>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()));
		value6 = Unsafe.ReadUnaligned<T6>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()));
		value7 = Unsafe.ReadUnaligned<T7>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()));
		value8 = Unsafe.ReadUnaligned<T8>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()));
		value9 = Unsafe.ReadUnaligned<T9>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()));
		value10 = Unsafe.ReadUnaligned<T10>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(out T1 value1, out T2 value2, out T3 value3, out T4 value4, out T5 value5, out T6 value6, out T7 value7, out T8 value8, out T9 value9, out T10 value10, out T11 value11) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged where T9 : unmanaged where T10 : unmanaged where T11 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		value5 = Unsafe.ReadUnaligned<T5>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()));
		value6 = Unsafe.ReadUnaligned<T6>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()));
		value7 = Unsafe.ReadUnaligned<T7>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()));
		value8 = Unsafe.ReadUnaligned<T8>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()));
		value9 = Unsafe.ReadUnaligned<T9>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()));
		value10 = Unsafe.ReadUnaligned<T10>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()));
		value11 = Unsafe.ReadUnaligned<T11>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(out T1 value1, out T2 value2, out T3 value3, out T4 value4, out T5 value5, out T6 value6, out T7 value7, out T8 value8, out T9 value9, out T10 value10, out T11 value11, out T12 value12) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged where T9 : unmanaged where T10 : unmanaged where T11 : unmanaged where T12 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		value5 = Unsafe.ReadUnaligned<T5>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()));
		value6 = Unsafe.ReadUnaligned<T6>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()));
		value7 = Unsafe.ReadUnaligned<T7>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()));
		value8 = Unsafe.ReadUnaligned<T8>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()));
		value9 = Unsafe.ReadUnaligned<T9>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()));
		value10 = Unsafe.ReadUnaligned<T10>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()));
		value11 = Unsafe.ReadUnaligned<T11>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>()));
		value12 = Unsafe.ReadUnaligned<T12>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(out T1 value1, out T2 value2, out T3 value3, out T4 value4, out T5 value5, out T6 value6, out T7 value7, out T8 value8, out T9 value9, out T10 value10, out T11 value11, out T12 value12, out T13 value13) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged where T9 : unmanaged where T10 : unmanaged where T11 : unmanaged where T12 : unmanaged where T13 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		value5 = Unsafe.ReadUnaligned<T5>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()));
		value6 = Unsafe.ReadUnaligned<T6>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()));
		value7 = Unsafe.ReadUnaligned<T7>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()));
		value8 = Unsafe.ReadUnaligned<T8>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()));
		value9 = Unsafe.ReadUnaligned<T9>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()));
		value10 = Unsafe.ReadUnaligned<T10>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()));
		value11 = Unsafe.ReadUnaligned<T11>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>()));
		value12 = Unsafe.ReadUnaligned<T12>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>()));
		value13 = Unsafe.ReadUnaligned<T13>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(out T1 value1, out T2 value2, out T3 value3, out T4 value4, out T5 value5, out T6 value6, out T7 value7, out T8 value8, out T9 value9, out T10 value10, out T11 value11, out T12 value12, out T13 value13, out T14 value14) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged where T9 : unmanaged where T10 : unmanaged where T11 : unmanaged where T12 : unmanaged where T13 : unmanaged where T14 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + Unsafe.SizeOf<T14>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		value5 = Unsafe.ReadUnaligned<T5>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()));
		value6 = Unsafe.ReadUnaligned<T6>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()));
		value7 = Unsafe.ReadUnaligned<T7>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()));
		value8 = Unsafe.ReadUnaligned<T8>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()));
		value9 = Unsafe.ReadUnaligned<T9>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()));
		value10 = Unsafe.ReadUnaligned<T10>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()));
		value11 = Unsafe.ReadUnaligned<T11>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>()));
		value12 = Unsafe.ReadUnaligned<T12>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>()));
		value13 = Unsafe.ReadUnaligned<T13>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>()));
		value14 = Unsafe.ReadUnaligned<T14>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void ReadUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(out T1 value1, out T2 value2, out T3 value3, out T4 value4, out T5 value5, out T6 value6, out T7 value7, out T8 value8, out T9 value9, out T10 value10, out T11 value11, out T12 value12, out T13 value13, out T14 value14, out T15 value15) where T1 : unmanaged where T2 : unmanaged where T3 : unmanaged where T4 : unmanaged where T5 : unmanaged where T6 : unmanaged where T7 : unmanaged where T8 : unmanaged where T9 : unmanaged where T10 : unmanaged where T11 : unmanaged where T12 : unmanaged where T13 : unmanaged where T14 : unmanaged where T15 : unmanaged
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + Unsafe.SizeOf<T14>() + Unsafe.SizeOf<T15>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		value5 = Unsafe.ReadUnaligned<T5>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()));
		value6 = Unsafe.ReadUnaligned<T6>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()));
		value7 = Unsafe.ReadUnaligned<T7>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()));
		value8 = Unsafe.ReadUnaligned<T8>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()));
		value9 = Unsafe.ReadUnaligned<T9>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()));
		value10 = Unsafe.ReadUnaligned<T10>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()));
		value11 = Unsafe.ReadUnaligned<T11>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>()));
		value12 = Unsafe.ReadUnaligned<T12>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>()));
		value13 = Unsafe.ReadUnaligned<T13>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>()));
		value14 = Unsafe.ReadUnaligned<T14>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>()));
		value15 = Unsafe.ReadUnaligned<T15>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + Unsafe.SizeOf<T14>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousReadUnmanaged<T1>(out T1 value1)
	{
		int num = Unsafe.SizeOf<T1>();
		value1 = Unsafe.ReadUnaligned<T1>(ref GetSpanReference(num));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousReadUnmanaged<T1, T2>(out T1 value1, out T2 value2)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousReadUnmanaged<T1, T2, T3>(out T1 value1, out T2 value2, out T3 value3)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousReadUnmanaged<T1, T2, T3, T4>(out T1 value1, out T2 value2, out T3 value3, out T4 value4)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousReadUnmanaged<T1, T2, T3, T4, T5>(out T1 value1, out T2 value2, out T3 value3, out T4 value4, out T5 value5)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		value5 = Unsafe.ReadUnaligned<T5>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousReadUnmanaged<T1, T2, T3, T4, T5, T6>(out T1 value1, out T2 value2, out T3 value3, out T4 value4, out T5 value5, out T6 value6)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		value5 = Unsafe.ReadUnaligned<T5>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()));
		value6 = Unsafe.ReadUnaligned<T6>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousReadUnmanaged<T1, T2, T3, T4, T5, T6, T7>(out T1 value1, out T2 value2, out T3 value3, out T4 value4, out T5 value5, out T6 value6, out T7 value7)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		value5 = Unsafe.ReadUnaligned<T5>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()));
		value6 = Unsafe.ReadUnaligned<T6>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()));
		value7 = Unsafe.ReadUnaligned<T7>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousReadUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8>(out T1 value1, out T2 value2, out T3 value3, out T4 value4, out T5 value5, out T6 value6, out T7 value7, out T8 value8)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		value5 = Unsafe.ReadUnaligned<T5>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()));
		value6 = Unsafe.ReadUnaligned<T6>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()));
		value7 = Unsafe.ReadUnaligned<T7>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()));
		value8 = Unsafe.ReadUnaligned<T8>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousReadUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9>(out T1 value1, out T2 value2, out T3 value3, out T4 value4, out T5 value5, out T6 value6, out T7 value7, out T8 value8, out T9 value9)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		value5 = Unsafe.ReadUnaligned<T5>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()));
		value6 = Unsafe.ReadUnaligned<T6>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()));
		value7 = Unsafe.ReadUnaligned<T7>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()));
		value8 = Unsafe.ReadUnaligned<T8>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()));
		value9 = Unsafe.ReadUnaligned<T9>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousReadUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(out T1 value1, out T2 value2, out T3 value3, out T4 value4, out T5 value5, out T6 value6, out T7 value7, out T8 value8, out T9 value9, out T10 value10)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		value5 = Unsafe.ReadUnaligned<T5>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()));
		value6 = Unsafe.ReadUnaligned<T6>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()));
		value7 = Unsafe.ReadUnaligned<T7>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()));
		value8 = Unsafe.ReadUnaligned<T8>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()));
		value9 = Unsafe.ReadUnaligned<T9>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()));
		value10 = Unsafe.ReadUnaligned<T10>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousReadUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(out T1 value1, out T2 value2, out T3 value3, out T4 value4, out T5 value5, out T6 value6, out T7 value7, out T8 value8, out T9 value9, out T10 value10, out T11 value11)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		value5 = Unsafe.ReadUnaligned<T5>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()));
		value6 = Unsafe.ReadUnaligned<T6>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()));
		value7 = Unsafe.ReadUnaligned<T7>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()));
		value8 = Unsafe.ReadUnaligned<T8>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()));
		value9 = Unsafe.ReadUnaligned<T9>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()));
		value10 = Unsafe.ReadUnaligned<T10>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()));
		value11 = Unsafe.ReadUnaligned<T11>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousReadUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(out T1 value1, out T2 value2, out T3 value3, out T4 value4, out T5 value5, out T6 value6, out T7 value7, out T8 value8, out T9 value9, out T10 value10, out T11 value11, out T12 value12)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		value5 = Unsafe.ReadUnaligned<T5>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()));
		value6 = Unsafe.ReadUnaligned<T6>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()));
		value7 = Unsafe.ReadUnaligned<T7>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()));
		value8 = Unsafe.ReadUnaligned<T8>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()));
		value9 = Unsafe.ReadUnaligned<T9>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()));
		value10 = Unsafe.ReadUnaligned<T10>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()));
		value11 = Unsafe.ReadUnaligned<T11>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>()));
		value12 = Unsafe.ReadUnaligned<T12>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousReadUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(out T1 value1, out T2 value2, out T3 value3, out T4 value4, out T5 value5, out T6 value6, out T7 value7, out T8 value8, out T9 value9, out T10 value10, out T11 value11, out T12 value12, out T13 value13)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		value5 = Unsafe.ReadUnaligned<T5>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()));
		value6 = Unsafe.ReadUnaligned<T6>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()));
		value7 = Unsafe.ReadUnaligned<T7>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()));
		value8 = Unsafe.ReadUnaligned<T8>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()));
		value9 = Unsafe.ReadUnaligned<T9>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()));
		value10 = Unsafe.ReadUnaligned<T10>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()));
		value11 = Unsafe.ReadUnaligned<T11>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>()));
		value12 = Unsafe.ReadUnaligned<T12>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>()));
		value13 = Unsafe.ReadUnaligned<T13>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousReadUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(out T1 value1, out T2 value2, out T3 value3, out T4 value4, out T5 value5, out T6 value6, out T7 value7, out T8 value8, out T9 value9, out T10 value10, out T11 value11, out T12 value12, out T13 value13, out T14 value14)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + Unsafe.SizeOf<T14>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		value5 = Unsafe.ReadUnaligned<T5>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()));
		value6 = Unsafe.ReadUnaligned<T6>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()));
		value7 = Unsafe.ReadUnaligned<T7>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()));
		value8 = Unsafe.ReadUnaligned<T8>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()));
		value9 = Unsafe.ReadUnaligned<T9>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()));
		value10 = Unsafe.ReadUnaligned<T10>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()));
		value11 = Unsafe.ReadUnaligned<T11>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>()));
		value12 = Unsafe.ReadUnaligned<T12>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>()));
		value13 = Unsafe.ReadUnaligned<T13>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>()));
		value14 = Unsafe.ReadUnaligned<T14>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>()));
		Advance(num);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void DangerousReadUnmanaged<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(out T1 value1, out T2 value2, out T3 value3, out T4 value4, out T5 value5, out T6 value6, out T7 value7, out T8 value8, out T9 value9, out T10 value10, out T11 value11, out T12 value12, out T13 value13, out T14 value14, out T15 value15)
	{
		int num = Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + Unsafe.SizeOf<T14>() + Unsafe.SizeOf<T15>();
		ref byte spanReference = ref GetSpanReference(num);
		value1 = Unsafe.ReadUnaligned<T1>(ref spanReference);
		value2 = Unsafe.ReadUnaligned<T2>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>()));
		value3 = Unsafe.ReadUnaligned<T3>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>()));
		value4 = Unsafe.ReadUnaligned<T4>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>()));
		value5 = Unsafe.ReadUnaligned<T5>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>()));
		value6 = Unsafe.ReadUnaligned<T6>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>()));
		value7 = Unsafe.ReadUnaligned<T7>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>()));
		value8 = Unsafe.ReadUnaligned<T8>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>()));
		value9 = Unsafe.ReadUnaligned<T9>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>()));
		value10 = Unsafe.ReadUnaligned<T10>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>()));
		value11 = Unsafe.ReadUnaligned<T11>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>()));
		value12 = Unsafe.ReadUnaligned<T12>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>()));
		value13 = Unsafe.ReadUnaligned<T13>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>()));
		value14 = Unsafe.ReadUnaligned<T14>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>()));
		value15 = Unsafe.ReadUnaligned<T15>(ref Unsafe.Add(ref spanReference, Unsafe.SizeOf<T1>() + Unsafe.SizeOf<T2>() + Unsafe.SizeOf<T3>() + Unsafe.SizeOf<T4>() + Unsafe.SizeOf<T5>() + Unsafe.SizeOf<T6>() + Unsafe.SizeOf<T7>() + Unsafe.SizeOf<T8>() + Unsafe.SizeOf<T9>() + Unsafe.SizeOf<T10>() + Unsafe.SizeOf<T11>() + Unsafe.SizeOf<T12>() + Unsafe.SizeOf<T13>() + Unsafe.SizeOf<T14>()));
		Advance(num);
	}

	public byte ReadVarIntByte()
	{
		ReadUnmanaged<sbyte>(out var value);
		return checked(value switch
		{
			-121 => ReadUnmanaged<byte>(), 
			-122 => (byte)ReadUnmanaged<sbyte>(), 
			-123 => ReadUnmanaged<byte>(), 
			-124 => (byte)ReadUnmanaged<short>(), 
			-125 => (byte)ReadUnmanaged<uint>(), 
			-126 => (byte)ReadUnmanaged<int>(), 
			-127 => (byte)ReadUnmanaged<ulong>(), 
			sbyte.MinValue => (byte)ReadUnmanaged<long>(), 
			_ => (byte)value, 
		});
	}

	public sbyte ReadVarIntSByte()
	{
		ReadUnmanaged<sbyte>(out var value);
		return checked(value switch
		{
			-121 => (sbyte)ReadUnmanaged<byte>(), 
			-122 => ReadUnmanaged<sbyte>(), 
			-123 => (sbyte)ReadUnmanaged<ushort>(), 
			-124 => (sbyte)ReadUnmanaged<short>(), 
			-125 => (sbyte)ReadUnmanaged<uint>(), 
			-126 => (sbyte)ReadUnmanaged<int>(), 
			-127 => (sbyte)ReadUnmanaged<ulong>(), 
			sbyte.MinValue => (sbyte)ReadUnmanaged<long>(), 
			_ => value, 
		});
	}

	public ushort ReadVarIntUInt16()
	{
		ReadUnmanaged<sbyte>(out var value);
		return checked(value switch
		{
			-121 => ReadUnmanaged<byte>(), 
			-122 => (ushort)ReadUnmanaged<sbyte>(), 
			-123 => ReadUnmanaged<ushort>(), 
			-124 => (ushort)ReadUnmanaged<short>(), 
			-125 => (ushort)ReadUnmanaged<uint>(), 
			-126 => (ushort)ReadUnmanaged<int>(), 
			-127 => (ushort)ReadUnmanaged<ulong>(), 
			sbyte.MinValue => (ushort)ReadUnmanaged<long>(), 
			_ => (ushort)value, 
		});
	}

	public short ReadVarIntInt16()
	{
		ReadUnmanaged<sbyte>(out var value);
		return checked(value switch
		{
			-121 => ReadUnmanaged<byte>(), 
			-122 => ReadUnmanaged<sbyte>(), 
			-123 => (short)ReadUnmanaged<ushort>(), 
			-124 => ReadUnmanaged<short>(), 
			-125 => (short)ReadUnmanaged<uint>(), 
			-126 => (short)ReadUnmanaged<int>(), 
			-127 => (short)ReadUnmanaged<ulong>(), 
			sbyte.MinValue => (short)ReadUnmanaged<long>(), 
			_ => value, 
		});
	}

	public uint ReadVarIntUInt32()
	{
		ReadUnmanaged<sbyte>(out var value);
		return checked(value switch
		{
			-121 => ReadUnmanaged<byte>(), 
			-122 => (uint)ReadUnmanaged<sbyte>(), 
			-123 => ReadUnmanaged<ushort>(), 
			-124 => (uint)ReadUnmanaged<short>(), 
			-125 => ReadUnmanaged<uint>(), 
			-126 => (uint)ReadUnmanaged<int>(), 
			-127 => (uint)ReadUnmanaged<ulong>(), 
			sbyte.MinValue => (uint)ReadUnmanaged<long>(), 
			_ => (uint)value, 
		});
	}

	public int ReadVarIntInt32()
	{
		ReadUnmanaged<sbyte>(out var value);
		return checked(value switch
		{
			-121 => ReadUnmanaged<byte>(), 
			-122 => ReadUnmanaged<sbyte>(), 
			-123 => ReadUnmanaged<ushort>(), 
			-124 => ReadUnmanaged<short>(), 
			-125 => (int)ReadUnmanaged<uint>(), 
			-126 => ReadUnmanaged<int>(), 
			-127 => (int)ReadUnmanaged<ulong>(), 
			sbyte.MinValue => (int)ReadUnmanaged<long>(), 
			_ => value, 
		});
	}

	public ulong ReadVarIntUInt64()
	{
		ReadUnmanaged<sbyte>(out var value);
		return checked(value switch
		{
			-121 => ReadUnmanaged<byte>(), 
			-122 => (ulong)ReadUnmanaged<sbyte>(), 
			-123 => ReadUnmanaged<ushort>(), 
			-124 => (ulong)ReadUnmanaged<short>(), 
			-125 => ReadUnmanaged<uint>(), 
			-126 => (ulong)ReadUnmanaged<int>(), 
			-127 => ReadUnmanaged<ulong>(), 
			sbyte.MinValue => (ulong)ReadUnmanaged<long>(), 
			_ => (ulong)value, 
		});
	}

	public long ReadVarIntInt64()
	{
		ReadUnmanaged<sbyte>(out var value);
		return value switch
		{
			-121 => ReadUnmanaged<byte>(), 
			-122 => ReadUnmanaged<sbyte>(), 
			-123 => ReadUnmanaged<ushort>(), 
			-124 => ReadUnmanaged<short>(), 
			-125 => ReadUnmanaged<uint>(), 
			-126 => ReadUnmanaged<int>(), 
			-127 => checked((long)ReadUnmanaged<ulong>()), 
			sbyte.MinValue => ReadUnmanaged<long>(), 
			_ => value, 
		};
	}
}
