using System.Collections.Generic;

namespace YooAsset;

public sealed class PreDownloadContentOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		CheckParams,
		CheckActiveManifest,
		LoadPackageManifest,
		Done
	}

	private readonly PlayModeImpl _impl;

	private readonly string _packageVersion;

	private readonly int _timeout;

	private FSLoadPackageManifestOperation _loadPackageManifestOp;

	private PackageManifest _manifest;

	private ESteps _steps;

	internal PreDownloadContentOperation(PlayModeImpl impl, string packageVersion, int timeout)
	{
		_impl = impl;
		_packageVersion = packageVersion;
		_timeout = timeout;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.CheckParams;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.CheckParams)
		{
			if (string.IsNullOrEmpty(_packageVersion))
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "Package version is null or empty.";
				return;
			}
			_steps = ESteps.CheckActiveManifest;
		}
		if (_steps == ESteps.CheckActiveManifest)
		{
			if (_impl.ActiveManifest != null && _impl.ActiveManifest.PackageVersion == _packageVersion)
			{
				_manifest = _impl.ActiveManifest;
				_steps = ESteps.Done;
				Status = EOperationStatus.Succeed;
				return;
			}
			_steps = ESteps.LoadPackageManifest;
		}
		if (_steps != ESteps.LoadPackageManifest)
		{
			return;
		}
		if (_loadPackageManifestOp == null)
		{
			IFileSystem mainFileSystem = _impl.GetMainFileSystem();
			_loadPackageManifestOp = mainFileSystem.LoadPackageManifestAsync(_packageVersion, _timeout);
			_loadPackageManifestOp.StartOperation();
			AddChildOperation(_loadPackageManifestOp);
		}
		_loadPackageManifestOp.UpdateOperation();
		if (_loadPackageManifestOp.IsDone)
		{
			if (_loadPackageManifestOp.Status == EOperationStatus.Succeed)
			{
				_manifest = _loadPackageManifestOp.Manifest;
				_steps = ESteps.Done;
				Status = EOperationStatus.Succeed;
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = _loadPackageManifestOp.Error;
			}
		}
	}

	public ResourceDownloaderOperation CreateResourceDownloader(int downloadingMaxNumber, int failedTryAgain, int timeout = 60)
	{
		if (Status != EOperationStatus.Succeed)
		{
			YooLogger.Warning("PreDownloadContentOperation status is not succeed !");
			return ResourceDownloaderOperation.CreateEmptyDownloader(_impl.PackageName, downloadingMaxNumber, failedTryAgain, timeout);
		}
		List<BundleInfo> downloadListByAll = _impl.GetDownloadListByAll(_manifest);
		return new ResourceDownloaderOperation(_impl.PackageName, downloadListByAll, downloadingMaxNumber, failedTryAgain, timeout);
	}

	public ResourceDownloaderOperation CreateResourceDownloader(string tag, int downloadingMaxNumber, int failedTryAgain, int timeout = 60)
	{
		if (Status != EOperationStatus.Succeed)
		{
			YooLogger.Warning("PreDownloadContentOperation status is not succeed !");
			return ResourceDownloaderOperation.CreateEmptyDownloader(_impl.PackageName, downloadingMaxNumber, failedTryAgain, timeout);
		}
		List<BundleInfo> downloadListByTags = _impl.GetDownloadListByTags(_manifest, new string[1] { tag });
		return new ResourceDownloaderOperation(_impl.PackageName, downloadListByTags, downloadingMaxNumber, failedTryAgain, timeout);
	}

	public ResourceDownloaderOperation CreateResourceDownloader(string[] tags, int downloadingMaxNumber, int failedTryAgain, int timeout = 60)
	{
		if (Status != EOperationStatus.Succeed)
		{
			YooLogger.Warning("PreDownloadContentOperation status is not succeed !");
			return ResourceDownloaderOperation.CreateEmptyDownloader(_impl.PackageName, downloadingMaxNumber, failedTryAgain, timeout);
		}
		List<BundleInfo> downloadListByTags = _impl.GetDownloadListByTags(_manifest, tags);
		return new ResourceDownloaderOperation(_impl.PackageName, downloadListByTags, downloadingMaxNumber, failedTryAgain, timeout);
	}

	public ResourceDownloaderOperation CreateBundleDownloader(string location, bool recursiveDownload, int downloadingMaxNumber, int failedTryAgain, int timeout = 60)
	{
		if (Status != EOperationStatus.Succeed)
		{
			YooLogger.Warning("PreDownloadContentOperation status is not succeed !");
			return ResourceDownloaderOperation.CreateEmptyDownloader(_impl.PackageName, downloadingMaxNumber, failedTryAgain, timeout);
		}
		List<AssetInfo> list = new List<AssetInfo>();
		AssetInfo item = _manifest.ConvertLocationToAssetInfo(location, null);
		list.Add(item);
		List<BundleInfo> downloadListByPaths = _impl.GetDownloadListByPaths(_manifest, list.ToArray(), recursiveDownload);
		return new ResourceDownloaderOperation(_impl.PackageName, downloadListByPaths, downloadingMaxNumber, failedTryAgain, timeout);
	}

	public ResourceDownloaderOperation CreateBundleDownloader(string[] locations, bool recursiveDownload, int downloadingMaxNumber, int failedTryAgain, int timeout = 60)
	{
		if (Status != EOperationStatus.Succeed)
		{
			YooLogger.Warning("PreDownloadContentOperation status is not succeed !");
			return ResourceDownloaderOperation.CreateEmptyDownloader(_impl.PackageName, downloadingMaxNumber, failedTryAgain, timeout);
		}
		List<AssetInfo> list = new List<AssetInfo>(locations.Length);
		foreach (string location in locations)
		{
			AssetInfo item = _manifest.ConvertLocationToAssetInfo(location, null);
			list.Add(item);
		}
		List<BundleInfo> downloadListByPaths = _impl.GetDownloadListByPaths(_manifest, list.ToArray(), recursiveDownload);
		return new ResourceDownloaderOperation(_impl.PackageName, downloadListByPaths, downloadingMaxNumber, failedTryAgain, timeout);
	}
}
