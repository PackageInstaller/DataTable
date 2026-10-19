using System.Collections.Generic;
using System.Linq;

namespace YooAsset;

public sealed class ClearCacheFilesOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		Prepare,
		ClearCacheFiles,
		CheckClearResult,
		Done
	}

	private readonly PlayModeImpl _impl;

	private readonly ClearCacheFilesOptions _options;

	private List<IFileSystem> _cloneList;

	private FSClearCacheFilesOperation _clearCacheFilesOp;

	private ESteps _steps;

	internal ClearCacheFilesOperation(PlayModeImpl impl, ClearCacheFilesOptions options)
	{
		_impl = impl;
		_options = options;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.Prepare;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.Prepare)
		{
			List<IFileSystem> fileSystems = _impl.FileSystems;
			if (fileSystems == null || fileSystems.Count == 0)
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "The file system is empty !";
				return;
			}
			foreach (IFileSystem item in fileSystems)
			{
				if (item == null)
				{
					_steps = ESteps.Done;
					Status = EOperationStatus.Failed;
					Error = "An empty object exists in the list!";
					return;
				}
			}
			_cloneList = fileSystems.ToList();
			_steps = ESteps.ClearCacheFiles;
		}
		if (_steps == ESteps.ClearCacheFiles)
		{
			if (_cloneList.Count == 0)
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Succeed;
			}
			else
			{
				IFileSystem fileSystem = _cloneList[0];
				_cloneList.RemoveAt(0);
				_clearCacheFilesOp = fileSystem.ClearCacheFilesAsync(_impl.ActiveManifest, _options);
				_clearCacheFilesOp.StartOperation();
				AddChildOperation(_clearCacheFilesOp);
				_steps = ESteps.CheckClearResult;
			}
		}
		if (_steps != ESteps.CheckClearResult)
		{
			return;
		}
		_clearCacheFilesOp.UpdateOperation();
		Progress = _clearCacheFilesOp.Progress;
		if (_clearCacheFilesOp.IsDone)
		{
			if (_clearCacheFilesOp.Status == EOperationStatus.Succeed)
			{
				_steps = ESteps.ClearCacheFiles;
				return;
			}
			_steps = ESteps.Done;
			Status = EOperationStatus.Failed;
			Error = _clearCacheFilesOp.Error;
		}
	}

	internal override string InternalGetDesc()
	{
		return "ClearMode : " + _options.ClearMode;
	}
}
