using UnityEngine;
using UnityEngine.Networking;

namespace YooAsset;

internal class UnityWebFileRequestOperation : UnityWebRequestOperation
{
	private UnityWebRequestAsyncOperation _requestOperation;

	private readonly string _fileSavePath;

	internal UnityWebFileRequestOperation(string url, string fileSavePath, int timeout = 60)
		: base(url, timeout)
	{
		_fileSavePath = fileSavePath;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.CreateRequest;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.CreateRequest)
		{
			_latestDownloadBytes = 0uL;
			_latestDownloadRealtime = Time.realtimeSinceStartup;
			CreateWebRequest();
			_steps = ESteps.Download;
		}
		if (_steps != ESteps.Download)
		{
			return;
		}
		Progress = _requestOperation.progress;
		if (!_requestOperation.isDone)
		{
			CheckRequestTimeout();
			return;
		}
		if (CheckRequestResult())
		{
			_steps = ESteps.Done;
			Status = EOperationStatus.Succeed;
		}
		else
		{
			_steps = ESteps.Done;
			Status = EOperationStatus.Failed;
		}
		DisposeRequest();
	}

	internal override void InternalAbort()
	{
		_steps = ESteps.Done;
		DisposeRequest();
	}

	private void CreateWebRequest()
	{
		_webRequest = DownloadSystemHelper.NewUnityWebRequestGet(_requestURL);
		DownloadHandlerFile downloadHandlerFile = new DownloadHandlerFile(_fileSavePath);
		downloadHandlerFile.removeFileOnAbort = true;
		_webRequest.downloadHandler = downloadHandlerFile;
		_webRequest.disposeDownloadHandlerOnDispose = true;
		_requestOperation = _webRequest.SendWebRequest();
	}
}
