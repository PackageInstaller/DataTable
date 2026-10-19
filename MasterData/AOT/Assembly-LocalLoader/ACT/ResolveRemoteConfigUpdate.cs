using System;
using ACT.Error;
using UnityEngine;

namespace ACT;

internal sealed class ResolveRemoteConfigUpdate : GameLoadingFlowBase
{
	private enum ResolveState
	{
		ApplyingPreDownload,
		RequestingNormal,
		Complete
	}

	private readonly MonoBehaviour _mono;

	private readonly DownloadData _downloadData;

	private readonly ZipDownloadParam _normalZipDownloadParam;

	private readonly YooAssetInitData _normalInitData;

	private GameLoadingData _gameLoadingData;

	private ResolveState _state;

	private DownloadAsset _preDownloadAsset;

	private RemoteConfigPreDownload _preDownload;

	internal override EGameLoadingStage Stage => EGameLoadingStage.RemoteConfig;

	internal ResolveRemoteConfigUpdate(MonoBehaviour mono, DownloadData downloadData, ZipDownloadParam normalZipDownloadParam, YooAssetInitData normalInitData)
	{
		_mono = mono;
		_downloadData = downloadData;
		_normalZipDownloadParam = normalZipDownloadParam;
		_normalInitData = normalInitData;
	}

	internal override void Init(GameLoadingData data)
	{
		_gameLoadingData = data;
		if (_mono == null || _downloadData == null || _normalZipDownloadParam == null || _normalInitData == null)
		{
			Error("RemoteConfig update resolver is missing required startup data.");
			Fail();
		}
		else
		{
			_normalZipDownloadParam.Source = RemoteConfigZipSource.Normal;
			EvaluateInitialRemoteConfig();
		}
	}

	internal override void Update()
	{
		if (_state == ResolveState.ApplyingPreDownload && _preDownloadAsset != null)
		{
			_preDownloadAsset.Tick();
			if (_preDownloadAsset.CurrentLoadState == EGameLoadingState.Failed)
			{
				Fail();
			}
			else if (_preDownloadAsset.CurrentLoadState == EGameLoadingState.Succeed)
			{
				ApplyPreDownloadVersion();
				RequestNormalRemoteConfig();
			}
		}
	}

	private void EvaluateInitialRemoteConfig()
	{
		RemoteConfig remoteConfig = LuminApplication.RemoteConfig;
		if (remoteConfig == null)
		{
			Fail();
			return;
		}
		if (LuminApplication.IsLocalVersion)
		{
			UseNormalPackages();
			Complete();
			return;
		}
		if (VersionsEqual(remoteConfig, _downloadData))
		{
			UseHotfixPackages(remoteConfig.Hotfix);
			Complete();
			return;
		}
		_preDownload = remoteConfig.PreDownload;
		if (CanInstallPreDownload())
		{
			StartPreDownloadExtraction();
		}
		else if (IsRemoteVersionNewer(remoteConfig, _downloadData))
		{
			UseNormalPackages();
			Complete();
		}
		else if (IsLocalVersionAheadOfRemote(remoteConfig, _downloadData))
		{
			Log("本地版本高于正式版本(预下载已推进)，跳过资源更新并保留本地版本号。");
			_normalZipDownloadParam.Source = RemoteConfigZipSource.None;
			_normalZipDownloadParam.WriteVersionInfo = false;
			Complete();
		}
		else
		{
			Debug.LogWarning("[RemoteConfig] The first remote resource version is older or incompatible with the local version; skip resource download.");
			_normalZipDownloadParam.Source = RemoteConfigZipSource.None;
			Complete();
		}
	}

	private void RequestNormalRemoteConfig()
	{
		_state = ResolveState.RequestingNormal;
		_loadState = EGameLoadingState.Waiting;
		int defaultPackageVersion = (_downloadData.HasVersionInfo ? _downloadData.AssetVersion : 0);
		int rawfileVersion = (_downloadData.HasVersionInfo ? _downloadData.RawFileVersion : 0);
		int clientStaticVersion = (_downloadData.HasVersionInfo ? _downloadData.ClientStaticVersion : 0);
		int dllVersion = (_downloadData.HasVersionInfo ? _downloadData.DllVersion : 0);
		_mono.StartCoroutine(LuminApplication.Init(_mono, defaultPackageVersion, rawfileVersion, clientStaticVersion, dllVersion, OnNormalRemoteConfigLoaded));
	}

	private void OnNormalRemoteConfigLoaded(bool success, RemoteConfig config)
	{
		try
		{
			if (!success || config == null)
			{
				Fail();
				return;
			}
			UseNormalPackages();
			Complete();
		}
		catch (Exception exception)
		{
			Exception(exception);
			Fail();
		}
	}

	private void StartPreDownloadExtraction()
	{
		_downloadData.AcceptUpdate = true;
		PreDownloadPackageStore.PreDownloadTarget target = PreDownloadPackageStore.CreateTarget(_preDownload);
		string preDownloadVersionKey = target.ToVersionKey();
		PreDownloadPackageStore.PromoteStagedTarget(LuminApplication.GetResPath(), target, PreDownloadPackageStore.CreatePackageZipInfos(_preDownload));
		ZipDownloadParam zipDownloadParam = new ZipDownloadParam
		{
			DllZipDownloadURLs = _preDownload.DiffDllInfos,
			ClientStaticZipDownloadURLs = _preDownload.DiffClientStaticInfos,
			AssetsZipDownloadURLs = _preDownload.DiffAssetInfos,
			RawFileZipDownloadURLs = _preDownload.DiffRawFileInfos,
			DownloadTags = _normalZipDownloadParam.DownloadTags,
			IntegrityDownloadTags = _normalZipDownloadParam.IntegrityDownloadTags,
			IsPreDownload = false,
			WriteVersionInfo = false,
			UsePreDownloadedPackages = true,
			PreDownloadVersionKey = preDownloadVersionKey,
			Source = RemoteConfigZipSource.Normal
		};
		YooAssetInitData initData = new YooAssetInitData
		{
			DownloadData = _downloadData,
			YooAssetParam = _normalInitData.YooAssetParam,
			ZipDownloadParam = zipDownloadParam,
			PackageInfos = _normalInitData.PackageInfos
		};
		_preDownloadAsset = new DownloadAsset(initData);
		_preDownloadAsset.Initialize(_gameLoadingData);
		_state = ResolveState.ApplyingPreDownload;
		_loadState = EGameLoadingState.Loading;
	}

	private void ApplyPreDownloadVersion()
	{
		_downloadData.AssetVersion = _preDownload.AssetsVersion;
		_downloadData.ClientStaticVersion = _preDownload.ClientStaticVersion;
		_downloadData.DllVersion = _preDownload.DllVersion;
		_downloadData.RawFileVersion = _preDownload.RawFileVersion;
		_downloadData.HasVersionInfo = true;
		WritePreDownloadVersionInfo();
	}

	private void WritePreDownloadVersionInfo()
	{
		try
		{
			string text = WriteVersionInfoFlow.WriteVersionInfoFile(_preDownload.AssetsVersion, _preDownload.ClientStaticVersion, _preDownload.DllVersion, _preDownload.RawFileVersion);
			Log("已写入预下载版本信息: " + text + ", " + $"AssetVersion={_preDownload.AssetsVersion}, ClientStaticVersion={_preDownload.ClientStaticVersion}, " + $"DllVersion={_preDownload.DllVersion}, RawFileVersion={_preDownload.RawFileVersion}");
		}
		catch (Exception ex)
		{
			Warning("写入预下载版本信息失败: " + ex.Message);
			LuminErrorAOT.ReportGameLoadingError("C03-0504", "01", 1, ex.Message);
		}
	}

	private void UseNormalPackages()
	{
		_normalZipDownloadParam.Source = RemoteConfigZipSource.Normal;
	}

	private bool CanInstallPreDownload()
	{
		RemoteConfigPreDownload preDownload = _preDownload;
		if (!_downloadData.HasVersionInfo || preDownload == null || !preDownload.HasAnyDiffZipInfos())
		{
			return false;
		}
		PreDownloadPackageStore.PreDownloadTarget preDownloadTarget = PreDownloadPackageStore.CreateTarget(preDownload);
		PreDownloadPackageStore.PreDownloadTarget right = PreDownloadPackageStore.CreateTarget(_downloadData);
		if (PreDownloadPackageStore.Compare(preDownloadTarget, right) <= 0)
		{
			Log("跳过预下载安装: 目标 " + preDownloadTarget.ToVersionKey() + " 未高于本地版本 " + right.ToVersionKey() + "。");
			return false;
		}
		if (PreDownloadPackageStore.TryGetStagedTarget(LuminApplication.GetResPath(), out var target, out var versionKey) && !PreDownloadPackageStore.IsSameOrNewer(preDownloadTarget, target))
		{
			Log("跳过预下载安装: 暂存区已有更新的目标 " + versionKey + "，本次目标 " + preDownloadTarget.ToVersionKey() + " 更旧。");
			return false;
		}
		return true;
	}

	private static bool IsLocalVersionAheadOfRemote(RemoteConfig remote, DownloadData local)
	{
		if (remote == null || local == null || !local.HasVersionInfo)
		{
			return false;
		}
		return PreDownloadPackageStore.Compare(PreDownloadPackageStore.CreateTarget(local), PreDownloadPackageStore.CreateTarget(remote)) > 0;
	}

	private void UseHotfixPackages(RemoteConfigHotfix hotfix)
	{
		_normalZipDownloadParam.Source = RemoteConfigZipSource.Hotfix;
		if (hotfix == null || !hotfix.HasAnyDiffZipInfos())
		{
			_normalZipDownloadParam.AssetsZipDownloadURLs = null;
			_normalZipDownloadParam.ClientStaticZipDownloadURLs = null;
			_normalZipDownloadParam.DllZipDownloadURLs = null;
			_normalZipDownloadParam.RawFileZipDownloadURLs = null;
		}
	}

	private void Complete()
	{
		_state = ResolveState.Complete;
		_loadState = EGameLoadingState.Succeed;
	}

	private void Fail()
	{
		LuminErrorAOT.ReportGameLoadingError("C01-0104", "01", 0);
		_loadState = EGameLoadingState.Failed;
	}

	private static bool VersionsEqual(RemoteConfig remote, DownloadData local)
	{
		if (local != null && local.HasVersionInfo && remote.AssetsVersion == local.AssetVersion && remote.ClientStaticVersion == local.ClientStaticVersion && remote.DllVersion == local.DllVersion)
		{
			return remote.RawFileVersion == local.RawFileVersion;
		}
		return false;
	}

	private static bool IsRemoteVersionNewer(RemoteConfig remote, DownloadData local)
	{
		int num = ((local != null && local.HasVersionInfo) ? local.AssetVersion : 0);
		int num2 = ((local != null && local.HasVersionInfo) ? local.ClientStaticVersion : 0);
		int num3 = ((local != null && local.HasVersionInfo) ? local.DllVersion : 0);
		int num4 = ((local != null && local.HasVersionInfo) ? local.RawFileVersion : 0);
		if (remote.AssetsVersion < num || remote.ClientStaticVersion < num2 || remote.DllVersion < num3 || remote.RawFileVersion < num4)
		{
			return false;
		}
		if (remote.AssetsVersion <= num && remote.ClientStaticVersion <= num2 && remote.DllVersion <= num3)
		{
			return remote.RawFileVersion > num4;
		}
		return true;
	}
}
