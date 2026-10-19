using System;
using System.Collections.Generic;

namespace YooAsset;

internal class LoadBundleFileOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		CheckConcurrency,
		LoadBundleFile,
		Done
	}

	private readonly ResourceManager _resourceManager;

	private readonly List<ProviderOperation> _providers = new List<ProviderOperation>(100);

	private readonly List<ProviderOperation> _removeList = new List<ProviderOperation>(100);

	private FSLoadBundleOperation _loadBundleOp;

	private ESteps _steps;

	public BundleInfo LoadBundleInfo { get; private set; }

	public bool IsDestroyed { get; private set; }

	public int RefCount { get; private set; }

	public float DownloadProgress { get; set; }

	public long DownloadedBytes { get; set; }

	public BundleResult Result { get; set; }

	internal LoadBundleFileOperation(ResourceManager resourceManager, BundleInfo bundleInfo)
	{
		_resourceManager = resourceManager;
		LoadBundleInfo = bundleInfo;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.CheckConcurrency;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.CheckConcurrency)
		{
			if (IsWaitForAsyncComplete)
			{
				_steps = ESteps.LoadBundleFile;
			}
			else
			{
				if (_resourceManager.BundleLoadingIsBusy())
				{
					return;
				}
				_steps = ESteps.LoadBundleFile;
			}
		}
		if (_steps != ESteps.LoadBundleFile)
		{
			return;
		}
		if (_loadBundleOp == null)
		{
			_resourceManager.BundleLoadingCounter++;
			_loadBundleOp = LoadBundleInfo.LoadBundleFile();
			_loadBundleOp.StartOperation();
			AddChildOperation(_loadBundleOp);
		}
		if (IsWaitForAsyncComplete)
		{
			_loadBundleOp.WaitForAsyncComplete();
		}
		_loadBundleOp.UpdateOperation();
		DownloadProgress = _loadBundleOp.DownloadProgress;
		DownloadedBytes = _loadBundleOp.DownloadedBytes;
		if (!_loadBundleOp.IsDone)
		{
			return;
		}
		if (_loadBundleOp.Status == EOperationStatus.Succeed)
		{
			if (_loadBundleOp.Result == null)
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "The bundle loader result is null ! " + LoadBundleInfo.Bundle.BundleName;
			}
			else
			{
				_steps = ESteps.Done;
				Result = _loadBundleOp.Result;
				Status = EOperationStatus.Succeed;
			}
		}
		else
		{
			_steps = ESteps.Done;
			Status = EOperationStatus.Failed;
			Error = _loadBundleOp.Error;
		}
		_resourceManager.BundleLoadingCounter--;
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
		return "BundleName : " + LoadBundleInfo.Bundle.BundleName;
	}

	public void Reference()
	{
		RefCount++;
	}

	public void Release()
	{
		RefCount--;
	}

	public void DestroyLoader()
	{
		IsDestroyed = true;
		if (RefCount > 0)
		{
			throw new Exception("Bundle file loader ref is not zero : " + LoadBundleInfo.Bundle.BundleName);
		}
		if (!IsDone)
		{
			throw new Exception("Bundle file loader is not done : " + LoadBundleInfo.Bundle.BundleName);
		}
		if (Result != null)
		{
			Result.UnloadBundleFile();
		}
	}

	public bool CanDestroyLoader()
	{
		if (!IsDone)
		{
			return false;
		}
		if (RefCount > 0)
		{
			return false;
		}
		if (LoadBundleInfo.Bundle.ReferenceBundleIDs.Count > 0)
		{
			foreach (int referenceBundleID in LoadBundleInfo.Bundle.ReferenceBundleIDs)
			{
				if (!_resourceManager.CheckBundleDestroyed(referenceBundleID))
				{
					return false;
				}
			}
		}
		return true;
	}

	public void AddProvider(ProviderOperation provider)
	{
		if (!_providers.Contains(provider))
		{
			_providers.Add(provider);
		}
	}

	public void TryDestroyProviders()
	{
		_removeList.Clear();
		foreach (ProviderOperation provider in _providers)
		{
			if (provider.CanDestroyProvider())
			{
				_removeList.Add(provider);
			}
		}
		foreach (ProviderOperation remove in _removeList)
		{
			_providers.Remove(remove);
			remove.DestroyProvider();
		}
		if (_removeList.Count > 0)
		{
			_resourceManager.RemoveBundleProviders(_removeList);
			_removeList.Clear();
		}
	}
}
