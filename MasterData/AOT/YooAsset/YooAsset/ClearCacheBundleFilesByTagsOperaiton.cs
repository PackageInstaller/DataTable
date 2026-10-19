using System.Collections.Generic;

namespace YooAsset;

internal class ClearCacheBundleFilesByTagsOperaiton : FSClearCacheFilesOperation
{
	private enum ESteps
	{
		None,
		CheckManifest,
		CheckArgs,
		GetClearCacheFiles,
		ClearFilterCacheFiles,
		Done
	}

	private readonly DefaultCacheFileSystem _fileSystem;

	private readonly PackageManifest _manifest;

	private readonly object _clearParam;

	private string[] _tags;

	private List<string> _clearBundleGUIDs;

	private int _clearFileTotalCount;

	private ESteps _steps;

	internal ClearCacheBundleFilesByTagsOperaiton(DefaultCacheFileSystem fileSystem, PackageManifest manifest, object clearParam)
	{
		_fileSystem = fileSystem;
		_manifest = manifest;
		_clearParam = clearParam;
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
				_steps = ESteps.CheckArgs;
			}
		}
		if (_steps == ESteps.CheckArgs)
		{
			if (_clearParam == null)
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "Clear param is null !";
				return;
			}
			if (_clearParam is string)
			{
				_tags = new string[1] { _clearParam as string };
			}
			else if (_clearParam is List<string>)
			{
				List<string> list = _clearParam as List<string>;
				_tags = list.ToArray();
			}
			else
			{
				if (!(_clearParam is string[]))
				{
					_steps = ESteps.Done;
					Status = EOperationStatus.Failed;
					Error = "Invalid clear param : " + _clearParam.GetType().FullName;
					return;
				}
				_tags = _clearParam as string[];
			}
			_steps = ESteps.GetClearCacheFiles;
		}
		if (_steps == ESteps.GetClearCacheFiles)
		{
			_clearBundleGUIDs = GetBundleGUIDsByTag();
			_clearFileTotalCount = _clearBundleGUIDs.Count;
			_steps = ESteps.ClearFilterCacheFiles;
		}
		if (_steps != ESteps.ClearFilterCacheFiles)
		{
			return;
		}
		for (int num = _clearBundleGUIDs.Count - 1; num >= 0; num--)
		{
			string bundleGUID = _clearBundleGUIDs[num];
			_fileSystem.DeleteCacheBundleFile(bundleGUID);
			_clearBundleGUIDs.RemoveAt(num);
			if (OperationSystem.IsBusy)
			{
				break;
			}
		}
		if (_clearFileTotalCount == 0)
		{
			Progress = 1f;
		}
		else
		{
			Progress = 1f - (float)(_clearBundleGUIDs.Count / _clearFileTotalCount);
		}
		if (_clearBundleGUIDs.Count == 0)
		{
			_steps = ESteps.Done;
			Status = EOperationStatus.Succeed;
		}
	}

	private List<string> GetBundleGUIDsByTag()
	{
		List<string> allCachedBundleGUIDs = _fileSystem.GetAllCachedBundleGUIDs();
		List<string> list = new List<string>(allCachedBundleGUIDs.Count);
		foreach (string item in allCachedBundleGUIDs)
		{
			if (_manifest.TryGetPackageBundleByBundleGUID(item, out var result) && result.HasTag(_tags))
			{
				list.Add(item);
			}
		}
		return list;
	}
}
