using System;
using System.IO;
using ACT.LocalLoader;
using Cysharp.Threading.Tasks;
using UnityEngine;
using YooAsset;

namespace ACT;

public static class YooAssetPackageInitUtility
{
	private static bool _rawFileNeedsReinitialize;

	private static UniTask<bool> _runningRawFileReinitialize;

	public static bool RawFileNeedsReinitialize => _rawFileNeedsReinitialize;

	public static void MarkRawFileNeedsReinitialize()
	{
		_rawFileNeedsReinitialize = true;
	}

	public static UniTask<bool> ReinitializeRawFileIfNeededAsync()
	{
		if (!_rawFileNeedsReinitialize && !IsRawFileReinitializeRunning())
		{
			return UniTask.FromResult(value: true);
		}
		return ReinitializeRawFileAsync();
	}

	public static UniTask<bool> ReinitializeRawFileAsync()
	{
		if (IsRawFileReinitializeRunning())
		{
			return _runningRawFileReinitialize;
		}
		_runningRawFileReinitialize = ReinitializeRawFileInternalAsync();
		return _runningRawFileReinitialize;
	}

	private static bool IsRawFileReinitializeRunning()
	{
		return _runningRawFileReinitialize.Status == UniTaskStatus.Pending;
	}

	private static async UniTask<bool> ReinitializeRawFileInternalAsync()
	{
		YooAssetInitData initData = GameStart.CachedYooAssetInitData;
		if (initData?.YooAssetParam == null)
		{
			Debug.LogError("[YooAssetPackageInitUtility] Cached YooAsset init data is not ready.");
			return false;
		}
		initData.InitPackageData();
		if (initData.PackageInfos == null || !initData.PackageInfos.TryGetValue(AssetType.RawFile, out var packageInfo) || packageInfo == null || string.IsNullOrEmpty(packageInfo.PackageName))
		{
			Debug.LogError("[YooAssetPackageInitUtility] RawFile package info is missing.");
			return false;
		}
		float startTime = Time.realtimeSinceStartup;
		Debug.Log($"[YooAssetPackageInitUtility] Reinitialize RawFile begin: package={packageInfo.PackageName}, playMode={initData.YooAssetParam.PlayMode}");
		try
		{
			ResourcePackage package = YooAssets.TryGetPackage(packageInfo.PackageName);
			if (package == null)
			{
				package = YooAssets.CreatePackage(packageInfo.PackageName);
			}
			if (package.InitializeStatus != EOperationStatus.None)
			{
				DestroyOperation destroyOperation = package.DestroyAsync();
				await destroyOperation.Task;
				if (destroyOperation.Status != EOperationStatus.Succeed)
				{
					Debug.LogError("[YooAssetPackageInitUtility] Destroy RawFile package failed: " + destroyOperation.Error);
					return false;
				}
			}
			packageInfo.Package = package;
			InitializeParameters parameters = CreateInitializeParameters(AssetType.RawFile, package.PackageName, initData.YooAssetParam.PlayMode);
			InitializationOperation initOperation = package.InitializeAsync(parameters);
			await initOperation.Task;
			if (initOperation.Status != EOperationStatus.Succeed)
			{
				Debug.LogError("[YooAssetPackageInitUtility] Initialize RawFile package failed: " + initOperation.Error);
				return false;
			}
			RequestPackageVersionOperation versionOperation = package.RequestPackageVersionAsync();
			await versionOperation.Task;
			if (versionOperation.Status != EOperationStatus.Succeed)
			{
				Debug.LogError("[YooAssetPackageInitUtility] Request RawFile package version failed: " + versionOperation.Error);
				return false;
			}
			packageInfo.RequestPackageVersionOperation = versionOperation;
			string packageVersion = versionOperation.PackageVersion;
			UpdatePackageManifestOperation manifestOperation = package.UpdatePackageManifestAsync(packageVersion);
			await manifestOperation.Task;
			if (manifestOperation.Status != EOperationStatus.Succeed)
			{
				Debug.LogError("[YooAssetPackageInitUtility] Update RawFile package manifest failed: " + manifestOperation.Error);
				return false;
			}
			_rawFileNeedsReinitialize = false;
			Debug.Log($"[YooAssetPackageInitUtility] Reinitialize RawFile complete: version={packageVersion}, elapsed={Time.realtimeSinceStartup - startTime:f3}s");
			return true;
		}
		catch (Exception arg)
		{
			Debug.LogError($"[YooAssetPackageInitUtility] Reinitialize RawFile exception: {arg}");
			return false;
		}
	}

	internal static InitializeParameters CreateInitializeParameters(AssetType assetType, string packageName, EPlayMode playMode)
	{
		switch (playMode)
		{
		case EPlayMode.EditorSimulateMode:
		{
			EditorSimulateModeParameters editorSimulateModeParameters = new EditorSimulateModeParameters();
			string editorSimulatePackageRootDirectory = GetEditorSimulatePackageRootDirectory(packageName);
			if (!CheckEditorSimulateManifest(packageName, editorSimulatePackageRootDirectory, out var error))
			{
				throw new FileNotFoundException(error);
			}
			editorSimulateModeParameters.EditorFileSystemParameters = FileSystemParameters.CreateDefaultEditorFileSystemParameters(editorSimulatePackageRootDirectory);
			return editorSimulateModeParameters;
		}
		case EPlayMode.HostPlayMode:
		{
			string packageVersion = GetPackageVersion(assetType);
			string manifestURL = GetManifestURL(assetType, packageName, packageVersion);
			string manifestURL2 = GetManifestURL(assetType, packageName, packageVersion);
			string bundleURL = GetBundleURL(assetType, packageName);
			RemoteServices remoteServices = new RemoteServices(manifestURL, manifestURL2, bundleURL, assetType, packageName);
			HostPlayModeParameters hostPlayModeParameters = new HostPlayModeParameters();
			IDecryptionServices decryptionServices = CreateDecryptionServices(assetType);
			FileSystemParameters fileSystemParameters2 = FileSystemParameters.CreateDefaultCacheFileSystemParameters(remoteServices, decryptionServices);
			fileSystemParameters2.AddParameter("INSTALL_CLEAR_MODE", EOverwriteInstallClearMode.ClearAllManifestFiles);
			if (assetType == AssetType.RawFile)
			{
				fileSystemParameters2.AddParameter("APPEND_FILE_EXTENSION", true);
			}
			hostPlayModeParameters.CacheFileSystemParameters = fileSystemParameters2;
			return hostPlayModeParameters;
		}
		case EPlayMode.OfflinePlayMode:
		{
			FileSystemParameters fileSystemParameters = FileSystemParameters.CreateDefaultBuildinFileSystemParameters(CreateDecryptionServices(assetType), GetOfflinePath(packageName));
			fileSystemParameters.AddParameter("INSTALL_CLEAR_MODE", EOverwriteInstallClearMode.ClearAllManifestFiles);
			return new OfflinePlayModeParameters
			{
				BuildinFileSystemParameters = fileSystemParameters
			};
		}
		default:
			throw new NotSupportedException($"Unsupported YooAsset play mode: {playMode}");
		}
	}

	private static IDecryptionServices CreateDecryptionServices(AssetType assetType)
	{
		if (assetType != AssetType.RawFile)
		{
			return null;
		}
		return new LuminRawFileEncryptionServices();
	}

	private static string GetManifestURL(AssetType type, string packageName, string assetVersion)
	{
		return LuminApplication.GetManifestPath(type) + "/" + packageName + "/" + assetVersion;
	}

	private static string GetBundleURL(AssetType type, string packageName)
	{
		return LuminApplication.GetBundlePath(type) + "/" + packageName;
	}

	private static string GetPackageVersion(AssetType assetType)
	{
		return assetType switch
		{
			AssetType.Assets => LuminApplication.RemoteConfig.AssetsVersion.ToString(), 
			AssetType.ClientStatic => LuminApplication.RemoteConfig.ClientStaticVersion.ToString(), 
			AssetType.Dll => LuminApplication.RemoteConfig.DllVersion.ToString(), 
			AssetType.RawFile => LuminApplication.RemoteConfig.RawFileVersion.ToString(), 
			_ => "1", 
		};
	}

	private static string GetOfflinePath(string packageName)
	{
		return Application.streamingAssetsPath + "/yoo/" + packageName;
	}

	private static string GetEditorSimulatePackageRootDirectory(string packageName)
	{
		string text = Directory.GetParent(Application.dataPath)?.FullName;
		if (string.IsNullOrEmpty(text))
		{
			return string.Empty;
		}
		return Path.Combine(text, "ServerData", packageName).Replace("\\", "/");
	}

	private static bool CheckEditorSimulateManifest(string packageName, string packageRootDirectory, out string error)
	{
		error = string.Empty;
		if (string.IsNullOrEmpty(packageRootDirectory) || !Directory.Exists(packageRootDirectory))
		{
			error = GetEditorSimulateManifestMissingMessage(packageName, packageRootDirectory);
			return false;
		}
		string text = Path.Combine(packageRootDirectory, YooAssetSettingsData.GetPackageVersionFileName(packageName));
		if (!File.Exists(text))
		{
			error = GetEditorSimulateManifestMissingMessage(packageName, text);
			return false;
		}
		string text2 = File.ReadAllText(text).Trim();
		if (string.IsNullOrEmpty(text2))
		{
			error = GetEditorSimulateManifestMissingMessage(packageName, text);
			return false;
		}
		string text3 = Path.Combine(packageRootDirectory, YooAssetSettingsData.GetPackageHashFileName(packageName, text2));
		if (!File.Exists(text3))
		{
			error = GetEditorSimulateManifestMissingMessage(packageName, text3);
			return false;
		}
		string text4 = Path.Combine(packageRootDirectory, YooAssetSettingsData.GetManifestBinaryFileName(packageName, text2));
		if (!File.Exists(text4))
		{
			error = GetEditorSimulateManifestMissingMessage(packageName, text4);
			return false;
		}
		return true;
	}

	private static string GetEditorSimulateManifestMissingMessage(string packageName, string missingPath)
	{
		return "Editor Simulate Manifest missing for package '" + packageName + "'. Missing: " + missingPath + ". Click the toolbar button '刷新资源索引' or menu '资源/刷新编辑器资源索引' to refresh.";
	}
}
