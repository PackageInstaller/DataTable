using System;
using System.Collections.Generic;
using System.IO;
using System.Security.Cryptography;
using Cysharp.Threading.Tasks;

namespace ACT;

internal sealed class ApplyPreDownloadedZipPackagesFlow : DownloadAssetSubFlowBase
{
	private bool _applyInProgress;

	private bool _applyCompleted;

	private bool _applySucceeded;

	internal override EGameLoadingStage Stage => EGameLoadingStage.CheckZipState;

	internal ApplyPreDownloadedZipPackagesFlow(DownloadAssetContext context)
		: base(context)
	{
	}

	internal override void Init(GameLoadingData data)
	{
		_applyInProgress = false;
		_applyCompleted = false;
		_applySucceeded = false;
		_loadState = EGameLoadingState.Loading;
	}

	internal override void Update()
	{
		if (!_applyInProgress && !_applyCompleted)
		{
			_applyInProgress = true;
			ApplyPreDownloadedPackagesAsync().Forget();
		}
		else if (_applyCompleted)
		{
			_loadState = (_applySucceeded ? EGameLoadingState.Succeed : EGameLoadingState.Failed);
		}
	}

	private async UniTask ApplyPreDownloadedPackagesAsync()
	{
		try
		{
			string versionKey = Context.ZipDownloadParam?.PreDownloadVersionKey;
			if (string.IsNullOrEmpty(versionKey))
			{
				if (!PreDownloadPackageStore.IsCurrentRemoteVersionNewerThanLocal(DownloadData, out var reason))
				{
					Log("跳过解压预下载暂存包: " + reason + "。");
					_applySucceeded = true;
					return;
				}
				if (!PreDownloadPackageStore.TryGetCurrentVersionKey(out versionKey))
				{
					Log("跳过解压预下载暂存包: 无法确定当前版本 key。");
					_applySucceeded = true;
					return;
				}
			}
			if (Context.ZipPackageInfos == null || Context.PackageInfos == null)
			{
				Log($"跳过解压预下载暂存包: zip 信息不可用(zipPackageInfos={Context.ZipPackageInfos != null}, " + $"packageInfos={Context.PackageInfos != null})。");
				_applySucceeded = true;
				return;
			}
			string resourceRoot = GetDataDirectory();
			int appliedCount = 0;
			int stagedFoundCount = 0;
			Log("[DownloadFlow] 开始应用预下载暂存包: versionKey=" + versionKey + ", root=" + resourceRoot + ", " + $"待下载zip={CountNeedDownloadZips()}");
			foreach (KeyValuePair<AssetType, List<ZipPackageInfo>> packagePair in Context.ZipPackageInfos)
			{
				if (!Context.PackageInfos.TryGetValue(packagePair.Key, out var packageInfo) || string.IsNullOrEmpty(packageInfo.PackageName) || packagePair.Value == null)
				{
					continue;
				}
				foreach (ZipPackageInfo zipInfo in packagePair.Value)
				{
					if (!zipInfo.NeedDownload)
					{
						continue;
					}
					string stagedZipPath = ResolveStagedZipPath(resourceRoot, versionKey, packageInfo.PackageName, zipInfo);
					if (!string.IsNullOrEmpty(stagedZipPath))
					{
						stagedFoundCount++;
						Log($"[{packagePair.Key}] 校验预下载暂存包: {stagedZipPath}");
						bool flag;
						try
						{
							flag = await IsMatchingStagedZipAsync(stagedZipPath, zipInfo);
						}
						catch (Exception ex)
						{
							Warning($"[{packagePair.Key}] 校验预下载暂存包时发生异常，保留且不使用: {stagedZipPath}, {ex.Message}");
							continue;
						}
						if (!flag)
						{
							Warning($"[{packagePair.Key}] 预下载暂存包不匹配当前正式更新，保留且不使用: {stagedZipPath}");
							continue;
						}
						zipInfo.PreDownloadedFilePath = stagedZipPath;
						zipInfo.FilePath = stagedZipPath;
						zipInfo.IsDownloaded = true;
						zipInfo.DownloadedBytes = 0L;
						appliedCount++;
					}
				}
				packageInfo = null;
			}
			RecalculateDownloadBytes();
			Log($"预下载暂存包应用结束: 命中暂存包 {stagedFoundCount} 个，应用 {appliedCount} 个。");
			if (appliedCount > 0)
			{
				Context.HasAppliedPreDownloadedPackages = true;
				Log($"已应用 {appliedCount} 个匹配当前版本的预下载暂存包，后续将先解压它们。");
			}
			_applySucceeded = true;
		}
		catch (Exception ex2)
		{
			Exception(ex2);
			DownloadData.ErrorCode = "C03-0507";
			DownloadData.SystemModule = "03";
			DownloadData.Message = ex2.Message;
			DownloadData.DownloadFail = true;
			DownloadData.CanRetry = true;
			DownloadData.AcceptUpdate = false;
			_applySucceeded = false;
		}
		finally
		{
			_applyInProgress = false;
			_applyCompleted = true;
		}
	}

	private static string ResolveStagedZipPath(string resourceRoot, string versionKey, string packageName, ZipPackageInfo zipInfo)
	{
		return TryGetStagedZipPath(resourceRoot, versionKey, packageName, Path.GetFileName(zipInfo.Url)) ?? TryGetStagedZipPath(resourceRoot, versionKey, packageName, zipInfo.FileName) ?? TryGetStagedZipPath(resourceRoot, versionKey, packageName, $"{zipInfo.AssetType}.zip");
	}

	private static string TryGetStagedZipPath(string resourceRoot, string versionKey, string packageName, string stagedFileName)
	{
		if (string.IsNullOrEmpty(stagedFileName))
		{
			return null;
		}
		string stagedZipPath = PreDownloadPackageStore.GetStagedZipPath(resourceRoot, versionKey, packageName, stagedFileName);
		if (string.IsNullOrEmpty(stagedZipPath) || !File.Exists(stagedZipPath))
		{
			return null;
		}
		return stagedZipPath;
	}

	private int CountNeedDownloadZips()
	{
		if (Context.ZipPackageInfos == null)
		{
			return 0;
		}
		int num = 0;
		foreach (KeyValuePair<AssetType, List<ZipPackageInfo>> zipPackageInfo in Context.ZipPackageInfos)
		{
			if (zipPackageInfo.Value == null)
			{
				continue;
			}
			foreach (ZipPackageInfo item in zipPackageInfo.Value)
			{
				if (item != null && item.NeedDownload)
				{
					num++;
				}
			}
		}
		return num;
	}

	private async UniTask<bool> IsMatchingStagedZipAsync(string filePath, ZipPackageInfo zipInfo)
	{
		FileInfo fileInfo = new FileInfo(filePath);
		if (zipInfo.RemoteFileSize > 0 && fileInfo.Length != zipInfo.RemoteFileSize)
		{
			return false;
		}
		if (string.IsNullOrEmpty(zipInfo.ExpectedHash))
		{
			return true;
		}
		await UniTask.SwitchToThreadPool();
		bool result;
		try
		{
			using MD5 mD = MD5.Create();
			using FileStream fileStream = File.OpenRead(filePath);
			int num = (int)Math.Min(fileStream.Length, 2048L);
			byte[] buffer = new byte[num];
			if (fileStream.Length > 2048)
			{
				fileStream.Seek(-2048L, SeekOrigin.End);
			}
			int num2 = 0;
			while (true)
			{
				if (num2 < num)
				{
					int num3 = fileStream.Read(buffer, num2, num - num2);
					if (num3 == 0)
					{
						result = false;
						break;
					}
					num2 += num3;
					continue;
				}
				string a = BitConverter.ToString(mD.ComputeHash(buffer)).Replace("-", "").ToLowerInvariant();
				result = string.Equals(a, zipInfo.ExpectedHash, StringComparison.OrdinalIgnoreCase);
				break;
			}
		}
		finally
		{
			await UniTask.SwitchToMainThread();
		}
		return result;
	}

	private void RecalculateDownloadBytes()
	{
		long num = 0L;
		foreach (KeyValuePair<AssetType, List<ZipPackageInfo>> zipPackageInfo in Context.ZipPackageInfos)
		{
			if (zipPackageInfo.Value == null)
			{
				continue;
			}
			foreach (ZipPackageInfo item in zipPackageInfo.Value)
			{
				if (item.NeedDownload)
				{
					num += Math.Max(0L, item.RemoteFileSize);
				}
			}
		}
		Context.ZipTotalBytes = num;
		Context.DownloadedZipBytes = 0L;
		DownloadData.MaxDownloadBytes = num;
		DownloadData.CurDownloadBytes = 0L;
	}
}
