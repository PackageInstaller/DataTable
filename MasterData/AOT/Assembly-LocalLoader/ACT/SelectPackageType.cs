using System;
using UnityEngine;

namespace ACT;

internal class SelectPackageType : GameLoadingFlowBase
{
	private DownloadData _downloadData;

	private ZipDownloadParam _zipDownloadParam;

	internal override EGameLoadingStage Stage => EGameLoadingStage.SelectPackageType;

	internal SelectPackageType(DownloadData downloadData, ZipDownloadParam zipDownloadParam)
	{
		_downloadData = downloadData;
		_zipDownloadParam = zipDownloadParam;
	}

	internal override void Init(GameLoadingData data)
	{
		if (_downloadData == null)
		{
			Error("SelectPackageType DownloadData为空");
			return;
		}
		try
		{
			if (LuminApplication.IsLocalVersion)
			{
				_loadState = EGameLoadingState.Succeed;
				return;
			}
			if (LuminApplication.RemoteConfig == null)
			{
				_loadState = EGameLoadingState.Succeed;
				Error("SelectPackageType RemoteConfig为空");
				return;
			}
			if (_zipDownloadParam.Source == RemoteConfigZipSource.None)
			{
				_zipDownloadParam.AssetsZipDownloadURLs = null;
				_zipDownloadParam.ClientStaticZipDownloadURLs = null;
				_zipDownloadParam.DllZipDownloadURLs = null;
				_zipDownloadParam.RawFileZipDownloadURLs = null;
				_loadState = EGameLoadingState.Succeed;
				return;
			}
			if (_zipDownloadParam.Source == RemoteConfigZipSource.Hotfix)
			{
				RemoteConfigHotfix hotfix = LuminApplication.RemoteConfig.Hotfix;
				_zipDownloadParam.AssetsZipDownloadURLs = hotfix?.DiffAssetInfos;
				_zipDownloadParam.ClientStaticZipDownloadURLs = hotfix?.DiffClientStaticInfos;
				_zipDownloadParam.DllZipDownloadURLs = hotfix?.DiffDllInfos;
				_zipDownloadParam.RawFileZipDownloadURLs = hotfix?.DiffRawFileInfos;
				Debug.Log("Use hotfix ZIP packages for update.");
				_loadState = EGameLoadingState.Succeed;
				return;
			}
			if (_downloadData.HasVersionInfo)
			{
				_zipDownloadParam.AssetsZipDownloadURLs = LuminApplication.RemoteConfig.DiffAssetInfos;
				_zipDownloadParam.ClientStaticZipDownloadURLs = LuminApplication.RemoteConfig.DiffClientStaticInfos;
				_zipDownloadParam.DllZipDownloadURLs = LuminApplication.RemoteConfig.DiffDllInfos;
				_zipDownloadParam.RawFileZipDownloadURLs = LuminApplication.RemoteConfig.DiffRawFileInfos;
				Debug.Log("使用差量包进行更新");
			}
			else
			{
				_zipDownloadParam.AssetsZipDownloadURLs = LuminApplication.RemoteConfig.FullAssetInfos;
				_zipDownloadParam.ClientStaticZipDownloadURLs = LuminApplication.RemoteConfig.FullClientStaticInfos;
				_zipDownloadParam.DllZipDownloadURLs = LuminApplication.RemoteConfig.FullDllInfos;
				_zipDownloadParam.RawFileZipDownloadURLs = LuminApplication.RemoteConfig.FullRawFileInfos;
				Debug.Log("使用全量包进行下载");
			}
			_loadState = EGameLoadingState.Succeed;
		}
		catch (Exception exception)
		{
			Exception(exception);
		}
	}
}
