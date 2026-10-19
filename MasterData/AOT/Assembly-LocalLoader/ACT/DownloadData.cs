using System;
using System.Collections.Generic;

namespace ACT;

public class DownloadData
{
	public long MaxDownloadBytes;

	public long CurDownloadBytes;

	internal bool HasVersionInfo;

	internal int AssetVersion;

	internal int ClientStaticVersion;

	internal int DllVersion;

	internal int RawFileVersion;

	public bool AcceptUpdate;

	public bool DownloadComplete;

	public bool DownloadFail;

	public bool CanRetry;

	public bool CancelRequested;

	internal Action Retry;

	public Action CalSizeDone;

	internal Action<string, float> CheckState;

	internal string ErrorCode;

	internal string SystemModule;

	internal string Message;

	internal int RetryCount;

	internal Action<DownloadCallbackInfo> DownloadCallback;

	internal EGameLoadingStage CurrentLoadStage;

	private readonly Dictionary<ProgressStageType, StageProgressData> _stageProgressData = new Dictionary<ProgressStageType, StageProgressData>
	{
		[ProgressStageType.Download] = new StageProgressData("下载资源中"),
		[ProgressStageType.Extract] = new StageProgressData("解压资源中"),
		[ProgressStageType.CheckIntegrity] = new StageProgressData("缺失资源下载中")
	};

	public Action<ProgressStageType, StageProgressData> StageProgressChanged;

	public Action<ProgressStageType> StageChanged;

	public ProgressStageType CurrentStage { get; private set; }

	internal void SetStage(ProgressStageType stageType)
	{
		if (CurrentStage != stageType)
		{
			CurrentStage = stageType;
			StageChanged?.Invoke(stageType);
		}
	}

	public StageProgressData GetStageProgressData(ProgressStageType stageType)
	{
		if (_stageProgressData.TryGetValue(stageType, out var value))
		{
			return value;
		}
		StageProgressData stageProgressData = new StageProgressData(GetDefaultStageName(stageType));
		_stageProgressData[stageType] = stageProgressData;
		return stageProgressData;
	}

	internal void NotifyStageProgressChanged(ProgressStageType stageType)
	{
		if (_stageProgressData.TryGetValue(stageType, out var value))
		{
			StageProgressChanged?.Invoke(stageType, value);
		}
	}

	public void SetEditorMockStage(ProgressStageType stageType)
	{
		SetStage(stageType);
	}

	public void NotifyEditorMockStageProgressChanged(ProgressStageType stageType)
	{
		NotifyStageProgressChanged(stageType);
	}

	private static string GetDefaultStageName(ProgressStageType stageType)
	{
		return stageType switch
		{
			ProgressStageType.Download => "下载资源中", 
			ProgressStageType.Extract => "解压资源中", 
			ProgressStageType.CheckIntegrity => "缺失资源下载中", 
			_ => stageType.ToString(), 
		};
	}
}
