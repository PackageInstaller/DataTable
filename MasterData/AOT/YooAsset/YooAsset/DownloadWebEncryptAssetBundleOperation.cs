using UnityEngine;
using UnityEngine.Networking;

namespace YooAsset;

internal class DownloadWebEncryptAssetBundleOperation : DownloadAssetBundleOperation
{
	private readonly bool _checkTimeout;

	private readonly IWebDecryptionServices _decryptionServices;

	private DownloadHandlerBuffer _downloadhandler;

	private ESteps _steps;

	internal DownloadWebEncryptAssetBundleOperation(bool checkTimeout, IWebDecryptionServices decryptionServices, PackageBundle bundle, DownloadFileOptions options)
		: base(bundle, options)
	{
		_checkTimeout = checkTimeout;
		_decryptionServices = decryptionServices;
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
				if (_checkTimeout)
				{
					CheckRequestTimeout();
				}
				return;
			}
			if (CheckRequestResult())
			{
				if (_decryptionServices == null)
				{
					_steps = ESteps.Done;
					Status = EOperationStatus.Failed;
					Error = "The IWebDecryptionServices is null !";
					YooLogger.Error(Error);
					return;
				}
				byte[] data = _downloadhandler.data;
				if (data == null || data.Length == 0)
				{
					_steps = ESteps.Done;
					Status = EOperationStatus.Failed;
					Error = "The download handler data is null or empty !";
					YooLogger.Error(Error);
					return;
				}
				AssetBundle assetBundle = LoadEncryptedAssetBundle(data);
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
		_downloadhandler = new DownloadHandlerBuffer();
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

	private AssetBundle LoadEncryptedAssetBundle(byte[] fileData)
	{
		WebDecryptFileInfo fileInfo = new WebDecryptFileInfo
		{
			BundleName = Bundle.BundleName,
			FileLoadCRC = Bundle.UnityCRC,
			FileData = fileData
		};
		return _decryptionServices.LoadAssetBundle(fileInfo).Result;
	}
}
