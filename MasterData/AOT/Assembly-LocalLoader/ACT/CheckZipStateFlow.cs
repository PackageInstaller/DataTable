using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using ACT.Error;
using Cysharp.Threading.Tasks;
using Newtonsoft.Json.Linq;
using UnityEngine;
using UnityEngine.Networking;
using bamboosdk;

namespace ACT;

internal class CheckZipStateFlow : DownloadAssetSubFlowBase
{
	private const int DefaultZipSizeRequestBatch = 4;

	private bool _zipSizeCalculating;

	private bool _zipSizeCalculated;

	private DateTime _verStart;

	internal override EGameLoadingStage Stage => EGameLoadingStage.CheckZipState;

	internal CheckZipStateFlow(DownloadAssetContext context)
		: base(context)
	{
	}

	internal override void Init(GameLoadingData data)
	{
		_zipSizeCalculating = false;
		_zipSizeCalculated = false;
		Context.HasZipPackages = HasAnyZipPackages();
		Debug.Log($"[DownloadFlow] ZIP state check initialized: hasZipPackages={Context.HasZipPackages}, " + $"packageTypeCount={Context.PackageInfos?.Count ?? 0}, tags={GetDownloadTagSummary()}.");
		DownloadData.MaxDownloadBytes = 0L;
		DownloadData.CurDownloadBytes = 0L;
		DownloadData.DownloadComplete = false;
		DownloadData.DownloadFail = false;
		DownloadData.CanRetry = false;
		DownloadData.CancelRequested = false;
		SetProgressStage(ProgressStageType.Download);
		DownloadData.ErrorCode = "C01-9999";
		DownloadData.SystemModule = "00";
		DownloadData.Message = "";
		_loadState = EGameLoadingState.Loading;
	}

	internal override void Update()
	{
		try
		{
			if (!DownloadData.DownloadFail || DownloadData.CanRetry)
			{
				if (!Context.HasZipPackages)
				{
					DownloadData.MaxDownloadBytes = 0L;
					_loadState = EGameLoadingState.Succeed;
				}
				else if (_zipSizeCalculated)
				{
					_zipSizeCalculated = false;
					_loadState = EGameLoadingState.Succeed;
				}
				else if (!_zipSizeCalculating)
				{
					_zipSizeCalculating = true;
					CalculateZipPackagesSizeAsync().Forget();
				}
			}
		}
		catch (Exception exception)
		{
			Exception(exception);
			_zipSizeCalculating = false;
			_zipSizeCalculated = true;
			FailZipStateCheck(exception);
		}
	}

	private async UniTask CalculateZipPackagesSizeAsync()
	{
		_ = 1;
		try
		{
			_verStart = DateTime.Now;
			BamBooSdk.getInstance().taEvent("file_verification_start", new JObject().ToString());
			EnsureZipDirectoriesInitialized();
			Context.ZipPackageInfos = new Dictionary<AssetType, List<ZipPackageInfo>>();
			long num = 0L;
			int matchedZipCount = 0;
			Debug.Log("[DownloadFlow] ZIP state check begin: tags=" + GetDownloadTagSummary() + ".");
			foreach (KeyValuePair<AssetType, PackageInfo> packageInfo in Context.PackageInfos)
			{
				AssetType assetType = packageInfo.Key;
				ZipInfo[] zipUrls = GetZipDownloadURLs(assetType);
				_ = Context.ZipDownloadDirectories[assetType];
				if (zipUrls == null || zipUrls.Length == 0)
				{
					Context.ZipPackageInfos[assetType] = new List<ZipPackageInfo>();
					continue;
				}
				List<ZipPackageInfo> packageInfoList = new List<ZipPackageInfo>();
				List<(UniTask<long> task, ZipPackageInfo info)> sizeTasks = new List<(UniTask<long>, ZipPackageInfo)>(4);
				for (int i = 0; i < zipUrls.Length; i++)
				{
					ZipInfo zipInfo = zipUrls[i];
					if (zipInfo == null || string.IsNullOrEmpty(zipInfo.url))
					{
						continue;
					}
					string url = zipInfo.url;
					string zipFilePath = GetZipFilePath(url, assetType);
					string zipStreamingAssetsFilePath = GetZipStreamingAssetsFilePath(url, assetType);
					string fileName = Path.GetFileName(zipFilePath);
					long num2 = 0L;
					if (!string.IsNullOrEmpty(zipInfo.size) && long.TryParse(zipInfo.size, out var result))
					{
						num2 = result;
					}
					string text = GenerateHashSizeFileName(zipInfo.hash, num2);
					if (string.IsNullOrEmpty(text))
					{
						text = fileName;
					}
					ZipPackageInfo zipInfo2 = new ZipPackageInfo
					{
						Url = url,
						AssetType = assetType,
						Index = i,
						FilePath = zipFilePath,
						DownloadFilePath = zipFilePath,
						StreamingAssetsFilePath = zipStreamingAssetsFilePath,
						FileName = text,
						RemoteFileSize = num2,
						ExpectedHash = zipInfo.hash,
						IsDownloaded = false,
						IsExtracted = false,
						DownloadedBytes = 0L
					};
					zipInfo2.UpdateTagState(zipInfo.tag);
					zipInfo2.UpdateDownloadState();
					zipInfo2.UpdateExtractState(this);
					if (!ContainsDownloadTag(zipInfo2.Tags))
					{
						Log($"[{assetType}] zip标签不匹配玩家标签: {fileName}，跳过下载与解压流程");
						continue;
					}
					if (zipInfo2.IsDownloaded)
					{
						if (zipInfo2.IsFromStreamingAssets)
						{
							zipInfo2.RemoteFileSize = ((zipInfo2.DownloadedBytes > 0) ? zipInfo2.DownloadedBytes : num2);
							Log($"[{assetType}] 在StreamingAssets中发现zip文件: {Path.GetFileName(zipInfo2.FilePath)}，大小 {zipInfo2.DownloadedBytes} bytes，跳过下载统计");
						}
						else if (num2 > 0 && zipInfo2.DownloadedBytes != num2)
						{
							Warning($"[{assetType}] zip文件未完成: {fileName}，当前 {zipInfo2.DownloadedBytes} bytes，目标 {num2} bytes，将继续下载");
							zipInfo2.IsDownloaded = false;
							zipInfo2.FilePath = zipInfo2.DownloadFilePath;
							zipInfo2.RemoteFileSize = num2;
							num += num2;
						}
						else
						{
							zipInfo2.RemoteFileSize = zipInfo2.DownloadedBytes;
							Log($"[{assetType}] 已存在zip文件: {fileName}，大小 {zipInfo2.DownloadedBytes} bytes，跳过下载统计");
						}
					}
					else if (zipInfo2.IsExtracted)
					{
						if (TryGetZipMarkerBytes(fileName, assetType, out var markerBytes))
						{
							zipInfo2.RemoteFileSize = markerBytes;
							Log($"[{assetType}] 已存在zip标记文件: {fileName} = {markerBytes} bytes，跳过下载统计");
						}
						else if (num2 > 0)
						{
							zipInfo2.RemoteFileSize = num2;
						}
					}
					else if (num2 > 0)
					{
						zipInfo2.RemoteFileSize = num2;
						num += num2;
					}
					else
					{
						sizeTasks.Add((GetRemoteFileSizeAsync(BuildFullUrl(url, assetType)), zipInfo2));
						if (sizeTasks.Count >= 4)
						{
							long num3 = num;
							num = num3 + await AwaitSizeBatch(sizeTasks);
						}
					}
					packageInfoList.Add(zipInfo2);
					matchedZipCount++;
				}
				if (sizeTasks.Count > 0)
				{
					long num3 = num;
					num = num3 + await AwaitSizeBatch(sizeTasks);
				}
				Context.ZipPackageInfos[assetType] = packageInfoList;
			}
			Context.ZipTotalBytes = num;
			DownloadData.MaxDownloadBytes = num;
			Debug.Log($"[DownloadFlow] ZIP state check completed: matchedZipCount={matchedZipCount}, " + $"totalBytes={num}, tags={GetDownloadTagSummary()}.");
			JObject jObject = new JObject
			{
				["result"] = 1,
				["event_duration"] = (DateTime.Now - _verStart).TotalSeconds
			};
			BamBooSdk.getInstance().taEvent("file_verification_end", jObject.ToString());
		}
		catch (Exception exception)
		{
			Exception(exception);
			FailZipStateCheck(exception);
		}
		finally
		{
			_zipSizeCalculating = false;
			_zipSizeCalculated = true;
		}
	}

	private async UniTask<long> AwaitSizeBatch(List<(UniTask<long> task, ZipPackageInfo info)> tasks)
	{
		long sum = 0L;
		long[] array = await UniTask.WhenAll(tasks.Select(((UniTask<long> task, ZipPackageInfo info) t) => t.task).ToList());
		for (int num = 0; num < array.Length; num++)
		{
			long num2 = array[num];
			if (num2 > 0)
			{
				tasks[num].info.RemoteFileSize = num2;
				sum += num2;
			}
		}
		tasks.Clear();
		return sum;
	}

	private async UniTask<long> GetRemoteFileSizeAsync(string url)
	{
		try
		{
			using UnityWebRequest request = UnityWebRequest.Head(url);
			request.method = "HEAD";
			await request.SendWebRequest();
			if (request.result != UnityWebRequest.Result.Success)
			{
				Warning("获取Zip包大小失败: " + request.error);
				return 0L;
			}
			if (long.TryParse(request.GetResponseHeader("Content-Length"), out var result))
			{
				return result;
			}
		}
		catch (Exception ex)
		{
			Warning("获取Zip包大小异常: " + ex.Message);
		}
		return 0L;
	}

	private static string BuildFullUrl(string relativePath, AssetType assetType)
	{
		if (string.IsNullOrEmpty(relativePath))
		{
			return relativePath;
		}
		if (Uri.TryCreate(relativePath, UriKind.Absolute, out var result) && (result.Scheme == Uri.UriSchemeHttp || result.Scheme == Uri.UriSchemeHttps))
		{
			return result.ToString();
		}
		string cDNPath = LuminApplication.GetCDNPath(assetType);
		if (string.IsNullOrEmpty(cDNPath))
		{
			return relativePath;
		}
		return cDNPath.TrimEnd('/') + "/" + relativePath.TrimStart('/');
	}

	private string GetDownloadTagSummary()
	{
		string[] array = Context.ZipDownloadParam?.DownloadTags;
		if (array != null && array.Length != 0)
		{
			return string.Join(",", array);
		}
		return "<all>";
	}

	private void FailZipStateCheck(Exception exception)
	{
		Context.ZipTotalBytes = 0L;
		DownloadData.MaxDownloadBytes = 0L;
		DownloadData.ErrorCode = "C01-0501";
		DownloadData.SystemModule = "00";
		DownloadData.Message = exception.Message;
		DownloadData.DownloadFail = true;
		DownloadData.CanRetry = false;
		DownloadData.AcceptUpdate = false;
		_loadState = EGameLoadingState.Failed;
		Debug.LogError("[DownloadFlow] ZIP state check failed: " + exception.Message);
	}

	private bool HasAnyZipPackages()
	{
		ZipDownloadParam zipDownloadParam = Context.ZipDownloadParam;
		bool num = zipDownloadParam.DllZipDownloadURLs != null && zipDownloadParam.DllZipDownloadURLs.Length != 0;
		bool flag = zipDownloadParam.ClientStaticZipDownloadURLs != null && zipDownloadParam.ClientStaticZipDownloadURLs.Length != 0;
		bool flag2 = zipDownloadParam.AssetsZipDownloadURLs != null && zipDownloadParam.AssetsZipDownloadURLs.Length != 0;
		bool flag3 = zipDownloadParam.RawFileZipDownloadURLs != null && zipDownloadParam.RawFileZipDownloadURLs.Length != 0;
		if (num | flag | flag2 | flag3)
		{
			return true;
		}
		try
		{
			EnsureZipDirectoriesInitialized();
			if (Context.ZipDownloadDirectories != null)
			{
				foreach (string value in Context.ZipDownloadDirectories.Values)
				{
					if (!string.IsNullOrEmpty(value) && Directory.Exists(value))
					{
						string[] files = Directory.GetFiles(value, "*.zip", SearchOption.TopDirectoryOnly);
						if (files.Length != 0)
						{
							Log($"在下载目录中发现 {files.Length} 个已存在的zip文件: {value}");
							return true;
						}
					}
				}
			}
		}
		catch (Exception ex)
		{
			LuminErrorAOT.ReportGameLoadingError("C01-0506", "03", 0, "", retry: false, null, showDialog: false);
			Log("检查下载目录时出错: " + ex.Message);
		}
		return false;
	}
}
