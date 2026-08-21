using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Threading;

namespace System.Net.Sockets;

public class SocketAsyncEventArgs : EventArgs, IDisposable
{
	private bool disposed;

	internal volatile int in_progress;

	private EndPoint remote_ep;

	private Socket current_socket;

	internal SocketAsyncResult socket_async_result = new SocketAsyncResult();

	[CompilerGenerated]
	private Exception _003CConnectByNameError_003Ek__BackingField;

	[CompilerGenerated]
	private int _003CSendPacketsSendSize_003Ek__BackingField;

	private Memory<byte> _buffer;

	private int _offset;

	private int _count;

	private bool _bufferIsExplicitArray;

	private IList<ArraySegment<byte>> _bufferList;

	private List<ArraySegment<byte>> _bufferListInternal;

	private Exception ConnectByNameError
	{
		[CompilerGenerated]
		set
		{
			_003CConnectByNameError_003Ek__BackingField = value;
		}
	}

	public Socket AcceptSocket { get; set; }

	public int BytesTransferred { get; private set; }

	public SocketAsyncOperation LastOperation { get; private set; }

	public EndPoint RemoteEndPoint
	{
		get
		{
			return remote_ep;
		}
		set
		{
			remote_ep = value;
		}
	}

	[MonoTODO("unused property")]
	public int SendPacketsSendSize
	{
		[CompilerGenerated]
		set
		{
			_003CSendPacketsSendSize_003Ek__BackingField = value;
		}
	}

	public SocketError SocketError { get; set; }

	public SocketFlags SocketFlags { get; set; }

	public object UserToken { get; set; }

	public Socket ConnectSocket
	{
		get
		{
			if (SocketError == SocketError.AccessDenied)
			{
				return null;
			}
			return current_socket;
		}
	}

	internal Socket CurrentSocket => current_socket;

	public byte[] Buffer
	{
		get
		{
			if (_bufferIsExplicitArray)
			{
				MemoryMarshal.TryGetArray((ReadOnlyMemory<byte>)_buffer, out ArraySegment<byte> segment);
				return segment.Array;
			}
			return null;
		}
	}

	public Memory<byte> MemoryBuffer => _buffer;

	public int Offset => _offset;

	public int Count => _count;

	public IList<ArraySegment<byte>> BufferList
	{
		get
		{
			return _bufferList;
		}
		set
		{
			if (value != null)
			{
				if (!_buffer.Equals(default(Memory<byte>)))
				{
					throw new ArgumentException(global::SR.Format("Buffer and BufferList properties cannot both be non-null.", "Buffer"));
				}
				int count = value.Count;
				if (_bufferListInternal == null)
				{
					_bufferListInternal = new List<ArraySegment<byte>>(count);
				}
				else
				{
					_bufferListInternal.Clear();
				}
				for (int i = 0; i < count; i++)
				{
					ArraySegment<byte> arraySegment = value[i];
					RangeValidationHelpers.ValidateSegment(arraySegment);
					_bufferListInternal.Add(arraySegment);
				}
			}
			else
			{
				_bufferListInternal?.Clear();
			}
			_bufferList = value;
		}
	}

	public event EventHandler<SocketAsyncEventArgs> Completed;

	public SocketAsyncEventArgs()
	{
		SendPacketsSendSize = -1;
	}

	internal SocketAsyncEventArgs(bool flowExecutionContext)
	{
	}

	~SocketAsyncEventArgs()
	{
		Dispose(disposing: false);
	}

	private void Dispose(bool disposing)
	{
		disposed = true;
		if (disposing)
		{
			_ = in_progress;
		}
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	internal void SetConnectByNameError(Exception error)
	{
		ConnectByNameError = error;
	}

	internal void SetBytesTransferred(int value)
	{
		BytesTransferred = value;
	}

	internal void SetCurrentSocket(Socket socket)
	{
		current_socket = socket;
	}

	internal void SetLastOperation(SocketAsyncOperation op)
	{
		if (disposed)
		{
			throw new ObjectDisposedException("System.Net.Sockets.SocketAsyncEventArgs");
		}
		if (Interlocked.Exchange(ref in_progress, 1) != 0)
		{
			throw new InvalidOperationException("Operation already in progress");
		}
		LastOperation = op;
	}

	internal void Complete_internal()
	{
		in_progress = 0;
		OnCompleted(this);
	}

	protected virtual void OnCompleted(SocketAsyncEventArgs e)
	{
		e?.Completed?.Invoke(e.current_socket, e);
	}

	internal void StartOperationCommon(Socket socket)
	{
		current_socket = socket;
	}

	internal void StartOperationWrapperConnect(MultipleConnectAsync args)
	{
		SetLastOperation(SocketAsyncOperation.Connect);
	}

	internal void FinishConnectByNameSyncFailure(Exception exception, int bytesTransferred, SocketFlags flags)
	{
		SetResults(exception, bytesTransferred, flags);
		if (current_socket != null)
		{
			current_socket.is_connected = false;
		}
		Complete_internal();
	}

	internal void FinishOperationAsyncFailure(Exception exception, int bytesTransferred, SocketFlags flags)
	{
		SetResults(exception, bytesTransferred, flags);
		if (current_socket != null)
		{
			current_socket.is_connected = false;
		}
		Complete_internal();
	}

	internal void FinishWrapperConnectSuccess(Socket connectSocket, int bytesTransferred, SocketFlags flags)
	{
		SetResults(SocketError.Success, bytesTransferred, flags);
		current_socket = connectSocket;
		Complete_internal();
	}

	internal void SetResults(SocketError socketError, int bytesTransferred, SocketFlags flags)
	{
		SocketError = socketError;
		ConnectByNameError = null;
		BytesTransferred = bytesTransferred;
		SocketFlags = flags;
	}

	internal void SetResults(Exception exception, int bytesTransferred, SocketFlags flags)
	{
		ConnectByNameError = exception;
		BytesTransferred = bytesTransferred;
		SocketFlags = flags;
		if (exception == null)
		{
			SocketError = SocketError.Success;
		}
		else if (exception is SocketException ex)
		{
			SocketError = ex.SocketErrorCode;
		}
		else
		{
			SocketError = SocketError.SocketError;
		}
	}

	internal void CopyBufferFrom(SocketAsyncEventArgs source)
	{
		_buffer = source._buffer;
		_offset = source._offset;
		_count = source._count;
		_bufferIsExplicitArray = source._bufferIsExplicitArray;
	}

	public void SetBuffer(byte[] buffer, int offset, int count)
	{
		if (buffer == null)
		{
			_buffer = default(Memory<byte>);
			_offset = 0;
			_count = 0;
			_bufferIsExplicitArray = false;
			return;
		}
		if (_bufferList != null)
		{
			throw new ArgumentException(global::SR.Format("Buffer and BufferList properties cannot both be non-null.", "BufferList"));
		}
		if ((uint)offset > buffer.Length)
		{
			throw new ArgumentOutOfRangeException("offset");
		}
		if ((uint)count > buffer.Length - offset)
		{
			throw new ArgumentOutOfRangeException("count");
		}
		_buffer = buffer;
		_offset = offset;
		_count = count;
		_bufferIsExplicitArray = true;
	}

	public void SetBuffer(Memory<byte> buffer)
	{
		if (buffer.Length != 0 && _bufferList != null)
		{
			throw new ArgumentException(global::SR.Format("Buffer and BufferList properties cannot both be non-null.", "BufferList"));
		}
		_buffer = buffer;
		_offset = 0;
		_count = buffer.Length;
		_bufferIsExplicitArray = false;
	}
}
