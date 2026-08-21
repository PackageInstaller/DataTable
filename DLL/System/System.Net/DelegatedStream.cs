using System.IO;
using System.Net.Sockets;
using System.Threading;
using System.Threading.Tasks;

namespace System.Net;

internal class DelegatedStream : Stream
{
	private readonly Stream _stream;

	private readonly NetworkStream _netStream;

	protected Stream BaseStream => _stream;

	public override bool CanRead => _stream.CanRead;

	public override bool CanSeek => _stream.CanSeek;

	public override bool CanWrite => _stream.CanWrite;

	public override long Length
	{
		get
		{
			if (!CanSeek)
			{
				throw new NotSupportedException("Seeking is not supported on this stream.");
			}
			return _stream.Length;
		}
	}

	public override long Position
	{
		get
		{
			if (!CanSeek)
			{
				throw new NotSupportedException("Seeking is not supported on this stream.");
			}
			return _stream.Position;
		}
		set
		{
			if (!CanSeek)
			{
				throw new NotSupportedException("Seeking is not supported on this stream.");
			}
			_stream.Position = value;
		}
	}

	protected DelegatedStream(Stream stream)
	{
		if (stream == null)
		{
			throw new ArgumentNullException("stream");
		}
		_stream = stream;
		_netStream = stream as NetworkStream;
	}

	public override IAsyncResult BeginRead(byte[] buffer, int offset, int count, AsyncCallback callback, object state)
	{
		if (!CanRead)
		{
			throw new NotSupportedException("Reading is not supported on this stream.");
		}
		IAsyncResult asyncResult = null;
		if (_netStream != null)
		{
			return _netStream.BeginRead(buffer, offset, count, callback, state);
		}
		return _stream.BeginRead(buffer, offset, count, callback, state);
	}

	public override IAsyncResult BeginWrite(byte[] buffer, int offset, int count, AsyncCallback callback, object state)
	{
		if (!CanWrite)
		{
			throw new NotSupportedException("Writing is not supported on this stream.");
		}
		IAsyncResult asyncResult = null;
		if (_netStream != null)
		{
			return _netStream.BeginWrite(buffer, offset, count, callback, state);
		}
		return _stream.BeginWrite(buffer, offset, count, callback, state);
	}

	public override void Close()
	{
		_stream.Close();
	}

	public override int EndRead(IAsyncResult asyncResult)
	{
		if (!CanRead)
		{
			throw new NotSupportedException("Reading is not supported on this stream.");
		}
		return _stream.EndRead(asyncResult);
	}

	public override void EndWrite(IAsyncResult asyncResult)
	{
		if (!CanWrite)
		{
			throw new NotSupportedException("Writing is not supported on this stream.");
		}
		_stream.EndWrite(asyncResult);
	}

	public override void Flush()
	{
		_stream.Flush();
	}

	public override Task FlushAsync(CancellationToken cancellationToken)
	{
		return _stream.FlushAsync(cancellationToken);
	}

	public override int Read(byte[] buffer, int offset, int count)
	{
		if (!CanRead)
		{
			throw new NotSupportedException("Reading is not supported on this stream.");
		}
		return _stream.Read(buffer, offset, count);
	}

	public override Task<int> ReadAsync(byte[] buffer, int offset, int count, CancellationToken cancellationToken)
	{
		if (!CanRead)
		{
			throw new NotSupportedException("Reading is not supported on this stream.");
		}
		return _stream.ReadAsync(buffer, offset, count, cancellationToken);
	}

	public override long Seek(long offset, SeekOrigin origin)
	{
		if (!CanSeek)
		{
			throw new NotSupportedException("Seeking is not supported on this stream.");
		}
		return _stream.Seek(offset, origin);
	}

	public override void SetLength(long value)
	{
		if (!CanSeek)
		{
			throw new NotSupportedException("Seeking is not supported on this stream.");
		}
		_stream.SetLength(value);
	}

	public override void Write(byte[] buffer, int offset, int count)
	{
		if (!CanWrite)
		{
			throw new NotSupportedException("Writing is not supported on this stream.");
		}
		_stream.Write(buffer, offset, count);
	}

	public override Task WriteAsync(byte[] buffer, int offset, int count, CancellationToken cancellationToken)
	{
		if (!CanWrite)
		{
			throw new NotSupportedException("Writing is not supported on this stream.");
		}
		return _stream.WriteAsync(buffer, offset, count, cancellationToken);
	}
}
