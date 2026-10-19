using UnityEngine;
using UnityEngine.Networking;

namespace YooAsset;

internal abstract class DefaultDownloadFileOperation : FSDownloadFileOperation
{
	protected enum ESteps
	{
		None,
		CheckExists,
		CreateRequest,
		CheckRequest,
		VerifyTempFile,
		CheckVerifyTempFile,
		TryAgain,
		Done
	}

	protected readonly DownloadFileOptions Options;

	protected UnityWebRequest _webRequest;

	protected string _requestURL;

	protected int _requestCount;

	protected bool _isAbort;

	protected long _latestDownloadBytes;

	protected float _latestDownloadRealtime;

	protected float _tryAgainTimer;

	protected int FailedTryAgain;

	internal DefaultDownloadFileOperation(PackageBundle bundle, DownloadFileOptions options)
		: base(bundle)
	{
		Options = options;
		FailedTryAgain = options.FailedTryAgain;
	}

	protected string GetRequestURL()
	{
		_requestCount++;
		string text = "";
		text = ((_requestCount % 2 != 0) ? Options.MainURL : Options.FallbackURL);
		if (!string.IsNullOrEmpty(Options.DeviceID))
		{
			return text + "?device_id=" + Options.DeviceID;
		}
		return text;
	}

	protected void ResetRequestFiled()
	{
		_isAbort = false;
		_latestDownloadBytes = 0L;
		_latestDownloadRealtime = Time.realtimeSinceStartup;
		DownloadProgress = 0f;
		DownloadedBytes = 0L;
		if (_tryAgainTimer > 0f)
		{
			YooLogger.Warning("Try again download : " + _requestURL);
		}
		_tryAgainTimer = 0f;
	}

	protected void CheckRequestTimeout()
	{
		if (_isAbort)
		{
			return;
		}
		if (_latestDownloadBytes != DownloadedBytes)
		{
			_latestDownloadBytes = DownloadedBytes;
			_latestDownloadRealtime = Time.realtimeSinceStartup;
		}
		if (Time.realtimeSinceStartup - _latestDownloadRealtime > (float)Options.Timeout)
		{
			YooLogger.Warning("Download request timeout : " + _requestURL);
			if (_webRequest != null)
			{
				_webRequest.Abort();
			}
			_isAbort = true;
		}
	}

	protected bool CheckRequestResult()
	{
		HttpCode = _webRequest.responseCode;
		if (_webRequest.result != UnityWebRequest.Result.Success)
		{
			Error = _webRequest.error + "  URL: " + _webRequest.url;
			return false;
		}
		return true;
	}
}
