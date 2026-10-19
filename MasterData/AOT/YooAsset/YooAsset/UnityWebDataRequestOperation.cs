using UnityEngine;
using UnityEngine.Networking;

namespace YooAsset;

internal class UnityWebDataRequestOperation : UnityWebRequestOperation
{
	private UnityWebRequestAsyncOperation _requestOperation;

	public byte[] Result { get; private set; }

	internal UnityWebDataRequestOperation(string url, int timeout = 60)
		: base(url, timeout)
	{
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
			Result = _webRequest.downloadHandler.data;
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
		DownloadHandlerBuffer downloadHandler = new DownloadHandlerBuffer();
		_webRequest.downloadHandler = downloadHandler;
		_webRequest.disposeDownloadHandlerOnDispose = true;
		_requestOperation = _webRequest.SendWebRequest();
	}
}
