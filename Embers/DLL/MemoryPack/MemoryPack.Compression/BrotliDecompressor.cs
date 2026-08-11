using System;
using System.Buffers;
using System.IO.Compression;
using MemoryPack.Internal;

namespace MemoryPack.Compression;

public struct BrotliDecompressor : IDisposable
{
	private ReusableReadOnlySequenceBuilder? sequenceBuilder;

	public ReadOnlySequence<byte> Decompress(ReadOnlySpan<byte> compressedSpan)
	{
		int consumed;
		return Decompress(compressedSpan, out consumed);
	}

	public ReadOnlySequence<byte> Decompress(ReadOnlySpan<byte> compressedSpan, out int consumed)
	{
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		if (sequenceBuilder != null)
		{
			MemoryPackSerializationException.ThrowAlreadyDecompressed();
		}
		sequenceBuilder = ReusableReadOnlySequenceBuilderPool.Rent();
		BrotliDecoder decoder = default(BrotliDecoder);
		try
		{
			OperationStatus status = OperationStatus.DestinationTooSmall;
			DecompressCore(ref status, ref decoder, compressedSpan, out consumed);
			if (status == OperationStatus.NeedMoreData)
			{
				MemoryPackSerializationException.ThrowCompressionFailed(status);
			}
		}
		finally
		{
			((BrotliDecoder)(ref decoder)).Dispose();
		}
		return sequenceBuilder.Build();
	}

	public ReadOnlySequence<byte> Decompress(ReadOnlySequence<byte> compressedSequence)
	{
		int consumed;
		return Decompress(compressedSequence, out consumed);
	}

	public ReadOnlySequence<byte> Decompress(ReadOnlySequence<byte> compressedSequence, out int consumed)
	{
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		if (sequenceBuilder != null)
		{
			MemoryPackSerializationException.ThrowAlreadyDecompressed();
		}
		sequenceBuilder = ReusableReadOnlySequenceBuilderPool.Rent();
		BrotliDecoder decoder = default(BrotliDecoder);
		try
		{
			OperationStatus status = OperationStatus.DestinationTooSmall;
			consumed = 0;
			foreach (ReadOnlyMemory<byte> item in compressedSequence)
			{
				DecompressCore(ref status, ref decoder, item.Span, out var consumed2);
				consumed += consumed2;
			}
			if (status == OperationStatus.NeedMoreData)
			{
				MemoryPackSerializationException.ThrowCompressionFailed(status);
			}
		}
		finally
		{
			((BrotliDecoder)(ref decoder)).Dispose();
		}
		return sequenceBuilder.Build();
	}

	private void DecompressCore(ref OperationStatus status, ref BrotliDecoder decoder, ReadOnlySpan<byte> source, out int consumed)
	{
		consumed = 0;
		byte[] array = null;
		status = OperationStatus.DestinationTooSmall;
		int num = source.Length;
		int num2 = default(int);
		int num3 = default(int);
		while (status == OperationStatus.DestinationTooSmall)
		{
			if (array == null)
			{
				num = GetDoubleCapacity(num);
				array = ArrayPool<byte>.Shared.Rent(num);
			}
			status = ((BrotliDecoder)(ref decoder)).Decompress(source, (Span<byte>)array, ref num2, ref num3);
			consumed += num2;
			if (status == OperationStatus.InvalidData)
			{
				MemoryPackSerializationException.ThrowCompressionFailed(status);
			}
			if (status == OperationStatus.NeedMoreData)
			{
				if (num3 > 0)
				{
					sequenceBuilder.Add(MemoryExtensions.AsMemory(array, 0, num3), returnToPool: true);
				}
				if (num2 > 0)
				{
					source = source.Slice(num2);
				}
				if (source.Length != 0)
				{
					MemoryPackSerializationException.ThrowCompressionFailed();
				}
				break;
			}
			if (num2 > 0)
			{
				source = source.Slice(num2);
			}
			if (num3 > 0)
			{
				sequenceBuilder.Add(MemoryExtensions.AsMemory(array, 0, num3), returnToPool: true);
				array = null;
			}
		}
	}

	public void Dispose()
	{
		if (sequenceBuilder != null)
		{
			ReusableReadOnlySequenceBuilderPool.Return(sequenceBuilder);
			sequenceBuilder = null;
		}
	}

	private int GetDoubleCapacity(int length)
	{
		int num = length * 2;
		if ((uint)num > 2147483647u)
		{
			num = int.MaxValue;
		}
		return Math.Max(num, 4096);
	}
}
