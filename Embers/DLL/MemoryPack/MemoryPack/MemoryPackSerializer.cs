using System;
using System.Buffers;
using System.IO;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Threading;
using System.Threading.Tasks;
using MemoryPack.Internal;

namespace MemoryPack;

public static class MemoryPackSerializer
{
	private sealed class SerializerWriterThreadStaticState
	{
		public ReusableLinkedArrayBufferWriter BufferWriter;

		public MemoryPackWriterOptionalState OptionalState;

		public SerializerWriterThreadStaticState()
		{
			BufferWriter = new ReusableLinkedArrayBufferWriter(useFirstBuffer: true, pinned: true);
			OptionalState = new MemoryPackWriterOptionalState();
		}

		public void Init(MemoryPackSerializerOptions? options)
		{
			OptionalState.Init(options);
		}

		public void Reset()
		{
			BufferWriter.Reset();
			OptionalState.Reset();
		}
	}

	[ThreadStatic]
	private static MemoryPackReaderOptionalState? threadStaticReaderOptionalState;

	[ThreadStatic]
	private static SerializerWriterThreadStaticState? threadStaticState;

	[ThreadStatic]
	private static MemoryPackWriterOptionalState? threadStaticWriterOptionalState;

	public static T? Deserialize<T>(ReadOnlySpan<byte> buffer, MemoryPackSerializerOptions? options = null)
	{
		T value = default(T);
		Deserialize(buffer, ref value, options);
		return value;
	}

	public static int Deserialize<T>(ReadOnlySpan<byte> buffer, ref T? value, MemoryPackSerializerOptions? options = null)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			if (buffer.Length < Unsafe.SizeOf<T>())
			{
				MemoryPackSerializationException.ThrowInvalidRange(Unsafe.SizeOf<T>(), buffer.Length);
			}
			value = Unsafe.ReadUnaligned<T>(ref MemoryMarshal.GetReference(buffer));
			return Unsafe.SizeOf<T>();
		}
		MemoryPackReaderOptionalState memoryPackReaderOptionalState = threadStaticReaderOptionalState;
		if (memoryPackReaderOptionalState == null)
		{
			memoryPackReaderOptionalState = (threadStaticReaderOptionalState = new MemoryPackReaderOptionalState());
		}
		memoryPackReaderOptionalState.Init(options);
		MemoryPackReader memoryPackReader = new MemoryPackReader(buffer, memoryPackReaderOptionalState);
		try
		{
			memoryPackReader.ReadValue(ref value);
			return memoryPackReader.Consumed;
		}
		finally
		{
			memoryPackReader.Dispose();
			memoryPackReaderOptionalState.Reset();
		}
	}

	public static T? Deserialize<T>(in ReadOnlySequence<byte> buffer, MemoryPackSerializerOptions? options = null)
	{
		T value = default(T);
		Deserialize(in buffer, ref value);
		return value;
	}

	public static int Deserialize<T>(in ReadOnlySequence<byte> buffer, ref T? value, MemoryPackSerializerOptions? options = null)
	{
		MemoryPackReaderOptionalState memoryPackReaderOptionalState = threadStaticReaderOptionalState;
		if (memoryPackReaderOptionalState == null)
		{
			memoryPackReaderOptionalState = (threadStaticReaderOptionalState = new MemoryPackReaderOptionalState());
		}
		memoryPackReaderOptionalState.Init(options);
		MemoryPackReader memoryPackReader = new MemoryPackReader(in buffer, memoryPackReaderOptionalState);
		try
		{
			memoryPackReader.ReadValue(ref value);
			return memoryPackReader.Consumed;
		}
		finally
		{
			memoryPackReader.Dispose();
			memoryPackReaderOptionalState.Reset();
		}
	}

	public static async ValueTask<T?> DeserializeAsync<T>(Stream stream, MemoryPackSerializerOptions? options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (stream is MemoryStream memoryStream && memoryStream.TryGetBuffer(out var buffer))
		{
			cancellationToken.ThrowIfCancellationRequested();
			T value = default(T);
			int num = Deserialize(buffer.AsSpan(checked((int)memoryStream.Position)), ref value, options);
			memoryStream.Seek(num, SeekOrigin.Current);
			return value;
		}
		ReusableReadOnlySequenceBuilder builder = ReusableReadOnlySequenceBuilderPool.Rent();
		try
		{
			byte[] buffer2 = ArrayPool<byte>.Shared.Rent(65536);
			int offset = 0;
			int num2;
			do
			{
				if (offset == buffer2.Length)
				{
					builder.Add(buffer2, returnToPool: true);
					buffer2 = ArrayPool<byte>.Shared.Rent(MathEx.NewArrayCapacity(buffer2.Length));
					offset = 0;
				}
				try
				{
					num2 = await stream.ReadAsync(MemoryExtensions.AsMemory(buffer2, offset, buffer2.Length - offset), cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
				}
				catch
				{
					ArrayPool<byte>.Shared.Return(buffer2);
					throw;
				}
				offset += num2;
			}
			while (num2 != 0);
			builder.Add(MemoryExtensions.AsMemory(buffer2, 0, offset), returnToPool: true);
			if (builder.TryGetSingleMemory(out var memory))
			{
				return Deserialize<T>(memory.Span, options);
			}
			return Deserialize<T>(builder.Build(), options);
		}
		finally
		{
			builder.Reset();
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static byte[] Serialize(Type type, object? value, MemoryPackSerializerOptions? options = null)
	{
		SerializerWriterThreadStaticState serializerWriterThreadStaticState = threadStaticState;
		if (serializerWriterThreadStaticState == null)
		{
			serializerWriterThreadStaticState = (threadStaticState = new SerializerWriterThreadStaticState());
		}
		serializerWriterThreadStaticState.Init(options);
		try
		{
			MemoryPackWriter writer = new MemoryPackWriter(ref Unsafe.As<ReusableLinkedArrayBufferWriter, IBufferWriter<byte>>(ref serializerWriterThreadStaticState.BufferWriter), serializerWriterThreadStaticState.BufferWriter.DangerousGetFirstBuffer(), serializerWriterThreadStaticState.OptionalState);
			Serialize(type, ref writer, value);
			return serializerWriterThreadStaticState.BufferWriter.ToArrayAndReset();
		}
		finally
		{
			serializerWriterThreadStaticState.Reset();
		}
	}

	public static void Serialize(Type type, in IBufferWriter<byte> bufferWriter, object? value, MemoryPackSerializerOptions? options = null)
	{
		MemoryPackWriterOptionalState memoryPackWriterOptionalState = threadStaticWriterOptionalState;
		if (memoryPackWriterOptionalState == null)
		{
			memoryPackWriterOptionalState = (threadStaticWriterOptionalState = new MemoryPackWriterOptionalState());
		}
		memoryPackWriterOptionalState.Init(options);
		try
		{
			MemoryPackWriter writer = new MemoryPackWriter(ref Unsafe.AsRef(in bufferWriter), memoryPackWriterOptionalState);
			Serialize(type, ref writer, value);
		}
		finally
		{
			memoryPackWriterOptionalState.Reset();
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static void Serialize(Type type, ref MemoryPackWriter writer, object? value)
	{
		writer.GetFormatter(type).Serialize(ref writer, ref value);
		writer.Flush();
	}

	public static async ValueTask SerializeAsync(Type type, Stream stream, object? value, MemoryPackSerializerOptions? options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		ReusableLinkedArrayBufferWriter tempWriter = ReusableLinkedArrayBufferWriterPool.Rent();
		try
		{
			SerializeToTempWriter(tempWriter, type, value, options);
			await tempWriter.WriteToAndResetAsync(stream, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
		}
		finally
		{
			ReusableLinkedArrayBufferWriterPool.Return(tempWriter);
		}
	}

	private static void SerializeToTempWriter(ReusableLinkedArrayBufferWriter bufferWriter, Type type, object? value, MemoryPackSerializerOptions? options)
	{
		MemoryPackWriterOptionalState memoryPackWriterOptionalState = threadStaticWriterOptionalState;
		if (memoryPackWriterOptionalState == null)
		{
			memoryPackWriterOptionalState = (threadStaticWriterOptionalState = new MemoryPackWriterOptionalState());
		}
		memoryPackWriterOptionalState.Init(options);
		MemoryPackWriter writer = new MemoryPackWriter(ref Unsafe.As<ReusableLinkedArrayBufferWriter, IBufferWriter<byte>>(ref bufferWriter), memoryPackWriterOptionalState);
		try
		{
			Serialize(type, ref writer, value);
		}
		finally
		{
			memoryPackWriterOptionalState.Reset();
		}
	}

	public static object? Deserialize(Type type, ReadOnlySpan<byte> buffer, MemoryPackSerializerOptions? options = null)
	{
		object value = null;
		Deserialize(type, buffer, ref value, options);
		return value;
	}

	public static int Deserialize(Type type, ReadOnlySpan<byte> buffer, ref object? value, MemoryPackSerializerOptions? options = null)
	{
		MemoryPackReaderOptionalState memoryPackReaderOptionalState = threadStaticReaderOptionalState;
		if (memoryPackReaderOptionalState == null)
		{
			memoryPackReaderOptionalState = (threadStaticReaderOptionalState = new MemoryPackReaderOptionalState());
		}
		memoryPackReaderOptionalState.Init(options);
		MemoryPackReader reader = new MemoryPackReader(buffer, memoryPackReaderOptionalState);
		try
		{
			reader.GetFormatter(type).Deserialize(ref reader, ref value);
			return reader.Consumed;
		}
		finally
		{
			reader.Dispose();
			memoryPackReaderOptionalState.Reset();
		}
	}

	public static object? Deserialize(Type type, in ReadOnlySequence<byte> buffer, MemoryPackSerializerOptions? options = null)
	{
		object value = null;
		Deserialize(type, in buffer, ref value, options);
		return value;
	}

	public static int Deserialize(Type type, in ReadOnlySequence<byte> buffer, ref object? value, MemoryPackSerializerOptions? options = null)
	{
		MemoryPackReaderOptionalState memoryPackReaderOptionalState = threadStaticReaderOptionalState;
		if (memoryPackReaderOptionalState == null)
		{
			memoryPackReaderOptionalState = (threadStaticReaderOptionalState = new MemoryPackReaderOptionalState());
		}
		memoryPackReaderOptionalState.Init(options);
		MemoryPackReader reader = new MemoryPackReader(in buffer, memoryPackReaderOptionalState);
		try
		{
			reader.GetFormatter(type).Deserialize(ref reader, ref value);
			return reader.Consumed;
		}
		finally
		{
			reader.Dispose();
			memoryPackReaderOptionalState.Reset();
		}
	}

	public static async ValueTask<object?> DeserializeAsync(Type type, Stream stream, MemoryPackSerializerOptions? options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (stream is MemoryStream memoryStream && memoryStream.TryGetBuffer(out var buffer))
		{
			cancellationToken.ThrowIfCancellationRequested();
			object value = null;
			int num = Deserialize(type, buffer.AsSpan(checked((int)memoryStream.Position)), ref value, options);
			memoryStream.Seek(num, SeekOrigin.Current);
			return value;
		}
		ReusableReadOnlySequenceBuilder builder = ReusableReadOnlySequenceBuilderPool.Rent();
		try
		{
			byte[] buffer2 = ArrayPool<byte>.Shared.Rent(65536);
			int offset = 0;
			int num2;
			do
			{
				if (offset == buffer2.Length)
				{
					builder.Add(buffer2, returnToPool: true);
					buffer2 = ArrayPool<byte>.Shared.Rent(MathEx.NewArrayCapacity(buffer2.Length));
					offset = 0;
				}
				try
				{
					num2 = await stream.ReadAsync(MemoryExtensions.AsMemory(buffer2, offset, buffer2.Length - offset), cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
				}
				catch
				{
					ArrayPool<byte>.Shared.Return(buffer2);
					throw;
				}
				offset += num2;
			}
			while (num2 != 0);
			builder.Add(MemoryExtensions.AsMemory(buffer2, 0, offset), returnToPool: true);
			if (builder.TryGetSingleMemory(out var memory))
			{
				return Deserialize(type, memory.Span, options);
			}
			return Deserialize(type, builder.Build(), options);
		}
		finally
		{
			builder.Reset();
		}
	}

	public static byte[] Serialize<T>(in T? value, MemoryPackSerializerOptions? options = null)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			byte[] array = MemoryMarshalEx.AllocateUninitializedArray<byte>(Unsafe.SizeOf<T>());
			Unsafe.WriteUnaligned(ref MemoryMarshalEx.GetArrayDataReference(array), value);
			return array;
		}
		SerializerWriterThreadStaticState serializerWriterThreadStaticState = threadStaticState;
		if (serializerWriterThreadStaticState == null)
		{
			serializerWriterThreadStaticState = (threadStaticState = new SerializerWriterThreadStaticState());
		}
		serializerWriterThreadStaticState.Init(options);
		try
		{
			MemoryPackWriter writer = new MemoryPackWriter(ref Unsafe.As<ReusableLinkedArrayBufferWriter, IBufferWriter<byte>>(ref serializerWriterThreadStaticState.BufferWriter), serializerWriterThreadStaticState.BufferWriter.DangerousGetFirstBuffer(), serializerWriterThreadStaticState.OptionalState);
			Serialize(ref writer, in value);
			return serializerWriterThreadStaticState.BufferWriter.ToArrayAndReset();
		}
		finally
		{
			serializerWriterThreadStaticState.Reset();
		}
	}

	public static void Serialize<T>(in IBufferWriter<byte> bufferWriter, in T? value, MemoryPackSerializerOptions? options = null)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			Unsafe.WriteUnaligned(ref MemoryMarshal.GetReference(bufferWriter.GetSpan(Unsafe.SizeOf<T>())), value);
			bufferWriter.Advance(Unsafe.SizeOf<T>());
			return;
		}
		MemoryPackWriterOptionalState memoryPackWriterOptionalState = threadStaticWriterOptionalState;
		if (memoryPackWriterOptionalState == null)
		{
			memoryPackWriterOptionalState = (threadStaticWriterOptionalState = new MemoryPackWriterOptionalState());
		}
		memoryPackWriterOptionalState.Init(options);
		try
		{
			MemoryPackWriter writer = new MemoryPackWriter(ref Unsafe.AsRef(in bufferWriter), memoryPackWriterOptionalState);
			Serialize(ref writer, in value);
		}
		finally
		{
			memoryPackWriterOptionalState.Reset();
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static void Serialize<T>(ref MemoryPackWriter writer, in T? value)
	{
		writer.WriteValue(in value);
		writer.Flush();
	}

	public static async ValueTask SerializeAsync<T>(Stream stream, T? value, MemoryPackSerializerOptions? options = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		ReusableLinkedArrayBufferWriter tempWriter = ReusableLinkedArrayBufferWriterPool.Rent();
		try
		{
			IBufferWriter<byte> bufferWriter = tempWriter;
			Serialize(in bufferWriter, in value, options);
			await tempWriter.WriteToAndResetAsync(stream, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			await stream.FlushAsync(cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
		}
		finally
		{
			ReusableLinkedArrayBufferWriterPool.Return(tempWriter);
		}
	}
}
