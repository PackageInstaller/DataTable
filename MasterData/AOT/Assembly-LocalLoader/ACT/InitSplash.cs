using ACT.LocalLoader;
using UnityEngine;

namespace ACT;

internal class InitSplash : GameLoadingFlowBase
{
	private Animator _animator;

	private GameLoadingData _loadingData;

	internal override int TotalRetryCount => 0;

	internal override EGameLoadingStage Stage => EGameLoadingStage.SplashImage;

	public InitSplash(Animator animator, MonoHotUpdate monoHotUpdate)
	{
		_animator = animator;
		monoHotUpdate.OnSplashScreenFinished();
	}

	internal override void Init(GameLoadingData data)
	{
		_loadingData = data;
		if (_animator == null)
		{
			Error("Splash Animator is null");
		}
		else
		{
			_loadState = EGameLoadingState.Loading;
		}
	}

	internal override void Update()
	{
		_loadState = EGameLoadingState.Succeed;
	}
}
