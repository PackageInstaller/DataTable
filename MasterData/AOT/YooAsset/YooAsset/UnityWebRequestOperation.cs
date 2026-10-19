using UnityEngine;
using UnityEngine.Networking;

namespace YooAsset;

internal abstract class UnityWebRequestOperation : AsyncOperationBase
{
	protected enum ESteps
	{
		None,
		CreateRequest,
		Download,
		Done
	}

	protected UnityWebRequest _webRequest;

	protected readonly string _requestURL;

	protected ESteps _steps;

	protected readonly float _timeout;

	protected ulong _latestDownloadBytes;

	protected float _latestDownloadRealtime;

	private bool _isAbort;

	public string URL => _requestURL;

	internal UnityWebRequestOperation(string url, int timeout)
	{
		_requestURL = url;
		_timeout = timeout;
	}

	protected void DisposeRequest()
	{
		if (_webRequest != null)
		{
			_webRequest.Dispose();
			_webRequest = null;
		}
	}

	protected void CheckRequestTimeout()
	{
		if (!_isAbort)
		{
			if (_latestDownloadBytes != _webRequest.downloadedBytes)
			{
				_latestDownloadBytes = _webRequest.downloadedBytes;
				_latestDownloadRealtime = Time.realtimeSinceStartup;
			}
			if (Time.realtimeSinceStartup - _latestDownloadRealtime > _timeout)
			{
				_webRequest.Abort();
				_isAbort = true;
			}
		}
	}

	protected bool CheckRequestResult()
	{
		if (_webRequest.result != UnityWebRequest.Result.Success)
		{
			Error = "URL : " + _requestURL + " Error : " + _webRequest.error;
			return false;
		}
		return true;
	}
}
