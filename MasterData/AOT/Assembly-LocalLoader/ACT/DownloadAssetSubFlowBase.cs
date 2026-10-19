using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using YooAsset;

namespace ACT;

internal abstract class DownloadAssetSubFlowBase : GameLoadingFlowBase
{
	protected readonly DownloadAssetContext Context;

	internal abstract override EGameLoadingStage Stage { get; }

	protected DownloadData DownloadData => Context.DownloadData;

	protected DownloadAssetSubFlowBase(DownloadAssetContext context)
	{
		Context = context;
	}

	protected void EnsureZipDirectoriesInitialized()
	{
		if (Context.ZipDownloadDirectories != null && Context.ExtractedDirectories != null && Context.ZipMarkerDirectories != null)
		{
			return;
		}
		string dataDirectory = GetDataDirectory();
		string zipExtractedDirectory = GetZipExtractedDirectory();
		DownloadAssetContext context = Context;
		if (context.ZipDownloadDirectories == null)
		{
			Dictionary<AssetType, string> dictionary = (context.ZipDownloadDirectories = new Dictionary<AssetType, string>());
		}
		context = Context;
		if (context.ExtractedDirectories == null)
		{
			Dictionary<AssetType, string> dictionary = (context.ExtractedDirectories = new Dictionary<AssetType, string>());
		}
		context = Context;
		if (context.ZipMarkerDirectories == null)
		{
			Dictionary<AssetType, string> dictionary = (context.ZipMarkerDirectories = new Dictionary<AssetType, string>());
		}
		foreach (KeyValuePair<AssetType, PackageInfo> packageInfo in Context.PackageInfos)
		{
			AssetType key = packageInfo.Key;
			string packageName = packageInfo.Value.PackageName;
			string text = (Context.ZipDownloadParam.IsPreDownload ? PreDownloadPackageStore.GetDownloadDirectory(dataDirectory, Context.ZipDownloadParam.PreDownloadVersionKey, packageName) : Path.Combine(dataDirectory, "downloads", packageName));
			string value = Path.Combine(zipExtractedDirectory, packageName, "BundleFiles");
			string value2 = (Context.ZipDownloadParam.IsPreDownload ? PreDownloadPackageStore.GetMarkerDirectory(dataDirectory, Context.ZipDownloadParam.PreDownloadVersionKey, packageName) : Path.Combine(dataDirectory, "zipmarkers", packageName));
			Context.ZipDownloadDirectories[key] = text;
			Context.ExtractedDirectories[key] = value;
			Context.ZipMarkerDirectories[key] = value2;
			if (!Directory.Exists(text))
			{
				Directory.CreateDirectory(text);
			}
		}
	}

	protected string GetDataDirectory()
	{
		return LuminApplication.GetResPath();
	}

	protected string GetZipExtractedDirectory()
	{
		return YooAssetSettingsData.GetYooDefaultCacheRoot();
	}

	protected string GetZipMarkerPath(string zipFileName, AssetType assetType)
	{
		EnsureZipDirectoriesInitialized();
		if (string.IsNullOrEmpty(zipFileName) || Context.ZipMarkerDirectories == null)
		{
			return null;
		}
		if (!Context.ZipMarkerDirectories.TryGetValue(assetType, out var value) || string.IsNullOrEmpty(value))
		{
			return null;
		}
		return Path.Combine(value, zipFileName + ".marker");
	}

	internal bool TryApplyZipMarkerProgress(string zipFileName, AssetType assetType)
	{
		string zipMarkerPath = GetZipMarkerPath(zipFileName, assetType);
		if (string.IsNullOrEmpty(zipMarkerPath) || !File.Exists(zipMarkerPath))
		{
			return false;
		}
		DownloadAssetContext context = Context;
		if (context.CountedZipMarkerFiles == null)
		{
			HashSet<string> hashSet = (context.CountedZipMarkerFiles = new HashSet<string>());
		}
		if (!Context.CountedZipMarkerFiles.Contains(zipMarkerPath))
		{
			Context.CountedZipMarkerFiles.Add(zipMarkerPath);
		}
		return true;
	}

	protected bool TryGetZipMarkerBytes(string zipFileName, AssetType assetType, out long markerBytes)
	{
		markerBytes = 0L;
		string zipMarkerPath = GetZipMarkerPath(zipFileName, assetType);
		if (string.IsNullOrEmpty(zipMarkerPath))
		{
			return false;
		}
		return TryReadZipMarkerBytes(zipMarkerPath, out markerBytes);
	}

	protected bool TryReadZipMarkerBytes(string markerPath, out long markerBytes)
	{
		markerBytes = 0L;
		if (string.IsNullOrEmpty(markerPath) || !File.Exists(markerPath))
		{
			return false;
		}
		try
		{
			if (long.TryParse(File.ReadAllText(markerPath), out var result) && result > 0)
			{
				markerBytes = result;
				return true;
			}
		}
		catch (Exception ex)
		{
			Log("读取zip记录文件失败: " + markerPath + ", " + ex.Message);
		}
		return false;
	}

	protected void MarkZipAsExtracted(string zipFileName, AssetType assetType, long zipFileSize)
	{
		string zipMarkerPath = GetZipMarkerPath(zipFileName, assetType);
		if (string.IsNullOrEmpty(zipMarkerPath))
		{
			return;
		}
		try
		{
			string directoryName = Path.GetDirectoryName(zipMarkerPath);
			if (!string.IsNullOrEmpty(directoryName))
			{
				if (!Directory.Exists(directoryName))
				{
					Directory.CreateDirectory(directoryName);
				}
				else
				{
					try
					{
						string[] files = Directory.GetFiles(directoryName, "*.marker");
						HashSet<string> hashSet = new HashSet<string>();
						if (Context.ZipPackageInfos != null && Context.ZipPackageInfos.TryGetValue(assetType, out var value))
						{
							foreach (ZipPackageInfo item2 in value)
							{
								if (!string.IsNullOrEmpty(item2.FileName))
								{
									string item = item2.FileName + ".marker";
									hashSet.Add(item);
								}
							}
						}
						string[] array = files;
						foreach (string path in array)
						{
							string fileName = Path.GetFileName(path);
							if (!hashSet.Contains(fileName))
							{
								try
								{
									File.Delete(path);
									Log("已删除不在本次下载列表中的旧标记文件: " + fileName);
								}
								catch (Exception ex)
								{
									Warning("删除旧标记文件失败: " + fileName + ", " + ex.Message);
								}
							}
						}
					}
					catch (Exception ex2)
					{
						Warning("清理旧标记文件失败: " + ex2.Message);
					}
				}
			}
			File.WriteAllText(zipMarkerPath, Math.Max(0L, zipFileSize).ToString());
		}
		catch (Exception ex3)
		{
			Log("写入zip记录文件失败: " + zipMarkerPath + ", " + ex3.Message);
		}
	}

	protected ZipInfo[] GetZipDownloadURLs(AssetType assetType)
	{
		ZipDownloadParam zipDownloadParam = Context.ZipDownloadParam;
		return assetType switch
		{
			AssetType.Dll => zipDownloadParam.DllZipDownloadURLs, 
			AssetType.ClientStatic => zipDownloadParam.ClientStaticZipDownloadURLs, 
			AssetType.Assets => zipDownloadParam.AssetsZipDownloadURLs, 
			AssetType.RawFile => zipDownloadParam.RawFileZipDownloadURLs, 
			_ => null, 
		};
	}

	protected string GetZipFilePath(string zipUrl, AssetType assetType)
	{
		EnsureZipDirectoriesInitialized();
		string text = Path.GetFileName(zipUrl);
		if (string.IsNullOrEmpty(text))
		{
			text = $"{assetType}.zip";
		}
		return Path.Combine(Context.ZipDownloadDirectories[assetType], text);
	}

	protected string GetZipStreamingAssetsFilePath(string zipUrl, AssetType assetType)
	{
		if (Context.PackageInfos == null || !Context.PackageInfos.TryGetValue(assetType, out var value) || value == null)
		{
			return null;
		}
		string text = Path.GetFileName(zipUrl);
		if (string.IsNullOrEmpty(text))
		{
			text = $"{assetType}.zip";
		}
		return Path.Combine(Application.streamingAssetsPath, value.PackageName, text);
	}

	protected string GenerateHashSizeFileName(string hash, long size)
	{
		if (string.IsNullOrEmpty(hash))
		{
			return null;
		}
		return $"{hash}_{size}";
	}

	protected bool ContainsDownloadTag(IReadOnlyList<string> tags)
	{
		if (tags == null || tags.Count == 0)
		{
			return true;
		}
		string[] array = Context.ZipDownloadParam?.DownloadTags;
		if (array == null || array.Length == 0)
		{
			return true;
		}
		for (int i = 0; i < tags.Count; i++)
		{
			string text = tags[i];
			if (string.IsNullOrWhiteSpace(text))
			{
				continue;
			}
			foreach (string text2 in array)
			{
				if (!string.IsNullOrWhiteSpace(text2) && string.Equals(text.Trim(), text2.Trim(), StringComparison.OrdinalIgnoreCase))
				{
					return true;
				}
			}
		}
		return false;
	}

	protected void SetProgressStage(ProgressStageType stage)
	{
		DownloadData?.SetStage(stage);
	}

	protected static float CalculateStagePercent(long currentBytes, long totalBytes, int currentCount, int totalCount)
	{
		if (totalBytes > 0)
		{
			return Mathf.Clamp01((float)currentBytes / (float)totalBytes);
		}
		if (totalCount > 0)
		{
			return Mathf.Clamp01((float)currentCount / (float)totalCount);
		}
		return 0f;
	}
}
