using System.IO;
using System.Net.Sockets;
using System.Threading;
using System.Threading.Tasks;

namespace System.Net;

internal class NetworkStreamWrapper : Stream
{
	private TcpClient _client;

	private NetworkStream _networkStream;

	protected bool UsingSecureStream => _networkStream is TlsStream;

	internal IPAddress ServerAddress => ((IPEndPoint)Socket.RemoteEndPoint).Address;

	internal Socket Socket => _client.Client;

	internal NetworkStream NetworkStream
	{
		get
		{
			return _networkStream;
		}
		set
		{
			_networkStream = value;
		}
	}

	public override bool CanRead => _networkStream.CanRead;

	public override bool CanSeek => _networkStream.CanSeek;

	public override bool CanWrite => _networkStream.CanWrite;

	public override bool CanTimeout => _networkStream.CanTimeout;

	public override int ReadTimeout
	{
		get
		{
			return _networkStream.ReadTimeout;
		}
		set
		{
			_networkStream.ReadTimeout = value;
		}
	}

	public override int WriteTimeout
	{
		get
		{
			return _networkStream.WriteTimeout;
		}
		set
		{
			_networkStream.WriteTimeout = value;
		}
	}

	public override long Length => _networkStream.Length;

	public override long Position
	{
		get
		{
			return _networkStream.Position;
		}
		set
		{
			_networkStream.Position = value;
		}
	}

	internal NetworkStreamWrapper(TcpClient client)
	{
		_client = client;
		_networkStream = client.GetStream();
	}

	public override long Seek(long offset, SeekOrigin origin)
	{
		return _networkStream.Seek(offset, origin);
	}

	public override int Read(byte[] buffer, int offset, int size)
	{
		return _networkStream.Read(buffer, offset, size);
	}

	public override void Write(byte[] buffer, int offset, int size)
	{
		_networkStream.Write(buffer, offset, size);
	}

	protected override void Dispose(bool disposing)
	{
		try
		{
			if (disposing)
			{
				CloseSocket();
			}
		}
		finally
		{
			base.Dispose(disposing);
		}
	}

	internal void CloseSocket()
	{
		_networkStream.Close();
		_client.Dispose();
	}

	public void Close(int timeout)
	{
		_networkStream.Close(timeout);
		_client.Dispose();
	}

	public override IAsyncResult BeginRead(byte[] buffer, int offset, int size, AsyncCallback callback, object state)
	{
		return _networkStream.BeginRead(buffer, offset, size, callback, state);
	}

	public override int EndRead(IAsyncResult asyncResult)
	{
		return _networkStream.EndRead(asyncResult);
	}

	public override Task<int> ReadAsync(byte[] buffer, int offset, int count, CancellationToken cancellationToken)
	{
		return _networkStream.ReadAsync(buffer, offset, count, cancellationToken);
	}

	public override IAsyncResult BeginWrite(byte[] buffer, int offset, int size, AsyncCallback callback, object state)
	{
		return _networkStream.BeginWrite(buffer, offset, size, callback, state);
	}

	public override void EndWrite(IAsyncResult asyncResult)
	{
		_networkStream.EndWrite(asyncResult);
	}

	public override Task WriteAsync(byte[] buffer, int offset, int count, CancellationToken cancellationToken)
	{
		return _networkStream.WriteAsync(buffer, offset, count, cancellationToken);
	}

	public override void Flush()
	{
		_networkStream.Flush();
	}

	public override Task FlushAsync(CancellationToken cancellationToken)
	{
		return _networkStream.FlushAsync(cancellationToken);
	}

	public override void SetLength(long value)
	{
		_networkStream.SetLength(value);
	}

	internal void SetSocketTimeoutOption(int timeout)
	{
		_networkStream.ReadTimeout = timeout;
		_networkStream.WriteTimeout = timeout;
	}
}
