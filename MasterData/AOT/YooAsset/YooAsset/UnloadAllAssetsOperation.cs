using UnityEngine;

namespace YooAsset;

public sealed class UnloadAllAssetsOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		CheckOptions,
		ReleaseAll,
		AbortDownload,
		CheckLoading,
		DestroyAll,
		Done
	}

	private readonly ResourceManager _resManager;

	private readonly UnloadAllAssetsOptions _options;

	private ESteps _steps;

	internal UnloadAllAssetsOperation(ResourceManager resourceManager, UnloadAllAssetsOptions options)
	{
		_resManager = resourceManager;
		_options = options;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.CheckOptions;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.CheckOptions)
		{
			if (_options == null)
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "UnloadAllAssetsOptions is null.";
				return;
			}
			if (_options.LockLoadOperation)
			{
				_resManager.LockLoadOperation = true;
			}
			_steps = ESteps.ReleaseAll;
		}
		if (_steps == ESteps.ReleaseAll)
		{
			_resManager.SceneHandles.Clear();
			if (_options.ReleaseAllHandles)
			{
				foreach (ProviderOperation value in _resManager.ProviderDic.Values)
				{
					value.ReleaseAllHandles();
				}
			}
			_steps = ESteps.AbortDownload;
		}
		if (_steps == ESteps.AbortDownload)
		{
			foreach (LoadBundleFileOperation value2 in _resManager.LoaderDic.Values)
			{
				value2.AbortOperation();
			}
			_steps = ESteps.CheckLoading;
		}
		if (_steps == ESteps.CheckLoading)
		{
			foreach (ProviderOperation value3 in _resManager.ProviderDic.Values)
			{
				if (!value3.IsDone)
				{
					return;
				}
			}
			_steps = ESteps.DestroyAll;
		}
		if (_steps != ESteps.DestroyAll)
		{
			return;
		}
		foreach (ProviderOperation value4 in _resManager.ProviderDic.Values)
		{
			value4.DestroyProvider();
		}
		foreach (LoadBundleFileOperation value5 in _resManager.LoaderDic.Values)
		{
			value5.DestroyLoader();
		}
		_resManager.ProviderDic.Clear();
		_resManager.LoaderDic.Clear();
		_resManager.LockLoadOperation = false;
		Resources.UnloadUnusedAssets();
		_steps = ESteps.Done;
		Status = EOperationStatus.Succeed;
	}
}
