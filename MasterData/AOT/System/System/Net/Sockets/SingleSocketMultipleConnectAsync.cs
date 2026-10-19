namespace System.Net.Sockets;

internal sealed class SingleSocketMultipleConnectAsync : MultipleConnectAsync
{
	private Socket _socket;

	private bool _userSocket;

	public SingleSocketMultipleConnectAsync(Socket socket, bool userSocket)
	{
		_socket = socket;
		_userSocket = userSocket;
	}

	protected override IPAddress GetNextAddress(out Socket attemptSocket)
	{
		_socket.ReplaceHandleIfNecessaryAfterFailedConnect();
		IPAddress iPAddress = null;
		do
		{
			if (_nextAddress >= _addressList.Length)
			{
				attemptSocket = null;
				return null;
			}
			iPAddress = _addressList[_nextAddress];
			_nextAddress++;
		}
		while (!_socket.CanTryAddressFamily(iPAddress.AddressFamily));
		attemptSocket = _socket;
		return iPAddress;
	}

	protected override void OnFail(bool abortive)
	{
		if (abortive || !_userSocket)
		{
			_socket.Dispose();
		}
	}

	protected override void OnSucceed()
	{
	}
}
