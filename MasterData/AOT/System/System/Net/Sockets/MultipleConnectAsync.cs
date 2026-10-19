using System.Runtime.ExceptionServices;

namespace System.Net.Sockets;

internal abstract class MultipleConnectAsync
{
	private enum State
	{
		NotStarted,
		DnsQuery,
		ConnectAttempt,
		Completed,
		Canceled
	}

	protected SocketAsyncEventArgs _userArgs;

	protected SocketAsyncEventArgs _internalArgs;

	protected DnsEndPoint _endPoint;

	protected IPAddress[] _addressList;

	protected int _nextAddress;

	private State _state;

	private object _lockObject = new object();

	public bool StartConnectAsync(SocketAsyncEventArgs args, DnsEndPoint endPoint)
	{
		lock (_lockObject)
		{
			if (endPoint.AddressFamily != AddressFamily.Unspecified && endPoint.AddressFamily != AddressFamily.InterNetwork && endPoint.AddressFamily != AddressFamily.InterNetworkV6)
			{
				NetEventSource.Fail(this, $"Unexpected endpoint address family: {endPoint.AddressFamily}", "StartConnectAsync");
			}
			_userArgs = args;
			_endPoint = endPoint;
			if (_state == State.Canceled)
			{
				SyncFail(new SocketException(995));
				return false;
			}
			if (_state != State.NotStarted)
			{
				NetEventSource.Fail(this, "MultipleConnectAsync.StartConnectAsync(): Unexpected object state", "StartConnectAsync");
			}
			_state = State.DnsQuery;
			IAsyncResult asyncResult = Dns.BeginGetHostAddresses(endPoint.Host, DnsCallback, null);
			if (asyncResult.CompletedSynchronously)
			{
				return DoDnsCallback(asyncResult, sync: true);
			}
			return true;
		}
	}

	private void DnsCallback(IAsyncResult result)
	{
		if (!result.CompletedSynchronously)
		{
			DoDnsCallback(result, sync: false);
		}
	}

	private bool DoDnsCallback(IAsyncResult result, bool sync)
	{
		Exception ex = null;
		lock (_lockObject)
		{
			if (_state == State.Canceled)
			{
				return true;
			}
			if (_state != State.DnsQuery)
			{
				NetEventSource.Fail(this, "MultipleConnectAsync.DoDnsCallback(): Unexpected object state", "DoDnsCallback");
			}
			try
			{
				_addressList = Dns.EndGetHostAddresses(result);
				if (_addressList == null)
				{
					NetEventSource.Fail(this, "MultipleConnectAsync.DoDnsCallback(): EndGetHostAddresses returned null!", "DoDnsCallback");
				}
			}
			catch (Exception ex2)
			{
				_state = State.Completed;
				ex = ex2;
			}
			if (ex == null)
			{
				_state = State.ConnectAttempt;
				_internalArgs = new SocketAsyncEventArgs();
				_internalArgs.Completed += InternalConnectCallback;
				_internalArgs.CopyBufferFrom(_userArgs);
				ex = AttemptConnection();
				if (ex != null)
				{
					_state = State.Completed;
				}
			}
		}
		if (ex != null)
		{
			return Fail(sync, ex);
		}
		return true;
	}

	private void InternalConnectCallback(object sender, SocketAsyncEventArgs args)
	{
		Exception ex = null;
		lock (_lockObject)
		{
			if (_state == State.Canceled)
			{
				ex = new SocketException(995);
			}
			else if (args.SocketError == SocketError.Success)
			{
				_state = State.Completed;
			}
			else if (args.SocketError == SocketError.OperationAborted)
			{
				ex = new SocketException(995);
				_state = State.Canceled;
			}
			else
			{
				SocketError socketError = args.SocketError;
				args.in_progress = 0;
				Exception ex2 = AttemptConnection();
				if (ex2 == null)
				{
					return;
				}
				ex = ((!(ex2 is SocketException { SocketErrorCode: SocketError.NoData })) ? ex2 : new SocketException((int)socketError));
				_state = State.Completed;
			}
		}
		if (ex == null)
		{
			Succeed();
		}
		else
		{
			AsyncFail(ex);
		}
	}

	private Exception AttemptConnection()
	{
		try
		{
			IPAddress nextAddress = GetNextAddress(out var attemptSocket);
			if (nextAddress == null)
			{
				return new SocketException(11004);
			}
			_internalArgs.RemoteEndPoint = new IPEndPoint(nextAddress, _endPoint.Port);
			return AttemptConnection(attemptSocket, _internalArgs);
		}
		catch (Exception ex)
		{
			if (ex is ObjectDisposedException)
			{
				NetEventSource.Fail(this, "unexpected ObjectDisposedException", "AttemptConnection");
			}
			return ex;
		}
	}

	private Exception AttemptConnection(Socket attemptSocket, SocketAsyncEventArgs args)
	{
		try
		{
			if (attemptSocket == null)
			{
				NetEventSource.Fail(null, "attemptSocket is null!", "AttemptConnection");
			}
			if (!attemptSocket.ConnectAsync(args))
			{
				InternalConnectCallback(null, args);
			}
		}
		catch (ObjectDisposedException)
		{
			return new SocketException(995);
		}
		catch (Exception result)
		{
			return result;
		}
		return null;
	}

	protected abstract void OnSucceed();

	private void Succeed()
	{
		OnSucceed();
		_userArgs.FinishWrapperConnectSuccess(_internalArgs.ConnectSocket, _internalArgs.BytesTransferred, _internalArgs.SocketFlags);
		_internalArgs.Dispose();
	}

	protected abstract void OnFail(bool abortive);

	private bool Fail(bool sync, Exception e)
	{
		if (sync)
		{
			SyncFail(e);
			return false;
		}
		AsyncFail(e);
		return true;
	}

	private void SyncFail(Exception e)
	{
		OnFail(abortive: false);
		if (_internalArgs != null)
		{
			_internalArgs.Dispose();
		}
		if (e is SocketException exception)
		{
			_userArgs.FinishConnectByNameSyncFailure(exception, 0, SocketFlags.None);
		}
		else
		{
			ExceptionDispatchInfo.Throw(e);
		}
	}

	private void AsyncFail(Exception e)
	{
		OnFail(abortive: false);
		if (_internalArgs != null)
		{
			_internalArgs.Dispose();
		}
		_userArgs.FinishOperationAsyncFailure(e, 0, SocketFlags.None);
	}

	protected abstract IPAddress GetNextAddress(out Socket attemptSocket);
}
