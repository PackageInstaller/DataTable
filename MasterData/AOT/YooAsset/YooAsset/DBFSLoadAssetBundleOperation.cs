using System.IO;
using UnityEngine;

namespace YooAsset;

internal class DBFSLoadAssetBundleOperation : FSLoadBundleOperation
{
	private enum ESteps
	{
		None,
		LoadAssetBundle,
		CheckResult,
		Done
	}

	private readonly DefaultBuildinFileSystem _fileSystem;

	private readonly PackageBundle _bundle;

	private AssetBundleCreateRequest _createRequest;

	private AssetBundle _assetBundle;

	private Stream _managedStream;

	private ESteps _steps;

	internal DBFSLoadAssetBundleOperation(DefaultBuildinFileSystem fileSystem, PackageBundle bundle)
	{
		_fileSystem = fileSystem;
		_bundle = bundle;
	}

	internal override void InternalStart()
	{
		DownloadProgress = 1f;
		DownloadedBytes = _bundle.FileSize;
		_steps = ESteps.LoadAssetBundle;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
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
					string buildinFileLoadPath = _fileSystem.GetBuildinFileLoadPath(_bundle);
					_assetBundle = AssetBundle.LoadFromFile(buildinFileLoadPath);
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
				string buildinFileLoadPath2 = _fileSystem.GetBuildinFileLoadPath(_bundle);
				_createRequest = AssetBundle.LoadFromFileAsync(buildinFileLoadPath2);
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
		else if (_bundle.Encrypted)
		{
			_steps = ESteps.Done;
			Status = EOperationStatus.Failed;
			Error = "Failed to load encrypted buildin asset bundle file : " + _bundle.BundleName;
			YooLogger.Error(Error);
		}
		else
		{
			_steps = ESteps.Done;
			Status = EOperationStatus.Failed;
			Error = "Failed to load buildin asset bundle file : " + _bundle.BundleName;
			YooLogger.Error(Error);
		}
	}

	internal override void InternalWaitForAsyncComplete()
	{
		while (!ExecuteWhileDone())
		{
		}
		_steps = ESteps.Done;
	}
}
