using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using Cysharp.Threading.Tasks;
using Newtonsoft.Json.Linq;
using UnityEngine;
using UnityEngine.Networking;
using bamboosdk;

namespace ACT;

internal class DownloadZipPackagesFlow : DownloadAssetSubFlowBase
{
	private class StreamingDownloadHandler : DownloadHandlerScript
	{
		private FileStream _fileStream;

		private long _totalReceived;

		public long TotalReceived => _totalReceived;

		public StreamingDownloadHandler(FileStream fileStream, long startPosition)
		{
			_fileStream = fileStream;
			_totalReceived = startPosition;
		}

		protected override bool ReceiveData(byte[] data, int dataLength)
		{
			if (data == null || dataLength == 0)
			{
				return false;
			}
			try
			{
				_fileStream.Write(data, 0, dataLength);
				_fileStream.Flush();
				_totalReceived += dataLength;
				return true;
			}
			catch
			{
				return false;
			}
		}
	}

	private const int MaxZipDownloadRetryCount = 3;

	private const int MaxSingleFileRetryCount = 4;

	private const float DownloadProgressUpdateInterval = 0.5f;

	private bool _zipDownloadInProgress;

	private bool _zipDownloadCompleted;

	private bool _zipDownloadSuccess;

	private int _zipDownloadRetryCount;

	private bool _useBackupCdn;

	private float _lastDownloadProgressUpdateTime;

	private long _lastDownloadProgressBytes;

	private const float WaitAcceptUpdateLogInterval = 5f;

	private float _waitAcceptUpdateFirstLogTime;

	private float _lastWaitAcceptUpdateLogTime;

	private bool _bambooSdkDownloadCompleted;

	private bool _bambooSdkDownloadSuccess;

	private List<ZipPackageInfo> _bambooSdkPackages;

	private const float BambooWaitLogInterval = 10f;

	private float _bambooWaitStartTime;

	private float _lastBambooWaitLogTime;

	internal override EGameLoadingStage Stage => EGameLoadingStage.DownloadZipPackages;

	internal DownloadZipPackagesFlow(DownloadAssetContext context)
		: base(context)
	{
	}

	internal override void Init(GameLoadingData data)
	{
		_zipDownloadInProgress = false;
		_zipDownloadCompleted = false;
		_zipDownloadSuccess = false;
		_zipDownloadRetryCount = 0;
		_useBackupCdn = false;
		_lastDownloadProgressUpdateTime = 0f;
		_lastDownloadProgressBytes = 0L;
		_waitAcceptUpdateFirstLogTime = 0f;
		_lastWaitAcceptUpdateLogTime = 0f;
		_loadState = EGameLoadingState.Loading;
	}

	private bool IsCancelRequested()
	{
		if (DownloadData != null)
		{
			return DownloadData.CancelRequested;
		}
		return false;
	}

	private void MarkCanceled()
	{
		_zipDownloadInProgress = false;
		_zipDownloadCompleted = true;
		_zipDownloadSuccess = false;
		if (DownloadData != null)
		{
			DownloadData.DownloadFail = true;
			DownloadData.CanRetry = false;
			DownloadData.AcceptUpdate = false;
		}
	}

	private string GetCurrentCdnBase(AssetType assetType)
	{
		if (LuminApplication.RemoteConfig == null)
		{
			return "";
		}
		if (_useBackupCdn)
		{
			string backUpCDNPath = LuminApplication.GetBackUpCDNPath(assetType);
			if (!string.IsNullOrEmpty(backUpCDNPath))
			{
				return backUpCDNPath.TrimEnd('/');
			}
		}
		string cDNPath = LuminApplication.GetCDNPath(assetType);
		if (string.IsNullOrEmpty(cDNPath))
		{
			return "";
		}
		return cDNPath.TrimEnd('/');
	}

	private string BuildFullUrl(string relativePath, AssetType assetType)
	{
		if (Uri.TryCreate(relativePath, UriKind.Absolute, out var result) && (result.Scheme == Uri.UriSchemeHttp || result.Scheme == Uri.UriSchemeHttps))
		{
			return result.ToString();
		}
		string currentCdnBase = GetCurrentCdnBase(assetType);
		if (string.IsNullOrEmpty(currentCdnBase))
		{
			return relativePath;
		}
		string text = relativePath.TrimStart('/');
		return currentCdnBase + "/" + text;
	}

	internal override void Update()
	{
		try
		{
			if (IsCancelRequested())
			{
				MarkCanceled();
				_loadState = EGameLoadingState.Failed;
				return;
			}
			if (!Context.HasZipPackages || Context.ZipPackageInfos == null || Context.ZipPackageInfos.Count == 0)
			{
				Log($"[DownloadFlow] 没有需要下载的Zip包，本子流程直接完成: hasZipPackages={Context.HasZipPackages}, " + $"zipPackageInfos={Context.ZipPackageInfos?.Count ?? 0}");
				_loadState = EGameLoadingState.Succeed;
				return;
			}
			EnsureZipDirectoriesInitialized();
			if (!DownloadData.AcceptUpdate)
			{
				if (CountNeedDownloadZips() == 0)
				{
					Log("[DownloadFlow] 没有待下载的Zip包，无需等待更新确认，本子流程直接完成。");
					_zipDownloadCompleted = true;
					_zipDownloadSuccess = true;
					_loadState = EGameLoadingState.Succeed;
				}
				else
				{
					WarnWaitingAcceptUpdate();
				}
			}
			else if (!_zipDownloadInProgress && !_zipDownloadCompleted)
			{
				SetProgressStage(ProgressStageType.Download);
				ResetDownloadProgressState();
				ApplyBaselineDownloadedBytesFromPartialFiles();
				UpdateDownloadProgress(isActive: true, DownloadData.CurDownloadBytes, DownloadData.MaxDownloadBytes, 0L, forceNotify: true);
				_zipDownloadInProgress = true;
				_zipDownloadCompleted = false;
				_zipDownloadSuccess = false;
				DownloadAllZipPackages().Forget();
			}
			else if (_zipDownloadCompleted)
			{
				if (_zipDownloadSuccess)
				{
					_zipDownloadRetryCount = 0;
					UpdateDownloadProgress(isActive: false, DownloadData.MaxDownloadBytes, DownloadData.MaxDownloadBytes, 0L, forceNotify: true);
					_loadState = EGameLoadingState.Succeed;
				}
				else if (_zipDownloadRetryCount < 3)
				{
					_zipDownloadRetryCount++;
					_zipDownloadInProgress = false;
					_zipDownloadCompleted = false;
					_zipDownloadSuccess = false;
					ApplyBaselineDownloadedBytesFromPartialFiles();
				}
				else
				{
					DownloadData.ErrorCode = "C01-0501";
					DownloadData.SystemModule = "01";
					DownloadData.Message = "";
					DownloadData.DownloadFail = true;
					DownloadData.CanRetry = true;
					DownloadData.AcceptUpdate = false;
					UpdateDownloadProgress(isActive: false, DownloadData.CurDownloadBytes, DownloadData.MaxDownloadBytes, 0L, forceNotify: true);
					_loadState = EGameLoadingState.Failed;
				}
			}
		}
		catch (Exception exception)
		{
			Exception(exception);
			_zipDownloadInProgress = false;
			_zipDownloadCompleted = true;
			_zipDownloadSuccess = false;
			DownloadData.ErrorCode = "C01-0501";
			DownloadData.SystemModule = "01";
			DownloadData.Message = "";
			DownloadData.DownloadFail = true;
			DownloadData.CanRetry = true;
			DownloadData.AcceptUpdate = false;
			UpdateDownloadProgress(isActive: false, DownloadData.CurDownloadBytes, DownloadData.MaxDownloadBytes, 0L, forceNotify: true);
			_loadState = EGameLoadingState.Failed;
		}
	}

	private void WarnWaitingAcceptUpdate()
	{
		float realtimeSinceStartup = Time.realtimeSinceStartup;
		if (_waitAcceptUpdateFirstLogTime <= 0f)
		{
			_waitAcceptUpdateFirstLogTime = realtimeSinceStartup;
			_lastWaitAcceptUpdateLogTime = realtimeSinceStartup;
			Warning("[DownloadFlow] 下载未启动: 等待用户确认更新(AcceptUpdate=false), " + $"待下载zip={CountNeedDownloadZips()}, max={DownloadData.MaxDownloadBytes}, " + $"cur={DownloadData.CurDownloadBytes}");
		}
		else if (!(realtimeSinceStartup - _lastWaitAcceptUpdateLogTime < 5f))
		{
			_lastWaitAcceptUpdateLogTime = realtimeSinceStartup;
			Warning($"[DownloadFlow] 仍在等待用户确认更新(AcceptUpdate=false), 已等待 {realtimeSinceStartup - _waitAcceptUpdateFirstLogTime:F0}s");
		}
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

	private async UniTask<bool> DownloadAllZipPackages()
	{
		_ = 1;
		try
		{
			if (IsCancelRequested())
			{
				MarkCanceled();
				return false;
			}
			Log($"开始执行Zip包下载，当前自动重试次数: {_zipDownloadRetryCount}/{3}");
			EnsureZipDirectoriesInitialized();
			Log("开始下载所有Zip包");
			if (Context.ZipPackageInfos == null || Context.ZipPackageInfos.Count == 0)
			{
				Error("未找到zip包信息，无法下载");
				_zipDownloadCompleted = true;
				_zipDownloadSuccess = false;
				_zipDownloadInProgress = false;
				return false;
			}
			float size = (float)DownloadData.MaxDownloadBytes / 1048576f;
			JObject jObject = new JObject { ["size"] = size };
			BamBooSdk.getInstance().taEvent("resource_download_begin", jObject.ToString());
			List<ZipPackageInfo> allNeedDownloadPackages = new List<ZipPackageInfo>();
			foreach (KeyValuePair<AssetType, List<ZipPackageInfo>> zipPackageInfo in Context.ZipPackageInfos)
			{
				if (IsCancelRequested())
				{
					MarkCanceled();
					return false;
				}
				AssetType key = zipPackageInfo.Key;
				List<ZipPackageInfo> value = zipPackageInfo.Value;
				if (value == null || value.Count == 0)
				{
					continue;
				}
				int num = Enumerable.Count(value, (ZipPackageInfo z) => z.NeedDownload);
				if (num == 0)
				{
					Log($"[{key}] 所有Zip包已下载或已解压，跳过下载");
					continue;
				}
				Log($"[{key}] 需要下载 {num}/{value.Count} 个Zip包");
				foreach (ZipPackageInfo item in value)
				{
					if (item.NeedDownload)
					{
						allNeedDownloadPackages.Add(item);
					}
				}
			}
			if (allNeedDownloadPackages.Count == 0)
			{
				Log("所有Zip包已下载或已解压，跳过下载");
				_zipDownloadCompleted = true;
				_zipDownloadSuccess = true;
				_zipDownloadInProgress = false;
				return true;
			}
			Log($"开始下载共 {allNeedDownloadPackages.Count} 个Zip包");
			bool flag = await DownloadUsingBambooSdk(allNeedDownloadPackages);
			if (IsCancelRequested())
			{
				MarkCanceled();
				return false;
			}
			if (!flag)
			{
				Error("Zip包下载失败");
				_zipDownloadCompleted = true;
				_zipDownloadSuccess = false;
				_zipDownloadInProgress = false;
				DownloadData.ErrorCode = "C01-0501";
				DownloadData.SystemModule = "01";
				DownloadData.Message = "";
				DownloadData.DownloadFail = true;
				DownloadData.CanRetry = true;
				JObject jObject2 = new JObject
				{
					["size"] = size,
					["result"] = 2,
					["type"] = 3
				};
				BamBooSdk.getInstance().taEvent("resource_download_end", jObject2.ToString());
				return false;
			}
			foreach (ZipPackageInfo item2 in allNeedDownloadPackages)
			{
				item2.UpdateDownloadState();
			}
			Log("所有Zip包下载完成");
			Context.DownloadedZipBytes = Context.ZipTotalBytes;
			DownloadData.CurDownloadBytes = DownloadData.MaxDownloadBytes;
			UpdateDownloadProgress(isActive: false, DownloadData.MaxDownloadBytes, DownloadData.MaxDownloadBytes, 0L, forceNotify: true);
			bool flag2 = await VerifyAndProcessDownloadedFiles();
			if (IsCancelRequested())
			{
				MarkCanceled();
				return false;
			}
			if (!flag2)
			{
				Error("文件校验或处理失败");
				_zipDownloadCompleted = true;
				_zipDownloadSuccess = false;
				_zipDownloadInProgress = false;
				DownloadData.ErrorCode = "C03-0507";
				DownloadData.SystemModule = "03";
				DownloadData.Message = "";
				DownloadData.DownloadFail = true;
				DownloadData.CanRetry = true;
				DownloadData.AcceptUpdate = false;
				JObject jObject3 = new JObject
				{
					["size"] = size,
					["result"] = 2,
					["type"] = 3
				};
				BamBooSdk.getInstance().taEvent("resource_download_end", jObject3.ToString());
				return false;
			}
			JObject jObject4 = new JObject
			{
				["size"] = size,
				["result"] = 1,
				["type"] = 3
			};
			BamBooSdk.getInstance().taEvent("resource_download_end", jObject4.ToString());
			_zipDownloadRetryCount = 0;
			_zipDownloadCompleted = true;
			_zipDownloadSuccess = true;
			_zipDownloadInProgress = false;
			return true;
		}
		catch (Exception ex)
		{
			Exception(ex);
			DownloadData.ErrorCode = "C01-0501";
			DownloadData.SystemModule = "03";
			DownloadData.Message = ex.Message;
			DownloadData.DownloadFail = true;
			DownloadData.CanRetry = true;
			DownloadData.AcceptUpdate = false;
			_zipDownloadCompleted = true;
			_zipDownloadSuccess = false;
			_zipDownloadInProgress = false;
			UpdateDownloadProgress(isActive: false, DownloadData.CurDownloadBytes, DownloadData.MaxDownloadBytes, 0L, forceNotify: true);
			return false;
		}
	}

	private async UniTask<bool> DownloadUsingBambooSdk(List<ZipPackageInfo> needDownloadPackages)
	{
		_ = 1;
		try
		{
			_bambooSdkPackages = needDownloadPackages;
			DownloadData downloadData = DownloadData;
			downloadData.DownloadCallback = (Action<DownloadCallbackInfo>)Delegate.Combine(downloadData.DownloadCallback, new Action<DownloadCallbackInfo>(OnUpdateDownloadProgress));
			try
			{
				int attemptsPerCdn = 1 + Mathf.Max(0, 2);
				if (!(await ExecuteBambooSdkDownloadAttemptsAsync(needDownloadPackages, attemptsPerCdn)))
				{
					bool useBackupCdn = _useBackupCdn;
					_useBackupCdn = !_useBackupCdn;
					LogBambooDownloadFailedZips(needDownloadPackages);
					Warning($"[Bamboo] backgroundDownload 失败，已切换 CDN（原 useBackupCdn={useBackupCdn}）当前基址: {GetCurrentCdnBase((needDownloadPackages.Count > 0) ? needDownloadPackages[0].AssetType : AssetType.Assets)}，重新发起下载");
					if (!(await ExecuteBambooSdkDownloadAttemptsAsync(needDownloadPackages, attemptsPerCdn)))
					{
						return false;
					}
				}
				return true;
			}
			finally
			{
				DownloadData downloadData2 = DownloadData;
				downloadData2.DownloadCallback = (Action<DownloadCallbackInfo>)Delegate.Remove(downloadData2.DownloadCallback, new Action<DownloadCallbackInfo>(OnUpdateDownloadProgress));
				_bambooSdkPackages = null;
			}
		}
		catch (Exception exception)
		{
			Exception(exception);
			return false;
		}
	}

	private async UniTask<bool> ExecuteBambooSdkDownloadAttemptsAsync(List<ZipPackageInfo> needDownloadPackages, int attemptCount)
	{
		for (int attempt = 0; attempt < attemptCount; attempt++)
		{
			if (IsCancelRequested())
			{
				return false;
			}
			if (attempt > 0)
			{
				Warning($"[Bamboo] 当前 CDN={GetCurrentCdnBase((needDownloadPackages.Count > 0) ? needDownloadPackages[0].AssetType : AssetType.Assets)} 下载失败，同一 CDN 重试 {attempt}/{attemptCount - 1}");
			}
			string text = GenerateBambooDownloadJson(needDownloadPackages);
			Log($"[Bamboo] startDownload 第 {attempt + 1}/{attemptCount} 次，JSON: {text}");
			_bambooSdkDownloadCompleted = false;
			_bambooSdkDownloadSuccess = false;
			Debug.Log($"[DownloadFlow] startDownload begin: attempt={attempt + 1}/{attemptCount}, " + $"packageCount={needDownloadPackages.Count}, " + "cdn=" + GetCurrentCdnBase((needDownloadPackages.Count > 0) ? needDownloadPackages[0].AssetType : AssetType.Assets) + ".");
			Log("Start Download Using Bamboo SDK");
			BamBooSdkNative.getInstance().getExtend("backgroundDownload", text);
			_bambooWaitStartTime = Time.realtimeSinceStartup;
			_lastBambooWaitLogTime = _bambooWaitStartTime;
			while (!_bambooSdkDownloadCompleted)
			{
				if (IsCancelRequested())
				{
					return false;
				}
				float realtimeSinceStartup = Time.realtimeSinceStartup;
				if (realtimeSinceStartup - _lastBambooWaitLogTime >= 10f)
				{
					_lastBambooWaitLogTime = realtimeSinceStartup;
					Warning($"[Bamboo] startDownload 等待 SDK 回调中: 已等待 {realtimeSinceStartup - _bambooWaitStartTime:F0}s, " + $"attempt={attempt + 1}/{attemptCount}, packageCount={needDownloadPackages.Count}");
				}
				await UniTask.Yield();
			}
			if (_bambooSdkDownloadSuccess)
			{
				return true;
			}
		}
		return false;
	}

	private void LogBambooDownloadFailedZips(List<ZipPackageInfo> needDownloadPackages)
	{
		if (needDownloadPackages == null || needDownloadPackages.Count == 0)
		{
			Warning("[Bamboo] 下载失败，Zip 包列表为空，无法打印失败项");
			return;
		}
		foreach (ZipPackageInfo needDownloadPackage in needDownloadPackages)
		{
			if (!needDownloadPackage.NeedDownload)
			{
				continue;
			}
			long num = 0L;
			if (File.Exists(needDownloadPackage.FilePath))
			{
				try
				{
					num = new FileInfo(needDownloadPackage.FilePath).Length;
				}
				catch
				{
				}
			}
			bool flag = needDownloadPackage.RemoteFileSize > 0 && num == needDownloadPackage.RemoteFileSize;
			Warning($"[Bamboo] 需下载 Zip 诊断: [{needDownloadPackage.AssetType}] Index={needDownloadPackage.Index} FileName={needDownloadPackage.FileName} " + $"LocalBytes={num} RemoteBytes={needDownloadPackage.RemoteFileSize} SizeMatch={flag} " + "Path=" + needDownloadPackage.FilePath + " Url=" + BuildFullUrl(needDownloadPackage.Url, needDownloadPackage.AssetType));
		}
	}

	private string GenerateBambooDownloadJson(List<ZipPackageInfo> needDownloadPackages)
	{
		JArray jArray = new JArray();
		int num = 0;
		foreach (ZipPackageInfo needDownloadPackage in needDownloadPackages)
		{
			JObject item = new JObject
			{
				["Url"] = BuildFullUrl(needDownloadPackage.Url, needDownloadPackage.AssetType),
				["Index"] = num,
				["ExpectedSize"] = needDownloadPackage.RemoteFileSize,
				["FilePath"] = needDownloadPackage.FilePath,
				["ExpectedHash"] = needDownloadPackage.ExpectedHash ?? "",
				["DownloadedBytes"] = needDownloadPackage.DownloadedBytes
			};
			jArray.Add(item);
			num++;
		}
		return new JObject
		{
			["action"] = "startDownload",
			["taskArray"] = jArray
		}.ToString();
	}

	private void OnUpdateDownloadProgress(DownloadCallbackInfo info)
	{
		if (info == null)
		{
			return;
		}
		Debug.Log($"[DownloadFlow] startDownload callback: status={info.status}, " + $"taskCount={info.taskArray?.Length ?? 0}, message={info.Message ?? string.Empty}.");
		switch (info.status)
		{
		case 0:
		{
			long num = 0L;
			bool flag = false;
			if (info.taskArray != null)
			{
				TaskInfo[] taskArray = info.taskArray;
				foreach (TaskInfo taskInfo in taskArray)
				{
					if (taskInfo != null)
					{
						num += taskInfo.DownloadedBytes;
						ZipPackageInfo zipPackageInfo = FindPackageBySdkIndex(taskInfo.Index);
						if (zipPackageInfo == null || zipPackageInfo.RemoteFileSize <= 0 || taskInfo.DownloadedBytes < zipPackageInfo.RemoteFileSize)
						{
							flag = false;
						}
					}
					else
					{
						flag = false;
					}
				}
			}
			Context.DownloadedZipBytes = num;
			DownloadData.CurDownloadBytes = Context.DownloadedZipBytes;
			UpdateDownloadProgress(isActive: true, DownloadData.CurDownloadBytes, DownloadData.MaxDownloadBytes);
			if (flag)
			{
				_bambooSdkDownloadSuccess = true;
				_bambooSdkDownloadCompleted = true;
			}
			break;
		}
		case 1:
			_bambooSdkDownloadSuccess = true;
			_bambooSdkDownloadCompleted = true;
			break;
		case 2:
		case 3:
			_bambooSdkDownloadSuccess = false;
			_bambooSdkDownloadCompleted = true;
			break;
		default:
			Warning($"[Bamboo] backgroundDownload 返回未知状态: {info.status}, message={info.Message}");
			_bambooSdkDownloadSuccess = false;
			_bambooSdkDownloadCompleted = true;
			break;
		}
	}

	private ZipPackageInfo FindPackageBySdkIndex(int sdkIndex)
	{
		if (_bambooSdkPackages == null || sdkIndex < 0 || sdkIndex >= _bambooSdkPackages.Count)
		{
			return null;
		}
		return _bambooSdkPackages[sdkIndex];
	}

	private async UniTask<bool> DownloadZipPackage(ZipPackageInfo zipInfo)
	{
		_ = 1;
		try
		{
			if (IsCancelRequested())
			{
				return false;
			}
			string zipFilePath = zipInfo.FilePath;
			string fileName = zipInfo.FileName;
			AssetType assetType = zipInfo.AssetType;
			int index = zipInfo.Index;
			if (!File.Exists(zipFilePath) && TryApplyZipMarkerProgress(fileName, assetType))
			{
				Log($"[{assetType}] Zip包 [{index}] 已在历史记录中完成，跳过下载: {zipInfo.Url}");
				ApplyZipCompleteProgress(zipInfo.RemoteFileSize);
				return true;
			}
			string url = BuildFullUrl(zipInfo.Url, assetType);
			bool flag = await DownloadZipFile(url, zipFilePath, zipInfo.RemoteFileSize, zipInfo.ExpectedHash);
			if (!flag)
			{
				for (int retry = 0; retry < 4; retry++)
				{
					if (flag)
					{
						break;
					}
					if (IsCancelRequested())
					{
						return false;
					}
					_useBackupCdn = !_useBackupCdn;
					string url2 = BuildFullUrl(zipInfo.Url, assetType);
					Warning($"[{assetType}] Zip包 [{index}] 下载失败，第 {retry + 1}/{4} 次重试，CDN: {GetCurrentCdnBase(assetType)}");
					flag = await DownloadZipFile(url2, zipFilePath, zipInfo.RemoteFileSize, zipInfo.ExpectedHash);
				}
			}
			if (!flag)
			{
				Error($"[{assetType}] Zip包 [{index}] 所有下载尝试均失败");
				return false;
			}
			Log($"[{assetType}] Zip包 [{index}] 下载成功: {zipFilePath}");
			return true;
		}
		catch (Exception ex)
		{
			Error($"[{zipInfo.AssetType}] 下载Zip包 [{zipInfo.Index}] 时发生异常: {ex.Message}\n{ex.StackTrace}");
			return false;
		}
	}

	private async UniTask<bool> DownloadZipFile(string url, string savePath, long expectedFileSize, string expectedHash = null)
	{
		long startPosition = 0L;
		bool needDelete = false;
		string deleteReason = null;
		try
		{
			string directoryName = Path.GetDirectoryName(savePath);
			if (!string.IsNullOrEmpty(directoryName))
			{
				Directory.CreateDirectory(directoryName);
			}
			if (File.Exists(savePath))
			{
				try
				{
					FileInfo fileInfo = new FileInfo(savePath);
					startPosition = fileInfo.Length;
					if (expectedFileSize > 0 && startPosition > expectedFileSize)
					{
						Warning($"文件大小({startPosition})超过预期大小({expectedFileSize})，将重新下载");
						File.Delete(savePath);
						startPosition = 0L;
					}
					else
					{
						if (expectedFileSize > 0 && startPosition == expectedFileSize)
						{
							Log($"文件已下载完成，大小: {startPosition} bytes");
							ApplyZipCompleteProgress(expectedFileSize);
							return true;
						}
						if (startPosition > 0)
						{
							Log($"发现未完成的下载，从 {startPosition} 字节处继续下载");
						}
					}
				}
				catch (Exception ex)
				{
					Warning("读取文件信息失败: " + ex.Message + "，将重新下载");
					startPosition = 0L;
					if (File.Exists(savePath))
					{
						File.Delete(savePath);
					}
				}
			}
			using (UnityWebRequest request = UnityWebRequest.Get(url))
			{
				FileStream fileStream = null;
				try
				{
					FileMode mode = ((startPosition > 0) ? FileMode.Append : FileMode.Create);
					fileStream = new FileStream(savePath, mode, FileAccess.Write, FileShare.None, 8192, useAsync: true);
					StreamingDownloadHandler customHandler = (StreamingDownloadHandler)(request.downloadHandler = new StreamingDownloadHandler(fileStream, startPosition));
					request.disposeDownloadHandlerOnDispose = true;
					request.disposeUploadHandlerOnDispose = true;
					if (startPosition > 0)
					{
						request.SetRequestHeader("Range", $"bytes={startPosition}-");
					}
					UnityWebRequestAsyncOperation operation = request.SendWebRequest();
					long lastProgressUpdateBytes = startPosition;
					while (!operation.isDone)
					{
						if (IsCancelRequested())
						{
							request.Abort();
							return false;
						}
						long totalReceived = customHandler.TotalReceived;
						long num = totalReceived - lastProgressUpdateBytes;
						if (num > 0)
						{
							Context.DownloadedZipBytes += num;
							lastProgressUpdateBytes = totalReceived;
							if (Context.ZipTotalBytes > 0)
							{
								Context.DownloadedZipBytes = Math.Min(Context.DownloadedZipBytes, Context.ZipTotalBytes);
							}
							DownloadData.CurDownloadBytes = Context.DownloadedZipBytes;
							UpdateDownloadProgress(isActive: true, DownloadData.CurDownloadBytes, DownloadData.MaxDownloadBytes);
						}
						await UniTask.Yield();
					}
					long num2 = customHandler.TotalReceived - lastProgressUpdateBytes;
					if (num2 > 0)
					{
						Context.DownloadedZipBytes += num2;
						if (Context.ZipTotalBytes > 0)
						{
							Context.DownloadedZipBytes = Math.Min(Context.DownloadedZipBytes, Context.ZipTotalBytes);
						}
						DownloadData.CurDownloadBytes = Context.DownloadedZipBytes;
						UpdateDownloadProgress(isActive: true, DownloadData.CurDownloadBytes, DownloadData.MaxDownloadBytes);
					}
					fileStream.Close();
					fileStream = null;
					if (startPosition > 0 && request.responseCode == 200)
					{
						Warning("服务器未返回 206 Partial Content（实际 200），放弃续传并从头下载: " + savePath);
						try
						{
							if (File.Exists(savePath))
							{
								File.Delete(savePath);
							}
						}
						catch (Exception ex2)
						{
							Error("删除无法续传的临时文件失败: " + ex2.Message);
							return false;
						}
						return await DownloadZipFile(url, savePath, expectedFileSize, expectedHash);
					}
					if (request.result != UnityWebRequest.Result.Success)
					{
						string error = request.error;
						switch (request.result)
						{
						case UnityWebRequest.Result.ConnectionError:
							Warning("网络连接错误: " + error + "，将保留临时文件以便续传");
							return false;
						case UnityWebRequest.Result.ProtocolError:
						{
							long responseCode = request.responseCode;
							Error($"HTTP 错误 {responseCode}: {error}");
							if (responseCode >= 400 && responseCode < 500)
							{
								needDelete = true;
								deleteReason = $"HTTP {responseCode}";
							}
							else
							{
								Warning($"服务器端错误 {responseCode}，保留临时文件以便稍后重试");
							}
							return false;
						}
						case UnityWebRequest.Result.DataProcessingError:
							Error("数据处理错误: " + error);
							needDelete = true;
							deleteReason = "数据处理错误";
							return false;
						default:
							Error("下载失败: " + error);
							needDelete = true;
							deleteReason = "下载失败";
							return false;
						}
					}
				}
				catch (Exception ex3)
				{
					Error("下载过程中发生异常: " + ex3.Message + "\n" + ex3.StackTrace);
					fileStream?.Close();
					needDelete = true;
					deleteReason = "异常中断";
					return false;
				}
				finally
				{
					fileStream?.Dispose();
				}
			}
			if (File.Exists(savePath))
			{
				long length = new FileInfo(savePath).Length;
				if (expectedFileSize > 0 && length != expectedFileSize)
				{
					Error($"文件大小校验失败：预期大小 {expectedFileSize} bytes，实际大小 {length} bytes");
					needDelete = true;
					deleteReason = "大小不匹配";
					return false;
				}
				Log($"文件下载完成，大小: {length} bytes" + ((startPosition > 0) ? $" (从 {startPosition} 字节处续传)" : ""));
				if (Context.ZipTotalBytes > 0)
				{
					Context.DownloadedZipBytes = Math.Min(Context.DownloadedZipBytes, Context.ZipTotalBytes);
					DownloadData.CurDownloadBytes = Context.DownloadedZipBytes;
				}
				return true;
			}
			Error("下载完成但文件不存在: " + savePath);
			needDelete = true;
			deleteReason = "文件不存在";
			return false;
		}
		catch (Exception ex4)
		{
			Error("下载Zip文件异常: " + ex4.Message);
			needDelete = true;
			deleteReason = "下载异常";
			UpdateDownloadProgress(isActive: false, DownloadData.CurDownloadBytes, DownloadData.MaxDownloadBytes, 0L, forceNotify: true);
			return false;
		}
		finally
		{
			if (needDelete && !string.IsNullOrEmpty(deleteReason))
			{
				try
				{
					DeleteFileOnError(savePath, deleteReason);
				}
				catch (Exception ex5)
				{
					Warning("DeleteFileOnError 调用失败: " + ex5.Message);
				}
			}
		}
		void DeleteFileOnError(string path, string reason)
		{
			if (File.Exists(path))
			{
				try
				{
					File.Delete(path);
					Warning("已删除" + reason + "的文件: " + path);
				}
				catch (Exception ex6)
				{
					Warning("删除文件时出错: " + ex6.Message);
				}
			}
		}
	}

	private async UniTask<bool> VerifyAndProcessDownloadedFiles()
	{
		_ = 2;
		try
		{
			if (IsCancelRequested())
			{
				return false;
			}
			Log("开始统一校验下载的文件");
			StageProgressData stageProgressData = DownloadData?.GetStageProgressData(ProgressStageType.Download);
			if (stageProgressData != null)
			{
				stageProgressData.StageName = "正在校验文件...";
				DownloadData.NotifyStageProgressChanged(ProgressStageType.Download);
			}
			if (Context.ZipPackageInfos == null || Context.ZipPackageInfos.Count == 0)
			{
				Warning("没有需要校验的文件");
				return true;
			}
			foreach (KeyValuePair<AssetType, List<ZipPackageInfo>> zipPackageInfo in Context.ZipPackageInfos)
			{
				AssetType assetType = zipPackageInfo.Key;
				List<ZipPackageInfo> value = zipPackageInfo.Value;
				if (value == null || value.Count == 0)
				{
					continue;
				}
				foreach (ZipPackageInfo zipInfo in value)
				{
					if (IsCancelRequested())
					{
						return false;
					}
					string savePath = zipInfo.FilePath;
					if (!File.Exists(savePath) || string.IsNullOrEmpty(zipInfo.ExpectedHash))
					{
						continue;
					}
					Log($"[{assetType}] 校验文件哈希值: {Path.GetFileName(savePath)}");
					await UniTask.SwitchToThreadPool();
					string actualHash = await CalculateFileMD5Async(savePath);
					await UniTask.SwitchToMainThread();
					if (IsCancelRequested())
					{
						return false;
					}
					if (string.IsNullOrEmpty(actualHash))
					{
						Error($"[{assetType}] 计算文件MD5哈希值失败: {Path.GetFileName(savePath)}");
						return false;
					}
					if (!string.Equals(actualHash, zipInfo.ExpectedHash, StringComparison.OrdinalIgnoreCase))
					{
						Error($"[{assetType}] 文件MD5哈希值校验失败：{Path.GetFileName(savePath)}，预期 {zipInfo.ExpectedHash}，实际 {actualHash}");
						if (!zipInfo.IsFromStreamingAssets)
						{
							try
							{
								File.Delete(savePath);
							}
							catch (Exception ex)
							{
								Warning("删除hash不匹配的文件失败: " + ex.Message);
							}
						}
						else
						{
							Warning($"[{assetType}] StreamingAssets中的zip哈希不匹配，保留原文件: {Path.GetFileName(savePath)}");
						}
						return false;
					}
					Log($"[{assetType}] 文件哈希值校验通过: {Path.GetFileName(savePath)}");
				}
			}
			Log("所有文件校验完成");
			return true;
		}
		catch (Exception ex2)
		{
			Error("文件校验和处理异常: " + ex2.Message + "\n" + ex2.StackTrace);
			return false;
		}
	}

	private async UniTask<string> CalculateFileMD5Async(string filePath)
	{
		string result = default;
		object obj;
		int num;
		try
		{
			await UniTask.SwitchToThreadPool();
			using MD5 md5 = MD5.Create();
			using FileStream stream = File.OpenRead(filePath);
			long length = stream.Length;
			byte[] buffer;
			if (length <= 2048)
			{
				buffer = new byte[length];
				stream.Read(buffer, 0, (int)length);
			}
			else
			{
				buffer = new byte[2048];
				stream.Seek(-2048L, SeekOrigin.End);
				stream.Read(buffer, 0, 2048);
			}
			byte[] array = md5.ComputeHash(buffer);
			string hash = BitConverter.ToString(array).Replace("-", "").ToLowerInvariant();
			await UniTask.SwitchToMainThread();
			result = hash;
			return result;
		}
		catch (Exception ex)
		{
			obj = ex;
			num = 1;
		}
		if (num != 1)
		{
			return result;
		}
		Exception e = (Exception)obj;
		await UniTask.SwitchToMainThread();
		Error("计算MD5哈希值异常: " + e.Message);
		return null;
	}

	private void ApplyZipCompleteProgress(long bytesToAdd)
	{
		if (bytesToAdd > 0)
		{
			Context.DownloadedZipBytes += bytesToAdd;
			if (Context.ZipTotalBytes > 0)
			{
				Context.DownloadedZipBytes = Math.Min(Context.DownloadedZipBytes, Context.ZipTotalBytes);
			}
			DownloadData.CurDownloadBytes = Context.DownloadedZipBytes;
			UpdateDownloadProgress(isActive: true, DownloadData.CurDownloadBytes, DownloadData.MaxDownloadBytes);
		}
	}

	private void ApplyBaselineDownloadedBytesFromPartialFiles()
	{
		long val = SumOnDiskBytesForNeedDownloadZips();
		long val2 = Math.Max(0L, DownloadData.CurDownloadBytes);
		long num = Math.Max(val, val2);
		if (Context.ZipTotalBytes > 0)
		{
			num = Math.Min(num, Context.ZipTotalBytes);
		}
		Context.DownloadedZipBytes = num;
		DownloadData.CurDownloadBytes = num;
	}

	private long SumOnDiskBytesForNeedDownloadZips()
	{
		long num = 0L;
		if (Context.ZipPackageInfos == null)
		{
			return num;
		}
		foreach (KeyValuePair<AssetType, List<ZipPackageInfo>> zipPackageInfo in Context.ZipPackageInfos)
		{
			if (zipPackageInfo.Value == null)
			{
				continue;
			}
			foreach (ZipPackageInfo item in zipPackageInfo.Value)
			{
				if (!item.NeedDownload || !File.Exists(item.FilePath))
				{
					continue;
				}
				try
				{
					long num2 = new FileInfo(item.FilePath).Length;
					if (item.RemoteFileSize > 0)
					{
						num2 = Math.Min(num2, item.RemoteFileSize);
					}
					num += num2;
				}
				catch
				{
				}
			}
		}
		return num;
	}

	private void ResetDownloadProgressState()
	{
		StageProgressData stageProgressData = DownloadData?.GetStageProgressData(ProgressStageType.Download);
		if (stageProgressData != null)
		{
			stageProgressData.Reset();
			stageProgressData.StageName = AOTStringDefine.LoadData;
			stageProgressData.IsActive = false;
			_lastDownloadProgressUpdateTime = 0f;
			_lastDownloadProgressBytes = 0L;
			DownloadData.NotifyStageProgressChanged(ProgressStageType.Download);
		}
	}

	private void UpdateDownloadProgress(bool isActive, long currentBytes, long totalBytes, long? speedOverride = null, bool forceNotify = false)
	{
		StageProgressData stageProgressData = DownloadData?.GetStageProgressData(ProgressStageType.Download);
		if (stageProgressData == null)
		{
			return;
		}
		float unscaledTime = Time.unscaledTime;
		if (forceNotify || !(unscaledTime - _lastDownloadProgressUpdateTime < 0.5f))
		{
			long val = speedOverride ?? CalculateDownloadSpeed(currentBytes, unscaledTime);
			if (forceNotify && !speedOverride.HasValue && currentBytes == _lastDownloadProgressBytes)
			{
				val = stageProgressData.SpeedBytesPerSecond;
			}
			stageProgressData.StageName = (string.IsNullOrEmpty(stageProgressData.StageName) ? AOTStringDefine.LoadData : stageProgressData.StageName);
			stageProgressData.IsActive = isActive;
			stageProgressData.CurrentBytes = Math.Max(0L, currentBytes);
			stageProgressData.TotalBytes = Math.Max(0L, totalBytes);
			stageProgressData.Percent = DownloadAssetSubFlowBase.CalculateStagePercent(stageProgressData.CurrentBytes, stageProgressData.TotalBytes, 0, 0);
			stageProgressData.SpeedBytesPerSecond = Math.Max(0L, val);
			_lastDownloadProgressBytes = stageProgressData.CurrentBytes;
			_lastDownloadProgressUpdateTime = unscaledTime;
			DownloadData.NotifyStageProgressChanged(ProgressStageType.Download);
		}
	}

	private long CalculateDownloadSpeed(long currentBytes, float now)
	{
		if (_lastDownloadProgressUpdateTime <= 0f)
		{
			return 0L;
		}
		float num = Mathf.Max(now - _lastDownloadProgressUpdateTime, float.Epsilon);
		long num2 = Math.Max(0L, currentBytes - _lastDownloadProgressBytes);
		if (num2 <= 0)
		{
			return 0L;
		}
		return (long)((float)num2 / num);
	}
}
