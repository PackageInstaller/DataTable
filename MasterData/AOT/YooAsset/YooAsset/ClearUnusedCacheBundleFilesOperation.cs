using System.Collections.Generic;

namespace YooAsset;

internal sealed class ClearUnusedCacheBundleFilesOperation : FSClearCacheFilesOperation
{
	private enum ESteps
	{
		None,
		CheckManifest,
		GetUnusedCacheFiles,
		ClearUnusedCacheFiles,
		Done
	}

	private readonly DefaultCacheFileSystem _fileSystem;

	private readonly PackageManifest _manifest;

	private List<string> _unusedBundleGUIDs;

	private int _unusedFileTotalCount;

	private ESteps _steps;

	internal ClearUnusedCacheBundleFilesOperation(DefaultCacheFileSystem fileSystem, PackageManifest manifest)
	{
		_fileSystem = fileSystem;
		_manifest = manifest;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.CheckManifest;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.CheckManifest)
		{
			if (_manifest == null)
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "Can not found active package manifest !";
			}
			else
			{
				_steps = ESteps.GetUnusedCacheFiles;
			}
		}
		if (_steps == ESteps.GetUnusedCacheFiles)
		{
			_unusedBundleGUIDs = GetUnusedBundleGUIDs();
			_unusedFileTotalCount = _unusedBundleGUIDs.Count;
			_steps = ESteps.ClearUnusedCacheFiles;
		}
		if (_steps != ESteps.ClearUnusedCacheFiles)
		{
			return;
		}
		for (int num = _unusedBundleGUIDs.Count - 1; num >= 0; num--)
		{
			string bundleGUID = _unusedBundleGUIDs[num];
			_fileSystem.DeleteCacheBundleFile(bundleGUID);
			_unusedBundleGUIDs.RemoveAt(num);
			if (OperationSystem.IsBusy)
			{
				break;
			}
		}
		if (_unusedFileTotalCount == 0)
		{
			Progress = 1f;
		}
		else
		{
			Progress = 1f - (float)(_unusedBundleGUIDs.Count / _unusedFileTotalCount);
		}
		if (_unusedBundleGUIDs.Count == 0)
		{
			_steps = ESteps.Done;
			Status = EOperationStatus.Succeed;
		}
	}

	private List<string> GetUnusedBundleGUIDs()
	{
		List<string> allCachedBundleGUIDs = _fileSystem.GetAllCachedBundleGUIDs();
		List<string> list = new List<string>(allCachedBundleGUIDs.Count);
		foreach (string item in allCachedBundleGUIDs)
		{
			if (!_manifest.IsIncludeBundleFile(item))
			{
				list.Add(item);
			}
		}
		return list;
	}
}
