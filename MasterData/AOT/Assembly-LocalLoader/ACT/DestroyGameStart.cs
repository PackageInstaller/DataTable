using ACT.LocalLoader;
using UnityEngine;

namespace ACT;

internal class DestroyGameStart : GameLoadingFlowBase
{
	private GameStart _gameStart;

	internal override EGameLoadingStage Stage => EGameLoadingStage.DestroyGameStart;

	internal override void Init(GameLoadingData data)
	{
		_loadState = EGameLoadingState.Loading;
		_gameStart = Object.FindObjectOfType<GameStart>();
		if ((bool)_gameStart)
		{
			Object.Destroy(_gameStart.gameObject);
			_loadState = EGameLoadingState.Succeed;
		}
		else
		{
			_loadState = EGameLoadingState.Failed;
		}
	}
}
