using System.IO;
using System.Threading;
using System.Threading.Tasks;

namespace System.Net.Sockets;

public class NetworkStream : Stream
{
	private readonly Socket _streamSocket;

	private readonly bool _ownsSocket;

	private bool _readable;

	private bool _writeable;

	private int _closeTimeout = -1;

	private volatile bool _cleanedUp;

	private int _currentReadTimeout = -1;

	private int _currentWriteTimeout = -1;

	public override bool CanRead => _readable;

	public override bool CanSeek => false;

	public override bool CanWrite => _writeable;

	public override bool CanTimeout => true;

	public override int ReadTimeout
	{
		get
		{
			int num = (int)_streamSocket.GetSocketOption(SocketOptionLevel.Socket, SocketOptionName.ReceiveTimeout);
			if (num == 0)
			{
				return -1;
			}
			return num;
		}
		set
		{
			if (value <= 0 && value != -1)
			{
				throw new ArgumentOutOfRangeException("value", "Timeout can be only be set to 'System.Threading.Timeout.Infinite' or a value > 0.");
			}
			SetSocketTimeoutOption(SocketShutdown.Receive, value, silent: false);
		}
	}

	public override int WriteTimeout
	{
		get
		{
			int num = (int)_streamSocket.GetSocketOption(SocketOptionLevel.Socket, SocketOptionName.SendTimeout);
			if (num == 0)
			{
				return -1;
			}
			return num;
		}
		set
		{
			if (value <= 0 && value != -1)
			{
				throw new ArgumentOutOfRangeException("value", "Timeout can be only be set to 'System.Threading.Timeout.Infinite' or a value > 0.");
			}
			SetSocketTimeoutOption(SocketShutdown.Send, value, silent: false);
		}
	}

	public override long Length
	{
		get
		{
			throw new NotSupportedException("This stream does not support seek operations.");
		}
	}

	public override long Position
	{
		get
		{
			throw new NotSupportedException("This stream does not support seek operations.");
		}
		set
		{
			throw new NotSupportedException("This stream does not support seek operations.");
		}
	}

	internal Socket InternalSocket
	{
		get
		{
			Socket streamSocket = _streamSocket;
			if (_cleanedUp || streamSocket == null)
			{
				throw new ObjectDisposedException(GetType().FullName);
			}
			return streamSocket;
		}
	}

	public NetworkStream(Socket socket)
		: this(socket, FileAccess.ReadWrite, ownsSocket: false)
	{
	}

	public NetworkStream(Socket socket, bool ownsSocket)
		: this(socket, FileAccess.ReadWrite, ownsSocket)
	{
	}

	public NetworkStream(Socket socket, FileAccess access, bool ownsSocket)
	{
		if (socket == null)
		{
			throw new ArgumentNullException("socket");
		}
		if (!socket.Blocking)
		{
			throw new IOException("The operation is not allowed on a non-blocking Socket.");
		}
		if (!socket.Connected)
		{
			throw new IOException("The operation is not allowed on non-connected sockets.");
		}
		if (socket.SocketType != SocketType.Stream)
		{
			throw new IOException("The operation is not allowed on non-stream oriented sockets.");
		}
		_streamSocket = socket;
		_ownsSocket = ownsSocket;
		switch (access)
		{
		case FileAccess.Read:
			_readable = true;
			break;
		case FileAccess.Write:
			_writeable = true;
			break;
		default:
			_readable = true;
			_writeable = true;
			break;
		}
	}

	public override long Seek(long offset, SeekOrigin origin)
	{
		throw new NotSupportedException("This stream does not support seek operations.");
	}

	public override int Read(byte[] buffer, int offset, int size)
	{
		bool canRead = CanRead;
		if (_cleanedUp)
		{
			throw new ObjectDisposedException(GetType().FullName);
		}
		if (!canRead)
		{
			throw new InvalidOperationException("The stream does not support reading.");
		}
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		if ((uint)offset > buffer.Length)
		{
			throw new ArgumentOutOfRangeException("offset");
		}
		if ((uint)size > buffer.Length - offset)
		{
			throw new ArgumentOutOfRangeException("size");
		}
		try
		{
			return _streamSocket.Receive(buffer, offset, size, SocketFlags.None);
		}
		catch (Exception ex) when (!(ex is OutOfMemoryException))
		{
			throw new IOException(global::SR.Format("Unable to read data from the transport connection: {0}.", ex.Message), ex);
		}
	}

	public override int Read(Span<byte> destination)
	{
		if (GetType() != typeof(NetworkStream))
		{
			return base.Read(destination);
		}
		if (_cleanedUp)
		{
			throw new ObjectDisposedException(GetType().FullName);
		}
		if (!CanRead)
		{
			throw new InvalidOperationException("The stream does not support reading.");
		}
		int result = _streamSocket.Receive(destination, SocketFlags.None, out var errorCode);
		if (errorCode != SocketError.Success)
		{
			SocketException ex = new SocketException((int)errorCode);
			throw new IOException(global::SR.Format("Unable to read data from the transport connection: {0}.", ex.Message), ex);
		}
		return result;
	}

	public unsafe override int ReadByte()
	{
		byte result = default(byte);
		if (Read(new Span<byte>(&result, 1)) != 0)
		{
			return result;
		}
		return -1;
	}

	public override void Write(byte[] buffer, int offset, int size)
	{
		bool canWrite = CanWrite;
		if (_cleanedUp)
		{
			throw new ObjectDisposedException(GetType().FullName);
		}
		if (!canWrite)
		{
			throw new InvalidOperationException("The stream does not support writing.");
		}
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		if ((uint)offset > buffer.Length)
		{
			throw new ArgumentOutOfRangeException("offset");
		}
		if ((uint)size > buffer.Length - offset)
		{
			throw new ArgumentOutOfRangeException("size");
		}
		try
		{
			_streamSocket.Send(buffer, offset, size, SocketFlags.None);
		}
		catch (Exception ex) when (!(ex is OutOfMemoryException))
		{
			throw new IOException(global::SR.Format("Unable to write data to the transport connection: {0}.", ex.Message), ex);
		}
	}

	public override void Write(ReadOnlySpan<byte> source)
	{
		if (GetType() != typeof(NetworkStream))
		{
			base.Write(source);
			return;
		}
		if (_cleanedUp)
		{
			throw new ObjectDisposedException(GetType().FullName);
		}
		if (!CanWrite)
		{
			throw new InvalidOperationException("The stream does not support writing.");
		}
		_streamSocket.Send(source, SocketFlags.None, out var errorCode);
		if (errorCode == SocketError.Success)
		{
			return;
		}
		SocketException ex = new SocketException((int)errorCode);
		throw new IOException(global::SR.Format("Unable to write data to the transport connection: {0}.", ex.Message), ex);
	}

	public unsafe override void WriteByte(byte value)
	{
		Write(new ReadOnlySpan<byte>(&value, 1));
	}

	public void Close(int timeout)
	{
		if (timeout < -1)
		{
			throw new ArgumentOutOfRangeException("timeout");
		}
		_closeTimeout = timeout;
		Dispose();
	}

	protected override void Dispose(bool disposing)
	{
		bool cleanedUp = _cleanedUp;
		_cleanedUp = true;
		if (!cleanedUp & disposing)
		{
			_readable = false;
			_writeable = false;
			if (_ownsSocket)
			{
				_streamSocket.InternalShutdown(SocketShutdown.Both);
				_streamSocket.Close(_closeTimeout);
			}
		}
		base.Dispose(disposing);
	}

	~NetworkStream()
	{
		Dispose(disposing: false);
	}

	public override IAsyncResult BeginRead(byte[] buffer, int offset, int size, AsyncCallback callback, object state)
	{
		bool canRead = CanRead;
		if (_cleanedUp)
		{
			throw new ObjectDisposedException(GetType().FullName);
		}
		if (!canRead)
		{
			throw new InvalidOperationException("The stream does not support reading.");
		}
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		if ((uint)offset > buffer.Length)
		{
			throw new ArgumentOutOfRangeException("offset");
		}
		if ((uint)size > buffer.Length - offset)
		{
			throw new ArgumentOutOfRangeException("size");
		}
		try
		{
			return _streamSocket.BeginReceive(buffer, offset, size, SocketFlags.None, callback, state);
		}
		catch (Exception ex) when (!(ex is OutOfMemoryException))
		{
			throw new IOException(global::SR.Format("Unable to read data from the transport connection: {0}.", ex.Message), ex);
		}
	}

	public override int EndRead(IAsyncResult asyncResult)
	{
		if (_cleanedUp)
		{
			throw new ObjectDisposedException(GetType().FullName);
		}
		if (asyncResult == null)
		{
			throw new ArgumentNullException("asyncResult");
		}
		try
		{
			return _streamSocket.EndReceive(asyncResult);
		}
		catch (Exception ex) when (!(ex is OutOfMemoryException))
		{
			throw new IOException(global::SR.Format("Unable to read data from the transport connection: {0}.", ex.Message), ex);
		}
	}

	public override IAsyncResult BeginWrite(byte[] buffer, int offset, int size, AsyncCallback callback, object state)
	{
		bool canWrite = CanWrite;
		if (_cleanedUp)
		{
			throw new ObjectDisposedException(GetType().FullName);
		}
		if (!canWrite)
		{
			throw new InvalidOperationException("The stream does not support writing.");
		}
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		if ((uint)offset > buffer.Length)
		{
			throw new ArgumentOutOfRangeException("offset");
		}
		if ((uint)size > buffer.Length - offset)
		{
			throw new ArgumentOutOfRangeException("size");
		}
		try
		{
			return _streamSocket.BeginSend(buffer, offset, size, SocketFlags.None, callback, state);
		}
		catch (Exception ex) when (!(ex is OutOfMemoryException))
		{
			throw new IOException(global::SR.Format("Unable to write data to the transport connection: {0}.", ex.Message), ex);
		}
	}

	public override void EndWrite(IAsyncResult asyncResult)
	{
		if (_cleanedUp)
		{
			throw new ObjectDisposedException(GetType().FullName);
		}
		if (asyncResult == null)
		{
			throw new ArgumentNullException("asyncResult");
		}
		try
		{
			_streamSocket.EndSend(asyncResult);
		}
		catch (Exception ex) when (!(ex is OutOfMemoryException))
		{
			throw new IOException(global::SR.Format("Unable to write data to the transport connection: {0}.", ex.Message), ex);
		}
	}

	public override Task<int> ReadAsync(byte[] buffer, int offset, int size, CancellationToken cancellationToken)
	{
		bool canRead = CanRead;
		if (_cleanedUp)
		{
			throw new ObjectDisposedException(GetType().FullName);
		}
		if (!canRead)
		{
			throw new InvalidOperationException("The stream does not support reading.");
		}
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		if ((uint)offset > buffer.Length)
		{
			throw new ArgumentOutOfRangeException("offset");
		}
		if ((uint)size > buffer.Length - offset)
		{
			throw new ArgumentOutOfRangeException("size");
		}
		try
		{
			return _streamSocket.ReceiveAsync(new Memory<byte>(buffer, offset, size), SocketFlags.None, fromNetworkStream: true, cancellationToken).AsTask();
		}
		catch (Exception ex) when (!(ex is OutOfMemoryException))
		{
			throw new IOException(global::SR.Format("Unable to read data from the transport connection: {0}.", ex.Message), ex);
		}
	}

	public override ValueTask<int> ReadAsync(Memory<byte> buffer, CancellationToken cancellationToken)
	{
		bool canRead = CanRead;
		if (_cleanedUp)
		{
			throw new ObjectDisposedException(GetType().FullName);
		}
		if (!canRead)
		{
			throw new InvalidOperationException("The stream does not support reading.");
		}
		try
		{
			return _streamSocket.ReceiveAsync(buffer, SocketFlags.None, fromNetworkStream: true, cancellationToken);
		}
		catch (Exception ex) when (!(ex is OutOfMemoryException))
		{
			throw new IOException(global::SR.Format("Unable to read data from the transport connection: {0}.", ex.Message), ex);
		}
	}

	public override Task WriteAsync(byte[] buffer, int offset, int size, CancellationToken cancellationToken)
	{
		bool canWrite = CanWrite;
		if (_cleanedUp)
		{
			throw new ObjectDisposedException(GetType().FullName);
		}
		if (!canWrite)
		{
			throw new InvalidOperationException("The stream does not support writing.");
		}
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		if ((uint)offset > buffer.Length)
		{
			throw new ArgumentOutOfRangeException("offset");
		}
		if ((uint)size > buffer.Length - offset)
		{
			throw new ArgumentOutOfRangeException("size");
		}
		try
		{
			return _streamSocket.SendAsyncForNetworkStream(new ReadOnlyMemory<byte>(buffer, offset, size), SocketFlags.None, cancellationToken).AsTask();
		}
		catch (Exception ex) when (!(ex is OutOfMemoryException))
		{
			throw new IOException(global::SR.Format("Unable to write data to the transport connection: {0}.", ex.Message), ex);
		}
	}

	public override ValueTask WriteAsync(ReadOnlyMemory<byte> buffer, CancellationToken cancellationToken)
	{
		bool canWrite = CanWrite;
		if (_cleanedUp)
		{
			throw new ObjectDisposedException(GetType().FullName);
		}
		if (!canWrite)
		{
			throw new InvalidOperationException("The stream does not support writing.");
		}
		try
		{
			return _streamSocket.SendAsyncForNetworkStream(buffer, SocketFlags.None, cancellationToken);
		}
		catch (Exception ex) when (!(ex is OutOfMemoryException))
		{
			throw new IOException(global::SR.Format("Unable to write data to the transport connection: {0}.", ex.Message), ex);
		}
	}

	public override void Flush()
	{
	}

	public override Task FlushAsync(CancellationToken cancellationToken)
	{
		return Task.CompletedTask;
	}

	public override void SetLength(long value)
	{
		throw new NotSupportedException("This stream does not support seek operations.");
	}

	internal void SetSocketTimeoutOption(SocketShutdown mode, int timeout, bool silent)
	{
		if (NetEventSource.IsEnabled)
		{
			NetEventSource.Enter(this, mode, timeout, silent, "SetSocketTimeoutOption");
		}
		if (timeout < 0)
		{
			timeout = 0;
		}
		if ((mode == SocketShutdown.Send || mode == SocketShutdown.Both) && timeout != _currentWriteTimeout)
		{
			_streamSocket.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.SendTimeout, timeout, silent);
			_currentWriteTimeout = timeout;
		}
		if ((mode == SocketShutdown.Receive || mode == SocketShutdown.Both) && timeout != _currentReadTimeout)
		{
			_streamSocket.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.ReceiveTimeout, timeout, silent);
			_currentReadTimeout = timeout;
		}
	}
}
