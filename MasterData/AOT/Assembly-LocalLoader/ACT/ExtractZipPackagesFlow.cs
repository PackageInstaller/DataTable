using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT;

internal class ExtractZipPackagesFlow : DownloadAssetSubFlowBase
{
	private bool _zipExtractInProgress;

	private bool _zipExtractCompleted;

	private bool _zipExtractSuccess;

	internal override EGameLoadingStage Stage => EGameLoadingStage.ExtractZipPackages;

	internal ExtractZipPackagesFlow(DownloadAssetContext context)
		: base(context)
	{
	}

	internal override void Init(GameLoadingData data)
	{
		_zipExtractInProgress = false;
		_zipExtractCompleted = false;
		_zipExtractSuccess = false;
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
		_zipExtractInProgress = false;
		_zipExtractCompleted = true;
		_zipExtractSuccess = false;
		if (DownloadData != null)
		{
			DownloadData.DownloadFail = true;
			DownloadData.CanRetry = false;
			DownloadData.AcceptUpdate = false;
		}
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
			EnsureZipDirectoriesInitialized();
			if (!HasZipFilesToExtract())
			{
				Log("[DownloadFlow] 没有需要解压的Zip包，本子流程直接完成: " + $"zipPackageInfos={Context.ZipPackageInfos?.Count ?? 0}, " + $"hasAppliedPreDownloaded={Context.HasAppliedPreDownloadedPackages}");
				_zipExtractCompleted = true;
				_zipExtractSuccess = true;
				_loadState = EGameLoadingState.Succeed;
			}
			else if (!_zipExtractInProgress && !_zipExtractCompleted)
			{
				SetProgressStage(ProgressStageType.Extract);
				_zipExtractInProgress = true;
				_zipExtractCompleted = false;
				_zipExtractSuccess = false;
				ExtractAllZipPackages().Forget();
			}
			else if (_zipExtractCompleted)
			{
				if (_zipExtractSuccess)
				{
					_loadState = EGameLoadingState.Succeed;
					return;
				}
				DownloadData.ErrorCode = "C03-0502";
				DownloadData.SystemModule = "01";
				DownloadData.Message = "";
				DownloadData.DownloadFail = true;
				DownloadData.CanRetry = true;
				DownloadData.AcceptUpdate = false;
				_loadState = EGameLoadingState.Failed;
			}
		}
		catch (Exception ex)
		{
			Exception(ex);
			_zipExtractInProgress = false;
			_zipExtractCompleted = true;
			_zipExtractSuccess = false;
			DownloadData.ErrorCode = "C03-0502";
			DownloadData.SystemModule = "03";
			DownloadData.Message = ex.Message;
			DownloadData.DownloadFail = true;
			DownloadData.CanRetry = true;
			DownloadData.AcceptUpdate = false;
			_loadState = EGameLoadingState.Failed;
		}
	}

	private async UniTask<bool> ExtractAllZipPackages()
	{
		try
		{
			if (IsCancelRequested())
			{
				return false;
			}
			EnsureZipDirectoriesInitialized();
			Log("开始统一解压所有Zip包");
			Dictionary<AssetType, List<ZipExtractionEntry>> dictionary = BuildExtractionPlan(out var totalExtractBytes, out var totalExtractFiles);
			long extractedBytes = 0L;
			int extractedFiles = 0;
			if (totalExtractFiles > 0)
			{
				UpdateExtractProgress(isActive: true, extractedBytes, totalExtractBytes, extractedFiles, totalExtractFiles);
			}
			else
			{
				ResetExtractProgressState();
			}
			foreach (KeyValuePair<AssetType, List<ZipExtractionEntry>> item in dictionary)
			{
				if (IsCancelRequested())
				{
					MarkCanceled();
					return false;
				}
				AssetType assetType = item.Key;
				string extractDir = Context.ExtractedDirectories[assetType];
				List<ZipExtractionEntry> value = item.Value;
				Log($"[{assetType}] 解压目录: {extractDir}");
				Log($"[{assetType}] 找到 {value.Count} 个zip文件，开始解压到目录: {extractDir}");
				foreach (ZipExtractionEntry zipEntry in value)
				{
					if (IsCancelRequested())
					{
						MarkCanceled();
						return false;
					}
					Log($"[{assetType}] 解压zip文件: {Path.GetFileName(zipEntry.Path)}");
					if (!(await ExtractZipFileWithProgress(zipEntry.Path, extractDir, assetType, extractedBytes, totalExtractBytes, extractedFiles, totalExtractFiles, zipEntry.HashSizeFileName, zipEntry.DeleteAfterExtract, zipEntry.DeleteOnExtractFailure, zipEntry.Tags)))
					{
						if (IsCancelRequested())
						{
							MarkCanceled();
							return false;
						}
						Error($"[{assetType}] 解压失败: {zipEntry.Path}");
						if (zipEntry.DeleteOnExtractFailure)
						{
							try
							{
								if (File.Exists(zipEntry.Path))
								{
									File.Delete(zipEntry.Path);
									Warning("已删除损坏的zip文件: " + zipEntry.Path);
								}
							}
							catch (Exception ex)
							{
								Warning("删除zip文件失败: " + ex.Message);
							}
						}
						_zipExtractCompleted = true;
						_zipExtractSuccess = false;
						_zipExtractInProgress = false;
						DownloadData.DownloadFail = true;
						DownloadData.CanRetry = true;
						DownloadData.ErrorCode = "C03-0502";
						DownloadData.SystemModule = "03";
						DownloadData.Message = $"AssetType: {assetType}, File: {Path.GetFileName(zipEntry.Path)}";
						return false;
					}
					extractedFiles++;
					extractedBytes += Math.Max(0L, zipEntry.Size);
					UpdateExtractProgress(isActive: true, extractedBytes, totalExtractBytes, extractedFiles, totalExtractFiles);
				}
				if (Directory.Exists(extractDir))
				{
					string[] files = Directory.GetFiles(extractDir, "*", SearchOption.AllDirectories);
					Log($"[{assetType}] 所有Zip包解压完成: {extractDir}，包含 {files.Length} 个文件");
				}
			}
			if (totalExtractFiles > 0)
			{
				UpdateExtractProgress(isActive: true, totalExtractBytes, totalExtractBytes, totalExtractFiles, totalExtractFiles);
			}
			Log("所有Zip包解压完成");
			ClearPreDownloadCompletedVersionIfApplied();
			_zipExtractCompleted = true;
			_zipExtractSuccess = true;
			_zipExtractInProgress = false;
			return true;
		}
		catch (Exception ex2)
		{
			Exception(ex2);
			DownloadData.ErrorCode = "C03-0502";
			DownloadData.SystemModule = "03";
			DownloadData.Message = ex2.Message;
			DownloadData.DownloadFail = true;
			DownloadData.CanRetry = true;
			DownloadData.AcceptUpdate = false;
			_zipExtractCompleted = true;
			_zipExtractSuccess = false;
			_zipExtractInProgress = false;
			return false;
		}
	}

	private void ClearPreDownloadCompletedVersionIfApplied()
	{
		if (Context.HasAppliedPreDownloadedPackages)
		{
			PlayerPrefs.DeleteKey("PreDownload.CompletedVersion");
			PlayerPrefs.Save();
			Context.HasAppliedPreDownloadedPackages = false;
			Log("已成功应用预下载暂存包，清除预下载完成标记。");
		}
	}

	private async UniTask<bool> ExtractZipFileWithProgress(string zipPath, string extractPath, AssetType assetType, long baseExtractedBytes, long totalExtractBytes, int baseExtractedFiles, int totalExtractFiles, string hashSizeFileName = null, bool deleteAfterExtract = true, bool deleteOnExtractFailure = true, string[] tags = null)
	{
		bool result = default;
		object obj;
		int num3;
		try
		{
			if (IsCancelRequested())
			{
				result = false;
				return result;
			}
			if (!File.Exists(zipPath))
			{
				Error("Zip文件不存在: " + zipPath);
				result = false;
				return result;
			}
			Log("开始解压Zip文件: " + zipPath + " -> " + extractPath);
			await UniTask.SwitchToThreadPool();
			if (!Directory.Exists(extractPath))
			{
				Directory.CreateDirectory(extractPath);
			}
			long zipFileSize = new FileInfo(zipPath).Length;
			int extractedEntryCount = 0;
			List<string> extractedFilePaths = new List<string>();
			using (FileStream zipStream = new FileStream(zipPath, FileMode.Open, FileAccess.Read, FileShare.Read, 262144))
			{
				using ZipArchive archive = new ZipArchive(zipStream, ZipArchiveMode.Read);
				long currentZipExtractedBytes = 0L;
				byte[] copyBuffer = new byte[262144];
				long totalUncompressedSize = 0L;
				foreach (ZipArchiveEntry entry in archive.Entries)
				{
					totalUncompressedSize += entry.Length;
				}
				float lastProgressTime = Environment.TickCount;
				foreach (ZipArchiveEntry entry2 in archive.Entries)
				{
					if (IsCancelRequested())
					{
						result = false;
						return result;
					}
					string text = Path.Combine(extractPath, entry2.FullName);
					if (string.IsNullOrEmpty(entry2.Name))
					{
						Directory.CreateDirectory(text);
						continue;
					}
					string directoryName = Path.GetDirectoryName(text);
					if (!string.IsNullOrEmpty(directoryName) && !Directory.Exists(directoryName))
					{
						Directory.CreateDirectory(directoryName);
					}
					using (Stream stream = entry2.Open())
					{
						using FileStream fileStream = new FileStream(text, FileMode.Create, FileAccess.Write, FileShare.None, 262144);
						int count;
						while ((count = stream.Read(copyBuffer, 0, copyBuffer.Length)) > 0)
						{
							if (IsCancelRequested())
							{
								result = false;
								return result;
							}
							fileStream.Write(copyBuffer, 0, count);
						}
					}
					extractedFilePaths.Add(text);
					extractedEntryCount++;
					currentZipExtractedBytes += entry2.Length;
					float num = Environment.TickCount;
					if (num - lastProgressTime >= 300f)
					{
						lastProgressTime = num;
						double num2 = ((totalUncompressedSize > 0) ? ((double)currentZipExtractedBytes / (double)totalUncompressedSize) : 0.0);
						long estimatedCurrentBytes = baseExtractedBytes + (long)((double)zipFileSize * num2);
						await UniTask.SwitchToMainThread();
						UpdateExtractProgress(isActive: true, estimatedCurrentBytes, totalExtractBytes, baseExtractedFiles, totalExtractFiles);
						await UniTask.SwitchToThreadPool();
					}
				}
			}
			if (extractedEntryCount != 0)
			{
				DownloadAssetManager.Instance.RecordExtractedFiles(tags, extractedFilePaths);
				try
				{
					string text2 = ((!string.IsNullOrEmpty(hashSizeFileName)) ? hashSizeFileName : Path.GetFileName(zipPath));
					MarkZipAsExtracted(text2, assetType, zipFileSize);
					Log("已写入marker文件: " + text2);
				}
				catch (Exception ex)
				{
					Log("记录Zip解压信息失败: " + zipPath + ", " + ex.Message);
				}
				try
				{
					if (File.Exists(zipPath))
					{
						if (deleteAfterExtract)
						{
							File.Delete(zipPath);
							Log($"已删除解压完成的zip文件: {Path.GetFileName(zipPath)}, 释放 {zipFileSize} bytes");
						}
						else
						{
							Log("保留StreamingAssets中的zip文件: " + Path.GetFileName(zipPath));
						}
					}
				}
				catch (Exception ex2)
				{
					Warning("删除已解压的zip文件失败: " + Path.GetFileName(zipPath) + ", " + ex2.Message);
				}
				await UniTask.SwitchToMainThread();
				Log($"Zip文件解压完成: {Path.GetFileName(zipPath)}，共 {extractedEntryCount} 个文件");
				result = true;
				return result;
			}
			await UniTask.SwitchToMainThread();
			Warning("zip包内无有效文件: " + Path.GetFileName(zipPath));
			result = false;
			return result;
		}
		catch (Exception ex3)
		{
			obj = ex3;
			num3 = 1;
		}
		if (num3 != 1)
		{
			return result;
		}
		Exception e = (Exception)obj;
		await UniTask.SwitchToMainThread();
		Error("解压Zip文件异常: " + e.Message + "\n" + e.StackTrace);
		try
		{
			if (deleteOnExtractFailure && File.Exists(zipPath))
			{
				File.Delete(zipPath);
				Warning("已删除解压异常的zip文件: " + zipPath);
			}
		}
		catch (Exception ex4)
		{
			Warning("删除zip文件失败: " + ex4.Message);
		}
		return false;
	}

	private Dictionary<AssetType, List<ZipExtractionEntry>> BuildExtractionPlan(out long totalBytes, out int totalFiles)
	{
		totalBytes = 0L;
		totalFiles = 0;
		Dictionary<AssetType, List<ZipExtractionEntry>> dictionary = new Dictionary<AssetType, List<ZipExtractionEntry>>();
		if (Context.PackageInfos == null || Context.ZipPackageInfos == null)
		{
			return dictionary;
		}
		foreach (KeyValuePair<AssetType, PackageInfo> packageInfo in Context.PackageInfos)
		{
			AssetType key = packageInfo.Key;
			if (!Context.ZipPackageInfos.TryGetValue(key, out var value) || value == null || value.Count == 0)
			{
				continue;
			}
			List<ZipExtractionEntry> list = new List<ZipExtractionEntry>(value.Count);
			foreach (ZipPackageInfo item in value)
			{
				if (item == null || item.IsExtracted)
				{
					continue;
				}
				item.UpdateDownloadState();
				if (!item.IsDownloaded || string.IsNullOrEmpty(item.FilePath) || !File.Exists(item.FilePath))
				{
					continue;
				}
				long num = item.RemoteFileSize;
				if (num <= 0)
				{
					try
					{
						num = new FileInfo(item.FilePath).Length;
					}
					catch
					{
						num = 0L;
					}
				}
				bool flag = string.Equals(item.FilePath, item.PreDownloadedFilePath, StringComparison.OrdinalIgnoreCase);
				bool flag2 = !item.IsFromStreamingAssets;
				list.Add(new ZipExtractionEntry(item.FilePath, num, item.FileName, flag2, flag2 && !flag, item.Tags));
				totalBytes += num;
				totalFiles++;
			}
			if (list.Count > 0)
			{
				dictionary[key] = list;
				if (Context.ExtractedDirectories.TryGetValue(key, out var value2) && !Directory.Exists(value2))
				{
					Directory.CreateDirectory(value2);
				}
			}
		}
		return dictionary;
	}

	private bool HasZipFilesToExtract()
	{
		if (Context.ZipPackageInfos == null)
		{
			return false;
		}
		foreach (KeyValuePair<AssetType, List<ZipPackageInfo>> zipPackageInfo in Context.ZipPackageInfos)
		{
			if (zipPackageInfo.Value == null)
			{
				continue;
			}
			foreach (ZipPackageInfo item in zipPackageInfo.Value)
			{
				if (item != null && !item.IsExtracted)
				{
					item.UpdateDownloadState();
					if (item.IsDownloaded && !string.IsNullOrEmpty(item.FilePath) && File.Exists(item.FilePath))
					{
						return true;
					}
				}
			}
		}
		return false;
	}

	private void ResetExtractProgressState()
	{
		StageProgressData stageProgressData = DownloadData?.GetStageProgressData(ProgressStageType.Extract);
		if (stageProgressData != null)
		{
			stageProgressData.Reset();
			DownloadData.NotifyStageProgressChanged(ProgressStageType.Extract);
		}
	}

	private void UpdateExtractProgress(bool isActive, long currentBytes, long totalBytes, int currentCount, int totalCount)
	{
		StageProgressData stageProgressData = DownloadData?.GetStageProgressData(ProgressStageType.Extract);
		if (stageProgressData != null)
		{
			stageProgressData.IsActive = isActive;
			stageProgressData.CurrentBytes = currentBytes;
			stageProgressData.TotalBytes = totalBytes;
			stageProgressData.CurrentCount = currentCount;
			stageProgressData.TotalCount = totalCount;
			stageProgressData.Percent = DownloadAssetSubFlowBase.CalculateStagePercent(currentBytes, totalBytes, currentCount, totalCount);
			DownloadData.NotifyStageProgressChanged(ProgressStageType.Extract);
		}
	}
}
