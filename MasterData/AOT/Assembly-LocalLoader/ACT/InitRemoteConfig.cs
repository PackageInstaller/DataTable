using System;
using ACT.Error;
using UnityEngine;

namespace ACT;

internal class InitRemoteConfig : GameLoadingFlowBase
{
	private GameLoadingData _data;

	private MonoBehaviour _mono;

	private DownloadData _downloadData;

	private Action _onLoaded;

	internal override EGameLoadingStage Stage => EGameLoadingStage.RemoteConfig;

	internal InitRemoteConfig(MonoBehaviour mono, DownloadData downloadData, Action onLoaded)
	{
		_mono = mono;
		_downloadData = downloadData;
		_onLoaded = onLoaded;
	}

	internal override void Init(GameLoadingData data)
	{
		_data = data;
		if (_mono == null)
		{
			Error("InitRemoteConfig 获取Mono为空");
			LuminErrorAOT.ReportGameLoadingError("C01-0103", "01", 0);
			return;
		}
		_loadState = EGameLoadingState.Waiting;
		int defaultPackageVersion = ((_downloadData != null && _downloadData.HasVersionInfo) ? _downloadData.AssetVersion : 0);
		int rawfileVersion = ((_downloadData != null && _downloadData.HasVersionInfo) ? _downloadData.RawFileVersion : 0);
		int clientStaticVersion = ((_downloadData != null && _downloadData.HasVersionInfo) ? _downloadData.ClientStaticVersion : 0);
		int dllVersion = ((_downloadData != null && _downloadData.HasVersionInfo) ? _downloadData.DllVersion : 0);
		_mono.StartCoroutine(LuminApplication.Init(_mono, defaultPackageVersion, rawfileVersion, clientStaticVersion, dllVersion, OnGetRemoteConfig));
	}

	private void OnGetRemoteConfig(bool getSuccess, RemoteConfig config)
	{
		try
		{
			if (getSuccess)
			{
				_onLoaded?.Invoke();
				_loadState = EGameLoadingState.Succeed;
			}
			else
			{
				_loadState = EGameLoadingState.Failed;
			}
		}
		catch (Exception exception)
		{
			Exception(exception);
			LuminErrorAOT.ReportGameLoadingError("C01-0104", "01", 0);
		}
	}
}
