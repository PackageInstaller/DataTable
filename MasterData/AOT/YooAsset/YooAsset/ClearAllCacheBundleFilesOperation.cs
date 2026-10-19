using System.Collections.Generic;

namespace YooAsset;

internal sealed class ClearAllCacheBundleFilesOperation : FSClearCacheFilesOperation
{
	private enum ESteps
	{
		None,
		GetAllCacheFiles,
		ClearAllCacheFiles,
		Done
	}

	private readonly DefaultCacheFileSystem _fileSystem;

	private List<string> _allBundleGUIDs;

	private int _fileTotalCount;

	private ESteps _steps;

	internal ClearAllCacheBundleFilesOperation(DefaultCacheFileSystem fileSystem)
	{
		_fileSystem = fileSystem;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.GetAllCacheFiles;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.GetAllCacheFiles)
		{
			_allBundleGUIDs = _fileSystem.GetAllCachedBundleGUIDs();
			_fileTotalCount = _allBundleGUIDs.Count;
			_steps = ESteps.ClearAllCacheFiles;
		}
		if (_steps != ESteps.ClearAllCacheFiles)
		{
			return;
		}
		for (int num = _allBundleGUIDs.Count - 1; num >= 0; num--)
		{
			string bundleGUID = _allBundleGUIDs[num];
			_fileSystem.DeleteCacheBundleFile(bundleGUID);
			_allBundleGUIDs.RemoveAt(num);
			if (OperationSystem.IsBusy)
			{
				break;
			}
		}
		if (_fileTotalCount == 0)
		{
			Progress = 1f;
		}
		else
		{
			Progress = 1f - (float)(_allBundleGUIDs.Count / _fileTotalCount);
		}
		if (_allBundleGUIDs.Count == 0)
		{
			_steps = ESteps.Done;
			Status = EOperationStatus.Succeed;
		}
	}
}
