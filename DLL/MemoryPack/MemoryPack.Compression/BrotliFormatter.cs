using System;
using System.Buffers;
using System.IO.Compression;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using MemoryPack.Internal;

namespace MemoryPack.Compression;

[Preserve]
public sealed class BrotliFormatter : MemoryPackFormatter<byte[]>
{
	internal const int DefaultDecompssionSizeLimit = 134217728;

	public static readonly BrotliFormatter Default = new BrotliFormatter();

	private readonly CompressionLevel compressionLevel;

	private readonly int window;

	private readonly int decompressionSizeLimit;

	public BrotliFormatter()
		: this(CompressionLevel.Fastest)
	{
	}

	public BrotliFormatter(CompressionLevel compressionLevel)
		: this(compressionLevel, 22)
	{
	}

	public BrotliFormatter(CompressionLevel compressionLevel, int window)
		: this(compressionLevel, window, 134217728)
	{
	}

	public BrotliFormatter(CompressionLevel compressionLevel, int window, int decompressionSizeLimit)
	{
		this.compressionLevel = compressionLevel;
		this.window = window;
		this.decompressionSizeLimit = decompressionSizeLimit;
	}

	[Preserve]
	public unsafe override void Serialize(ref MemoryPackWriter writer, ref byte[]? value)
	{
		if (value == null)
		{
			writer.WriteNullCollectionHeader();
			return;
		}
		if (value.Length == 0)
		{
			writer.WriteCollectionHeader(0);
			return;
		}
		int qualityFromCompressionLevel = BrotliUtils.GetQualityFromCompressionLevel(compressionLevel);
		BrotliEncoder val = default(BrotliEncoder);
		((BrotliEncoder)(ref val))._002Ector(qualityFromCompressionLevel, window);
		try
		{
			int num = BrotliUtils.BrotliEncoderMaxCompressedSize(value.Length);
			ref byte spanReference = ref writer.GetSpanReference(num + 8);
			Span<byte> span = MemoryMarshal.CreateSpan(ref Unsafe.Add(ref spanReference, 8), num);
			int num2 = default(int);
			int num3 = default(int);
			OperationStatus operationStatus = ((BrotliEncoder)(ref val)).Compress((ReadOnlySpan<byte>)MemoryExtensions.AsSpan(value), span, ref num2, ref num3, true);
			if (operationStatus != OperationStatus.Done)
			{
				MemoryPackSerializationException.ThrowCompressionFailed(operationStatus);
			}
			if (num2 != value.Length)
			{
				MemoryPackSerializationException.ThrowCompressionFailed();
			}
			Unsafe.WriteUnaligned(ref spanReference, value.Length);
			Unsafe.WriteUnaligned(ref Unsafe.Add(ref spanReference, 4), num3);
			writer.Advance(num3 + 8);
		}
		finally
		{
			((IDisposable)(*(BrotliEncoder*)(&val))/*cast due to constrained. prefix*/).Dispose();
		}
	}

	[Preserve]
	public unsafe override void Deserialize(ref MemoryPackReader reader, ref byte[]? value)
	{
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		int num = reader.ReadUnmanaged<int>();
		reader.DangerousReadUnmanagedSpanView<byte>(out var isNull, out var view);
		if (isNull)
		{
			value = null;
			return;
		}
		if (view.Length == 0)
		{
			value = Array.Empty<byte>();
			return;
		}
		if (decompressionSizeLimit < num)
		{
			MemoryPackSerializationException.ThrowDecompressionSizeLimitExceeded(decompressionSizeLimit, num);
		}
		if (value == null || value.Length != num)
		{
			value = new byte[num];
		}
		BrotliDecoder val = default(BrotliDecoder);
		try
		{
			int num2 = default(int);
			int num3 = default(int);
			OperationStatus operationStatus = ((BrotliDecoder)(ref val)).Decompress(view, (Span<byte>)value, ref num2, ref num3);
			if (operationStatus != OperationStatus.Done)
			{
				MemoryPackSerializationException.ThrowCompressionFailed(operationStatus);
			}
			if (num2 != view.Length || num3 != value.Length)
			{
				MemoryPackSerializationException.ThrowCompressionFailed();
			}
		}
		finally
		{
			((IDisposable)(*(BrotliDecoder*)(&val))/*cast due to constrained. prefix*/).Dispose();
		}
	}
}
[Preserve]
public sealed class BrotliFormatter<T> : MemoryPackFormatter<T>
{
	internal const int DefaultDecompssionSizeLimit = 134217728;

	public static readonly BrotliFormatter Default = new BrotliFormatter();

	private readonly CompressionLevel compressionLevel;

	private readonly int window;

	public BrotliFormatter()
		: this(CompressionLevel.Fastest)
	{
	}

	public BrotliFormatter(CompressionLevel compressionLevel)
		: this(compressionLevel, 22)
	{
	}

	public BrotliFormatter(CompressionLevel compressionLevel, int window)
	{
		this.compressionLevel = compressionLevel;
		this.window = window;
	}

	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref T? value)
	{
		BrotliCompressor source = new BrotliCompressor(compressionLevel, window);
		try
		{
			MemoryPackWriter memoryPackWriter = new MemoryPackWriter(ref Unsafe.As<BrotliCompressor, IBufferWriter<byte>>(ref source), writer.OptionalState);
			memoryPackWriter.WriteValue(in value);
			memoryPackWriter.Flush();
			source.CopyTo(ref writer);
		}
		finally
		{
			source.Dispose();
		}
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref T? value)
	{
		using BrotliDecompressor brotliDecompressor = default(BrotliDecompressor);
		reader.GetRemainingSource(out var singleSource, out var remainingSource);
		int consumed;
		using MemoryPackReader memoryPackReader = new MemoryPackReader((singleSource.Length == 0) ? brotliDecompressor.Decompress(remainingSource, out consumed) : brotliDecompressor.Decompress(singleSource, out consumed), reader.OptionalState);
		memoryPackReader.ReadValue(ref value);
		reader.Advance(consumed);
	}
}
