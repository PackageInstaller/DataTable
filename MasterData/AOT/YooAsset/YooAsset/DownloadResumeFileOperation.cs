using System.IO;
using UnityEngine;
using UnityEngine.Networking;

namespace YooAsset;

internal sealed class DownloadResumeFileOperation : DefaultDownloadFileOperation
{
	private readonly DefaultCacheFileSystem _fileSystem;

	private DownloadHandlerFileRange _downloadHandle;

	private VerifyTempFileOperation _verifyOperation;

	private bool _isReuqestLocalFile;

	private long _fileOriginLength;

	private string _tempFilePath;

	private ESteps _steps;

	internal DownloadResumeFileOperation(DefaultCacheFileSystem fileSystem, PackageBundle bundle, DownloadFileOptions options)
		: base(bundle, options)
	{
		_fileSystem = fileSystem;
	}

	internal override void InternalStart()
	{
		_isReuqestLocalFile = DownloadSystemHelper.IsRequestLocalFile(Options.MainURL);
		_tempFilePath = _fileSystem.GetTempFilePath(Bundle);
		_steps = ESteps.CheckExists;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.CheckExists)
		{
			if (_fileSystem.Exists(Bundle))
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Succeed;
			}
			else
			{
				_steps = ESteps.CreateRequest;
			}
		}
		if (_steps == ESteps.CreateRequest)
		{
			FileUtility.CreateFileDirectory(_tempFilePath);
			_requestURL = GetRequestURL();
			ResetRequestFiled();
			_fileOriginLength = 0L;
			long beginLength = -1L;
			if (File.Exists(_tempFilePath))
			{
				FileInfo fileInfo = new FileInfo(_tempFilePath);
				if (fileInfo.Length >= Bundle.FileSize)
				{
					File.Delete(_tempFilePath);
				}
				else
				{
					beginLength = (_fileOriginLength = fileInfo.Length);
					DownloadedBytes = _fileOriginLength;
				}
			}
			CreateWebRequest(beginLength);
			_steps = ESteps.CheckRequest;
		}
		if (_steps == ESteps.CheckRequest)
		{
			DownloadProgress = _webRequest.downloadProgress;
			DownloadedBytes = _fileOriginLength + (long)_webRequest.downloadedBytes;
			if (!_webRequest.isDone)
			{
				CheckRequestTimeout();
				return;
			}
			if (CheckRequestResult())
			{
				_steps = ESteps.VerifyTempFile;
			}
			else
			{
				_steps = ESteps.TryAgain;
			}
			ClearTempFileWhenError();
			DisposeWebRequest();
		}
		if (_steps == ESteps.VerifyTempFile)
		{
			TempFileElement element = new TempFileElement(_tempFilePath, Bundle.FileCRC, Bundle.FileSize);
			_verifyOperation = new VerifyTempFileOperation(element);
			_verifyOperation.StartOperation();
			AddChildOperation(_verifyOperation);
			_steps = ESteps.CheckVerifyTempFile;
		}
		if (_steps == ESteps.CheckVerifyTempFile)
		{
			if (IsWaitForAsyncComplete)
			{
				_verifyOperation.WaitForAsyncComplete();
			}
			_verifyOperation.UpdateOperation();
			if (!_verifyOperation.IsDone)
			{
				return;
			}
			if (_verifyOperation.Status == EOperationStatus.Succeed)
			{
				if (_fileSystem.WriteCacheBundleFile(Bundle, _tempFilePath))
				{
					Status = EOperationStatus.Succeed;
					_steps = ESteps.Done;
				}
				else
				{
					Error = _fileSystem.GetType().FullName + " failed to write file !";
					Status = EOperationStatus.Failed;
					_steps = ESteps.Done;
				}
			}
			else
			{
				Error = _verifyOperation.Error;
				_steps = ESteps.TryAgain;
			}
			if (File.Exists(_tempFilePath))
			{
				File.Delete(_tempFilePath);
			}
		}
		if (_steps != ESteps.TryAgain)
		{
			return;
		}
		if (_isReuqestLocalFile)
		{
			Status = EOperationStatus.Failed;
			_steps = ESteps.Done;
			YooLogger.Error(Error);
			return;
		}
		if (FailedTryAgain <= 0)
		{
			Status = EOperationStatus.Failed;
			_steps = ESteps.Done;
			YooLogger.Error(Error);
			return;
		}
		_tryAgainTimer += Time.unscaledDeltaTime;
		if (_tryAgainTimer > 1f)
		{
			FailedTryAgain--;
			_steps = ESteps.CreateRequest;
			YooLogger.Warning(Error);
		}
	}

	internal override void InternalAbort()
	{
		_steps = ESteps.Done;
		DisposeWebRequest();
	}

	internal override void InternalWaitForAsyncComplete()
	{
		while (true)
		{
			if (_isReuqestLocalFile)
			{
				InternalUpdate();
				if (IsDone)
				{
					return;
				}
			}
			else if (ExecuteWhileDone())
			{
				break;
			}
		}
		_steps = ESteps.Done;
	}

	private void CreateWebRequest(long beginLength)
	{
		_webRequest = DownloadSystemHelper.NewUnityWebRequestGet(_requestURL);
		DownloadHandlerFile downloadHandlerFile = new DownloadHandlerFile(_tempFilePath, append: true);
		downloadHandlerFile.removeFileOnAbort = false;
		_webRequest.downloadHandler = downloadHandlerFile;
		_webRequest.disposeDownloadHandlerOnDispose = true;
		if (beginLength > 0)
		{
			_webRequest.SetRequestHeader("Range", $"bytes={beginLength}-");
		}
		_webRequest.SendWebRequest();
	}

	private void DisposeWebRequest()
	{
		if (_downloadHandle != null)
		{
			_downloadHandle.Cleanup();
			_downloadHandle = null;
		}
		if (_webRequest != null)
		{
			_webRequest.Dispose();
			_webRequest = null;
		}
	}

	private void ClearTempFileWhenError()
	{
		if (_fileSystem.ResumeDownloadResponseCodes != null && _fileSystem.ResumeDownloadResponseCodes.Contains(HttpCode) && File.Exists(_tempFilePath))
		{
			File.Delete(_tempFilePath);
		}
	}
}
