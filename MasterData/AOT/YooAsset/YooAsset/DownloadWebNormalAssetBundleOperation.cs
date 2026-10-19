using UnityEngine;
using UnityEngine.Networking;

namespace YooAsset;

internal class DownloadWebNormalAssetBundleOperation : DownloadAssetBundleOperation
{
	private readonly bool _disableUnityWebCache;

	private DownloadHandlerAssetBundle _downloadhandler;

	private ESteps _steps;

	internal DownloadWebNormalAssetBundleOperation(bool disableUnityWebCache, PackageBundle bundle, DownloadFileOptions options)
		: base(bundle, options)
	{
		_disableUnityWebCache = disableUnityWebCache;
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
			_requestURL = GetRequestURL();
			ResetRequestFiled();
			CreateWebRequest();
			_steps = ESteps.CheckRequest;
		}
		if (_steps == ESteps.CheckRequest)
		{
			DownloadProgress = _webRequest.downloadProgress;
			DownloadedBytes = (long)_webRequest.downloadedBytes;
			Progress = DownloadProgress;
			if (!_webRequest.isDone)
			{
				CheckRequestTimeout();
				return;
			}
			if (CheckRequestResult())
			{
				AssetBundle assetBundle = _downloadhandler.assetBundle;
				if (assetBundle == null)
				{
					_steps = ESteps.Done;
					Status = EOperationStatus.Failed;
					Error = "Download handler asset bundle object is null !";
				}
				else
				{
					_steps = ESteps.Done;
					Result = assetBundle;
					Status = EOperationStatus.Succeed;
				}
			}
			else
			{
				_steps = ESteps.TryAgain;
			}
			DisposeWebRequest();
		}
		if (_steps != ESteps.TryAgain)
		{
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

	private void CreateWebRequest()
	{
		_downloadhandler = CreateWebDownloadHandler();
		_webRequest = DownloadSystemHelper.NewUnityWebRequestGet(_requestURL);
		_webRequest.downloadHandler = _downloadhandler;
		_webRequest.disposeDownloadHandlerOnDispose = true;
		_webRequest.SendWebRequest();
	}

	private void DisposeWebRequest()
	{
		if (_webRequest != null)
		{
			_webRequest.Dispose();
			_webRequest = null;
		}
	}

	private DownloadHandlerAssetBundle CreateWebDownloadHandler()
	{
		if (_disableUnityWebCache)
		{
			return new DownloadHandlerAssetBundle(_requestURL, Bundle.UnityCRC)
			{
				autoLoadAssetBundle = false
			};
		}
		Hash128 hash = Hash128.Parse(Bundle.FileHash);
		return new DownloadHandlerAssetBundle(_requestURL, hash, Bundle.UnityCRC)
		{
			autoLoadAssetBundle = false
		};
	}
}
