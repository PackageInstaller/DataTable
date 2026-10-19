using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace YooAsset;

internal abstract class ProviderOperation : AsyncOperationBase
{
	protected enum ESteps
	{
		None,
		StartBundleLoader,
		WaitBundleLoader,
		ProcessBundleResult,
		Done
	}

	private ESteps _steps;

	private readonly LoadBundleFileOperation _mainBundleLoader;

	private readonly List<LoadBundleFileOperation> _bundleLoaders = new List<LoadBundleFileOperation>(10);

	private readonly HashSet<HandleBase> _handles = new HashSet<HandleBase>();

	public string SpawnScene = string.Empty;

	public string ProviderGUID { get; private set; }

	public AssetInfo MainAssetInfo { get; private set; }

	public UnityEngine.Object AssetObject { get; protected set; }

	public UnityEngine.Object[] AllAssetObjects { get; protected set; }

	public UnityEngine.Object[] SubAssetObjects { get; protected set; }

	public Scene SceneObject { get; protected set; }

	public BundleResult BundleResultObject { get; protected set; }

	public string SceneName { get; protected set; }

	public int RefCount { get; private set; }

	public bool IsDestroyed { get; private set; }

	public ProviderOperation(ResourceManager manager, string providerGUID, AssetInfo assetInfo)
	{
		ProviderGUID = providerGUID;
		MainAssetInfo = assetInfo;
		if (string.IsNullOrEmpty(providerGUID))
		{
			return;
		}
		_mainBundleLoader = manager.CreateMainBundleFileLoader(assetInfo);
		_mainBundleLoader.AddProvider(this);
		_bundleLoaders.Add(_mainBundleLoader);
		List<LoadBundleFileOperation> list = manager.CreateDependBundleFileLoaders(assetInfo);
		if (list.Count > 0)
		{
			_bundleLoaders.AddRange(list);
		}
		foreach (LoadBundleFileOperation bundleLoader in _bundleLoaders)
		{
			bundleLoader.Reference();
		}
	}

	internal override void InternalStart()
	{
		_steps = ESteps.StartBundleLoader;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.StartBundleLoader)
		{
			foreach (LoadBundleFileOperation bundleLoader in _bundleLoaders)
			{
				bundleLoader.StartOperation();
				AddChildOperation(bundleLoader);
			}
			_steps = ESteps.WaitBundleLoader;
		}
		if (_steps == ESteps.WaitBundleLoader)
		{
			if (IsWaitForAsyncComplete)
			{
				foreach (LoadBundleFileOperation bundleLoader2 in _bundleLoaders)
				{
					bundleLoader2.WaitForAsyncComplete();
				}
			}
			foreach (LoadBundleFileOperation bundleLoader3 in _bundleLoaders)
			{
				bundleLoader3.UpdateOperation();
			}
			foreach (LoadBundleFileOperation bundleLoader4 in _bundleLoaders)
			{
				if (!bundleLoader4.IsDone)
				{
					return;
				}
				if (bundleLoader4.Status != EOperationStatus.Succeed)
				{
					InvokeCompletion(bundleLoader4.Error, EOperationStatus.Failed);
					return;
				}
			}
			BundleResultObject = _mainBundleLoader.Result;
			if (BundleResultObject == null)
			{
				string error = "Loaded bundle result is null !";
				InvokeCompletion(error, EOperationStatus.Failed);
				return;
			}
			_steps = ESteps.ProcessBundleResult;
		}
		if (_steps == ESteps.ProcessBundleResult)
		{
			ProcessBundleResult();
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
		return "AssetPath : " + MainAssetInfo.AssetPath;
	}

	protected abstract void ProcessBundleResult();

	public void DestroyProvider()
	{
		IsDestroyed = true;
		if (!IsDone)
		{
			Error = "User abort !";
			Status = EOperationStatus.Failed;
		}
		foreach (LoadBundleFileOperation bundleLoader in _bundleLoaders)
		{
			bundleLoader.Release();
		}
	}

	public bool CanDestroyProvider()
	{
		if (_steps == ESteps.ProcessBundleResult)
		{
			return false;
		}
		return RefCount <= 0;
	}

	public T CreateHandle<T>() where T : HandleBase
	{
		RefCount++;
		HandleBase handleBase = HandleFactory.CreateHandle(this, typeof(T));
		_handles.Add(handleBase);
		return handleBase as T;
	}

	public void ReleaseHandle(HandleBase handle)
	{
		if (RefCount <= 0)
		{
			throw new Exception("Should never get here !");
		}
		if (!_handles.Remove(handle))
		{
			throw new Exception("Should never get here !");
		}
		RefCount--;
	}

	public void ReleaseAllHandles()
	{
		foreach (HandleBase item in _handles.ToList())
		{
			item.Release();
		}
	}

	protected void InvokeCompletion(string error, EOperationStatus status)
	{
		_steps = ESteps.Done;
		Error = error;
		Status = status;
		foreach (HandleBase item in _handles.ToList())
		{
			if (item.IsValid)
			{
				item.InvokeCallback();
			}
		}
	}

	public DownloadStatus GetDownloadStatus()
	{
		DownloadStatus result = default;
		foreach (LoadBundleFileOperation bundleLoader in _bundleLoaders)
		{
			result.TotalBytes += bundleLoader.LoadBundleInfo.Bundle.FileSize;
			result.DownloadedBytes += bundleLoader.DownloadedBytes;
		}
		if (result.TotalBytes == 0L)
		{
			throw new Exception("Should never get here !");
		}
		result.IsDone = result.DownloadedBytes == result.TotalBytes;
		result.Progress = (float)result.DownloadedBytes / (float)result.TotalBytes;
		return result;
	}

	[Conditional("DEBUG")]
	public void InitProviderDebugInfo()
	{
		SpawnScene = SceneManager.GetActiveScene().name;
	}

	internal List<string> GetDebugDependBundles()
	{
		List<string> list = new List<string>(_bundleLoaders.Count);
		foreach (LoadBundleFileOperation bundleLoader in _bundleLoaders)
		{
			PackageBundle bundle = bundleLoader.LoadBundleInfo.Bundle;
			list.Add(bundle.BundleName);
		}
		return list;
	}
}
