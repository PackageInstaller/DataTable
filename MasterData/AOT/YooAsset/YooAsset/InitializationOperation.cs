using System.Collections.Generic;
using System.Linq;

namespace YooAsset;

public class InitializationOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		Prepare,
		ClearOldFileSystem,
		InitFileSystem,
		CheckInitResult,
		Done
	}

	private readonly PlayModeImpl _impl;

	private readonly List<FileSystemParameters> _parametersList;

	private List<FileSystemParameters> _cloneList;

	private FSInitializeFileSystemOperation _initFileSystemOp;

	private ESteps _steps;

	internal InitializationOperation(PlayModeImpl impl, List<FileSystemParameters> parametersList)
	{
		_impl = impl;
		_parametersList = parametersList;
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
			if (_parametersList == null || _parametersList.Count == 0)
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "The file system parameters is empty !";
				return;
			}
			foreach (FileSystemParameters parameters in _parametersList)
			{
				if (parameters == null)
				{
					_steps = ESteps.Done;
					Status = EOperationStatus.Failed;
					Error = "An empty object exists in the list!";
					return;
				}
			}
			_cloneList = _parametersList.ToList();
			_steps = ESteps.ClearOldFileSystem;
		}
		if (_steps == ESteps.ClearOldFileSystem)
		{
			foreach (IFileSystem fileSystem2 in _impl.FileSystems)
			{
				fileSystem2.OnDestroy();
			}
			_impl.FileSystems.Clear();
			_steps = ESteps.InitFileSystem;
		}
		if (_steps == ESteps.InitFileSystem)
		{
			if (_cloneList.Count == 0)
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Succeed;
			}
			else
			{
				FileSystemParameters fileSystemParameters = _cloneList[0];
				_cloneList.RemoveAt(0);
				IFileSystem fileSystem = fileSystemParameters.CreateFileSystem(_impl.PackageName);
				if (fileSystem == null)
				{
					_steps = ESteps.Done;
					Status = EOperationStatus.Failed;
					Error = "Failed to create file system instance !";
					return;
				}
				_impl.FileSystems.Add(fileSystem);
				_initFileSystemOp = fileSystem.InitializeFileSystemAsync();
				_initFileSystemOp.StartOperation();
				AddChildOperation(_initFileSystemOp);
				_steps = ESteps.CheckInitResult;
			}
		}
		if (_steps != ESteps.CheckInitResult)
		{
			return;
		}
		_initFileSystemOp.UpdateOperation();
		Progress = _initFileSystemOp.Progress;
		if (_initFileSystemOp.IsDone)
		{
			if (_initFileSystemOp.Status == EOperationStatus.Succeed)
			{
				_steps = ESteps.InitFileSystem;
				return;
			}
			_steps = ESteps.Done;
			Status = EOperationStatus.Failed;
			Error = _initFileSystemOp.Error;
		}
	}

	internal override string InternalGetDesc()
	{
		return $"PlayMode : {_impl.PlayMode}";
	}
}
