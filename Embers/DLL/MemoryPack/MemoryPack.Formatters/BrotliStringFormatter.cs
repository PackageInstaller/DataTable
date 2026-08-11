using System;
using System.Buffers;
using System.IO.Compression;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using MemoryPack.Compression;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class BrotliStringFormatter : MemoryPackFormatter<string>
{
	[ThreadStatic]
	private static StrongBox<int>? threadStaticConsumedBox;

	internal const int DefaultDecompssionSizeLimit = 134217728;

	public static readonly BrotliStringFormatter Default = new BrotliStringFormatter();

	private readonly CompressionLevel compressionLevel;

	private readonly int window;

	private readonly int decompressionSizeLimit;

	public BrotliStringFormatter()
		: this(CompressionLevel.Fastest)
	{
	}

	public BrotliStringFormatter(CompressionLevel compressionLevel)
		: this(compressionLevel, 22)
	{
		this.compressionLevel = compressionLevel;
	}

	public BrotliStringFormatter(CompressionLevel compressionLevel, int window)
		: this(compressionLevel, window, 134217728)
	{
	}

	public BrotliStringFormatter(CompressionLevel compressionLevel, int window, int decompressionSizeLimit)
	{
		this.compressionLevel = compressionLevel;
		this.window = window;
		this.decompressionSizeLimit = decompressionSizeLimit;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	[Preserve]
	public unsafe override void Serialize(ref MemoryPackWriter writer, ref string? value)
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
			int num = value.Length * 2;
			int num2 = BrotliUtils.BrotliEncoderMaxCompressedSize(num);
			ref byte spanReference = ref writer.GetSpanReference(num2 + 4);
			Span<byte> span = MemoryMarshal.CreateSpan(ref Unsafe.Add(ref spanReference, 4), num2);
			int num3 = default(int);
			int num4 = default(int);
			OperationStatus operationStatus = ((BrotliEncoder)(ref val)).Compress(MemoryMarshal.AsBytes(MemoryExtensions.AsSpan(value)), span, ref num3, ref num4, true);
			if (operationStatus != OperationStatus.Done)
			{
				MemoryPackSerializationException.ThrowCompressionFailed(operationStatus);
			}
			if (num3 != num)
			{
				MemoryPackSerializationException.ThrowCompressionFailed();
			}
			Unsafe.WriteUnaligned(ref spanReference, value.Length);
			writer.Advance(num4 + 4);
		}
		finally
		{
			((IDisposable)(*(BrotliEncoder*)(&val))/*cast due to constrained. prefix*/).Dispose();
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	[Preserve]
	public unsafe override void Deserialize(ref MemoryPackReader reader, ref string? value)
	{
		if (!reader.DangerousTryReadCollectionHeader(out var length))
		{
			value = null;
			return;
		}
		if (length == 0)
		{
			value = "";
			return;
		}
		int num = length * 2;
		if (decompressionSizeLimit < num)
		{
			MemoryPackSerializationException.ThrowDecompressionSizeLimitExceeded(decompressionSizeLimit, num);
		}
		reader.GetRemainingSource(out var singleSource, out var remainingSource);
		StrongBox<int> strongBox = threadStaticConsumedBox;
		if (strongBox == null)
		{
			strongBox = (threadStaticConsumedBox = new StrongBox<int>());
		}
		else
		{
			strongBox.Value = 0;
		}
		if (singleSource.Length != 0)
		{
			fixed (byte* ptr = singleSource)
			{
				value = string.Create(length, ((IntPtr)ptr, singleSource.Length, num, strongBox), delegate(Span<char> stringSpan, (IntPtr, int Length, int byteLength, StrongBox<int> consumedBox) state)
				{
					//IL_0025: Unknown result type (might be due to invalid IL or missing references)
					Span<byte> span = MemoryMarshal.CreateSpan(ref Unsafe.AsRef<byte>((void*)state.Item1), state.Length);
					Span<byte> span2 = MemoryMarshal.AsBytes(stringSpan);
					BrotliDecoder val = default(BrotliDecoder);
					try
					{
						int value2 = default(int);
						int num2 = default(int);
						OperationStatus operationStatus = ((BrotliDecoder)(ref val)).Decompress((ReadOnlySpan<byte>)span, span2, ref value2, ref num2);
						if (operationStatus != OperationStatus.Done)
						{
							MemoryPackSerializationException.ThrowCompressionFailed(operationStatus);
						}
						if (num2 != state.byteLength)
						{
							MemoryPackSerializationException.ThrowCompressionFailed();
						}
						state.consumedBox.Value = value2;
					}
					finally
					{
						((IDisposable)(*(BrotliDecoder*)(&val))/*cast due to constrained. prefix*/).Dispose();
					}
				});
				reader.Advance(strongBox.Value);
			}
			return;
		}
		value = string.Create(length, (remainingSource, remainingSource.Length, num, strongBox), delegate(Span<char> stringSpan, (ReadOnlySequence<byte> remainingSource, long Length, int byteLength, StrongBox<int> consumedBox) state)
		{
			//IL_0009: Unknown result type (might be due to invalid IL or missing references)
			Span<byte> span = MemoryMarshal.AsBytes(stringSpan);
			BrotliDecoder val = default(BrotliDecoder);
			try
			{
				int num2 = 0;
				OperationStatus operationStatus = OperationStatus.DestinationTooSmall;
				int num3 = default(int);
				int start = default(int);
				foreach (ReadOnlyMemory<byte> item in state.remainingSource)
				{
					operationStatus = ((BrotliDecoder)(ref val)).Decompress(item.Span, span, ref num3, ref start);
					num2 += num3;
					span = span.Slice(start);
					if (operationStatus == OperationStatus.Done)
					{
						break;
					}
				}
				if (operationStatus != OperationStatus.Done)
				{
					MemoryPackSerializationException.ThrowCompressionFailed(operationStatus);
				}
				state.consumedBox.Value = num2;
			}
			finally
			{
				((IDisposable)(*(BrotliDecoder*)(&val))/*cast due to constrained. prefix*/).Dispose();
			}
		});
		reader.Advance(strongBox.Value);
	}
}
