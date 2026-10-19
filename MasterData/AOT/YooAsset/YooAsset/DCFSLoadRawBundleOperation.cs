using System;
using System.IO;

namespace YooAsset;

internal class DCFSLoadRawBundleOperation : FSLoadBundleOperation
{
	protected enum ESteps
	{
		None,
		CheckExist,
		DownloadFile,
		LoadCacheRawBundle,
		Done
	}

	protected readonly DefaultCacheFileSystem _fileSystem;

	protected readonly PackageBundle _bundle;

	protected FSDownloadFileOperation _downloadFileOp;

	protected ESteps _steps;

	internal DCFSLoadRawBundleOperation(DefaultCacheFileSystem fileSystem, PackageBundle bundle)
	{
		_fileSystem = fileSystem;
		_bundle = bundle;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.CheckExist;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.CheckExist)
		{
			if (_fileSystem.Exists(_bundle))
			{
				string cacheBundleFileLoadPath = _fileSystem.GetCacheBundleFileLoadPath(_bundle);
				if (!File.Exists(cacheBundleFileLoadPath))
				{
					try
					{
						File.Move(_fileSystem.GetRecordFileElement(_bundle).DataFilePath, cacheBundleFileLoadPath);
						_steps = ESteps.LoadCacheRawBundle;
					}
					catch (Exception ex)
					{
						_steps = ESteps.Done;
						Status = EOperationStatus.Failed;
						Error = "Faild rename raw data file : " + ex.Message;
					}
				}
				else
				{
					DownloadProgress = 1f;
					DownloadedBytes = _bundle.FileSize;
					_steps = ESteps.LoadCacheRawBundle;
				}
			}
			else
			{
				_steps = ESteps.DownloadFile;
			}
		}
		if (_steps == ESteps.DownloadFile)
		{
			if (_downloadFileOp == null)
			{
				DownloadFileOptions options = new DownloadFileOptions(int.MaxValue, 60);
				_downloadFileOp = _fileSystem.DownloadFileAsync(_bundle, options);
				_downloadFileOp.StartOperation();
				AddChildOperation(_downloadFileOp);
			}
			if (IsWaitForAsyncComplete)
			{
				_downloadFileOp.WaitForAsyncComplete();
			}
			_downloadFileOp.UpdateOperation();
			DownloadProgress = _downloadFileOp.DownloadProgress;
			DownloadedBytes = _downloadFileOp.DownloadedBytes;
			if (!_downloadFileOp.IsDone)
			{
				return;
			}
			if (_downloadFileOp.Status == EOperationStatus.Succeed)
			{
				_steps = ESteps.LoadCacheRawBundle;
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = _downloadFileOp.Error;
			}
		}
		if (_steps == ESteps.LoadCacheRawBundle)
		{
			string cacheBundleFileLoadPath2 = _fileSystem.GetCacheBundleFileLoadPath(_bundle);
			if (File.Exists(cacheBundleFileLoadPath2))
			{
				_steps = ESteps.Done;
				Result = new RawBundleResult(_fileSystem, _bundle);
				Status = EOperationStatus.Succeed;
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "Can not found cache raw bundle file : " + cacheBundleFileLoadPath2;
				YooLogger.Error(Error);
			}
		}
	}

	internal override void InternalWaitForAsyncComplete()
	{
		while (!ExecuteWhileDone())
		{
		}
		if (_downloadFileOp != null && _downloadFileOp.Status == EOperationStatus.Failed)
		{
			YooLogger.Error("Try load bundle " + _bundle.BundleName + " from remote !");
		}
		_steps = ESteps.Done;
	}
}
