using UnityEngine;

namespace YooAsset;

internal class DWSFSLoadAssetBundleOperation : FSLoadBundleOperation
{
	private enum ESteps
	{
		None,
		DownloadAssetBundle,
		Done
	}

	private readonly DefaultWebServerFileSystem _fileSystem;

	private readonly PackageBundle _bundle;

	private DownloadAssetBundleOperation _downloadAssetBundleOp;

	private ESteps _steps;

	internal DWSFSLoadAssetBundleOperation(DefaultWebServerFileSystem fileSystem, PackageBundle bundle)
	{
		_fileSystem = fileSystem;
		_bundle = bundle;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.DownloadAssetBundle;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done || _steps != ESteps.DownloadAssetBundle)
		{
			return;
		}
		if (_downloadAssetBundleOp == null)
		{
			DownloadFileOptions downloadFileOptions = new DownloadFileOptions(int.MaxValue, 60);
			string webFileLoadPath = _fileSystem.GetWebFileLoadPath(_bundle);
			downloadFileOptions.MainURL = DownloadSystemHelper.ConvertToWWWPath(webFileLoadPath);
			downloadFileOptions.FallbackURL = downloadFileOptions.MainURL;
			if (_bundle.Encrypted)
			{
				_downloadAssetBundleOp = new DownloadWebEncryptAssetBundleOperation(checkTimeout: true, _fileSystem.DecryptionServices, _bundle, downloadFileOptions);
				_downloadAssetBundleOp.StartOperation();
				AddChildOperation(_downloadAssetBundleOp);
			}
			else
			{
				_downloadAssetBundleOp = new DownloadWebNormalAssetBundleOperation(_fileSystem.DisableUnityWebCache, _bundle, downloadFileOptions);
				_downloadAssetBundleOp.StartOperation();
				AddChildOperation(_downloadAssetBundleOp);
			}
		}
		_downloadAssetBundleOp.UpdateOperation();
		DownloadProgress = _downloadAssetBundleOp.DownloadProgress;
		DownloadedBytes = _downloadAssetBundleOp.DownloadedBytes;
		Progress = _downloadAssetBundleOp.Progress;
		if (!_downloadAssetBundleOp.IsDone)
		{
			return;
		}
		if (_downloadAssetBundleOp.Status == EOperationStatus.Succeed)
		{
			AssetBundle result = _downloadAssetBundleOp.Result;
			if (result == null)
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "DownloadAssetBundleOperation loaded asset bundle is null !";
			}
			else
			{
				_steps = ESteps.Done;
				Result = new AssetBundleResult(_fileSystem, _bundle, result, null);
				Status = EOperationStatus.Succeed;
			}
		}
		else
		{
			_steps = ESteps.Done;
			Status = EOperationStatus.Failed;
			Error = _downloadAssetBundleOp.Error;
		}
	}

	internal override void InternalWaitForAsyncComplete()
	{
		if (_steps != ESteps.Done)
		{
			_steps = ESteps.Done;
			Status = EOperationStatus.Failed;
			Error = "WebGL platform not support sync load method !";
			Debug.LogError(Error);
		}
	}
}
