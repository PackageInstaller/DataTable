using System;

namespace YooAsset;

internal class DCFSInitializeOperation : FSInitializeFileSystemOperation
{
	private enum ESteps
	{
		None,
		CheckAppFootPrint,
		SearchCacheFiles,
		VerifyCacheFiles,
		CreateDownloadCenter,
		Done
	}

	private readonly DefaultCacheFileSystem _fileSystem;

	private SearchCacheFilesOperation _searchCacheFilesOp;

	private VerifyCacheFilesOperation _verifyCacheFilesOp;

	private ESteps _steps;

	internal DCFSInitializeOperation(DefaultCacheFileSystem fileSystem)
	{
		_fileSystem = fileSystem;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.CheckAppFootPrint;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.CheckAppFootPrint)
		{
			ApplicationFootPrint applicationFootPrint = new ApplicationFootPrint(_fileSystem);
			applicationFootPrint.Load(_fileSystem.PackageName);
			bool flag = applicationFootPrint.IsDirty();
			if (flag)
			{
				if (_fileSystem.InstallClearMode == EOverwriteInstallClearMode.None)
				{
					YooLogger.Warning("Do nothing when overwrite install application !");
				}
				else if (_fileSystem.InstallClearMode == EOverwriteInstallClearMode.ClearAllCacheFiles)
				{
					_fileSystem.DeleteAllBundleFiles();
					_fileSystem.DeleteAllManifestFiles();
					YooLogger.Warning("Delete all cache files when overwrite install application !");
				}
				else if (_fileSystem.InstallClearMode == EOverwriteInstallClearMode.ClearAllBundleFiles)
				{
					_fileSystem.DeleteAllBundleFiles();
					YooLogger.Warning("Delete all bundle files when overwrite install application !");
				}
				else
				{
					if (_fileSystem.InstallClearMode != EOverwriteInstallClearMode.ClearAllManifestFiles)
					{
						throw new NotImplementedException(_fileSystem.InstallClearMode.ToString());
					}
					_fileSystem.DeleteAllManifestFiles();
					YooLogger.Warning("Delete all manifest files when overwrite install application !");
				}
				applicationFootPrint.Coverage(_fileSystem.PackageName);
			}
			if (!flag)
			{
				_fileSystem.TryLoadRecordsFromDisk();
			}
			_steps = ESteps.SearchCacheFiles;
		}
		if (_steps == ESteps.SearchCacheFiles)
		{
			if (_searchCacheFilesOp == null)
			{
				_searchCacheFilesOp = new SearchCacheFilesOperation(_fileSystem);
				_searchCacheFilesOp.StartOperation();
				AddChildOperation(_searchCacheFilesOp);
			}
			_searchCacheFilesOp.UpdateOperation();
			Progress = _searchCacheFilesOp.Progress;
			if (!_searchCacheFilesOp.IsDone)
			{
				return;
			}
			_fileSystem.RemoveRecordsNotIn(_searchCacheFilesOp.FoundBundleGUIDs);
			_steps = ESteps.VerifyCacheFiles;
		}
		if (_steps == ESteps.VerifyCacheFiles)
		{
			if (_verifyCacheFilesOp == null)
			{
				_verifyCacheFilesOp = new VerifyCacheFilesOperation(_fileSystem, _searchCacheFilesOp.Result);
				_verifyCacheFilesOp.StartOperation();
				AddChildOperation(_verifyCacheFilesOp);
			}
			_verifyCacheFilesOp.UpdateOperation();
			Progress = _verifyCacheFilesOp.Progress;
			if (!_verifyCacheFilesOp.IsDone)
			{
				return;
			}
			if (_verifyCacheFilesOp.Status == EOperationStatus.Succeed)
			{
				_fileSystem.SaveRecordsSnapshot();
				_steps = ESteps.CreateDownloadCenter;
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = _verifyCacheFilesOp.Error;
			}
		}
		if (_steps == ESteps.CreateDownloadCenter)
		{
			if (_fileSystem.DownloadCenter == null)
			{
				_fileSystem.DownloadCenter = new DownloadCenterOperation(_fileSystem);
				OperationSystem.StartOperation(_fileSystem.PackageName, _fileSystem.DownloadCenter);
			}
			_steps = ESteps.Done;
			Status = EOperationStatus.Succeed;
		}
	}
}
