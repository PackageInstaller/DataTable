using System;
using System.Collections.Generic;
using System.IO;
using System.Text.RegularExpressions;
using UnityEngine;

namespace ACT;

internal static class PreDownloadPackageStore
{
	internal readonly struct PreDownloadTarget
	{
		internal readonly int AssetsVersion;

		internal readonly int ClientStaticVersion;

		internal readonly int DllVersion;

		internal readonly int RawFileVersion;

		internal PreDownloadTarget(int assetsVersion, int clientStaticVersion, int dllVersion, int rawFileVersion)
		{
			AssetsVersion = assetsVersion;
			ClientStaticVersion = clientStaticVersion;
			DllVersion = dllVersion;
			RawFileVersion = rawFileVersion;
		}

		internal string ToVersionKey()
		{
			return BuildVersionKey(AssetsVersion, ClientStaticVersion, DllVersion, RawFileVersion);
		}
	}

	internal readonly struct StagedPackageZipInfos
	{
		internal readonly string PackageName;

		internal readonly ZipInfo[] ZipInfos;

		internal StagedPackageZipInfos(string packageName, ZipInfo[] zipInfos)
		{
			PackageName = packageName;
			ZipInfos = zipInfos;
		}
	}

	private const string RootDirectoryName = "pre-download";

	private const string DownloadsDirectoryName = "downloads";

	private const string MarkersDirectoryName = "zipmarkers";

	private const string VersionKeyPattern = "^a(\\d+)_cs(\\d+)_d(\\d+)_r(\\d+)$";

	internal static string BuildVersionKey(int assetsVersion, int clientStaticVersion, int dllVersion, int rawFileVersion)
	{
		return $"a{assetsVersion}_cs{clientStaticVersion}_d{dllVersion}_r{rawFileVersion}";
	}

	internal static bool TryGetCurrentVersionKey(out string versionKey)
	{
		versionKey = null;
		RemoteConfig remoteConfig = LuminApplication.RemoteConfig;
		if (remoteConfig == null)
		{
			return false;
		}
		versionKey = BuildVersionKey(remoteConfig.AssetsVersion, remoteConfig.ClientStaticVersion, remoteConfig.DllVersion, remoteConfig.RawFileVersion);
		return true;
	}

	internal static PreDownloadTarget CreateTarget(RemoteConfigPreDownload preDownload)
	{
		return new PreDownloadTarget(preDownload.AssetsVersion, preDownload.ClientStaticVersion, preDownload.DllVersion, preDownload.RawFileVersion);
	}

	internal static PreDownloadTarget CreateTarget(DownloadData localVersion)
	{
		return new PreDownloadTarget(localVersion.AssetVersion, localVersion.ClientStaticVersion, localVersion.DllVersion, localVersion.RawFileVersion);
	}

	internal static PreDownloadTarget CreateTarget(RemoteConfig config)
	{
		return new PreDownloadTarget(config.AssetsVersion, config.ClientStaticVersion, config.DllVersion, config.RawFileVersion);
	}

	internal static StagedPackageZipInfos[] CreatePackageZipInfos(RemoteConfigPreDownload preDownload)
	{
		return new StagedPackageZipInfos[4]
		{
			new StagedPackageZipInfos("Dll", preDownload.DiffDllInfos),
			new StagedPackageZipInfos("ClientStatic", preDownload.DiffClientStaticInfos),
			new StagedPackageZipInfos("Assets", preDownload.DiffAssetInfos),
			new StagedPackageZipInfos("RawFile", preDownload.DiffRawFileInfos)
		};
	}

	internal static int Compare(PreDownloadTarget left, PreDownloadTarget right)
	{
		bool flag = HasLowerVersion(left, right);
		bool flag2 = HasLowerVersion(right, left);
		if (flag == flag2)
		{
			return 0;
		}
		if (!flag)
		{
			return 1;
		}
		return -1;
	}

	internal static bool IsSameOrNewer(PreDownloadTarget candidate, PreDownloadTarget reference)
	{
		return !HasLowerVersion(candidate, reference);
	}

	private static bool HasLowerVersion(PreDownloadTarget candidate, PreDownloadTarget reference)
	{
		if (candidate.AssetsVersion >= reference.AssetsVersion && candidate.ClientStaticVersion >= reference.ClientStaticVersion && candidate.DllVersion >= reference.DllVersion)
		{
			return candidate.RawFileVersion < reference.RawFileVersion;
		}
		return true;
	}

	internal static bool TryParseVersionKey(string versionKey, out PreDownloadTarget target)
	{
		target = default;
		if (string.IsNullOrEmpty(versionKey))
		{
			return false;
		}
		Match match = Regex.Match(versionKey, "^a(\\d+)_cs(\\d+)_d(\\d+)_r(\\d+)$");
		if (!match.Success)
		{
			return false;
		}
		target = new PreDownloadTarget(int.Parse(match.Groups[1].Value), int.Parse(match.Groups[2].Value), int.Parse(match.Groups[3].Value), int.Parse(match.Groups[4].Value));
		return true;
	}

	internal static bool TryGetStagedTarget(string resourceRoot, out PreDownloadTarget target, out string versionKey)
	{
		target = default;
		versionKey = null;
		if (string.IsNullOrEmpty(resourceRoot))
		{
			return false;
		}
		string path = Path.Combine(resourceRoot, "pre-download");
		if (!Directory.Exists(path))
		{
			return false;
		}
		bool flag = false;
		PreDownloadTarget preDownloadTarget = default;
		string text = null;
		try
		{
			foreach (string item in Directory.EnumerateDirectories(path))
			{
				string fileName = Path.GetFileName(item);
				if (TryParseVersionKey(fileName, out var target2) && HasStagedPackages(resourceRoot, fileName) && (!flag || Compare(target2, preDownloadTarget) > 0))
				{
					flag = true;
					preDownloadTarget = target2;
					text = fileName;
				}
			}
		}
		catch (IOException)
		{
			return false;
		}
		catch (UnauthorizedAccessException)
		{
			return false;
		}
		if (!flag)
		{
			return false;
		}
		target = preDownloadTarget;
		versionKey = text;
		return true;
	}

	internal static void PromoteStagedTarget(string resourceRoot, PreDownloadTarget target, StagedPackageZipInfos[] packageZipInfos)
	{
		if (string.IsNullOrEmpty(resourceRoot) || packageZipInfos == null || packageZipInfos.Length == 0)
		{
			return;
		}
		string path = Path.Combine(resourceRoot, "pre-download");
		if (!Directory.Exists(path))
		{
			return;
		}
		string text = target.ToVersionKey();
		try
		{
			foreach (string item in Directory.EnumerateDirectories(path))
			{
				string fileName = Path.GetFileName(item);
				if (!string.Equals(fileName, text, StringComparison.OrdinalIgnoreCase))
				{
					if (TryParseVersionKey(fileName, out var _))
					{
						MoveReusableStagedPackages(resourceRoot, fileName, text, packageZipInfos);
						Debug.Log("[PreDownloadPackageStore] 预下载暂存目录推进: " + fileName + " -> " + text);
					}
					else
					{
						Debug.LogWarning("[PreDownloadPackageStore] 清理无法识别的预下载暂存目录: " + item);
					}
					DeleteDirectoryQuietly(item);
				}
			}
		}
		catch (IOException ex)
		{
			Debug.LogWarning("[PreDownloadPackageStore] 预下载暂存目标推进失败: " + ex.Message);
		}
		catch (UnauthorizedAccessException ex2)
		{
			Debug.LogWarning("[PreDownloadPackageStore] 预下载暂存目标推进失败: " + ex2.Message);
		}
	}

	private static void MoveReusableStagedPackages(string resourceRoot, string sourceVersionKey, string targetVersionKey, StagedPackageZipInfos[] packageZipInfos)
	{
		for (int i = 0; i < packageZipInfos.Length; i++)
		{
			StagedPackageZipInfos stagedPackageZipInfos = packageZipInfos[i];
			if (string.IsNullOrEmpty(stagedPackageZipInfos.PackageName) || stagedPackageZipInfos.ZipInfos == null)
			{
				continue;
			}
			string downloadDirectory = GetDownloadDirectory(resourceRoot, sourceVersionKey, stagedPackageZipInfos.PackageName);
			if (!Directory.Exists(downloadDirectory))
			{
				continue;
			}
			HashSet<string> hashSet = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
			ZipInfo[] zipInfos = stagedPackageZipInfos.ZipInfos;
			for (int j = 0; j < zipInfos.Length; j++)
			{
				string stagedFileName = GetStagedFileName(zipInfos[j]);
				if (!string.IsNullOrEmpty(stagedFileName))
				{
					hashSet.Add(stagedFileName);
				}
			}
			if (hashSet.Count == 0)
			{
				continue;
			}
			string downloadDirectory2 = GetDownloadDirectory(resourceRoot, targetVersionKey, stagedPackageZipInfos.PackageName);
			Directory.CreateDirectory(downloadDirectory2);
			foreach (string item in Directory.EnumerateFiles(downloadDirectory))
			{
				string fileName = Path.GetFileName(item);
				if (!hashSet.Contains(fileName))
				{
					continue;
				}
				string text = Path.Combine(downloadDirectory2, fileName);
				if (!File.Exists(text))
				{
					try
					{
						File.Move(item, text);
					}
					catch (IOException ex)
					{
						Debug.LogWarning("[PreDownloadPackageStore] 复用预下载暂存包失败: " + fileName + ", " + ex.Message);
					}
					catch (UnauthorizedAccessException ex2)
					{
						Debug.LogWarning("[PreDownloadPackageStore] 复用预下载暂存包失败: " + fileName + ", " + ex2.Message);
					}
				}
			}
		}
	}

	private static string GetStagedFileName(ZipInfo zipInfo)
	{
		if (zipInfo == null || string.IsNullOrEmpty(zipInfo.url))
		{
			return null;
		}
		string fileName = Path.GetFileName(zipInfo.url);
		if (!string.IsNullOrEmpty(fileName))
		{
			return fileName;
		}
		return null;
	}

	private static void DeleteDirectoryQuietly(string directory)
	{
		try
		{
			Directory.Delete(directory, recursive: true);
		}
		catch (IOException ex)
		{
			Debug.LogWarning("[PreDownloadPackageStore] 清理旧预下载暂存目录失败: " + directory + ", " + ex.Message);
		}
		catch (UnauthorizedAccessException ex2)
		{
			Debug.LogWarning("[PreDownloadPackageStore] 清理旧预下载暂存目录失败: " + directory + ", " + ex2.Message);
		}
	}

	internal static bool IsCurrentRemoteVersionNewerThanLocal(DownloadData localVersion, out string reason)
	{
		reason = null;
		if (localVersion == null || !localVersion.HasVersionInfo)
		{
			reason = "本地版本信息不可用";
			return false;
		}
		RemoteConfig remoteConfig = LuminApplication.RemoteConfig;
		if (remoteConfig == null)
		{
			reason = "正式远端版本信息不可用";
			return false;
		}
		if (remoteConfig.AssetsVersion < localVersion.AssetVersion || remoteConfig.ClientStaticVersion < localVersion.ClientStaticVersion || remoteConfig.DllVersion < localVersion.DllVersion || remoteConfig.RawFileVersion < localVersion.RawFileVersion)
		{
			reason = "正式远端版本包含回退";
			return false;
		}
		if (remoteConfig.AssetsVersion <= localVersion.AssetVersion && remoteConfig.ClientStaticVersion <= localVersion.ClientStaticVersion && remoteConfig.DllVersion <= localVersion.DllVersion && remoteConfig.RawFileVersion <= localVersion.RawFileVersion)
		{
			reason = "正式远端版本未高于本地版本";
			return false;
		}
		return true;
	}

	internal static string GetDownloadDirectory(string resourceRoot, string versionKey, string packageName)
	{
		return Path.Combine(GetVersionRoot(resourceRoot, versionKey), "downloads", packageName);
	}

	internal static string GetMarkerDirectory(string resourceRoot, string versionKey, string packageName)
	{
		return Path.Combine(GetVersionRoot(resourceRoot, versionKey), "zipmarkers", packageName);
	}

	internal static string GetStagedZipPath(string resourceRoot, string versionKey, string packageName, string fileName)
	{
		if (string.IsNullOrEmpty(resourceRoot) || string.IsNullOrEmpty(versionKey) || string.IsNullOrEmpty(packageName) || string.IsNullOrEmpty(fileName))
		{
			return null;
		}
		return Path.Combine(GetDownloadDirectory(resourceRoot, versionKey, packageName), fileName);
	}

	internal static bool HasStagedPackages(string resourceRoot, string versionKey)
	{
		if (string.IsNullOrEmpty(resourceRoot) || string.IsNullOrEmpty(versionKey))
		{
			return false;
		}
		string path = Path.Combine(GetVersionRoot(resourceRoot, versionKey), "downloads");
		if (!Directory.Exists(path))
		{
			return false;
		}
		try
		{
			using IEnumerator<string> enumerator = Directory.EnumerateFiles(path, "*.zip", SearchOption.AllDirectories).GetEnumerator();
			return enumerator.MoveNext();
		}
		catch (IOException)
		{
			return false;
		}
		catch (UnauthorizedAccessException)
		{
			return false;
		}
	}

	internal static long GetDownloadedBytes(string resourceRoot, string versionKey)
	{
		if (string.IsNullOrEmpty(resourceRoot) || string.IsNullOrEmpty(versionKey))
		{
			return 0L;
		}
		string path = Path.Combine(GetVersionRoot(resourceRoot, versionKey), "downloads");
		if (!Directory.Exists(path))
		{
			return 0L;
		}
		long num = 0L;
		try
		{
			foreach (string item in Directory.EnumerateFiles(path, "*", SearchOption.AllDirectories))
			{
				long length = new FileInfo(item).Length;
				if (length > 0)
				{
					if (num > long.MaxValue - length)
					{
						return long.MaxValue;
					}
					num += length;
				}
			}
		}
		catch (IOException)
		{
		}
		catch (UnauthorizedAccessException)
		{
		}
		return num;
	}

	private static string GetVersionRoot(string resourceRoot, string versionKey)
	{
		if (string.IsNullOrEmpty(resourceRoot))
		{
			throw new ArgumentException("Resource root is required.", "resourceRoot");
		}
		if (string.IsNullOrEmpty(versionKey))
		{
			throw new ArgumentException("Pre-download version key is required.", "versionKey");
		}
		return Path.Combine(resourceRoot, "pre-download", versionKey);
	}
}
