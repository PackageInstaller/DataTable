using System;
using System.Collections.Generic;
using System.Text;
using ACT.LocalLoader;
using UnityEngine;

namespace ACT;

public class DownloadAsset : GameLoadingFlowBase
{
	private readonly YooAssetInitData _initData;

	private DownloadAssetContext _context;

	private Queue<DownloadAssetSubFlowBase> _subFlows;

	private DownloadAssetSubFlowBase _currentSubFlow;

	private GameLoadingData _gameLoadingData;

	private float _subFlowEnterTime;

	private float _lastStallWarningTime;

	private const float SubFlowStallWarnAfterSeconds = 10f;

	private const float StallWarningInterval = 20f;

	internal override int TotalRetryCount => 0;

	internal override EGameLoadingStage Stage => EGameLoadingStage.DownloadAsset;

	public EGameLoadingState CurrentLoadState => _loadState;

	public EGameLoadingStage LoadingStage => Stage;

	public DownloadAsset(YooAssetInitData initData)
	{
		_initData = initData;
	}

	public void Initialize(GameLoadingData data)
	{
		Init(data);
	}

	public void Tick()
	{
		Update();
	}

	internal override void Init(GameLoadingData data)
	{
		_gameLoadingData = data;
		_context = new DownloadAssetContext
		{
			InitData = _initData
		};
		DownloadData downloadData = _context.DownloadData;
		downloadData.Retry = (Action)Delegate.Remove(downloadData.Retry, new Action(Retry));
		DownloadData downloadData2 = _context.DownloadData;
		downloadData2.Retry = (Action)Delegate.Combine(downloadData2.Retry, new Action(Retry));
		BuildSubFlows();
		_loadState = EGameLoadingState.Loading;
		NotifyHotUpdateEnterDownloadFlow();
	}

	private void NotifyHotUpdateEnterDownloadFlow()
	{
		if (_initData.ZipDownloadParam == null || !_initData.ZipDownloadParam.IsPreDownload)
		{
			MonoHotUpdate monoHotUpdate = UnityEngine.Object.FindFirstObjectByType<MonoHotUpdate>();
			if (monoHotUpdate != null)
			{
				monoHotUpdate.StartNotificationPermissionCheck();
			}
		}
	}

	internal override void Retry()
	{
		_loadState = EGameLoadingState.Loading;
		Log("Retry: 重置所有子流程");
		_context.Reset();
		_context.DownloadData.ErrorCode = "C01-9999";
		_context.DownloadData.SystemModule = "00";
		_context.DownloadData.Message = "";
		_context.DownloadData.CurDownloadBytes = 0L;
		_context.DownloadData.DownloadFail = false;
		_context.DownloadData.CanRetry = false;
		_context.DownloadData.DownloadComplete = false;
		_context.DownloadData.CancelRequested = false;
		_context.DownloadData.AcceptUpdate = true;
		BuildSubFlows();
	}

	internal override void Update()
	{
		if (_loadState != EGameLoadingState.Loading)
		{
			WarnIfPendingSubFlowsOnStopped();
			return;
		}
		if (_currentSubFlow == null)
		{
			if (_subFlows == null || _subFlows.Count == 0)
			{
				_context.DownloadData.DownloadComplete = true;
				_loadState = EGameLoadingState.Succeed;
				return;
			}
			_currentSubFlow = _subFlows.Dequeue();
			OnSubFlowEntered(_currentSubFlow);
		}
		if (_currentSubFlow.LoadState == EGameLoadingState.None)
		{
			_currentSubFlow.Init(_gameLoadingData);
		}
		if (_currentSubFlow.LoadState == EGameLoadingState.Waiting)
		{
			WarnIfSubFlowStalled();
			return;
		}
		if (_currentSubFlow.LoadState == EGameLoadingState.Loading)
		{
			_currentSubFlow.Update();
			WarnIfSubFlowStalled();
		}
		if (_currentSubFlow.LoadState == EGameLoadingState.Failed)
		{
			Warning($"[DownloadFlow] 子流程失败: {GetSubFlowName(_currentSubFlow)}(stage={_currentSubFlow.Stage}), " + $"队列剩余 {_subFlows?.Count ?? 0}, {BuildContextSnapshot()}");
			_loadState = EGameLoadingState.Failed;
		}
		else if (_currentSubFlow.LoadState == EGameLoadingState.Succeed)
		{
			_currentSubFlow = null;
			_subFlowEnterTime = 0f;
			if (_subFlows.Count == 0)
			{
				_context.DownloadData.DownloadComplete = true;
				_loadState = EGameLoadingState.Succeed;
			}
		}
	}

	private void OnSubFlowEntered(DownloadAssetSubFlowBase subFlow)
	{
		_subFlowEnterTime = Time.realtimeSinceStartup;
		Log($"开始子流程: {GetSubFlowName(subFlow)}(队列剩余 {_subFlows?.Count ?? 0})");
	}

	private void WarnIfSubFlowStalled()
	{
		if (_currentSubFlow != null && !(_subFlowEnterTime <= 0f))
		{
			float num = Time.realtimeSinceStartup - _subFlowEnterTime;
			if (!(num < 10f))
			{
				WarnThrottled($"[DownloadFlow] 子流程疑似卡住 {num:F0}s: {GetSubFlowName(_currentSubFlow)}" + $"(state={_currentSubFlow.LoadState}, stage={_currentSubFlow.Stage}), " + $"队列剩余 {_subFlows?.Count ?? 0}, {BuildContextSnapshot()}");
			}
		}
	}

	private void WarnIfPendingSubFlowsOnStopped()
	{
		if (_currentSubFlow != null || (_subFlows != null && _subFlows.Count != 0))
		{
			WarnThrottled($"[DownloadFlow] DownloadAsset 已停止推进但仍未完成: state={_loadState}, " + $"current={GetSubFlowName(_currentSubFlow)}, 队列剩余 {_subFlows?.Count ?? 0}, " + BuildContextSnapshot());
		}
	}

	private void WarnThrottled(string message)
	{
		float realtimeSinceStartup = Time.realtimeSinceStartup;
		if (!(realtimeSinceStartup - _lastStallWarningTime < 20f))
		{
			_lastStallWarningTime = realtimeSinceStartup;
			Warning(message);
		}
	}

	private static string GetSubFlowName(DownloadAssetSubFlowBase subFlow)
	{
		if (subFlow == null)
		{
			return "<none>";
		}
		return subFlow.GetType().Name;
	}

	private string BuildContextSnapshot()
	{
		DownloadData downloadData = _context?.DownloadData;
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append("AcceptUpdate=").Append(downloadData?.AcceptUpdate ?? false);
		stringBuilder.Append(", Complete=").Append(downloadData?.DownloadComplete ?? false);
		stringBuilder.Append(", Fail=").Append(downloadData?.DownloadFail ?? false);
		stringBuilder.Append(", CanRetry=").Append(downloadData?.CanRetry ?? false);
		stringBuilder.Append(", Cancel=").Append(downloadData?.CancelRequested ?? false);
		stringBuilder.Append(", bytes=").Append(downloadData?.CurDownloadBytes ?? 0).Append('/')
			.Append(downloadData?.MaxDownloadBytes ?? 0);
		stringBuilder.Append(", stage=").Append(downloadData?.CurrentStage.ToString() ?? "<null>");
		stringBuilder.Append(", HasZipPackages=").Append(_context?.HasZipPackages ?? false);
		AppendZipPackageSnapshot(stringBuilder);
		return stringBuilder.ToString();
	}

	private void AppendZipPackageSnapshot(StringBuilder builder)
	{
		builder.Append(", packageInfos=").Append((_context?.PackageInfos?.Count).GetValueOrDefault());
		Dictionary<AssetType, List<ZipPackageInfo>> dictionary = _context?.ZipPackageInfos;
		if (dictionary == null)
		{
			builder.Append(", zipPackageInfos=<null>");
			return;
		}
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		int num4 = 0;
		foreach (KeyValuePair<AssetType, List<ZipPackageInfo>> item in dictionary)
		{
			if (item.Value == null)
			{
				continue;
			}
			foreach (ZipPackageInfo item2 in item.Value)
			{
				if (item2 != null)
				{
					num++;
					if (item2.NeedDownload)
					{
						num2++;
					}
					if (item2.IsDownloaded)
					{
						num3++;
					}
					if (item2.IsExtracted)
					{
						num4++;
					}
				}
			}
		}
		builder.Append(", zipTotal=").Append(num).Append(", zipNeedDownload=")
			.Append(num2)
			.Append(", zipDownloaded=")
			.Append(num3)
			.Append(", zipExtracted=")
			.Append(num4);
	}

	private void BuildSubFlows()
	{
		_subFlows = new Queue<DownloadAssetSubFlowBase>();
		_currentSubFlow = null;
		int num;
		int num2;
		if (_initData.ZipDownloadParam != null)
		{
			num = (_initData.ZipDownloadParam.IsPreDownload ? 1 : 0);
			if (num != 0)
			{
				num2 = 0;
				goto IL_0058;
			}
		}
		else
		{
			num = 0;
		}
		num2 = ((_initData.ZipDownloadParam != null && _initData.ZipDownloadParam.UsePreDownloadedPackages) ? 1 : 0);
		goto IL_0058;
		IL_0058:
		_subFlows.Enqueue(new CheckZipStateFlow(_context));
		if (num2 != 0)
		{
			_subFlows.Enqueue(new ApplyPreDownloadedZipPackagesFlow(_context));
			_subFlows.Enqueue(new ExtractZipPackagesFlow(_context));
			_subFlows.Enqueue(new CheckZipStateFlow(_context));
		}
		_subFlows.Enqueue(new CheckDownloadStateFlow(_context));
		_subFlows.Enqueue(new DownloadZipPackagesFlow(_context));
		if (num == 0)
		{
			_subFlows.Enqueue(new ExtractZipPackagesFlow(_context));
		}
		_subFlows.Enqueue(new ClearUnusedFilesFlow(_context));
		if (_initData.ZipDownloadParam == null || _initData.ZipDownloadParam.WriteVersionInfo)
		{
			_subFlows.Enqueue(new WriteVersionInfoFlow(_context));
		}
	}
}
