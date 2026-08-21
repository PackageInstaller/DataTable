using System;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase;

public interface ILoadingService
{
	Task<DRLoadingTips> PrepareLoading(GameProcessType loadingType);

	Sprite GetBgSprite();

	void LoadingEnd(bool isSuccess);

	bool IsLoading();

	GameProcessType GetGameProcess();

	void ResetOuter();

	UniTask BacktiTitle(string sceneName, Func<bool, UniTask> loadTask = null);
}
