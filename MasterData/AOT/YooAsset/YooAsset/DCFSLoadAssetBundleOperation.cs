using System.IO;
using UnityEngine;

namespace YooAsset;

internal class DCFSLoadAssetBundleOperation : FSLoadBundleOperation
{
	protected enum ESteps
	{
		None,
		CheckExist,
		DownloadFile,
		LoadAssetBundle,
		CheckResult,
		Done
	}

	protected readonly DefaultCacheFileSystem _fileSystem;

	protected readonly PackageBundle _bundle;

	protected FSDownloadFileOperation _downloadFileOp;

	protected AssetBundleCreateRequest _createRequest;

	private AssetBundle _assetBundle;

	private Stream _managedStream;

	protected ESteps _steps;

	internal DCFSLoadAssetBundleOperation(DefaultCacheFileSystem fileSystem, PackageBundle bundle)
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
				DownloadProgress = 1f;
				DownloadedBytes = _bundle.FileSize;
				_steps = ESteps.LoadAssetBundle;
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
				_steps = ESteps.LoadAssetBundle;
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = _downloadFileOp.Error;
			}
		}
		if (_steps == ESteps.LoadAssetBundle)
		{
			if (_bundle.Encrypted && _fileSystem.DecryptionServices == null)
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "The IDecryptionServices is null !";
				YooLogger.Error(Error);
				return;
			}
			if (IsWaitForAsyncComplete)
			{
				if (_bundle.Encrypted)
				{
					DecryptResult decryptResult = _fileSystem.LoadEncryptedAssetBundle(_bundle);
					_assetBundle = decryptResult.Result;
					_managedStream = decryptResult.ManagedStream;
				}
				else
				{
					string cacheBundleFileLoadPath = _fileSystem.GetCacheBundleFileLoadPath(_bundle);
					_assetBundle = AssetBundle.LoadFromFile(cacheBundleFileLoadPath);
				}
			}
			else if (_bundle.Encrypted)
			{
				DecryptResult decryptResult2 = _fileSystem.LoadEncryptedAssetBundleAsync(_bundle);
				_createRequest = decryptResult2.CreateRequest;
				_managedStream = decryptResult2.ManagedStream;
			}
			else
			{
				string cacheBundleFileLoadPath2 = _fileSystem.GetCacheBundleFileLoadPath(_bundle);
				_createRequest = AssetBundle.LoadFromFileAsync(cacheBundleFileLoadPath2);
			}
			_steps = ESteps.CheckResult;
		}
		if (_steps != ESteps.CheckResult)
		{
			return;
		}
		if (_createRequest != null)
		{
			if (IsWaitForAsyncComplete)
			{
				YooLogger.Warning("Suspend the main thread to load unity bundle.");
				_assetBundle = _createRequest.assetBundle;
			}
			else
			{
				if (!_createRequest.isDone)
				{
					return;
				}
				_assetBundle = _createRequest.assetBundle;
			}
		}
		if (_assetBundle != null)
		{
			_steps = ESteps.Done;
			Result = new AssetBundleResult(_fileSystem, _bundle, _assetBundle, _managedStream);
			Status = EOperationStatus.Succeed;
		}
		else if (_fileSystem.VerifyCacheFile(_bundle) == EFileVerifyResult.Succeed)
		{
			if (_bundle.Encrypted)
			{
				_assetBundle = _fileSystem.LoadEncryptedAssetBundleFallback(_bundle).Result;
				if (_assetBundle != null)
				{
					_steps = ESteps.Done;
					Result = new AssetBundleResult(_fileSystem, _bundle, _assetBundle, _managedStream);
					Status = EOperationStatus.Succeed;
				}
				else
				{
					_steps = ESteps.Done;
					Status = EOperationStatus.Failed;
					Error = "Failed to load encrypted asset bundle file : " + _bundle.BundleName;
					YooLogger.Error(Error);
				}
				return;
			}
			byte[] array = FileUtility.ReadAllBytes(_fileSystem.GetCacheBundleFileLoadPath(_bundle));
			if (array != null && array.Length != 0)
			{
				_assetBundle = AssetBundle.LoadFromMemory(array);
				if (_assetBundle == null)
				{
					_steps = ESteps.Done;
					Status = EOperationStatus.Failed;
					Error = "Failed to load asset bundle from memory : " + _bundle.BundleName;
					YooLogger.Error(Error);
				}
				else
				{
					_steps = ESteps.Done;
					Result = new AssetBundleResult(_fileSystem, _bundle, _assetBundle, null);
					Status = EOperationStatus.Succeed;
				}
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "Failed to read asset bundle file bytes : " + _bundle.BundleName;
				YooLogger.Error(Error);
			}
		}
		else
		{
			_steps = ESteps.Done;
			_fileSystem.DeleteCacheBundleFile(_bundle.BundleGUID);
			Status = EOperationStatus.Failed;
			Error = "Find corrupted asset bundle file and delete : " + _bundle.BundleName;
			YooLogger.Error(Error);
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
