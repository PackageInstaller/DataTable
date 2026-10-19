using System;
using System.IO;
using System.Linq;

namespace ACT;

internal class ZipPackageInfo
{
	public string Url;

	public AssetType AssetType;

	public int Index;

	public string FilePath;

	public string DownloadFilePath;

	public string StreamingAssetsFilePath;

	public string PreDownloadedFilePath;

	public string FileName;

	public long RemoteFileSize;

	public string ExpectedHash;

	public bool IsDownloaded;

	public bool IsExtracted;

	public long DownloadedBytes;

	public string[] Tags;

	public bool NeedDownload
	{
		get
		{
			if (!IsDownloaded)
			{
				return !IsExtracted;
			}
			return false;
		}
	}

	public bool IsFromStreamingAssets => IsSamePath(FilePath, StreamingAssetsFilePath);

	public void UpdateDownloadState()
	{
		FilePath = ResolveExistingFilePath();
		bool flag = !string.IsNullOrEmpty(FilePath) && File.Exists(FilePath);
		if (flag)
		{
			try
			{
				FileInfo fileInfo = new FileInfo(FilePath);
				DownloadedBytes = fileInfo.Length;
			}
			catch
			{
				DownloadedBytes = 0L;
			}
		}
		else
		{
			DownloadedBytes = 0L;
		}
		bool flag2 = RemoteFileSize > 0;
		bool flag3 = flag2 && DownloadedBytes == RemoteFileSize;
		bool flag4 = IsFromStreamingAssets && !flag2;
		IsDownloaded = flag && (flag3 | flag4);
		if (((!IsDownloaded && IsFromStreamingAssets) & flag2) && DownloadedBytes != RemoteFileSize)
		{
			FilePath = DownloadFilePath;
		}
	}

	public void UpdateTagState(string zipName)
	{
		if (string.IsNullOrWhiteSpace(zipName))
		{
			Tags = Array.Empty<string>();
			return;
		}
		try
		{
			Tags = DownloadAssetManager.Parse(zipName).ToArray();
		}
		catch (Exception)
		{
			Tags = Array.Empty<string>();
		}
	}

	public bool UpdateExtractState(DownloadAssetSubFlowBase flow)
	{
		IsExtracted = flow.TryApplyZipMarkerProgress(FileName, AssetType);
		return IsExtracted;
	}

	private string ResolveExistingFilePath()
	{
		bool flag = TryGetFileLength(PreDownloadedFilePath, out var fileLength);
		bool flag2 = TryGetFileLength(DownloadFilePath, out var fileLength2);
		bool flag3 = TryGetFileLength(StreamingAssetsFilePath, out var fileLength3);
		if (RemoteFileSize > 0)
		{
			if (flag && fileLength == RemoteFileSize)
			{
				return PreDownloadedFilePath;
			}
			if (flag2 && fileLength2 == RemoteFileSize)
			{
				return DownloadFilePath;
			}
			if (flag3 && fileLength3 == RemoteFileSize)
			{
				return StreamingAssetsFilePath;
			}
		}
		if (flag)
		{
			return PreDownloadedFilePath;
		}
		if (flag2)
		{
			return DownloadFilePath;
		}
		if (flag3)
		{
			return StreamingAssetsFilePath;
		}
		if (string.IsNullOrEmpty(DownloadFilePath))
		{
			return StreamingAssetsFilePath;
		}
		return DownloadFilePath;
	}

	private static bool TryGetFileLength(string path, out long fileLength)
	{
		fileLength = 0L;
		if (string.IsNullOrEmpty(path) || !File.Exists(path))
		{
			return false;
		}
		try
		{
			fileLength = new FileInfo(path).Length;
			return true;
		}
		catch
		{
			return false;
		}
	}

	private static bool IsSamePath(string left, string right)
	{
		if (string.IsNullOrEmpty(left) || string.IsNullOrEmpty(right))
		{
			return false;
		}
		try
		{
			return string.Equals(Path.GetFullPath(left), Path.GetFullPath(right), StringComparison.OrdinalIgnoreCase);
		}
		catch
		{
			string a = left.Replace('\\', '/');
			string b = right.Replace('\\', '/');
			return string.Equals(a, b, StringComparison.OrdinalIgnoreCase);
		}
	}
}
