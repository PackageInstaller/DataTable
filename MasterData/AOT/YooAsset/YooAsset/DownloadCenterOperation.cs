using System.Collections.Generic;

namespace YooAsset;

internal class DownloadCenterOperation : AsyncOperationBase
{
	private readonly DefaultCacheFileSystem _fileSystem;

	protected readonly Dictionary<string, DefaultDownloadFileOperation> _downloaders = new Dictionary<string, DefaultDownloadFileOperation>(1000);

	protected readonly List<string> _removeDownloadList = new List<string>(1000);

	public DownloadCenterOperation(DefaultCacheFileSystem fileSystem)
	{
		_fileSystem = fileSystem;
	}

	internal override void InternalStart()
	{
	}

	internal override void InternalUpdate()
	{
		_removeDownloadList.Clear();
		foreach (KeyValuePair<string, DefaultDownloadFileOperation> downloader in _downloaders)
		{
			DefaultDownloadFileOperation value = downloader.Value;
			value.UpdateOperation();
			if (value.RefCount <= 0)
			{
				_removeDownloadList.Add(downloader.Key);
				value.AbortOperation();
			}
			else if (value.IsDone)
			{
				_removeDownloadList.Add(downloader.Key);
			}
		}
		foreach (string removeDownload in _removeDownloadList)
		{
			_downloaders.Remove(removeDownload);
		}
		int processingOperationCount = GetProcessingOperationCount();
		if (processingOperationCount == _downloaders.Count || processingOperationCount >= _fileSystem.DownloadMaxConcurrency)
		{
			return;
		}
		int num = _fileSystem.DownloadMaxConcurrency - processingOperationCount;
		if (num > _fileSystem.DownloadMaxRequestPerFrame)
		{
			num = _fileSystem.DownloadMaxRequestPerFrame;
		}
		foreach (KeyValuePair<string, DefaultDownloadFileOperation> downloader2 in _downloaders)
		{
			DefaultDownloadFileOperation value2 = downloader2.Value;
			if (value2.Status == EOperationStatus.None)
			{
				value2.StartOperation();
				num--;
				if (num <= 0)
				{
					break;
				}
			}
		}
	}

	public FSDownloadFileOperation DownloadFileAsync(PackageBundle bundle, DownloadFileOptions options)
	{
		if (_downloaders.TryGetValue(bundle.BundleGUID, out var value))
		{
			return value;
		}
		if (string.IsNullOrEmpty(options.ImportFilePath))
		{
			options.MainURL = _fileSystem.RemoteServices.GetRemoteMainURL(bundle.FileName);
			options.DeviceID = _fileSystem.RemoteServices.GetDeviceId();
			options.FallbackURL = _fileSystem.RemoteServices.GetRemoteFallbackURL(bundle.FileName);
		}
		else
		{
			options.MainURL = DownloadSystemHelper.ConvertToWWWPath(options.ImportFilePath);
			options.FallbackURL = options.MainURL;
		}
		DefaultDownloadFileOperation defaultDownloadFileOperation;
		if (bundle.FileSize >= _fileSystem.ResumeDownloadMinimumSize)
		{
			defaultDownloadFileOperation = new DownloadResumeFileOperation(_fileSystem, bundle, options);
			AddChildOperation(defaultDownloadFileOperation);
			_downloaders.Add(bundle.BundleGUID, defaultDownloadFileOperation);
		}
		else
		{
			defaultDownloadFileOperation = new DownloadNormalFileOperation(_fileSystem, bundle, options);
			AddChildOperation(defaultDownloadFileOperation);
			_downloaders.Add(bundle.BundleGUID, defaultDownloadFileOperation);
		}
		return defaultDownloadFileOperation;
	}

	private int GetProcessingOperationCount()
	{
		int num = 0;
		foreach (KeyValuePair<string, DefaultDownloadFileOperation> downloader in _downloaders)
		{
			if (downloader.Value.Status != EOperationStatus.None)
			{
				num++;
			}
		}
		return num;
	}
}
