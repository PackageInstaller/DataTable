using System.Collections.Generic;

namespace YooAsset;

public sealed class UnloadUnusedAssetsOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		UnloadUnused,
		Done
	}

	private readonly ResourceManager _resManager;

	private readonly int _loopCount;

	private int _loopCounter;

	private ESteps _steps;

	internal UnloadUnusedAssetsOperation(ResourceManager resourceManager, int loopCount)
	{
		_resManager = resourceManager;
		_loopCount = loopCount;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.UnloadUnused;
		_loopCounter = _loopCount;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done || _steps != ESteps.UnloadUnused)
		{
			return;
		}
		while (_loopCounter > 0)
		{
			_loopCounter--;
			LoopUnloadUnused();
			if (!IsWaitForAsyncComplete && OperationSystem.IsBusy)
			{
				break;
			}
		}
		if (_loopCounter <= 0)
		{
			_steps = ESteps.Done;
			Status = EOperationStatus.Succeed;
		}
	}

	internal override void InternalWaitForAsyncComplete()
	{
		while (!ExecuteWhileDone())
		{
		}
		_steps = ESteps.Done;
	}

	internal override string InternalGetDesc()
	{
		return $"LoopCount : {_loopCount}";
	}

	private void LoopUnloadUnused()
	{
		List<LoadBundleFileOperation> list = new List<LoadBundleFileOperation>(_resManager.LoaderDic.Count);
		foreach (LoadBundleFileOperation value in _resManager.LoaderDic.Values)
		{
			value.TryDestroyProviders();
		}
		foreach (LoadBundleFileOperation value2 in _resManager.LoaderDic.Values)
		{
			if (value2.CanDestroyLoader())
			{
				list.Add(value2);
			}
		}
		foreach (LoadBundleFileOperation item in list)
		{
			string bundleName = item.LoadBundleInfo.Bundle.BundleName;
			item.DestroyLoader();
			_resManager.LoaderDic.Remove(bundleName);
		}
	}
}
