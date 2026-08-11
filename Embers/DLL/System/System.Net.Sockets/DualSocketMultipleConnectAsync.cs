namespace System.Net.Sockets;

internal sealed class DualSocketMultipleConnectAsync : MultipleConnectAsync
{
	private Socket _socket4;

	private Socket _socket6;

	public DualSocketMultipleConnectAsync(SocketType socketType, ProtocolType protocolType)
	{
		if (Socket.OSSupportsIPv4)
		{
			_socket4 = new Socket(AddressFamily.InterNetwork, socketType, protocolType);
		}
		if (Socket.OSSupportsIPv6)
		{
			_socket6 = new Socket(AddressFamily.InterNetworkV6, socketType, protocolType);
		}
	}

	protected override IPAddress GetNextAddress(out Socket attemptSocket)
	{
		IPAddress iPAddress = null;
		attemptSocket = null;
		while (attemptSocket == null)
		{
			if (_nextAddress >= _addressList.Length)
			{
				return null;
			}
			iPAddress = _addressList[_nextAddress];
			_nextAddress++;
			if (iPAddress.AddressFamily == AddressFamily.InterNetworkV6)
			{
				attemptSocket = _socket6;
			}
			else if (iPAddress.AddressFamily == AddressFamily.InterNetwork)
			{
				attemptSocket = _socket4;
			}
		}
		attemptSocket?.ReplaceHandleIfNecessaryAfterFailedConnect();
		return iPAddress;
	}

	protected override void OnSucceed()
	{
		if (_socket4 != null && !_socket4.Connected)
		{
			_socket4.Dispose();
		}
		if (_socket6 != null && !_socket6.Connected)
		{
			_socket6.Dispose();
		}
	}

	protected override void OnFail(bool abortive)
	{
		_socket4?.Dispose();
		_socket6?.Dispose();
	}
}
