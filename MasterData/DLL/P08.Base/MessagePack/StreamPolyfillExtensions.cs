using System;
using System.Buffers;
using System.IO;
using System.Runtime.InteropServices;
using System.Threading;
using System.Threading.Tasks;

namespace MessagePack;

internal static class StreamPolyfillExtensions
{
	internal static int Read(this Stream stream, Span<byte> buffer)
	{
		if (stream == null)
		{
			throw new ArgumentNullException("stream");
		}
		byte[] array = ArrayPool<byte>.Shared.Rent(buffer.Length);
		try
		{
			int num = stream.Read(array, 0, buffer.Length);
			new Span<byte>(array, 0, num).CopyTo(buffer);
			return num;
		}
		finally
		{
			ArrayPool<byte>.Shared.Return(array);
		}
	}

	internal static ValueTask<int> ReadAsync(this Stream stream, Memory<byte> buffer, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (stream == null)
		{
			throw new ArgumentNullException("stream");
		}
		if (MemoryMarshal.TryGetArray((ReadOnlyMemory<byte>)buffer, out ArraySegment<byte> segment))
		{
			return new ValueTask<int>(stream.ReadAsync(segment.Array, segment.Offset, segment.Count, cancellationToken));
		}
		byte[] array = ArrayPool<byte>.Shared.Rent(buffer.Length);
		return FinishReadAsync(stream.ReadAsync(array, 0, buffer.Length, cancellationToken), array, buffer);
		static async ValueTask<int> FinishReadAsync(Task<int> readTask, byte[] localBuffer, Memory<byte> localDestination)
		{
			try
			{
				int num = await readTask.ConfigureAwait(continueOnCapturedContext: false);
				new Span<byte>(localBuffer, 0, num).CopyTo(localDestination.Span);
				return num;
			}
			finally
			{
				ArrayPool<byte>.Shared.Return(localBuffer);
			}
		}
	}

	internal static void Write(this Stream stream, ReadOnlySpan<byte> buffer)
	{
		if (stream == null)
		{
			throw new ArgumentNullException("stream");
		}
		byte[] array = ArrayPool<byte>.Shared.Rent(buffer.Length);
		try
		{
			buffer.CopyTo(array);
			stream.Write(array, 0, buffer.Length);
		}
		finally
		{
			ArrayPool<byte>.Shared.Return(array);
		}
	}

	internal static async ValueTask WriteAsync(this Stream stream, ReadOnlyMemory<byte> buffer, CancellationToken cancellationToken)
	{
		if (stream == null)
		{
			throw new ArgumentNullException("stream");
		}
		byte[] sharedBuffer = ArrayPool<byte>.Shared.Rent(buffer.Length);
		try
		{
			buffer.CopyTo(sharedBuffer);
			await stream.WriteAsync(sharedBuffer, 0, buffer.Length, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
		}
		finally
		{
			ArrayPool<byte>.Shared.Return(sharedBuffer);
		}
	}
}
