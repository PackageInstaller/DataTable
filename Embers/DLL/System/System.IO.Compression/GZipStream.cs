using System.Runtime.CompilerServices;
using System.Threading;
using System.Threading.Tasks;

namespace System.IO.Compression;

public class GZipStream : Stream
{
	private DeflateStream _deflateStream;

	public override bool CanRead => _deflateStream?.CanRead ?? false;

	public override bool CanWrite => _deflateStream?.CanWrite ?? false;

	public override bool CanSeek => _deflateStream?.CanSeek ?? false;

	public override long Length
	{
		get
		{
			throw new NotSupportedException("This operation is not supported.");
		}
	}

	public override long Position
	{
		get
		{
			throw new NotSupportedException("This operation is not supported.");
		}
		set
		{
			throw new NotSupportedException("This operation is not supported.");
		}
	}

	public GZipStream(Stream stream, CompressionMode mode)
		: this(stream, mode, leaveOpen: false)
	{
	}

	public GZipStream(Stream stream, CompressionMode mode, bool leaveOpen)
	{
		_deflateStream = new DeflateStream(stream, mode, leaveOpen, 31);
	}

	public override void Flush()
	{
		CheckDeflateStream();
		_deflateStream.Flush();
	}

	public override long Seek(long offset, SeekOrigin origin)
	{
		throw new NotSupportedException("This operation is not supported.");
	}

	public override void SetLength(long value)
	{
		throw new NotSupportedException("This operation is not supported.");
	}

	public override int ReadByte()
	{
		CheckDeflateStream();
		return _deflateStream.ReadByte();
	}

	public override IAsyncResult BeginRead(byte[] array, int offset, int count, AsyncCallback asyncCallback, object asyncState)
	{
		return TaskToApm.Begin(ReadAsync(array, offset, count, CancellationToken.None), asyncCallback, asyncState);
	}

	public override int EndRead(IAsyncResult asyncResult)
	{
		return TaskToApm.End<int>(asyncResult);
	}

	public override int Read(byte[] array, int offset, int count)
	{
		CheckDeflateStream();
		return _deflateStream.Read(array, offset, count);
	}

	public override int Read(Span<byte> buffer)
	{
		if (GetType() != typeof(GZipStream))
		{
			return base.Read(buffer);
		}
		CheckDeflateStream();
		return _deflateStream.ReadCore(buffer);
	}

	public override IAsyncResult BeginWrite(byte[] array, int offset, int count, AsyncCallback asyncCallback, object asyncState)
	{
		return TaskToApm.Begin(WriteAsync(array, offset, count, CancellationToken.None), asyncCallback, asyncState);
	}

	public override void EndWrite(IAsyncResult asyncResult)
	{
		TaskToApm.End(asyncResult);
	}

	public override void Write(byte[] array, int offset, int count)
	{
		CheckDeflateStream();
		_deflateStream.Write(array, offset, count);
	}

	public override void Write(ReadOnlySpan<byte> buffer)
	{
		if (GetType() != typeof(GZipStream))
		{
			base.Write(buffer);
			return;
		}
		CheckDeflateStream();
		_deflateStream.WriteCore(buffer);
	}

	public override void CopyTo(Stream destination, int bufferSize)
	{
		CheckDeflateStream();
		_deflateStream.CopyTo(destination, bufferSize);
	}

	protected override void Dispose(bool disposing)
	{
		try
		{
			if (disposing && _deflateStream != null)
			{
				_deflateStream.Dispose();
			}
			_deflateStream = null;
		}
		finally
		{
			base.Dispose(disposing);
		}
	}

	public override Task<int> ReadAsync(byte[] array, int offset, int count, CancellationToken cancellationToken)
	{
		CheckDeflateStream();
		return _deflateStream.ReadAsync(array, offset, count, cancellationToken);
	}

	public override ValueTask<int> ReadAsync(Memory<byte> buffer, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (GetType() != typeof(GZipStream))
		{
			return base.ReadAsync(buffer, cancellationToken);
		}
		CheckDeflateStream();
		return _deflateStream.ReadAsyncMemory(buffer, cancellationToken);
	}

	public override Task WriteAsync(byte[] array, int offset, int count, CancellationToken cancellationToken)
	{
		CheckDeflateStream();
		return _deflateStream.WriteAsync(array, offset, count, cancellationToken);
	}

	public override ValueTask WriteAsync(ReadOnlyMemory<byte> buffer, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (GetType() != typeof(GZipStream))
		{
			return base.WriteAsync(buffer, cancellationToken);
		}
		CheckDeflateStream();
		return _deflateStream.WriteAsyncMemory(buffer, cancellationToken);
	}

	public override Task FlushAsync(CancellationToken cancellationToken)
	{
		CheckDeflateStream();
		return _deflateStream.FlushAsync(cancellationToken);
	}

	public override Task CopyToAsync(Stream destination, int bufferSize, CancellationToken cancellationToken)
	{
		CheckDeflateStream();
		return _deflateStream.CopyToAsync(destination, bufferSize, cancellationToken);
	}

	private void CheckDeflateStream()
	{
		if (_deflateStream == null)
		{
			ThrowStreamClosedException();
		}
	}

	[MethodImpl(MethodImplOptions.NoInlining)]
	private static void ThrowStreamClosedException()
	{
		throw new ObjectDisposedException(null, "Cannot access a closed Stream.");
	}
}
