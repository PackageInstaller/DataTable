using System.Collections.Generic;
using UnityEngine;

namespace ACT;

internal class GameLoadingManager
{
	private readonly Queue<GameLoadingFlowBase> _loadBases = new Queue<GameLoadingFlowBase>();

	private GameLoadingFlowBase _currentGameLoadingFlowBase;

	private GameLoadingData _gameLoadingData;

	internal GameLoadingManager()
	{
		_gameLoadingData = new GameLoadingData();
	}

	internal void AddFlow(GameLoadingFlowBase gameLoadingFlowBase)
	{
		_loadBases.Enqueue(gameLoadingFlowBase);
	}

	internal void Update()
	{
		if (_currentGameLoadingFlowBase == null)
		{
			if (_loadBases == null || _loadBases.Count == 0)
			{
				return;
			}
			_currentGameLoadingFlowBase = _loadBases.Dequeue();
			if (LuminApplication.LogEnabled)
			{
				Debug.Log(_currentGameLoadingFlowBase.Stage);
			}
		}
		if (_currentGameLoadingFlowBase.LoadState == EGameLoadingState.None)
		{
			_currentGameLoadingFlowBase.Init(_gameLoadingData);
			GameLoadingData.CurStage = _currentGameLoadingFlowBase.Stage;
		}
		if (_currentGameLoadingFlowBase.LoadState != EGameLoadingState.Waiting)
		{
			if (_currentGameLoadingFlowBase.LoadState == EGameLoadingState.Loading)
			{
				_currentGameLoadingFlowBase.Update();
			}
			if (_currentGameLoadingFlowBase.LoadState == EGameLoadingState.Failed && _currentGameLoadingFlowBase.CanRetry)
			{
				_currentGameLoadingFlowBase.Retry();
			}
			if (_currentGameLoadingFlowBase.LoadState == EGameLoadingState.Succeed)
			{
				_currentGameLoadingFlowBase = null;
			}
		}
	}

	internal void StopLoading()
	{
		_currentGameLoadingFlowBase = null;
		_loadBases.Clear();
	}

	internal void LoadingOver()
	{
	}
}
