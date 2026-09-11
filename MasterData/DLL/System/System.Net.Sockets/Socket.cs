using System.Buffers;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Net.Configuration;
using System.Net.NetworkInformation;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Threading;
using System.Threading.Tasks;
using System.Threading.Tasks.Sources;
using Mono;

namespace System.Net.Sockets;

public class Socket : IDisposable
{
	private sealed class CachedEventArgs
	{
		public TaskSocketAsyncEventArgs<Socket> TaskAccept;

		public Int32TaskSocketAsyncEventArgs TaskReceive;

		public Int32TaskSocketAsyncEventArgs TaskSend;

		public AwaitableSocketAsyncEventArgs ValueTaskReceive;

		public AwaitableSocketAsyncEventArgs ValueTaskSend;
	}

	private class TaskSocketAsyncEventArgs<TResult> : SocketAsyncEventArgs
	{
		internal AsyncTaskMethodBuilder<TResult> _builder;

		internal bool _accessed;

		internal TaskSocketAsyncEventArgs()
			: base(flowExecutionContext: false)
		{
		}

		internal AsyncTaskMethodBuilder<TResult> GetCompletionResponsibility(out bool responsibleForReturningToPool)
		{
			lock (this)
			{
				responsibleForReturningToPool = _accessed;
				_accessed = true;
				_ = _builder.Task;
				return _builder;
			}
		}
	}

	private sealed class Int32TaskSocketAsyncEventArgs : TaskSocketAsyncEventArgs<int>
	{
		internal bool _wrapExceptionsInIOExceptions;
	}

	internal sealed class AwaitableSocketAsyncEventArgs : SocketAsyncEventArgs, IValueTaskSource, IValueTaskSource<int>
	{
		internal static readonly AwaitableSocketAsyncEventArgs Reserved = new AwaitableSocketAsyncEventArgs
		{
			_continuation = null
		};

		private static readonly Action<object> s_completedSentinel = delegate
		{
			throw new Exception("s_completedSentinel");
		};

		private static readonly Action<object> s_availableSentinel = delegate
		{
			throw new Exception("s_availableSentinel");
		};

		private Action<object> _continuation = s_availableSentinel;

		private ExecutionContext _executionContext;

		private object _scheduler;

		private short _token;

		public bool WrapExceptionsInIOExceptions { get; set; }

		public AwaitableSocketAsyncEventArgs()
			: base(flowExecutionContext: false)
		{
		}

		public bool Reserve()
		{
			return (object)Interlocked.CompareExchange(ref _continuation, null, s_availableSentinel) == s_availableSentinel;
		}

		private void Release()
		{
			_token++;
			Volatile.Write(ref _continuation, s_availableSentinel);
		}

		protected override void OnCompleted(SocketAsyncEventArgs _)
		{
			Action<object> action = _continuation;
			if (action == null && (action = Interlocked.CompareExchange(ref _continuation, s_completedSentinel, null)) == null)
			{
				return;
			}
			object userToken = base.UserToken;
			base.UserToken = null;
			_continuation = s_completedSentinel;
			ExecutionContext executionContext = _executionContext;
			if (executionContext == null)
			{
				InvokeContinuation(action, userToken, forceAsync: false);
				return;
			}
			_executionContext = null;
			ExecutionContext.Run(executionContext, delegate(object runState)
			{
				Tuple<AwaitableSocketAsyncEventArgs, Action<object>, object> tuple = (Tuple<AwaitableSocketAsyncEventArgs, Action<object>, object>)runState;
				tuple.Item1.InvokeContinuation(tuple.Item2, tuple.Item3, forceAsync: false);
			}, Tuple.Create(this, action, userToken));
		}

		public ValueTask<int> ReceiveAsync(Socket socket)
		{
			if (socket.ReceiveAsync(this))
			{
				return new ValueTask<int>(this, _token);
			}
			int bytesTransferred = base.BytesTransferred;
			SocketError socketError = base.SocketError;
			Release();
			if (socketError != SocketError.Success)
			{
				return new ValueTask<int>(Task.FromException<int>(CreateException(socketError)));
			}
			return new ValueTask<int>(bytesTransferred);
		}

		public ValueTask SendAsyncForNetworkStream(Socket socket)
		{
			if (socket.SendAsync(this))
			{
				return new ValueTask(this, _token);
			}
			SocketError socketError = base.SocketError;
			Release();
			if (socketError != SocketError.Success)
			{
				return new ValueTask(Task.FromException(CreateException(socketError)));
			}
			return default(ValueTask);
		}

		public ValueTaskSourceStatus GetStatus(short token)
		{
			if (token != _token)
			{
				ThrowIncorrectTokenException();
			}
			if ((object)_continuation == s_completedSentinel)
			{
				if (base.SocketError != SocketError.Success)
				{
					return ValueTaskSourceStatus.Faulted;
				}
				return ValueTaskSourceStatus.Succeeded;
			}
			return ValueTaskSourceStatus.Pending;
		}

		public void OnCompleted(Action<object> continuation, object state, short token, ValueTaskSourceOnCompletedFlags flags)
		{
			if (token != _token)
			{
				ThrowIncorrectTokenException();
			}
			if ((flags & ValueTaskSourceOnCompletedFlags.FlowExecutionContext) != ValueTaskSourceOnCompletedFlags.None)
			{
				_executionContext = ExecutionContext.Capture();
			}
			if ((flags & ValueTaskSourceOnCompletedFlags.UseSchedulingContext) != ValueTaskSourceOnCompletedFlags.None)
			{
				SynchronizationContext current = SynchronizationContext.Current;
				if (current != null && current.GetType() != typeof(SynchronizationContext))
				{
					_scheduler = current;
				}
				else
				{
					TaskScheduler current2 = TaskScheduler.Current;
					if (current2 != TaskScheduler.Default)
					{
						_scheduler = current2;
					}
				}
			}
			base.UserToken = state;
			Action<object> action = Interlocked.CompareExchange(ref _continuation, continuation, null);
			if ((object)action == s_completedSentinel)
			{
				_executionContext = null;
				base.UserToken = null;
				InvokeContinuation(continuation, state, forceAsync: true);
			}
			else if (action != null)
			{
				ThrowMultipleContinuationsException();
			}
		}

		private void InvokeContinuation(Action<object> continuation, object state, bool forceAsync)
		{
			object scheduler = _scheduler;
			_scheduler = null;
			if (scheduler != null)
			{
				if (scheduler is SynchronizationContext synchronizationContext)
				{
					synchronizationContext.Post(delegate(object s)
					{
						Tuple<Action<object>, object> tuple = (Tuple<Action<object>, object>)s;
						tuple.Item1(tuple.Item2);
					}, Tuple.Create(continuation, state));
				}
				else
				{
					Task.Factory.StartNew(continuation, state, CancellationToken.None, TaskCreationOptions.DenyChildAttach, (TaskScheduler)scheduler);
				}
			}
			else if (forceAsync)
			{
				ThreadPool.QueueUserWorkItem(continuation, state, preferLocal: true);
			}
			else
			{
				continuation(state);
			}
		}

		public int GetResult(short token)
		{
			if (token != _token)
			{
				ThrowIncorrectTokenException();
			}
			SocketError socketError = base.SocketError;
			int bytesTransferred = base.BytesTransferred;
			Release();
			if (socketError != SocketError.Success)
			{
				ThrowException(socketError);
			}
			return bytesTransferred;
		}

		void IValueTaskSource.GetResult(short token)
		{
			if (token != _token)
			{
				ThrowIncorrectTokenException();
			}
			SocketError socketError = base.SocketError;
			Release();
			if (socketError != SocketError.Success)
			{
				ThrowException(socketError);
			}
		}

		private void ThrowIncorrectTokenException()
		{
			throw new InvalidOperationException("The result of the operation was already consumed and may not be used again.");
		}

		private void ThrowMultipleContinuationsException()
		{
			throw new InvalidOperationException("Another continuation was already registered.");
		}

		private void ThrowException(SocketError error)
		{
			throw CreateException(error);
		}

		private Exception CreateException(SocketError error)
		{
			SocketException ex = new SocketException((int)error);
			if (!WrapExceptionsInIOExceptions)
			{
				return ex;
			}
			return new IOException(global::SR.Format("Unable to read data from the transport connection: {0}.", ex.Message), ex);
		}
	}

	private struct WSABUF
	{
		public int len;

		public IntPtr buf;
	}

	private static readonly EventHandler<SocketAsyncEventArgs> AcceptCompletedHandler = delegate(object s, SocketAsyncEventArgs e)
	{
		CompleteAccept((Socket)s, (TaskSocketAsyncEventArgs<Socket>)e);
	};

	private static readonly EventHandler<SocketAsyncEventArgs> ReceiveCompletedHandler = delegate(object s, SocketAsyncEventArgs e)
	{
		CompleteSendReceive((Socket)s, (Int32TaskSocketAsyncEventArgs)e, isReceive: true);
	};

	private static readonly EventHandler<SocketAsyncEventArgs> SendCompletedHandler = delegate(object s, SocketAsyncEventArgs e)
	{
		CompleteSendReceive((Socket)s, (Int32TaskSocketAsyncEventArgs)e, isReceive: false);
	};

	private static readonly TaskSocketAsyncEventArgs<Socket> s_rentedSocketSentinel = new TaskSocketAsyncEventArgs<Socket>();

	private static readonly Int32TaskSocketAsyncEventArgs s_rentedInt32Sentinel = new Int32TaskSocketAsyncEventArgs();

	private static readonly Task<int> s_zeroTask = Task.FromResult(0);

	private CachedEventArgs _cachedTaskEventArgs;

	private static object s_InternalSyncObject;

	internal static volatile bool s_SupportsIPv4;

	internal static volatile bool s_SupportsIPv6;

	internal static volatile bool s_OSSupportsIPv6;

	internal static volatile bool s_Initialized;

	private static volatile bool s_LoggingEnabled;

	internal static volatile bool s_PerfCountersEnabled;

	internal const int DefaultCloseTimeout = -1;

	private const int SOCKET_CLOSED_CODE = 10004;

	private const string TIMEOUT_EXCEPTION_MSG = "A connection attempt failed because the connected party did not properly respondafter a period of time, or established connection failed because connected host has failed to respond";

	private bool is_closed;

	private bool is_listening;

	private bool useOverlappedIO;

	private int linger_timeout;

	private AddressFamily addressFamily;

	private SocketType socketType;

	private ProtocolType protocolType;

	internal SafeSocketHandle m_Handle;

	internal EndPoint seed_endpoint;

	internal SemaphoreSlim ReadSem = new SemaphoreSlim(1, 1);

	internal SemaphoreSlim WriteSem = new SemaphoreSlim(1, 1);

	internal bool is_blocking = true;

	internal bool is_bound;

	internal bool is_connected;

	private int m_IntCleanedUp;

	internal bool connect_in_progress;

	internal readonly int ID;

	private static AsyncCallback AcceptAsyncCallback = delegate(IAsyncResult ares)
	{
		SocketAsyncEventArgs e = (SocketAsyncEventArgs)((SocketAsyncResult)ares).AsyncState;
		if (Interlocked.Exchange(ref e.in_progress, 0) != 1)
		{
			throw new InvalidOperationException("No operation in progress");
		}
		try
		{
			e.AcceptSocket = e.CurrentSocket.EndAccept(ares);
		}
		catch (SocketException ex)
		{
			e.SocketError = ex.SocketErrorCode;
		}
		catch (ObjectDisposedException)
		{
			e.SocketError = SocketError.OperationAborted;
		}
		finally
		{
			if (e.AcceptSocket == null)
			{
				e.AcceptSocket = new Socket(e.CurrentSocket.AddressFamily, e.CurrentSocket.SocketType, e.CurrentSocket.ProtocolType, null);
			}
			e.Complete_internal();
		}
	};

	private static IOAsyncCallback BeginAcceptCallback = delegate(IOAsyncResult ares)
	{
		SocketAsyncResult socketAsyncResult = (SocketAsyncResult)ares;
		Socket socket = null;
		try
		{
			if (socketAsyncResult.AcceptSocket == null)
			{
				socket = socketAsyncResult.socket.Accept();
			}
			else
			{
				socket = socketAsyncResult.AcceptSocket;
				socketAsyncResult.socket.Accept(socket);
			}
		}
		catch (Exception e)
		{
			socketAsyncResult.Complete(e);
			return;
		}
		socketAsyncResult.Complete(socket);
	};

	private static IOAsyncCallback BeginAcceptReceiveCallback = delegate(IOAsyncResult ares)
	{
		SocketAsyncResult socketAsyncResult = (SocketAsyncResult)ares;
		Socket socket = null;
		try
		{
			if (socketAsyncResult.AcceptSocket == null)
			{
				socket = socketAsyncResult.socket.Accept();
			}
			else
			{
				socket = socketAsyncResult.AcceptSocket;
				socketAsyncResult.socket.Accept(socket);
			}
		}
		catch (Exception e)
		{
			socketAsyncResult.Complete(e);
			return;
		}
		int total = 0;
		if (socketAsyncResult.Size > 0)
		{
			try
			{
				total = socket.Receive(socketAsyncResult.Buffer, socketAsyncResult.Offset, socketAsyncResult.Size, socketAsyncResult.SockFlags, out var errorCode);
				if (errorCode != SocketError.Success)
				{
					socketAsyncResult.Complete(new SocketException((int)errorCode));
					return;
				}
			}
			catch (Exception e2)
			{
				socketAsyncResult.Complete(e2);
				return;
			}
		}
		socketAsyncResult.Complete(socket, total);
	};

	private static AsyncCallback ConnectAsyncCallback = delegate(IAsyncResult ares)
	{
		SocketAsyncEventArgs e = (SocketAsyncEventArgs)((SocketAsyncResult)ares).AsyncState;
		if (Interlocked.Exchange(ref e.in_progress, 0) != 1)
		{
			throw new InvalidOperationException("No operation in progress");
		}
		try
		{
			e.CurrentSocket.EndConnect(ares);
		}
		catch (SocketException ex)
		{
			e.SocketError = ex.SocketErrorCode;
		}
		catch (ObjectDisposedException)
		{
			e.SocketError = SocketError.OperationAborted;
		}
		finally
		{
			e.Complete_internal();
		}
	};

	private static IOAsyncCallback BeginConnectCallback = delegate(IOAsyncResult ares)
	{
		SocketAsyncResult socketAsyncResult = (SocketAsyncResult)ares;
		if (socketAsyncResult.EndPoint == null)
		{
			socketAsyncResult.Complete(new SocketException(10049));
			return;
		}
		try
		{
			int num = (int)socketAsyncResult.socket.GetSocketOption(SocketOptionLevel.Socket, SocketOptionName.Error);
			if (num == 0)
			{
				socketAsyncResult.socket.seed_endpoint = socketAsyncResult.EndPoint;
				socketAsyncResult.socket.is_connected = true;
				socketAsyncResult.socket.is_bound = true;
				socketAsyncResult.socket.connect_in_progress = false;
				socketAsyncResult.error = 0;
				socketAsyncResult.Complete();
			}
			else if (socketAsyncResult.Addresses == null)
			{
				socketAsyncResult.socket.connect_in_progress = false;
				socketAsyncResult.Complete(new SocketException(num));
			}
			else if (socketAsyncResult.CurrentAddress >= socketAsyncResult.Addresses.Length)
			{
				socketAsyncResult.Complete(new SocketException(num));
			}
			else
			{
				BeginMConnect(socketAsyncResult);
			}
		}
		catch (Exception e)
		{
			socketAsyncResult.socket.connect_in_progress = false;
			socketAsyncResult.Complete(e);
		}
	};

	private static AsyncCallback DisconnectAsyncCallback = delegate(IAsyncResult ares)
	{
		SocketAsyncEventArgs e = (SocketAsyncEventArgs)((SocketAsyncResult)ares).AsyncState;
		if (Interlocked.Exchange(ref e.in_progress, 0) != 1)
		{
			throw new InvalidOperationException("No operation in progress");
		}
		try
		{
			e.CurrentSocket.EndDisconnect(ares);
		}
		catch (SocketException ex)
		{
			e.SocketError = ex.SocketErrorCode;
		}
		catch (ObjectDisposedException)
		{
			e.SocketError = SocketError.OperationAborted;
		}
		finally
		{
			e.Complete_internal();
		}
	};

	private static IOAsyncCallback BeginDisconnectCallback = delegate(IOAsyncResult ares)
	{
		SocketAsyncResult socketAsyncResult = (SocketAsyncResult)ares;
		try
		{
			socketAsyncResult.socket.Disconnect(socketAsyncResult.ReuseSocket);
		}
		catch (Exception e)
		{
			socketAsyncResult.Complete(e);
			return;
		}
		socketAsyncResult.Complete();
	};

	private static AsyncCallback ReceiveAsyncCallback = delegate(IAsyncResult ares)
	{
		SocketAsyncEventArgs e = (SocketAsyncEventArgs)((SocketAsyncResult)ares).AsyncState;
		if (Interlocked.Exchange(ref e.in_progress, 0) != 1)
		{
			throw new InvalidOperationException("No operation in progress");
		}
		try
		{
			e.SetBytesTransferred(e.CurrentSocket.EndReceive(ares));
		}
		catch (SocketException ex)
		{
			e.SocketError = ex.SocketErrorCode;
		}
		catch (ObjectDisposedException)
		{
			e.SocketError = SocketError.OperationAborted;
		}
		finally
		{
			e.Complete_internal();
		}
	};

	private unsafe static IOAsyncCallback BeginReceiveCallback = delegate(IOAsyncResult ares)
	{
		SocketAsyncResult socketAsyncResult = (SocketAsyncResult)ares;
		int total = 0;
		try
		{
			using MemoryHandle memoryHandle = socketAsyncResult.Buffer.Slice(socketAsyncResult.Offset, socketAsyncResult.Size).Pin();
			total = Receive_internal(socketAsyncResult.socket.m_Handle, (byte*)memoryHandle.Pointer, socketAsyncResult.Size, socketAsyncResult.SockFlags, out socketAsyncResult.error, socketAsyncResult.socket.is_blocking);
		}
		catch (Exception e)
		{
			socketAsyncResult.Complete(e);
			return;
		}
		socketAsyncResult.Complete(total);
	};

	private static IOAsyncCallback BeginReceiveGenericCallback = delegate(IOAsyncResult ares)
	{
		SocketAsyncResult socketAsyncResult = (SocketAsyncResult)ares;
		int num = 0;
		try
		{
			num = socketAsyncResult.socket.Receive(socketAsyncResult.Buffers, socketAsyncResult.SockFlags);
		}
		catch (Exception e)
		{
			socketAsyncResult.Complete(e);
			return;
		}
		socketAsyncResult.Complete(num);
	};

	private static AsyncCallback ReceiveFromAsyncCallback = delegate(IAsyncResult ares)
	{
		SocketAsyncEventArgs e = (SocketAsyncEventArgs)((SocketAsyncResult)ares).AsyncState;
		if (Interlocked.Exchange(ref e.in_progress, 0) != 1)
		{
			throw new InvalidOperationException("No operation in progress");
		}
		try
		{
			e.SetBytesTransferred(e.CurrentSocket.EndReceiveFrom_internal((SocketAsyncResult)ares, e));
		}
		catch (SocketException ex)
		{
			e.SocketError = ex.SocketErrorCode;
		}
		catch (ObjectDisposedException)
		{
			e.SocketError = SocketError.OperationAborted;
		}
		finally
		{
			e.Complete_internal();
		}
	};

	private static IOAsyncCallback BeginReceiveFromCallback = delegate(IOAsyncResult ares)
	{
		SocketAsyncResult socketAsyncResult = (SocketAsyncResult)ares;
		int num = 0;
		try
		{
			num = socketAsyncResult.socket.ReceiveFrom(socketAsyncResult.Buffer, socketAsyncResult.Offset, socketAsyncResult.Size, socketAsyncResult.SockFlags, ref socketAsyncResult.EndPoint, out var errorCode);
			if (errorCode != SocketError.Success)
			{
				socketAsyncResult.Complete(new SocketException(errorCode));
				return;
			}
		}
		catch (Exception e)
		{
			socketAsyncResult.Complete(e);
			return;
		}
		socketAsyncResult.Complete(num);
	};

	private static AsyncCallback SendAsyncCallback = delegate(IAsyncResult ares)
	{
		SocketAsyncEventArgs e = (SocketAsyncEventArgs)((SocketAsyncResult)ares).AsyncState;
		if (Interlocked.Exchange(ref e.in_progress, 0) != 1)
		{
			throw new InvalidOperationException("No operation in progress");
		}
		try
		{
			e.SetBytesTransferred(e.CurrentSocket.EndSend(ares));
		}
		catch (SocketException ex)
		{
			e.SocketError = ex.SocketErrorCode;
		}
		catch (ObjectDisposedException)
		{
			e.SocketError = SocketError.OperationAborted;
		}
		finally
		{
			e.Complete_internal();
		}
	};

	private static IOAsyncCallback BeginSendGenericCallback = delegate(IOAsyncResult ares)
	{
		SocketAsyncResult socketAsyncResult = (SocketAsyncResult)ares;
		int num = 0;
		try
		{
			num = socketAsyncResult.socket.Send(socketAsyncResult.Buffers, socketAsyncResult.SockFlags);
		}
		catch (Exception e)
		{
			socketAsyncResult.Complete(e);
			return;
		}
		socketAsyncResult.Complete(num);
	};

	private static AsyncCallback SendToAsyncCallback = delegate(IAsyncResult ares)
	{
		SocketAsyncEventArgs e = (SocketAsyncEventArgs)((SocketAsyncResult)ares).AsyncState;
		if (Interlocked.Exchange(ref e.in_progress, 0) != 1)
		{
			throw new InvalidOperationException("No operation in progress");
		}
		try
		{
			e.SetBytesTransferred(e.CurrentSocket.EndSendTo(ares));
		}
		catch (SocketException ex)
		{
			e.SocketError = ex.SocketErrorCode;
		}
		catch (ObjectDisposedException)
		{
			e.SocketError = SocketError.OperationAborted;
		}
		finally
		{
			e.Complete_internal();
		}
	};

	public static bool OSSupportsIPv4
	{
		get
		{
			InitializeSockets();
			return s_SupportsIPv4;
		}
	}

	public static bool OSSupportsIPv6
	{
		get
		{
			InitializeSockets();
			return s_OSSupportsIPv6;
		}
	}

	public IntPtr Handle => m_Handle.DangerousGetHandle();

	public AddressFamily AddressFamily => addressFamily;

	public SocketType SocketType => socketType;

	public ProtocolType ProtocolType => protocolType;

	public int ReceiveBufferSize
	{
		get
		{
			return (int)GetSocketOption(SocketOptionLevel.Socket, SocketOptionName.ReceiveBuffer);
		}
		set
		{
			if (value < 0)
			{
				throw new ArgumentOutOfRangeException("value");
			}
			SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.ReceiveBuffer, value);
		}
	}

	public int SendBufferSize
	{
		get
		{
			return (int)GetSocketOption(SocketOptionLevel.Socket, SocketOptionName.SendBuffer);
		}
		set
		{
			if (value < 0)
			{
				throw new ArgumentOutOfRangeException("value");
			}
			SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.SendBuffer, value);
		}
	}

	public bool DontFragment
	{
		set
		{
			if (addressFamily == AddressFamily.InterNetwork)
			{
				SetSocketOption(SocketOptionLevel.IP, SocketOptionName.DontFragment, value ? 1 : 0);
				return;
			}
			throw new NotSupportedException(global::SR.GetString("This protocol version is not supported."));
		}
	}

	public bool DualMode
	{
		get
		{
			if (AddressFamily != AddressFamily.InterNetworkV6)
			{
				throw new NotSupportedException(global::SR.GetString("This protocol version is not supported."));
			}
			return (int)GetSocketOption(SocketOptionLevel.IPv6, SocketOptionName.IPv6Only) == 0;
		}
		set
		{
			if (AddressFamily != AddressFamily.InterNetworkV6)
			{
				throw new NotSupportedException(global::SR.GetString("This protocol version is not supported."));
			}
			SetSocketOption(SocketOptionLevel.IPv6, SocketOptionName.IPv6Only, (!value) ? 1 : 0);
		}
	}

	private bool IsDualMode
	{
		get
		{
			if (AddressFamily == AddressFamily.InterNetworkV6)
			{
				return DualMode;
			}
			return false;
		}
	}

	private static object InternalSyncObject
	{
		get
		{
			if (s_InternalSyncObject == null)
			{
				object value = new object();
				Interlocked.CompareExchange(ref s_InternalSyncObject, value, null);
			}
			return s_InternalSyncObject;
		}
	}

	internal bool CleanedUp => m_IntCleanedUp == 1;

	public int Available
	{
		get
		{
			ThrowIfDisposedAndClosed();
			int result = Available_internal(m_Handle, out var error);
			if (error != 0)
			{
				throw new SocketException(error);
			}
			return result;
		}
	}

	public bool EnableBroadcast
	{
		set
		{
			ThrowIfDisposedAndClosed();
			if (protocolType != ProtocolType.Udp)
			{
				throw new SocketException(10042);
			}
			SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.Broadcast, value ? 1 : 0);
		}
	}

	public EndPoint LocalEndPoint
	{
		get
		{
			ThrowIfDisposedAndClosed();
			if (seed_endpoint == null)
			{
				return null;
			}
			SocketAddress socketAddress = LocalEndPoint_internal(m_Handle, (int)addressFamily, out var error);
			if (error != 0)
			{
				throw new SocketException(error);
			}
			return seed_endpoint.Create(socketAddress);
		}
	}

	public bool Blocking
	{
		get
		{
			return is_blocking;
		}
		set
		{
			ThrowIfDisposedAndClosed();
			Blocking_internal(m_Handle, value, out var error);
			if (error != 0)
			{
				throw new SocketException(error);
			}
			is_blocking = value;
		}
	}

	public bool Connected => is_connected;

	public bool NoDelay
	{
		get
		{
			ThrowIfDisposedAndClosed();
			ThrowIfUdp();
			return (int)GetSocketOption(SocketOptionLevel.Tcp, SocketOptionName.Debug) != 0;
		}
		set
		{
			ThrowIfDisposedAndClosed();
			ThrowIfUdp();
			SetSocketOption(SocketOptionLevel.Tcp, SocketOptionName.Debug, value ? 1 : 0);
		}
	}

	public EndPoint RemoteEndPoint
	{
		get
		{
			ThrowIfDisposedAndClosed();
			if (!is_connected || seed_endpoint == null)
			{
				return null;
			}
			SocketAddress socketAddress = RemoteEndPoint_internal(m_Handle, (int)addressFamily, out var error);
			if (error != 0)
			{
				throw new SocketException(error);
			}
			return seed_endpoint.Create(socketAddress);
		}
	}

	internal static int FamilyHint
	{
		get
		{
			int num = 0;
			if (OSSupportsIPv4)
			{
				num = 1;
			}
			if (OSSupportsIPv6)
			{
				num = ((num == 0) ? 2 : 0);
			}
			return num;
		}
	}

	internal ValueTask<int> ReceiveAsync(Memory<byte> buffer, SocketFlags socketFlags, bool fromNetworkStream, CancellationToken cancellationToken)
	{
		if (cancellationToken.IsCancellationRequested)
		{
			return new ValueTask<int>(Task.FromCanceled<int>(cancellationToken));
		}
		AwaitableSocketAsyncEventArgs e = LazyInitializer.EnsureInitialized(ref LazyInitializer.EnsureInitialized(ref _cachedTaskEventArgs, () => new CachedEventArgs()).ValueTaskReceive, () => new AwaitableSocketAsyncEventArgs());
		if (e.Reserve())
		{
			e.SetBuffer(buffer);
			e.SocketFlags = socketFlags;
			e.WrapExceptionsInIOExceptions = fromNetworkStream;
			return e.ReceiveAsync(this);
		}
		return new ValueTask<int>(ReceiveAsyncApm(buffer, socketFlags));
	}

	private Task<int> ReceiveAsyncApm(Memory<byte> buffer, SocketFlags socketFlags)
	{
		if (MemoryMarshal.TryGetArray((ReadOnlyMemory<byte>)buffer, out ArraySegment<byte> segment))
		{
			TaskCompletionSource<int> taskCompletionSource = new TaskCompletionSource<int>(this);
			BeginReceive(segment.Array, segment.Offset, segment.Count, socketFlags, delegate(IAsyncResult iar)
			{
				TaskCompletionSource<int> taskCompletionSource3 = (TaskCompletionSource<int>)iar.AsyncState;
				try
				{
					taskCompletionSource3.TrySetResult(((Socket)taskCompletionSource3.Task.AsyncState).EndReceive(iar));
				}
				catch (Exception exception)
				{
					taskCompletionSource3.TrySetException(exception);
				}
			}, taskCompletionSource);
			return taskCompletionSource.Task;
		}
		byte[] array = ArrayPool<byte>.Shared.Rent(buffer.Length);
		TaskCompletionSource<int> taskCompletionSource2 = new TaskCompletionSource<int>(this);
		BeginReceive(array, 0, buffer.Length, socketFlags, delegate(IAsyncResult iar)
		{
			Tuple<TaskCompletionSource<int>, Memory<byte>, byte[]> tuple = (Tuple<TaskCompletionSource<int>, Memory<byte>, byte[]>)iar.AsyncState;
			try
			{
				int num = ((Socket)tuple.Item1.Task.AsyncState).EndReceive(iar);
				new ReadOnlyMemory<byte>(tuple.Item3, 0, num).Span.CopyTo(tuple.Item2.Span);
				tuple.Item1.TrySetResult(num);
			}
			catch (Exception exception)
			{
				tuple.Item1.TrySetException(exception);
			}
			finally
			{
				ArrayPool<byte>.Shared.Return(tuple.Item3);
			}
		}, Tuple.Create(taskCompletionSource2, buffer, array));
		return taskCompletionSource2.Task;
	}

	internal ValueTask SendAsyncForNetworkStream(ReadOnlyMemory<byte> buffer, SocketFlags socketFlags, CancellationToken cancellationToken)
	{
		if (cancellationToken.IsCancellationRequested)
		{
			return new ValueTask(Task.FromCanceled(cancellationToken));
		}
		AwaitableSocketAsyncEventArgs e = LazyInitializer.EnsureInitialized(ref LazyInitializer.EnsureInitialized(ref _cachedTaskEventArgs, () => new CachedEventArgs()).ValueTaskSend, () => new AwaitableSocketAsyncEventArgs());
		if (e.Reserve())
		{
			e.SetBuffer(MemoryMarshal.AsMemory(buffer));
			e.SocketFlags = socketFlags;
			e.WrapExceptionsInIOExceptions = true;
			return e.SendAsyncForNetworkStream(this);
		}
		return new ValueTask(SendAsyncApm(buffer, socketFlags));
	}

	private Task<int> SendAsyncApm(ReadOnlyMemory<byte> buffer, SocketFlags socketFlags)
	{
		if (MemoryMarshal.TryGetArray(buffer, out var segment))
		{
			TaskCompletionSource<int> taskCompletionSource = new TaskCompletionSource<int>(this);
			BeginSend(segment.Array, segment.Offset, segment.Count, socketFlags, delegate(IAsyncResult iar)
			{
				TaskCompletionSource<int> taskCompletionSource3 = (TaskCompletionSource<int>)iar.AsyncState;
				try
				{
					taskCompletionSource3.TrySetResult(((Socket)taskCompletionSource3.Task.AsyncState).EndSend(iar));
				}
				catch (Exception exception)
				{
					taskCompletionSource3.TrySetException(exception);
				}
			}, taskCompletionSource);
			return taskCompletionSource.Task;
		}
		byte[] array = ArrayPool<byte>.Shared.Rent(buffer.Length);
		buffer.Span.CopyTo(array);
		TaskCompletionSource<int> taskCompletionSource2 = new TaskCompletionSource<int>(this);
		BeginSend(array, 0, buffer.Length, socketFlags, delegate(IAsyncResult iar)
		{
			Tuple<TaskCompletionSource<int>, byte[]> tuple = (Tuple<TaskCompletionSource<int>, byte[]>)iar.AsyncState;
			try
			{
				tuple.Item1.TrySetResult(((Socket)tuple.Item1.Task.AsyncState).EndSend(iar));
			}
			catch (Exception exception)
			{
				tuple.Item1.TrySetException(exception);
			}
			finally
			{
				ArrayPool<byte>.Shared.Return(tuple.Item2);
			}
		}, Tuple.Create(taskCompletionSource2, array));
		return taskCompletionSource2.Task;
	}

	private static void CompleteAccept(Socket s, TaskSocketAsyncEventArgs<Socket> saea)
	{
		SocketError socketError = saea.SocketError;
		Socket acceptSocket = saea.AcceptSocket;
		AsyncTaskMethodBuilder<Socket> completionResponsibility = saea.GetCompletionResponsibility(out var responsibleForReturningToPool);
		if (responsibleForReturningToPool)
		{
			s.ReturnSocketAsyncEventArgs(saea);
		}
		if (socketError == SocketError.Success)
		{
			completionResponsibility.SetResult(acceptSocket);
		}
		else
		{
			completionResponsibility.SetException(GetException(socketError));
		}
	}

	private static void CompleteSendReceive(Socket s, Int32TaskSocketAsyncEventArgs saea, bool isReceive)
	{
		SocketError socketError = saea.SocketError;
		int bytesTransferred = saea.BytesTransferred;
		bool wrapExceptionsInIOExceptions = saea._wrapExceptionsInIOExceptions;
		AsyncTaskMethodBuilder<int> completionResponsibility = saea.GetCompletionResponsibility(out var responsibleForReturningToPool);
		if (responsibleForReturningToPool)
		{
			s.ReturnSocketAsyncEventArgs(saea, isReceive);
		}
		if (socketError == SocketError.Success)
		{
			completionResponsibility.SetResult(bytesTransferred);
		}
		else
		{
			completionResponsibility.SetException(GetException(socketError, wrapExceptionsInIOExceptions));
		}
	}

	private static Exception GetException(SocketError error, bool wrapExceptionsInIOExceptions = false)
	{
		Exception ex = new SocketException((int)error);
		if (!wrapExceptionsInIOExceptions)
		{
			return ex;
		}
		return new IOException(global::SR.Format("Unable to transfer data on the transport connection: {0}.", ex.Message), ex);
	}

	private void ReturnSocketAsyncEventArgs(Int32TaskSocketAsyncEventArgs saea, bool isReceive)
	{
		saea._accessed = false;
		saea._builder = default(AsyncTaskMethodBuilder<int>);
		saea._wrapExceptionsInIOExceptions = false;
		if (isReceive)
		{
			Volatile.Write(ref _cachedTaskEventArgs.TaskReceive, saea);
		}
		else
		{
			Volatile.Write(ref _cachedTaskEventArgs.TaskSend, saea);
		}
	}

	private void ReturnSocketAsyncEventArgs(TaskSocketAsyncEventArgs<Socket> saea)
	{
		saea.AcceptSocket = null;
		saea._accessed = false;
		saea._builder = default(AsyncTaskMethodBuilder<Socket>);
		Volatile.Write(ref _cachedTaskEventArgs.TaskAccept, saea);
	}

	public Socket(SocketType socketType, ProtocolType protocolType)
		: this(AddressFamily.InterNetworkV6, socketType, protocolType)
	{
		DualMode = true;
	}

	public Socket(AddressFamily addressFamily, SocketType socketType, ProtocolType protocolType)
	{
		s_LoggingEnabled = Logging.On;
		_ = s_LoggingEnabled;
		InitializeSockets();
		m_Handle = new SafeSocketHandle(Socket_icall(addressFamily, socketType, protocolType, out var _), ownsHandle: true);
		if (m_Handle.IsInvalid)
		{
			throw new SocketException();
		}
		this.addressFamily = addressFamily;
		this.socketType = socketType;
		this.protocolType = protocolType;
		IPProtectionLevel iPProtectionLevel = SettingsSectionInternal.Section.IPProtectionLevel;
		if (iPProtectionLevel != IPProtectionLevel.Unspecified)
		{
			SetIPProtectionLevel(iPProtectionLevel);
		}
		SocketDefaults();
		_ = s_LoggingEnabled;
	}

	internal bool CanTryAddressFamily(AddressFamily family)
	{
		if (family != addressFamily)
		{
			if (family == AddressFamily.InterNetwork)
			{
				return IsDualMode;
			}
			return false;
		}
		return true;
	}

	public int Send(IList<ArraySegment<byte>> buffers, SocketFlags socketFlags)
	{
		int result = Send(buffers, socketFlags, out var errorCode);
		if (errorCode != SocketError.Success)
		{
			throw new SocketException(errorCode);
		}
		return result;
	}

	public int Send(byte[] buffer, int offset, int size, SocketFlags socketFlags)
	{
		int result = Send(buffer, offset, size, socketFlags, out var errorCode);
		if (errorCode != SocketError.Success)
		{
			throw new SocketException(errorCode);
		}
		return result;
	}

	public int Receive(byte[] buffer, int offset, int size, SocketFlags socketFlags)
	{
		int result = Receive(buffer, offset, size, socketFlags, out var errorCode);
		if (errorCode != SocketError.Success)
		{
			throw new SocketException(errorCode);
		}
		return result;
	}

	public int Receive(IList<ArraySegment<byte>> buffers, SocketFlags socketFlags)
	{
		int result = Receive(buffers, socketFlags, out var errorCode);
		if (errorCode != SocketError.Success)
		{
			throw new SocketException(errorCode);
		}
		return result;
	}

	public int IOControl(IOControlCode ioControlCode, byte[] optionInValue, byte[] optionOutValue)
	{
		return IOControl((int)ioControlCode, optionInValue, optionOutValue);
	}

	public void SetIPProtectionLevel(IPProtectionLevel level)
	{
		if (level == IPProtectionLevel.Unspecified)
		{
			throw new ArgumentException(global::SR.GetString("The specified value is not valid."), "level");
		}
		if (addressFamily == AddressFamily.InterNetworkV6)
		{
			SetSocketOption(SocketOptionLevel.IPv6, SocketOptionName.IPProtectionLevel, (int)level);
			return;
		}
		if (addressFamily == AddressFamily.InterNetwork)
		{
			SetSocketOption(SocketOptionLevel.IP, SocketOptionName.IPProtectionLevel, (int)level);
			return;
		}
		throw new NotSupportedException(global::SR.GetString("This protocol version is not supported."));
	}

	public IAsyncResult BeginSend(byte[] buffer, int offset, int size, SocketFlags socketFlags, AsyncCallback callback, object state)
	{
		IAsyncResult result = BeginSend(buffer, offset, size, socketFlags, out var errorCode, callback, state);
		if (errorCode != SocketError.Success && errorCode != SocketError.IOPending)
		{
			throw new SocketException(errorCode);
		}
		return result;
	}

	public int EndSend(IAsyncResult asyncResult)
	{
		int result = EndSend(asyncResult, out var errorCode);
		if (errorCode != SocketError.Success)
		{
			throw new SocketException(errorCode);
		}
		return result;
	}

	public IAsyncResult BeginReceive(byte[] buffer, int offset, int size, SocketFlags socketFlags, AsyncCallback callback, object state)
	{
		IAsyncResult result = BeginReceive(buffer, offset, size, socketFlags, out var errorCode, callback, state);
		if (errorCode != SocketError.Success && errorCode != SocketError.IOPending)
		{
			throw new SocketException(errorCode);
		}
		return result;
	}

	public int EndReceive(IAsyncResult asyncResult)
	{
		int result = EndReceive(asyncResult, out var errorCode);
		if (errorCode != SocketError.Success)
		{
			throw new SocketException(errorCode);
		}
		return result;
	}

	internal static void InitializeSockets()
	{
		if (s_Initialized)
		{
			return;
		}
		lock (InternalSyncObject)
		{
			if (!s_Initialized)
			{
				bool flag = true;
				bool num = IsProtocolSupported(NetworkInterfaceComponent.IPv4);
				flag = IsProtocolSupported(NetworkInterfaceComponent.IPv6);
				if (flag)
				{
					s_OSSupportsIPv6 = true;
					flag = SettingsSectionInternal.Section.Ipv6Enabled;
				}
				s_SupportsIPv4 = num;
				s_SupportsIPv6 = flag;
				s_Initialized = true;
			}
		}
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	~Socket()
	{
		Dispose(disposing: false);
	}

	internal void InternalShutdown(SocketShutdown how)
	{
		if (is_connected && !CleanedUp)
		{
			Shutdown_internal(m_Handle, how, out var _);
		}
	}

	internal void SetSocketOption(SocketOptionLevel optionLevel, SocketOptionName optionName, int optionValue, bool silent)
	{
		if (CleanedUp && is_closed)
		{
			if (!silent)
			{
				throw new ObjectDisposedException(GetType().ToString());
			}
			return;
		}
		SetSocketOption_internal(m_Handle, optionLevel, optionName, null, null, optionValue, out var error);
		if (!silent && error != 0)
		{
			throw new SocketException(error);
		}
	}

	public Socket(SocketInformation socketInformation)
	{
		is_listening = (socketInformation.Options & SocketInformationOptions.Listening) != 0;
		is_connected = (socketInformation.Options & SocketInformationOptions.Connected) != 0;
		is_blocking = (socketInformation.Options & SocketInformationOptions.NonBlocking) == 0;
		useOverlappedIO = (socketInformation.Options & SocketInformationOptions.UseOnlyOverlappedIO) != 0;
		IList list = DataConverter.Unpack("iiiil", socketInformation.ProtocolInformation, 0);
		addressFamily = (AddressFamily)(int)list[0];
		socketType = (SocketType)(int)list[1];
		protocolType = (ProtocolType)(int)list[2];
		is_bound = (int)list[3] != 0;
		m_Handle = new SafeSocketHandle((IntPtr)(long)list[4], ownsHandle: true);
		InitializeSockets();
		SocketDefaults();
	}

	internal Socket(AddressFamily family, SocketType type, ProtocolType proto, SafeSocketHandle safe_handle)
	{
		addressFamily = family;
		socketType = type;
		protocolType = proto;
		m_Handle = safe_handle;
		is_connected = true;
		InitializeSockets();
	}

	private void SocketDefaults()
	{
		try
		{
			if (addressFamily == AddressFamily.InterNetwork)
			{
				DontFragment = false;
				if (protocolType == ProtocolType.Tcp)
				{
					NoDelay = false;
				}
			}
			else if (addressFamily == AddressFamily.InterNetworkV6 && socketType != SocketType.Raw)
			{
				DualMode = true;
			}
		}
		catch (SocketException)
		{
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern IntPtr Socket_icall(AddressFamily family, SocketType type, ProtocolType proto, out int error);

	private static int Available_internal(SafeSocketHandle safeHandle, out int error)
	{
		bool success = false;
		try
		{
			safeHandle.DangerousAddRef(ref success);
			return Available_icall(safeHandle.DangerousGetHandle(), out error);
		}
		finally
		{
			if (success)
			{
				safeHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int Available_icall(IntPtr socket, out int error);

	private static SocketAddress LocalEndPoint_internal(SafeSocketHandle safeHandle, int family, out int error)
	{
		bool success = false;
		try
		{
			safeHandle.DangerousAddRef(ref success);
			return LocalEndPoint_icall(safeHandle.DangerousGetHandle(), family, out error);
		}
		finally
		{
			if (success)
			{
				safeHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern SocketAddress LocalEndPoint_icall(IntPtr socket, int family, out int error);

	private static void Blocking_internal(SafeSocketHandle safeHandle, bool block, out int error)
	{
		bool success = false;
		try
		{
			safeHandle.DangerousAddRef(ref success);
			Blocking_icall(safeHandle.DangerousGetHandle(), block, out error);
		}
		finally
		{
			if (success)
			{
				safeHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern void Blocking_icall(IntPtr socket, bool block, out int error);

	private static SocketAddress RemoteEndPoint_internal(SafeSocketHandle safeHandle, int family, out int error)
	{
		bool success = false;
		try
		{
			safeHandle.DangerousAddRef(ref success);
			return RemoteEndPoint_icall(safeHandle.DangerousGetHandle(), family, out error);
		}
		finally
		{
			if (success)
			{
				safeHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern SocketAddress RemoteEndPoint_icall(IntPtr socket, int family, out int error);

	public bool Poll(int microSeconds, SelectMode mode)
	{
		ThrowIfDisposedAndClosed();
		if (mode != SelectMode.SelectRead && mode != SelectMode.SelectWrite && mode != SelectMode.SelectError)
		{
			throw new NotSupportedException("'mode' parameter is not valid.");
		}
		bool flag = Poll_internal(m_Handle, mode, microSeconds, out var error);
		if (error != 0)
		{
			throw new SocketException(error);
		}
		if (((mode == SelectMode.SelectWrite) & flag) && !is_connected && (int)GetSocketOption(SocketOptionLevel.Socket, SocketOptionName.Error) == 0)
		{
			is_connected = true;
		}
		return flag;
	}

	private static bool Poll_internal(SafeSocketHandle safeHandle, SelectMode mode, int timeout, out int error)
	{
		bool success = false;
		try
		{
			safeHandle.DangerousAddRef(ref success);
			return Poll_icall(safeHandle.DangerousGetHandle(), mode, timeout, out error);
		}
		finally
		{
			if (success)
			{
				safeHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool Poll_icall(IntPtr socket, SelectMode mode, int timeout, out int error);

	public Socket Accept()
	{
		ThrowIfDisposedAndClosed();
		int error = 0;
		SafeSocketHandle safe_handle = Accept_internal(m_Handle, out error, is_blocking);
		if (error != 0)
		{
			if (is_closed)
			{
				error = 10004;
			}
			throw new SocketException(error);
		}
		return new Socket(AddressFamily, SocketType, ProtocolType, safe_handle)
		{
			seed_endpoint = seed_endpoint,
			Blocking = Blocking
		};
	}

	internal void Accept(Socket acceptSocket)
	{
		ThrowIfDisposedAndClosed();
		int error = 0;
		SafeSocketHandle handle = Accept_internal(m_Handle, out error, is_blocking);
		if (error != 0)
		{
			if (is_closed)
			{
				error = 10004;
			}
			throw new SocketException(error);
		}
		acceptSocket.addressFamily = AddressFamily;
		acceptSocket.socketType = SocketType;
		acceptSocket.protocolType = ProtocolType;
		acceptSocket.m_Handle = handle;
		acceptSocket.is_connected = true;
		acceptSocket.seed_endpoint = seed_endpoint;
		acceptSocket.Blocking = Blocking;
	}

	public bool AcceptAsync(SocketAsyncEventArgs e)
	{
		ThrowIfDisposedAndClosed();
		if (!is_bound)
		{
			throw new InvalidOperationException("You must call the Bind method before performing this operation.");
		}
		if (!is_listening)
		{
			throw new InvalidOperationException("You must call the Listen method before performing this operation.");
		}
		if (e.BufferList != null)
		{
			throw new ArgumentException("Multiple buffers cannot be used with this method.");
		}
		if (e.Count < 0)
		{
			throw new ArgumentOutOfRangeException("e.Count");
		}
		Socket acceptSocket = e.AcceptSocket;
		if (acceptSocket != null && (acceptSocket.is_bound || acceptSocket.is_connected))
		{
			throw new InvalidOperationException("AcceptSocket: The socket must not be bound or connected.");
		}
		InitSocketAsyncEventArgs(e, AcceptAsyncCallback, e, SocketOperation.Accept);
		QueueIOSelectorJob(ReadSem, e.socket_async_result.Handle, new IOSelectorJob(IOOperation.Read, BeginAcceptCallback, e.socket_async_result));
		return true;
	}

	public IAsyncResult BeginAccept(AsyncCallback callback, object state)
	{
		ThrowIfDisposedAndClosed();
		if (!is_bound || !is_listening)
		{
			throw new InvalidOperationException();
		}
		SocketAsyncResult socketAsyncResult = new SocketAsyncResult(this, callback, state, SocketOperation.Accept);
		QueueIOSelectorJob(ReadSem, socketAsyncResult.Handle, new IOSelectorJob(IOOperation.Read, BeginAcceptCallback, socketAsyncResult));
		return socketAsyncResult;
	}

	public Socket EndAccept(IAsyncResult asyncResult)
	{
		byte[] buffer;
		int bytesTransferred;
		return EndAccept(out buffer, out bytesTransferred, asyncResult);
	}

	public Socket EndAccept(out byte[] buffer, out int bytesTransferred, IAsyncResult asyncResult)
	{
		ThrowIfDisposedAndClosed();
		SocketAsyncResult socketAsyncResult = ValidateEndIAsyncResult(asyncResult, "EndAccept", "asyncResult");
		if (!socketAsyncResult.IsCompleted)
		{
			socketAsyncResult.AsyncWaitHandle.WaitOne();
		}
		socketAsyncResult.CheckIfThrowDelayedException();
		buffer = socketAsyncResult.Buffer.ToArray();
		bytesTransferred = socketAsyncResult.Total;
		return socketAsyncResult.AcceptedSocket;
	}

	private static SafeSocketHandle Accept_internal(SafeSocketHandle safeHandle, out int error, bool blocking)
	{
		try
		{
			safeHandle.RegisterForBlockingSyscall();
			return new SafeSocketHandle(Accept_icall(safeHandle.DangerousGetHandle(), out error, blocking), ownsHandle: true);
		}
		finally
		{
			safeHandle.UnRegisterForBlockingSyscall();
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern IntPtr Accept_icall(IntPtr sock, out int error, bool blocking);

	public void Bind(EndPoint localEP)
	{
		ThrowIfDisposedAndClosed();
		if (localEP == null)
		{
			throw new ArgumentNullException("localEP");
		}
		if (localEP is IPEndPoint input)
		{
			localEP = RemapIPEndPoint(input);
		}
		Bind_internal(m_Handle, localEP.Serialize(), out var error);
		if (error != 0)
		{
			throw new SocketException(error);
		}
		if (error == 0)
		{
			is_bound = true;
		}
		seed_endpoint = localEP;
	}

	private static void Bind_internal(SafeSocketHandle safeHandle, SocketAddress sa, out int error)
	{
		bool success = false;
		try
		{
			safeHandle.DangerousAddRef(ref success);
			Bind_icall(safeHandle.DangerousGetHandle(), sa, out error);
		}
		finally
		{
			if (success)
			{
				safeHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Bind_icall(IntPtr sock, SocketAddress sa, out int error);

	public void Listen(int backlog)
	{
		ThrowIfDisposedAndClosed();
		if (!is_bound)
		{
			throw new SocketException(10022);
		}
		Listen_internal(m_Handle, backlog, out var error);
		if (error != 0)
		{
			throw new SocketException(error);
		}
		is_listening = true;
	}

	private static void Listen_internal(SafeSocketHandle safeHandle, int backlog, out int error)
	{
		bool success = false;
		try
		{
			safeHandle.DangerousAddRef(ref success);
			Listen_icall(safeHandle.DangerousGetHandle(), backlog, out error);
		}
		finally
		{
			if (success)
			{
				safeHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Listen_icall(IntPtr sock, int backlog, out int error);

	public void Connect(IPAddress address, int port)
	{
		Connect(new IPEndPoint(address, port));
	}

	public void Connect(EndPoint remoteEP)
	{
		ThrowIfDisposedAndClosed();
		if (remoteEP == null)
		{
			throw new ArgumentNullException("remoteEP");
		}
		IPEndPoint iPEndPoint = remoteEP as IPEndPoint;
		if (iPEndPoint != null && socketType != SocketType.Dgram && (iPEndPoint.Address.Equals(IPAddress.Any) || iPEndPoint.Address.Equals(IPAddress.IPv6Any)))
		{
			throw new SocketException(10049);
		}
		if (is_listening)
		{
			throw new InvalidOperationException();
		}
		if (iPEndPoint != null)
		{
			remoteEP = RemapIPEndPoint(iPEndPoint);
		}
		SocketAddress sa = remoteEP.Serialize();
		int error = 0;
		Connect_internal(m_Handle, sa, out error, is_blocking);
		if (error == 0 || error == 10035)
		{
			seed_endpoint = remoteEP;
		}
		if (error != 0)
		{
			if (is_closed)
			{
				error = 10004;
			}
			throw new SocketException(error);
		}
		is_connected = socketType != SocketType.Dgram || iPEndPoint == null || (!iPEndPoint.Address.Equals(IPAddress.Any) && !iPEndPoint.Address.Equals(IPAddress.IPv6Any));
		is_bound = true;
	}

	public bool ConnectAsync(SocketAsyncEventArgs e)
	{
		ThrowIfDisposedAndClosed();
		if (is_listening)
		{
			throw new InvalidOperationException("You may not perform this operation after calling the Listen method.");
		}
		if (e.RemoteEndPoint == null)
		{
			throw new ArgumentNullException("remoteEP");
		}
		InitSocketAsyncEventArgs(e, null, e, SocketOperation.Connect);
		try
		{
			SocketAsyncResult socketAsyncResult;
			bool flag;
			if (!GetCheckedIPs(e, out var addresses))
			{
				socketAsyncResult = new SocketAsyncResult(this, ConnectAsyncCallback, e, SocketOperation.Connect)
				{
					EndPoint = e.RemoteEndPoint
				};
				flag = BeginSConnect(socketAsyncResult);
			}
			else
			{
				DnsEndPoint dnsEndPoint = (DnsEndPoint)e.RemoteEndPoint;
				if (addresses == null)
				{
					throw new ArgumentNullException("addresses");
				}
				if (addresses.Length == 0)
				{
					throw new ArgumentException("Empty addresses list");
				}
				if (AddressFamily != AddressFamily.InterNetwork && AddressFamily != AddressFamily.InterNetworkV6)
				{
					throw new NotSupportedException("This method is only valid for addresses in the InterNetwork or InterNetworkV6 families");
				}
				if (dnsEndPoint.Port <= 0 || dnsEndPoint.Port > 65535)
				{
					throw new ArgumentOutOfRangeException("port", "Must be > 0 and < 65536");
				}
				socketAsyncResult = new SocketAsyncResult(this, ConnectAsyncCallback, e, SocketOperation.Connect)
				{
					Addresses = addresses,
					Port = dnsEndPoint.Port
				};
				is_connected = false;
				flag = BeginMConnect(socketAsyncResult);
			}
			if (!flag)
			{
				e.CurrentSocket.EndConnect(socketAsyncResult);
			}
			return flag;
		}
		catch (SocketException ex)
		{
			e.SocketError = ex.SocketErrorCode;
			e.socket_async_result.Complete(ex, synch: true);
			return false;
		}
		catch (Exception e2)
		{
			e.socket_async_result.Complete(e2, synch: true);
			return false;
		}
	}

	public IAsyncResult BeginConnect(string host, int port, AsyncCallback callback, object state)
	{
		ThrowIfDisposedAndClosed();
		if (host == null)
		{
			throw new ArgumentNullException("host");
		}
		if (addressFamily != AddressFamily.InterNetwork && addressFamily != AddressFamily.InterNetworkV6)
		{
			throw new NotSupportedException("This method is valid only for sockets in the InterNetwork and InterNetworkV6 families");
		}
		if (port <= 0 || port > 65535)
		{
			throw new ArgumentOutOfRangeException("port", "Must be > 0 and < 65536");
		}
		if (is_listening)
		{
			throw new InvalidOperationException();
		}
		SocketAsyncResult sockares = new SocketAsyncResult(this, callback, state, SocketOperation.Connect)
		{
			Port = port
		};
		Dns.GetHostAddressesAsync(host).ContinueWith(delegate(Task<IPAddress[]> t)
		{
			if (t.IsFaulted)
			{
				sockares.Complete(t.Exception.InnerException);
			}
			else if (t.IsCanceled)
			{
				sockares.Complete(new OperationCanceledException());
			}
			else
			{
				sockares.Addresses = t.Result;
				BeginMConnect(sockares);
			}
		}, TaskScheduler.Default);
		return sockares;
	}

	public IAsyncResult BeginConnect(EndPoint remoteEP, AsyncCallback callback, object state)
	{
		ThrowIfDisposedAndClosed();
		if (remoteEP == null)
		{
			throw new ArgumentNullException("remoteEP");
		}
		if (is_listening)
		{
			throw new InvalidOperationException();
		}
		SocketAsyncResult obj = new SocketAsyncResult(this, callback, state, SocketOperation.Connect)
		{
			EndPoint = remoteEP
		};
		BeginSConnect(obj);
		return obj;
	}

	private static bool BeginMConnect(SocketAsyncResult sockares)
	{
		Exception e = null;
		for (int i = sockares.CurrentAddress; i < sockares.Addresses.Length; i++)
		{
			try
			{
				sockares.CurrentAddress++;
				sockares.EndPoint = new IPEndPoint(sockares.Addresses[i], sockares.Port);
				if (!sockares.socket.CanTryAddressFamily(sockares.EndPoint.AddressFamily))
				{
					continue;
				}
				return BeginSConnect(sockares);
			}
			catch (Exception ex)
			{
				e = ex;
			}
		}
		sockares.Complete(e, synch: true);
		return false;
	}

	private static bool BeginSConnect(SocketAsyncResult sockares)
	{
		EndPoint endPoint = sockares.EndPoint;
		if (endPoint is IPEndPoint)
		{
			IPEndPoint iPEndPoint = (IPEndPoint)endPoint;
			if (iPEndPoint.Address.Equals(IPAddress.Any) || iPEndPoint.Address.Equals(IPAddress.IPv6Any))
			{
				sockares.Complete(new SocketException(10049), synch: true);
				return false;
			}
			endPoint = (sockares.EndPoint = sockares.socket.RemapIPEndPoint(iPEndPoint));
		}
		if (!sockares.socket.CanTryAddressFamily(sockares.EndPoint.AddressFamily))
		{
			sockares.Complete(new ArgumentException("None of the discovered or specified addresses match the socket address family."), synch: true);
			return false;
		}
		int error = 0;
		if (sockares.socket.connect_in_progress)
		{
			sockares.socket.connect_in_progress = false;
			sockares.socket.m_Handle.Dispose();
			sockares.socket.m_Handle = new SafeSocketHandle(Socket_icall(sockares.socket.addressFamily, sockares.socket.socketType, sockares.socket.protocolType, out error), ownsHandle: true);
			if (error != 0)
			{
				sockares.Complete(new SocketException(error), synch: true);
				return false;
			}
		}
		bool num = sockares.socket.is_blocking;
		if (num)
		{
			sockares.socket.Blocking = false;
		}
		Connect_internal(sockares.socket.m_Handle, endPoint.Serialize(), out error, blocking: false);
		if (num)
		{
			sockares.socket.Blocking = true;
		}
		switch (error)
		{
		case 0:
			sockares.socket.is_connected = true;
			sockares.socket.is_bound = true;
			sockares.Complete(synch: true);
			return false;
		default:
			sockares.socket.is_connected = false;
			sockares.socket.is_bound = false;
			sockares.Complete(new SocketException(error), synch: true);
			return false;
		case 10035:
		case 10036:
			sockares.socket.is_connected = false;
			sockares.socket.is_bound = false;
			sockares.socket.connect_in_progress = true;
			IOSelector.Add(sockares.Handle, new IOSelectorJob(IOOperation.Write, BeginConnectCallback, sockares));
			return true;
		}
	}

	public void EndConnect(IAsyncResult asyncResult)
	{
		ThrowIfDisposedAndClosed();
		SocketAsyncResult socketAsyncResult = ValidateEndIAsyncResult(asyncResult, "EndConnect", "asyncResult");
		if (!socketAsyncResult.IsCompleted)
		{
			socketAsyncResult.AsyncWaitHandle.WaitOne();
		}
		socketAsyncResult.CheckIfThrowDelayedException();
	}

	private static void Connect_internal(SafeSocketHandle safeHandle, SocketAddress sa, out int error, bool blocking)
	{
		try
		{
			safeHandle.RegisterForBlockingSyscall();
			Connect_icall(safeHandle.DangerousGetHandle(), sa, out error, blocking);
		}
		finally
		{
			safeHandle.UnRegisterForBlockingSyscall();
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Connect_icall(IntPtr sock, SocketAddress sa, out int error, bool blocking);

	private bool GetCheckedIPs(SocketAsyncEventArgs e, out IPAddress[] addresses)
	{
		addresses = null;
		if (e.RemoteEndPoint is DnsEndPoint dnsEndPoint)
		{
			addresses = Dns.GetHostAddresses(dnsEndPoint.Host);
			if (dnsEndPoint.AddressFamily == AddressFamily.Unspecified)
			{
				return true;
			}
			int num = 0;
			for (int i = 0; i < addresses.Length; i++)
			{
				if (addresses[i].AddressFamily == dnsEndPoint.AddressFamily)
				{
					addresses[num++] = addresses[i];
				}
			}
			if (num != addresses.Length)
			{
				Array.Resize(ref addresses, num);
			}
			return true;
		}
		e.SetConnectByNameError(null);
		return false;
	}

	public void Disconnect(bool reuseSocket)
	{
		ThrowIfDisposedAndClosed();
		int error = 0;
		Disconnect_internal(m_Handle, reuseSocket, out error);
		switch (error)
		{
		case 50:
			throw new PlatformNotSupportedException();
		default:
			throw new SocketException(error);
		case 0:
			is_connected = false;
			break;
		}
	}

	public void EndDisconnect(IAsyncResult asyncResult)
	{
		ThrowIfDisposedAndClosed();
		SocketAsyncResult socketAsyncResult = ValidateEndIAsyncResult(asyncResult, "EndDisconnect", "asyncResult");
		if (!socketAsyncResult.IsCompleted)
		{
			socketAsyncResult.AsyncWaitHandle.WaitOne();
		}
		socketAsyncResult.CheckIfThrowDelayedException();
	}

	private static void Disconnect_internal(SafeSocketHandle safeHandle, bool reuse, out int error)
	{
		bool success = false;
		try
		{
			safeHandle.DangerousAddRef(ref success);
			Disconnect_icall(safeHandle.DangerousGetHandle(), reuse, out error);
		}
		finally
		{
			if (success)
			{
				safeHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Disconnect_icall(IntPtr sock, bool reuse, out int error);

	public unsafe int Receive(byte[] buffer, int offset, int size, SocketFlags socketFlags, out SocketError errorCode)
	{
		ThrowIfDisposedAndClosed();
		ThrowIfBufferNull(buffer);
		ThrowIfBufferOutOfRange(buffer, offset, size);
		int result;
		int error;
		fixed (byte* ptr = buffer)
		{
			result = Receive_internal(m_Handle, ptr + offset, size, socketFlags, out error, is_blocking);
		}
		errorCode = (SocketError)error;
		if (errorCode != SocketError.Success && errorCode != SocketError.WouldBlock && errorCode != SocketError.InProgress)
		{
			is_connected = false;
			is_bound = false;
			return result;
		}
		is_connected = true;
		return result;
	}

	private unsafe int Receive(Memory<byte> buffer, int offset, int size, SocketFlags socketFlags, out SocketError errorCode)
	{
		ThrowIfDisposedAndClosed();
		int result;
		int error;
		using (MemoryHandle memoryHandle = buffer.Slice(offset, size).Pin())
		{
			result = Receive_internal(m_Handle, (byte*)memoryHandle.Pointer, size, socketFlags, out error, is_blocking);
		}
		errorCode = (SocketError)error;
		if (errorCode != SocketError.Success && errorCode != SocketError.WouldBlock && errorCode != SocketError.InProgress)
		{
			is_connected = false;
			is_bound = false;
		}
		else
		{
			is_connected = true;
		}
		return result;
	}

	[CLSCompliant(false)]
	public unsafe int Receive(IList<ArraySegment<byte>> buffers, SocketFlags socketFlags, out SocketError errorCode)
	{
		ThrowIfDisposedAndClosed();
		if (buffers == null || buffers.Count == 0)
		{
			throw new ArgumentNullException("buffers");
		}
		int count = buffers.Count;
		GCHandle[] array = new GCHandle[count];
		int result;
		int error;
		try
		{
			fixed (WSABUF* ptr = new WSABUF[count])
			{
				for (int i = 0; i < count; i++)
				{
					ArraySegment<byte> arraySegment = buffers[i];
					if (arraySegment.Offset < 0 || arraySegment.Count < 0 || arraySegment.Count > arraySegment.Array.Length - arraySegment.Offset)
					{
						throw new ArgumentOutOfRangeException("segment");
					}
					try
					{
					}
					finally
					{
						array[i] = GCHandle.Alloc(arraySegment.Array, GCHandleType.Pinned);
					}
					ptr[i].len = arraySegment.Count;
					ptr[i].buf = Marshal.UnsafeAddrOfPinnedArrayElement(arraySegment.Array, arraySegment.Offset);
				}
				result = Receive_internal(m_Handle, ptr, count, socketFlags, out error, is_blocking);
			}
		}
		finally
		{
			for (int j = 0; j < count; j++)
			{
				if (array[j].IsAllocated)
				{
					array[j].Free();
				}
			}
		}
		errorCode = (SocketError)error;
		return result;
	}

	public int Receive(Span<byte> buffer, SocketFlags socketFlags, out SocketError errorCode)
	{
		byte[] array = new byte[buffer.Length];
		int result = Receive(array, 0, array.Length, socketFlags, out errorCode);
		array.CopyTo(buffer);
		return result;
	}

	public int Send(ReadOnlySpan<byte> buffer, SocketFlags socketFlags, out SocketError errorCode)
	{
		byte[] array = buffer.ToArray();
		return Send(array, 0, array.Length, socketFlags, out errorCode);
	}

	public bool ReceiveAsync(SocketAsyncEventArgs e)
	{
		ThrowIfDisposedAndClosed();
		if (e.MemoryBuffer.Equals(default(Memory<byte>)) && e.BufferList == null)
		{
			throw new NullReferenceException("Either e.Buffer or e.BufferList must be valid buffers.");
		}
		if (e.BufferList != null)
		{
			InitSocketAsyncEventArgs(e, ReceiveAsyncCallback, e, SocketOperation.ReceiveGeneric);
			e.socket_async_result.Buffers = e.BufferList;
			QueueIOSelectorJob(ReadSem, e.socket_async_result.Handle, new IOSelectorJob(IOOperation.Read, BeginReceiveGenericCallback, e.socket_async_result));
		}
		else
		{
			InitSocketAsyncEventArgs(e, ReceiveAsyncCallback, e, SocketOperation.Receive);
			e.socket_async_result.Buffer = e.MemoryBuffer;
			e.socket_async_result.Offset = e.Offset;
			e.socket_async_result.Size = e.Count;
			QueueIOSelectorJob(ReadSem, e.socket_async_result.Handle, new IOSelectorJob(IOOperation.Read, BeginReceiveCallback, e.socket_async_result));
		}
		return true;
	}

	public IAsyncResult BeginReceive(byte[] buffer, int offset, int size, SocketFlags socketFlags, out SocketError errorCode, AsyncCallback callback, object state)
	{
		ThrowIfDisposedAndClosed();
		ThrowIfBufferNull(buffer);
		ThrowIfBufferOutOfRange(buffer, offset, size);
		errorCode = SocketError.Success;
		SocketAsyncResult socketAsyncResult = new SocketAsyncResult(this, callback, state, SocketOperation.Receive)
		{
			Buffer = buffer,
			Offset = offset,
			Size = size,
			SockFlags = socketFlags
		};
		QueueIOSelectorJob(ReadSem, socketAsyncResult.Handle, new IOSelectorJob(IOOperation.Read, BeginReceiveCallback, socketAsyncResult));
		return socketAsyncResult;
	}

	public int EndReceive(IAsyncResult asyncResult, out SocketError errorCode)
	{
		ThrowIfDisposedAndClosed();
		SocketAsyncResult socketAsyncResult = ValidateEndIAsyncResult(asyncResult, "EndReceive", "asyncResult");
		if (!socketAsyncResult.IsCompleted)
		{
			socketAsyncResult.AsyncWaitHandle.WaitOne();
		}
		errorCode = socketAsyncResult.ErrorCode;
		if (errorCode != SocketError.Success && errorCode != SocketError.WouldBlock && errorCode != SocketError.InProgress)
		{
			is_connected = false;
		}
		if (errorCode == SocketError.Success)
		{
			socketAsyncResult.CheckIfThrowDelayedException();
		}
		return socketAsyncResult.Total;
	}

	private unsafe static int Receive_internal(SafeSocketHandle safeHandle, WSABUF* bufarray, int count, SocketFlags flags, out int error, bool blocking)
	{
		try
		{
			safeHandle.RegisterForBlockingSyscall();
			return Receive_array_icall(safeHandle.DangerousGetHandle(), bufarray, count, flags, out error, blocking);
		}
		finally
		{
			safeHandle.UnRegisterForBlockingSyscall();
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern int Receive_array_icall(IntPtr sock, WSABUF* bufarray, int count, SocketFlags flags, out int error, bool blocking);

	private unsafe static int Receive_internal(SafeSocketHandle safeHandle, byte* buffer, int count, SocketFlags flags, out int error, bool blocking)
	{
		try
		{
			safeHandle.RegisterForBlockingSyscall();
			return Receive_icall(safeHandle.DangerousGetHandle(), buffer, count, flags, out error, blocking);
		}
		finally
		{
			safeHandle.UnRegisterForBlockingSyscall();
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern int Receive_icall(IntPtr sock, byte* buffer, int count, SocketFlags flags, out int error, bool blocking);

	private unsafe int ReceiveFrom(Memory<byte> buffer, int offset, int size, SocketFlags socketFlags, ref EndPoint remoteEP, out SocketError errorCode)
	{
		SocketAddress sockaddr = remoteEP.Serialize();
		int result;
		int error;
		using (MemoryHandle memoryHandle = buffer.Slice(offset, size).Pin())
		{
			result = ReceiveFrom_internal(m_Handle, (byte*)memoryHandle.Pointer, size, socketFlags, ref sockaddr, out error, is_blocking);
		}
		errorCode = (SocketError)error;
		if (errorCode != SocketError.Success)
		{
			if (errorCode != SocketError.WouldBlock && errorCode != SocketError.InProgress)
			{
				is_connected = false;
			}
			else if (errorCode == SocketError.WouldBlock && is_blocking)
			{
				errorCode = SocketError.TimedOut;
			}
			return 0;
		}
		is_connected = true;
		is_bound = true;
		if (sockaddr != null)
		{
			remoteEP = remoteEP.Create(sockaddr);
		}
		seed_endpoint = remoteEP;
		return result;
	}

	public bool ReceiveFromAsync(SocketAsyncEventArgs e)
	{
		ThrowIfDisposedAndClosed();
		if (e.BufferList != null)
		{
			throw new NotSupportedException("Mono doesn't support using BufferList at this point.");
		}
		if (e.RemoteEndPoint == null)
		{
			throw new ArgumentNullException("remoteEP", "Value cannot be null.");
		}
		InitSocketAsyncEventArgs(e, ReceiveFromAsyncCallback, e, SocketOperation.ReceiveFrom);
		e.socket_async_result.Buffer = e.Buffer;
		e.socket_async_result.Offset = e.Offset;
		e.socket_async_result.Size = e.Count;
		e.socket_async_result.EndPoint = e.RemoteEndPoint;
		e.socket_async_result.SockFlags = e.SocketFlags;
		QueueIOSelectorJob(ReadSem, e.socket_async_result.Handle, new IOSelectorJob(IOOperation.Read, BeginReceiveFromCallback, e.socket_async_result));
		return true;
	}

	private int EndReceiveFrom_internal(SocketAsyncResult sockares, SocketAsyncEventArgs ares)
	{
		ThrowIfDisposedAndClosed();
		if (Interlocked.CompareExchange(ref sockares.EndCalled, 1, 0) == 1)
		{
			throw new InvalidOperationException("EndReceiveFrom can only be called once per asynchronous operation");
		}
		if (!sockares.IsCompleted)
		{
			sockares.AsyncWaitHandle.WaitOne();
		}
		sockares.CheckIfThrowDelayedException();
		ares.RemoteEndPoint = sockares.EndPoint;
		return sockares.Total;
	}

	private unsafe static int ReceiveFrom_internal(SafeSocketHandle safeHandle, byte* buffer, int count, SocketFlags flags, ref SocketAddress sockaddr, out int error, bool blocking)
	{
		try
		{
			safeHandle.RegisterForBlockingSyscall();
			return ReceiveFrom_icall(safeHandle.DangerousGetHandle(), buffer, count, flags, ref sockaddr, out error, blocking);
		}
		finally
		{
			safeHandle.UnRegisterForBlockingSyscall();
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern int ReceiveFrom_icall(IntPtr sock, byte* buffer, int count, SocketFlags flags, ref SocketAddress sockaddr, out int error, bool blocking);

	public unsafe int Send(byte[] buffer, int offset, int size, SocketFlags socketFlags, out SocketError errorCode)
	{
		ThrowIfDisposedAndClosed();
		ThrowIfBufferNull(buffer);
		ThrowIfBufferOutOfRange(buffer, offset, size);
		if (size == 0)
		{
			errorCode = SocketError.Success;
			return 0;
		}
		int num = 0;
		do
		{
			int error;
			fixed (byte* ptr = buffer)
			{
				num += Send_internal(m_Handle, ptr + (offset + num), size - num, socketFlags, out error, is_blocking);
			}
			errorCode = (SocketError)error;
			if (errorCode != SocketError.Success && errorCode != SocketError.WouldBlock && errorCode != SocketError.InProgress)
			{
				is_connected = false;
				is_bound = false;
				break;
			}
			is_connected = true;
		}
		while (num < size);
		return num;
	}

	[CLSCompliant(false)]
	public unsafe int Send(IList<ArraySegment<byte>> buffers, SocketFlags socketFlags, out SocketError errorCode)
	{
		ThrowIfDisposedAndClosed();
		if (buffers == null)
		{
			throw new ArgumentNullException("buffers");
		}
		if (buffers.Count == 0)
		{
			throw new ArgumentException("Buffer is empty", "buffers");
		}
		int count = buffers.Count;
		GCHandle[] array = new GCHandle[count];
		int result;
		int error;
		try
		{
			fixed (WSABUF* ptr = new WSABUF[count])
			{
				for (int i = 0; i < count; i++)
				{
					ArraySegment<byte> arraySegment = buffers[i];
					if (arraySegment.Offset < 0 || arraySegment.Count < 0 || arraySegment.Count > arraySegment.Array.Length - arraySegment.Offset)
					{
						throw new ArgumentOutOfRangeException("segment");
					}
					try
					{
					}
					finally
					{
						array[i] = GCHandle.Alloc(arraySegment.Array, GCHandleType.Pinned);
					}
					ptr[i].len = arraySegment.Count;
					ptr[i].buf = Marshal.UnsafeAddrOfPinnedArrayElement(arraySegment.Array, arraySegment.Offset);
				}
				result = Send_internal(m_Handle, ptr, count, socketFlags, out error, is_blocking);
			}
		}
		finally
		{
			for (int j = 0; j < count; j++)
			{
				if (array[j].IsAllocated)
				{
					array[j].Free();
				}
			}
		}
		errorCode = (SocketError)error;
		return result;
	}

	public bool SendAsync(SocketAsyncEventArgs e)
	{
		ThrowIfDisposedAndClosed();
		if (e.MemoryBuffer.Equals(default(Memory<byte>)) && e.BufferList == null)
		{
			throw new NullReferenceException("Either e.Buffer or e.BufferList must be valid buffers.");
		}
		if (e.BufferList != null)
		{
			InitSocketAsyncEventArgs(e, SendAsyncCallback, e, SocketOperation.SendGeneric);
			e.socket_async_result.Buffers = e.BufferList;
			QueueIOSelectorJob(WriteSem, e.socket_async_result.Handle, new IOSelectorJob(IOOperation.Write, BeginSendGenericCallback, e.socket_async_result));
		}
		else
		{
			InitSocketAsyncEventArgs(e, SendAsyncCallback, e, SocketOperation.Send);
			e.socket_async_result.Buffer = e.MemoryBuffer;
			e.socket_async_result.Offset = e.Offset;
			e.socket_async_result.Size = e.Count;
			QueueIOSelectorJob(WriteSem, e.socket_async_result.Handle, new IOSelectorJob(IOOperation.Write, delegate(IOAsyncResult s)
			{
				BeginSendCallback((SocketAsyncResult)s, 0);
			}, e.socket_async_result));
		}
		return true;
	}

	public IAsyncResult BeginSend(byte[] buffer, int offset, int size, SocketFlags socketFlags, out SocketError errorCode, AsyncCallback callback, object state)
	{
		ThrowIfDisposedAndClosed();
		ThrowIfBufferNull(buffer);
		ThrowIfBufferOutOfRange(buffer, offset, size);
		if (!is_connected)
		{
			errorCode = SocketError.NotConnected;
			return null;
		}
		errorCode = SocketError.Success;
		SocketAsyncResult socketAsyncResult = new SocketAsyncResult(this, callback, state, SocketOperation.Send)
		{
			Buffer = buffer,
			Offset = offset,
			Size = size,
			SockFlags = socketFlags
		};
		QueueIOSelectorJob(WriteSem, socketAsyncResult.Handle, new IOSelectorJob(IOOperation.Write, delegate(IOAsyncResult s)
		{
			BeginSendCallback((SocketAsyncResult)s, 0);
		}, socketAsyncResult));
		return socketAsyncResult;
	}

	private unsafe static void BeginSendCallback(SocketAsyncResult sockares, int sent_so_far)
	{
		int num = 0;
		try
		{
			using MemoryHandle memoryHandle = sockares.Buffer.Slice(sockares.Offset, sockares.Size).Pin();
			num = Send_internal(sockares.socket.m_Handle, (byte*)memoryHandle.Pointer, sockares.Size, sockares.SockFlags, out sockares.error, blocking: false);
		}
		catch (Exception e)
		{
			sockares.Complete(e);
			return;
		}
		if (sockares.error == 0)
		{
			sent_so_far += num;
			sockares.Offset += num;
			sockares.Size -= num;
			if (sockares.socket.CleanedUp)
			{
				sockares.Complete(sent_so_far);
				return;
			}
			if (sockares.Size > 0)
			{
				IOSelector.Add(sockares.Handle, new IOSelectorJob(IOOperation.Write, delegate(IOAsyncResult s)
				{
					BeginSendCallback((SocketAsyncResult)s, sent_so_far);
				}, sockares));
				return;
			}
			sockares.Total = sent_so_far;
		}
		sockares.Complete(sent_so_far);
	}

	public int EndSend(IAsyncResult asyncResult, out SocketError errorCode)
	{
		ThrowIfDisposedAndClosed();
		SocketAsyncResult socketAsyncResult = ValidateEndIAsyncResult(asyncResult, "EndSend", "asyncResult");
		if (!socketAsyncResult.IsCompleted)
		{
			socketAsyncResult.AsyncWaitHandle.WaitOne();
		}
		errorCode = socketAsyncResult.ErrorCode;
		if (errorCode != SocketError.Success && errorCode != SocketError.WouldBlock && errorCode != SocketError.InProgress)
		{
			is_connected = false;
		}
		if (errorCode == SocketError.Success)
		{
			socketAsyncResult.CheckIfThrowDelayedException();
		}
		return socketAsyncResult.Total;
	}

	private unsafe static int Send_internal(SafeSocketHandle safeHandle, WSABUF* bufarray, int count, SocketFlags flags, out int error, bool blocking)
	{
		try
		{
			safeHandle.RegisterForBlockingSyscall();
			return Send_array_icall(safeHandle.DangerousGetHandle(), bufarray, count, flags, out error, blocking);
		}
		finally
		{
			safeHandle.UnRegisterForBlockingSyscall();
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern int Send_array_icall(IntPtr sock, WSABUF* bufarray, int count, SocketFlags flags, out int error, bool blocking);

	private unsafe static int Send_internal(SafeSocketHandle safeHandle, byte* buffer, int count, SocketFlags flags, out int error, bool blocking)
	{
		try
		{
			safeHandle.RegisterForBlockingSyscall();
			return Send_icall(safeHandle.DangerousGetHandle(), buffer, count, flags, out error, blocking);
		}
		finally
		{
			safeHandle.UnRegisterForBlockingSyscall();
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern int Send_icall(IntPtr sock, byte* buffer, int count, SocketFlags flags, out int error, bool blocking);

	public unsafe int SendTo(byte[] buffer, int offset, int size, SocketFlags socketFlags, EndPoint remoteEP)
	{
		ThrowIfDisposedAndClosed();
		ThrowIfBufferNull(buffer);
		ThrowIfBufferOutOfRange(buffer, offset, size);
		if (remoteEP == null)
		{
			throw new ArgumentNullException("remoteEP");
		}
		int result;
		int error;
		fixed (byte* ptr = buffer)
		{
			result = SendTo_internal(m_Handle, ptr + offset, size, socketFlags, remoteEP.Serialize(), out error, is_blocking);
		}
		SocketError socketError = (SocketError)error;
		if (socketError != SocketError.Success)
		{
			if (socketError != SocketError.WouldBlock && socketError != SocketError.InProgress)
			{
				is_connected = false;
			}
			throw new SocketException(error);
		}
		is_connected = true;
		is_bound = true;
		seed_endpoint = remoteEP;
		return result;
	}

	private unsafe int SendTo(Memory<byte> buffer, int offset, int size, SocketFlags socketFlags, EndPoint remoteEP)
	{
		ThrowIfDisposedAndClosed();
		if (remoteEP == null)
		{
			throw new ArgumentNullException("remoteEP");
		}
		int result;
		int error;
		using (MemoryHandle memoryHandle = buffer.Slice(offset, size).Pin())
		{
			result = SendTo_internal(m_Handle, (byte*)memoryHandle.Pointer, size, socketFlags, remoteEP.Serialize(), out error, is_blocking);
		}
		SocketError socketError = (SocketError)error;
		if (socketError != SocketError.Success)
		{
			if (socketError != SocketError.WouldBlock && socketError != SocketError.InProgress)
			{
				is_connected = false;
			}
			throw new SocketException(error);
		}
		is_connected = true;
		is_bound = true;
		seed_endpoint = remoteEP;
		return result;
	}

	public bool SendToAsync(SocketAsyncEventArgs e)
	{
		ThrowIfDisposedAndClosed();
		if (e.BufferList != null)
		{
			throw new NotSupportedException("Mono doesn't support using BufferList at this point.");
		}
		if (e.RemoteEndPoint == null)
		{
			throw new ArgumentNullException("remoteEP", "Value cannot be null.");
		}
		InitSocketAsyncEventArgs(e, SendToAsyncCallback, e, SocketOperation.SendTo);
		e.socket_async_result.Buffer = e.Buffer;
		e.socket_async_result.Offset = e.Offset;
		e.socket_async_result.Size = e.Count;
		e.socket_async_result.SockFlags = e.SocketFlags;
		e.socket_async_result.EndPoint = e.RemoteEndPoint;
		QueueIOSelectorJob(WriteSem, e.socket_async_result.Handle, new IOSelectorJob(IOOperation.Write, delegate(IOAsyncResult s)
		{
			BeginSendToCallback((SocketAsyncResult)s, 0);
		}, e.socket_async_result));
		return true;
	}

	private static void BeginSendToCallback(SocketAsyncResult sockares, int sent_so_far)
	{
		int num = 0;
		try
		{
			num = sockares.socket.SendTo(sockares.Buffer, sockares.Offset, sockares.Size, sockares.SockFlags, sockares.EndPoint);
			if (sockares.error == 0)
			{
				sent_so_far += num;
				sockares.Offset += num;
				sockares.Size -= num;
			}
			if (sockares.Size > 0)
			{
				IOSelector.Add(sockares.Handle, new IOSelectorJob(IOOperation.Write, delegate(IOAsyncResult s)
				{
					BeginSendToCallback((SocketAsyncResult)s, sent_so_far);
				}, sockares));
				return;
			}
			sockares.Total = sent_so_far;
		}
		catch (Exception e)
		{
			sockares.Complete(e);
			return;
		}
		sockares.Complete();
	}

	public int EndSendTo(IAsyncResult asyncResult)
	{
		ThrowIfDisposedAndClosed();
		SocketAsyncResult socketAsyncResult = ValidateEndIAsyncResult(asyncResult, "EndSendTo", "result");
		if (!socketAsyncResult.IsCompleted)
		{
			socketAsyncResult.AsyncWaitHandle.WaitOne();
		}
		socketAsyncResult.CheckIfThrowDelayedException();
		return socketAsyncResult.Total;
	}

	private unsafe static int SendTo_internal(SafeSocketHandle safeHandle, byte* buffer, int count, SocketFlags flags, SocketAddress sa, out int error, bool blocking)
	{
		try
		{
			safeHandle.RegisterForBlockingSyscall();
			return SendTo_icall(safeHandle.DangerousGetHandle(), buffer, count, flags, sa, out error, blocking);
		}
		finally
		{
			safeHandle.UnRegisterForBlockingSyscall();
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern int SendTo_icall(IntPtr sock, byte* buffer, int count, SocketFlags flags, SocketAddress sa, out int error, bool blocking);

	public object GetSocketOption(SocketOptionLevel optionLevel, SocketOptionName optionName)
	{
		ThrowIfDisposedAndClosed();
		GetSocketOption_obj_internal(m_Handle, optionLevel, optionName, out var obj_val, out var error);
		if (error != 0)
		{
			throw new SocketException(error);
		}
		switch (optionName)
		{
		case SocketOptionName.Linger:
			return (LingerOption)obj_val;
		case SocketOptionName.AddMembership:
		case SocketOptionName.DropMembership:
			return (MulticastOption)obj_val;
		default:
			if (obj_val is int)
			{
				return (int)obj_val;
			}
			return obj_val;
		}
	}

	private static void GetSocketOption_obj_internal(SafeSocketHandle safeHandle, SocketOptionLevel level, SocketOptionName name, out object obj_val, out int error)
	{
		bool success = false;
		try
		{
			safeHandle.DangerousAddRef(ref success);
			GetSocketOption_obj_icall(safeHandle.DangerousGetHandle(), level, name, out obj_val, out error);
		}
		finally
		{
			if (success)
			{
				safeHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetSocketOption_obj_icall(IntPtr socket, SocketOptionLevel level, SocketOptionName name, out object obj_val, out int error);

	public void SetSocketOption(SocketOptionLevel optionLevel, SocketOptionName optionName, bool optionValue)
	{
		int optionValue2 = (optionValue ? 1 : 0);
		SetSocketOption(optionLevel, optionName, optionValue2);
	}

	public void SetSocketOption(SocketOptionLevel optionLevel, SocketOptionName optionName, int optionValue)
	{
		ThrowIfDisposedAndClosed();
		SetSocketOption_internal(m_Handle, optionLevel, optionName, null, null, optionValue, out var error);
		switch (error)
		{
		case 10022:
			throw new ArgumentException();
		default:
			throw new SocketException(error);
		case 0:
			break;
		}
	}

	private static void SetSocketOption_internal(SafeSocketHandle safeHandle, SocketOptionLevel level, SocketOptionName name, object obj_val, byte[] byte_val, int int_val, out int error)
	{
		bool success = false;
		try
		{
			safeHandle.DangerousAddRef(ref success);
			SetSocketOption_icall(safeHandle.DangerousGetHandle(), level, name, obj_val, byte_val, int_val, out error);
		}
		finally
		{
			if (success)
			{
				safeHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetSocketOption_icall(IntPtr socket, SocketOptionLevel level, SocketOptionName name, object obj_val, byte[] byte_val, int int_val, out int error);

	public int IOControl(int ioControlCode, byte[] optionInValue, byte[] optionOutValue)
	{
		if (CleanedUp)
		{
			throw new ObjectDisposedException(GetType().ToString());
		}
		int num = IOControl_internal(m_Handle, ioControlCode, optionInValue, optionOutValue, out var error);
		if (error != 0)
		{
			throw new SocketException(error);
		}
		if (num == -1)
		{
			throw new InvalidOperationException("Must use Blocking property instead.");
		}
		return num;
	}

	private static int IOControl_internal(SafeSocketHandle safeHandle, int ioctl_code, byte[] input, byte[] output, out int error)
	{
		bool success = false;
		try
		{
			safeHandle.DangerousAddRef(ref success);
			return IOControl_icall(safeHandle.DangerousGetHandle(), ioctl_code, input, output, out error);
		}
		finally
		{
			if (success)
			{
				safeHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int IOControl_icall(IntPtr sock, int ioctl_code, byte[] input, byte[] output, out int error);

	public void Close()
	{
		linger_timeout = 0;
		Dispose();
	}

	public void Close(int timeout)
	{
		linger_timeout = timeout;
		Dispose();
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern void Close_icall(IntPtr socket, out int error);

	public void Shutdown(SocketShutdown how)
	{
		ThrowIfDisposedAndClosed();
		if (!is_connected)
		{
			throw new SocketException(10057);
		}
		Shutdown_internal(m_Handle, how, out var error);
		if (error == 10057 || error == 0)
		{
			return;
		}
		throw new SocketException(error);
	}

	private static void Shutdown_internal(SafeSocketHandle safeHandle, SocketShutdown how, out int error)
	{
		bool success = false;
		try
		{
			safeHandle.DangerousAddRef(ref success);
			Shutdown_icall(safeHandle.DangerousGetHandle(), how, out error);
		}
		finally
		{
			if (success)
			{
				safeHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern void Shutdown_icall(IntPtr socket, SocketShutdown how, out int error);

	protected virtual void Dispose(bool disposing)
	{
		if (CleanedUp)
		{
			return;
		}
		m_IntCleanedUp = 1;
		bool flag = is_connected;
		is_connected = false;
		if (m_Handle != null)
		{
			is_closed = true;
			IntPtr handle = Handle;
			if (flag)
			{
				Linger(handle);
			}
			m_Handle.Dispose();
		}
	}

	private void Linger(IntPtr handle)
	{
		if (!is_connected || linger_timeout <= 0)
		{
			return;
		}
		Shutdown_icall(handle, SocketShutdown.Receive, out var error);
		if (error != 0)
		{
			return;
		}
		int num = linger_timeout / 1000;
		int num2 = linger_timeout % 1000;
		if (num2 > 0)
		{
			Poll_icall(handle, SelectMode.SelectRead, num2 * 1000, out error);
			if (error != 0)
			{
				return;
			}
		}
		if (num > 0)
		{
			LingerOption obj_val = new LingerOption(enable: true, num);
			SetSocketOption_icall(handle, SocketOptionLevel.Socket, SocketOptionName.Linger, obj_val, null, 0, out error);
		}
	}

	private void ThrowIfDisposedAndClosed()
	{
		if (CleanedUp && is_closed)
		{
			throw new ObjectDisposedException(GetType().ToString());
		}
	}

	private void ThrowIfBufferNull(byte[] buffer)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
	}

	private void ThrowIfBufferOutOfRange(byte[] buffer, int offset, int size)
	{
		if (offset < 0)
		{
			throw new ArgumentOutOfRangeException("offset", "offset must be >= 0");
		}
		if (offset > buffer.Length)
		{
			throw new ArgumentOutOfRangeException("offset", "offset must be <= buffer.Length");
		}
		if (size < 0)
		{
			throw new ArgumentOutOfRangeException("size", "size must be >= 0");
		}
		if (size > buffer.Length - offset)
		{
			throw new ArgumentOutOfRangeException("size", "size must be <= buffer.Length - offset");
		}
	}

	private void ThrowIfUdp()
	{
		if (protocolType == ProtocolType.Udp)
		{
			throw new SocketException(10042);
		}
	}

	private SocketAsyncResult ValidateEndIAsyncResult(IAsyncResult ares, string methodName, string argName)
	{
		if (ares == null)
		{
			throw new ArgumentNullException(argName);
		}
		SocketAsyncResult obj = (ares as SocketAsyncResult) ?? throw new ArgumentException("Invalid IAsyncResult", argName);
		if (Interlocked.CompareExchange(ref obj.EndCalled, 1, 0) == 1)
		{
			throw new InvalidOperationException(methodName + " can only be called once per asynchronous operation");
		}
		return obj;
	}

	private void QueueIOSelectorJob(SemaphoreSlim sem, IntPtr handle, IOSelectorJob job)
	{
		Task task = sem.WaitAsync();
		if (task.IsCompleted)
		{
			if (CleanedUp)
			{
				job.MarkDisposed();
			}
			else
			{
				IOSelector.Add(handle, job);
			}
			return;
		}
		task.ContinueWith(delegate
		{
			if (CleanedUp)
			{
				job.MarkDisposed();
			}
			else
			{
				IOSelector.Add(handle, job);
			}
		});
	}

	private void InitSocketAsyncEventArgs(SocketAsyncEventArgs e, AsyncCallback callback, object state, SocketOperation operation)
	{
		e.socket_async_result.Init(this, callback, state, operation);
		if (e.AcceptSocket != null)
		{
			e.socket_async_result.AcceptSocket = e.AcceptSocket;
		}
		e.SetCurrentSocket(this);
		e.SetLastOperation(SocketOperationToSocketAsyncOperation(operation));
		e.SocketError = SocketError.Success;
		e.SetBytesTransferred(0);
	}

	private SocketAsyncOperation SocketOperationToSocketAsyncOperation(SocketOperation op)
	{
		switch (op)
		{
		case SocketOperation.Connect:
			return SocketAsyncOperation.Connect;
		case SocketOperation.Accept:
			return SocketAsyncOperation.Accept;
		case SocketOperation.Disconnect:
			return SocketAsyncOperation.Disconnect;
		case SocketOperation.Receive:
		case SocketOperation.ReceiveGeneric:
			return SocketAsyncOperation.Receive;
		case SocketOperation.ReceiveFrom:
			return SocketAsyncOperation.ReceiveFrom;
		case SocketOperation.Send:
		case SocketOperation.SendGeneric:
			return SocketAsyncOperation.Send;
		case SocketOperation.SendTo:
			return SocketAsyncOperation.SendTo;
		default:
			throw new NotImplementedException($"Operation {op} is not implemented");
		}
	}

	private IPEndPoint RemapIPEndPoint(IPEndPoint input)
	{
		if (IsDualMode && input.AddressFamily == AddressFamily.InterNetwork)
		{
			return new IPEndPoint(input.Address.MapToIPv6(), input.Port);
		}
		return input;
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern void cancel_blocking_socket_operation(Thread thread);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool IsProtocolSupported_internal(NetworkInterfaceComponent networkInterface);

	private static bool IsProtocolSupported(NetworkInterfaceComponent networkInterface)
	{
		return IsProtocolSupported_internal(networkInterface);
	}
}
