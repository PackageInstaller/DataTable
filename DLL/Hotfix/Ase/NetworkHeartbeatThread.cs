#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Threading;
using Cysharp.Threading.Tasks;
using GameFramework;

namespace Ase;

public class NetworkHeartbeatThread : IDisposable
{
	private CancellationTokenSource _cts;

	private readonly int _intervalMs;

	private readonly Action _onHeartbeat;

	private bool _isRunning;

	private bool _disposed;

	public NetworkHeartbeatThread(int intervalMs, Action onHeartbeat)
	{
		if (intervalMs <= 0)
		{
			throw new ArgumentOutOfRangeException("intervalMs", "心跳间隔必须大于0");
		}
		_intervalMs = intervalMs;
		_onHeartbeat = onHeartbeat ?? throw new ArgumentNullException("onHeartbeat");
	}

	public void Start()
	{
		if (!_isRunning && !_disposed)
		{
			_isRunning = true;
			_cts = new CancellationTokenSource();
			RunHeartbeatLoop().Forget();
		}
	}

	public void Stop()
	{
		if (_isRunning && !_disposed)
		{
			_isRunning = false;
			_cts?.Cancel();
			_cts?.Dispose();
			_cts = null;
		}
	}

	private async UniTaskVoid RunHeartbeatLoop()
	{
		while (_isRunning && !_cts.Token.IsCancellationRequested)
		{
			try
			{
				_onHeartbeat?.Invoke();
			}
			catch (Exception arg)
			{
				Log.Error($"心跳回调执行出错: {arg}");
			}
			await UniTask.Delay(_intervalMs, ignoreTimeScale: false, PlayerLoopTiming.Update, _cts.Token);
		}
	}

	public void Dispose()
	{
		if (!_disposed)
		{
			_disposed = true;
			Stop();
		}
	}
}
