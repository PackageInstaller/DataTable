using System;

namespace Proxima;

public class ProximaStatus
{
	private bool _isRunning;

	private string _connectInfo;

	private bool _listening;

	private int _connections;

	private string _error;

	public bool IsRunning => _isRunning;

	public string ConnectInfo => _connectInfo;

	public bool Listening => _listening;

	public int Connections => _connections;

	public string Error => _error;

	public event Action Changed;

	internal void Reset()
	{
		_isRunning = false;
		_connectInfo = null;
		_listening = false;
		_connections = 0;
		_error = null;
		Changed?.Invoke();
	}

	internal void SetRunning(bool running)
	{
		_isRunning = running;
		Changed?.Invoke();
	}

	internal void SetConnectInfo(string info)
	{
		_connectInfo = info;
		_listening = true;
		_error = null;
		Changed?.Invoke();
	}

	internal void SetError(string error)
	{
		_error = error;
		Changed?.Invoke();
	}

	internal void IncrementConnections()
	{
		_connections++;
		Changed?.Invoke();
	}

	internal void DecrementConnections()
	{
		if (_connections > 0)
		{
			_connections--;
			Changed?.Invoke();
		}
	}
}
