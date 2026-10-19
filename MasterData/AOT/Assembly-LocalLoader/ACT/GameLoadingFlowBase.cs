using System;
using UnityEngine;

namespace ACT;

public abstract class GameLoadingFlowBase : FlowLogger
{
	protected EGameLoadingState _loadState;

	internal EGameLoadingState LoadState => _loadState;

	internal bool CanRetry => TotalRetryCount > RetryCount;

	internal virtual int TotalRetryCount => 0;

	internal int RetryCount { get; set; }

	internal abstract EGameLoadingStage Stage { get; }

	internal virtual void Init(GameLoadingData data)
	{
		_loadState = EGameLoadingState.Succeed;
	}

	internal virtual void Retry()
	{
		throw new Exception("LoadBase.Retry() is not implemented");
	}

	internal virtual void Update()
	{
		throw new Exception("LoadBase.Update() is not implemented");
	}

	internal override void Log(string message)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log(message);
		}
	}

	internal override void Warning(string message)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning(message);
		}
	}

	internal override void Error(string message)
	{
		Debug.LogError(message);
		_loadState = EGameLoadingState.Failed;
	}

	internal override void Exception(Exception exception)
	{
		Debug.LogException(exception);
		_loadState = EGameLoadingState.Failed;
		OnException();
	}

	internal virtual void OnException()
	{
	}
}
