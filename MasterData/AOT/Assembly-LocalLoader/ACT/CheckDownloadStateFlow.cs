using System;
using System.Collections.Generic;
using ACT.Error;
using Cysharp.Threading.Tasks;
using Newtonsoft.Json.Linq;
using UnityEngine;
using YooAsset;
using bamboosdk;

namespace ACT;

internal class CheckDownloadStateFlow : DownloadAssetSubFlowBase
{
	private const long ExtraDiskSpaceRequired = 3221225472L;

	private bool _queryInProgress;

	private bool _queryCompleted;

	private long _alreadyDownloadedBytes;

	private bool _emptyZipInfoWarned;

	private bool _bambooQueryCompleted;

	private long _bambooQueryDownloadedBytes;

	private const float BambooQueryWaitLogInterval = 10f;

	private float _bambooQueryWaitStartTime;

	private float _lastBambooQueryWaitLogTime;

	internal override EGameLoadingStage Stage => EGameLoadingStage.CheckDownloadState;

	internal CheckDownloadStateFlow(DownloadAssetContext context)
		: base(context)
	{
	}

	internal override void Init(GameLoadingData data)
	{
		_queryInProgress = false;
		_queryCompleted = false;
		_alreadyDownloadedBytes = 0L;
		_emptyZipInfoWarned = false;
		_loadState = EGameLoadingState.Loading;
	}

	internal override void Update()
	{
		if (Context.PlayMode == EPlayMode.EditorSimulateMode || !Context.HasZipPackages)
		{
			_loadState = EGameLoadingState.Succeed;
			return;
		}
		if (Context.ZipPackageInfos == null || Context.ZipPackageInfos.Count == 0)
		{
			if (!_emptyZipInfoWarned)
			{
				_emptyZipInfoWarned = true;
				Warning("[DownloadFlow] 检查下载状态无法推进: hasZipPackages=true 但 ZipPackageInfos 为空，子流程会一直等待。");
			}
			return;
		}
		List<ZipPackageInfo> list = CollectNeedDownloadPackages();
		if (list.Count == 0)
		{
			DownloadData.CurDownloadBytes = 0L;
			DownloadData.MaxDownloadBytes = 0L;
			DownloadData.AcceptUpdate = true;
			Context.DownloadedZipBytes = 0L;
			_loadState = EGameLoadingState.Succeed;
		}
		else if (_queryCompleted)
		{
			long num = CalculateRemainingDownloadBytes(list);
			long requiredSpace = num + 3221225472u;
			Log($"[DownloadFlow] 检查下载状态完成: needDownload={list.Count}, remaining={num}, " + $"max={DownloadData.MaxDownloadBytes}, cur={DownloadData.CurDownloadBytes}, " + $"acceptUpdate={DownloadData.AcceptUpdate}");
			if (!CheckAvailableDiskSpace(requiredSpace))
			{
				DownloadData.DownloadFail = true;
				_loadState = EGameLoadingState.Failed;
				return;
			}
			if (num <= 0 && !DownloadData.AcceptUpdate)
			{
				DownloadData.AcceptUpdate = true;
				Log("[DownloadFlow] 剩余下载量为 0，无需用户确认，直接放行下载/解压流程。");
			}
			_loadState = EGameLoadingState.Succeed;
			DownloadData.CalSizeDone?.Invoke();
		}
		else if (!_queryInProgress)
		{
			_queryInProgress = true;
			QueryAlreadyDownloadedBytes(list).Forget();
		}
	}

	private List<ZipPackageInfo> CollectNeedDownloadPackages()
	{
		List<ZipPackageInfo> list = new List<ZipPackageInfo>();
		if (Context.ZipPackageInfos == null)
		{
			return list;
		}
		foreach (KeyValuePair<AssetType, List<ZipPackageInfo>> zipPackageInfo in Context.ZipPackageInfos)
		{
			foreach (ZipPackageInfo item in zipPackageInfo.Value)
			{
				if (item.NeedDownload)
				{
					list.Add(item);
				}
			}
		}
		return list;
	}

	private async UniTask QueryAlreadyDownloadedBytes(List<ZipPackageInfo> needDownloadPackages)
	{
		try
		{
			_bambooQueryCompleted = false;
			_bambooQueryDownloadedBytes = 0L;
			string text = GenerateBambooQueryDownloadJson(needDownloadPackages);
			Debug.Log($"[DownloadFlow] queryDownload begin: packageCount={needDownloadPackages.Count}, " + "tags=" + GetDownloadTagSummary() + ".");
			Log("查询已下载大小 JSON: " + text);
			DownloadData downloadData = DownloadData;
			downloadData.DownloadCallback = (Action<DownloadCallbackInfo>)Delegate.Combine(downloadData.DownloadCallback, new Action<DownloadCallbackInfo>(OnQueryDownloadCallback));
			try
			{
				BamBooSdkNative.getInstance().getExtend("backgroundDownload", text);
				Debug.Log("[DownloadFlow] queryDownload dispatched to Bamboo SDK; waiting for callback.");
				_bambooQueryWaitStartTime = Time.realtimeSinceStartup;
				_lastBambooQueryWaitLogTime = _bambooQueryWaitStartTime;
				while (!_bambooQueryCompleted)
				{
					if (DownloadData.CancelRequested)
					{
						Debug.Log("[DownloadFlow] queryDownload canceled before an SDK callback was received.");
						return;
					}
					float realtimeSinceStartup = Time.realtimeSinceStartup;
					if (realtimeSinceStartup - _lastBambooQueryWaitLogTime >= 10f)
					{
						_lastBambooQueryWaitLogTime = realtimeSinceStartup;
						Warning($"[Bamboo] queryDownload 等待 SDK 回调中: 已等待 {realtimeSinceStartup - _bambooQueryWaitStartTime:F0}s, " + $"packageCount={needDownloadPackages.Count}");
					}
					await UniTask.Yield();
				}
			}
			finally
			{
				DownloadData downloadData2 = DownloadData;
				downloadData2.DownloadCallback = (Action<DownloadCallbackInfo>)Delegate.Remove(downloadData2.DownloadCallback, new Action<DownloadCallbackInfo>(OnQueryDownloadCallback));
			}
			_alreadyDownloadedBytes = _bambooQueryDownloadedBytes;
			DownloadData.CurDownloadBytes = _alreadyDownloadedBytes;
			Log($"已下载大小: {_alreadyDownloadedBytes} bytes");
		}
		catch (Exception ex)
		{
			Warning("查询已下载大小失败: " + ex.Message);
			_alreadyDownloadedBytes = 0L;
			DownloadData downloadData3 = DownloadData;
			downloadData3.DownloadCallback = (Action<DownloadCallbackInfo>)Delegate.Remove(downloadData3.DownloadCallback, new Action<DownloadCallbackInfo>(OnQueryDownloadCallback));
		}
		finally
		{
			_queryInProgress = false;
			_queryCompleted = true;
		}
	}

	private void OnQueryDownloadCallback(DownloadCallbackInfo info)
	{
		if (info == null)
		{
			return;
		}
		int num = info.taskArray?.Length ?? 0;
		Debug.Log($"[DownloadFlow] queryDownload callback: status={info.status}, taskCount={num}, " + "message=" + (info.Message ?? string.Empty) + ".");
		switch (info.status)
		{
		case 3:
		{
			long num2 = 0L;
			if (info.taskArray != null)
			{
				TaskInfo[] taskArray = info.taskArray;
				foreach (TaskInfo taskInfo in taskArray)
				{
					if (taskInfo != null)
					{
						num2 += taskInfo.DownloadedBytes;
					}
				}
			}
			_bambooQueryDownloadedBytes = num2;
			_bambooQueryCompleted = true;
			break;
		}
		case 0:
		case 1:
		case 2:
			_bambooQueryCompleted = true;
			break;
		default:
			Warning($"查询已下载大小返回未知 SDK 状态: {info.status}，按 0 字节继续下载。");
			_bambooQueryDownloadedBytes = 0L;
			_bambooQueryCompleted = true;
			break;
		}
	}

	private string GenerateBambooQueryDownloadJson(List<ZipPackageInfo> needDownloadPackages)
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
			["action"] = "queryDownload",
			["taskArray"] = jArray
		}.ToString();
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

	private long CalculateRemainingDownloadBytes(List<ZipPackageInfo> needDownloadPackages)
	{
		long num = 0L;
		foreach (ZipPackageInfo needDownloadPackage in needDownloadPackages)
		{
			num += needDownloadPackage.RemoteFileSize;
		}
		long val = num - _alreadyDownloadedBytes;
		return Math.Max(0L, val);
	}

	private bool CheckAvailableDiskSpace(long requiredSpace)
	{
		long leftDiskSpace = LuminBambooBridgeListener.LeftDiskSpace;
		Log($"Required disk space: {requiredSpace} bytes (remaining download + 3GB), Available: {leftDiskSpace} bytes");
		if (leftDiskSpace < 0)
		{
			return true;
		}
		if (leftDiskSpace < requiredSpace)
		{
			LuminErrorAOT.ReportGameLoadingError("C03-9902", "01", 1);
			Error($"No enough disk space: required {requiredSpace} bytes, available {leftDiskSpace} bytes");
			return false;
		}
		return true;
	}
}
