using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using UnityEngine;
using YooAsset;

namespace ACT;

public sealed class DownloadAssetManager
{
	private const string LocalDownloadedTagsPrefsKey = "DownloadAsset.LocalDownloadedTags";

	private const char LocalDownloadedTagSeparator = '|';

	private const string LocalDownloadedFileManifestDirectory = "downloaded-tag-files";

	private static readonly Lazy<DownloadAssetManager> _instance = new Lazy<DownloadAssetManager>(() => new DownloadAssetManager());

	private readonly HashSet<string> _playerTags = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

	private readonly HashSet<string> _localDownloadedTags = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

	private bool _localDownloadedTagsLoaded;

	public static DownloadAssetManager Instance => _instance.Value;

	public static IReadOnlyList<string> Parse(string tagString)
	{
		if (string.IsNullOrWhiteSpace(tagString))
		{
			throw new ArgumentException("Tag string can not be null or empty.", "tagString");
		}
		string[] array = tagString.Split('-');
		List<string> list = new List<string>(array.Length);
		string[] array2 = array;
		for (int i = 0; i < array2.Length; i++)
		{
			string text = array2[i].Trim();
			if (string.IsNullOrEmpty(text))
			{
				throw new FormatException("Invalid tag string format: " + tagString + ". Each tag segment must be non-empty.");
			}
			list.Add(text);
		}
		return list;
	}

	public void SetPlayerTags(IEnumerable<string> playerTags)
	{
		_playerTags.Clear();
		if (playerTags == null)
		{
			return;
		}
		foreach (string playerTag in playerTags)
		{
			if (!string.IsNullOrWhiteSpace(playerTag))
			{
				_playerTags.Add(playerTag.Trim());
			}
		}
	}

	public bool ContainsPlayerTag(IReadOnlyList<string> tags)
	{
		if (tags == null)
		{
			throw new ArgumentNullException("tags");
		}
		for (int i = 0; i < tags.Count; i++)
		{
			string text = tags[i];
			if (!string.IsNullOrWhiteSpace(text) && _playerTags.Contains(text.Trim()))
			{
				return true;
			}
		}
		return false;
	}

	public bool HasLocalDownloadedTag(string tag)
	{
		if (string.IsNullOrWhiteSpace(tag))
		{
			return false;
		}
		EnsureLocalDownloadedTagsLoaded();
		return _localDownloadedTags.Contains(tag.Trim());
	}

	public void AddLocalDownloadedTag(string tag)
	{
		if (!string.IsNullOrWhiteSpace(tag))
		{
			EnsureLocalDownloadedTagsLoaded();
			if (_localDownloadedTags.Add(tag.Trim()))
			{
				SaveLocalDownloadedTags();
			}
		}
	}

	public void RemoveLocalDownloadedTag(string tag)
	{
		if (!string.IsNullOrWhiteSpace(tag))
		{
			EnsureLocalDownloadedTagsLoaded();
			if (_localDownloadedTags.Remove(tag.Trim()))
			{
				SaveLocalDownloadedTags();
			}
		}
	}

	public void RecordExtractedFiles(IReadOnlyList<string> tags, IReadOnlyList<string> filePaths)
	{
		if (tags == null || filePaths == null || filePaths.Count == 0)
		{
			return;
		}
		HashSet<string> hashSet = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
		for (int i = 0; i < filePaths.Count; i++)
		{
			string text = NormalizeCacheFilePath(filePaths[i]);
			if (!string.IsNullOrEmpty(text))
			{
				hashSet.Add(text);
			}
		}
		if (hashSet.Count == 0)
		{
			return;
		}
		foreach (string tag in tags)
		{
			if (string.IsNullOrWhiteSpace(tag))
			{
				continue;
			}
			string tagManifestPath = GetTagManifestPath(tag);
			if (string.IsNullOrEmpty(tagManifestPath))
			{
				continue;
			}
			try
			{
				HashSet<string> hashSet2 = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
				if (File.Exists(tagManifestPath))
				{
					string[] array = File.ReadAllLines(tagManifestPath);
					for (int j = 0; j < array.Length; j++)
					{
						string text2 = NormalizeCacheFilePath(array[j]);
						if (!string.IsNullOrEmpty(text2))
						{
							hashSet2.Add(text2);
						}
					}
				}
				hashSet2.UnionWith(hashSet);
				Directory.CreateDirectory(Path.GetDirectoryName(tagManifestPath));
				File.WriteAllLines(tagManifestPath, hashSet2);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("[DownloadAssetManager] Failed to save extracted-file manifest for tag '" + tag + "': " + ex.Message);
			}
		}
	}

	public void DeleteLocalDownloadedTagFiles(string tag)
	{
		string tagManifestPath = GetTagManifestPath(tag);
		if (string.IsNullOrEmpty(tagManifestPath) || !File.Exists(tagManifestPath))
		{
			return;
		}
		try
		{
			HashSet<string> pathsReferencedByOtherTags = GetPathsReferencedByOtherTags(tagManifestPath);
			bool flag = false;
			string[] array = File.ReadAllLines(tagManifestPath);
			for (int i = 0; i < array.Length; i++)
			{
				string text = NormalizeCacheFilePath(array[i]);
				if (!string.IsNullOrEmpty(text) && !pathsReferencedByOtherTags.Contains(text) && File.Exists(text))
				{
					try
					{
						File.Delete(text);
					}
					catch (Exception ex)
					{
						flag = true;
						Debug.LogWarning("[DownloadAssetManager] Failed to delete downloaded file '" + text + "': " + ex.Message);
					}
				}
			}
			if (!flag)
			{
				File.Delete(tagManifestPath);
			}
		}
		catch (Exception ex2)
		{
			Debug.LogWarning("[DownloadAssetManager] Failed to delete downloaded files for tag '" + tag + "': " + ex2.Message);
		}
	}

	public void DeleteLocalDownloadedTagZipMarkers(string tag, IReadOnlyList<ZipInfo> rawFileZipInfos)
	{
		if (string.IsNullOrWhiteSpace(tag) || rawFileZipInfos == null || rawFileZipInfos.Count == 0)
		{
			return;
		}
		string resPath = LuminApplication.GetResPath();
		if (string.IsNullOrEmpty(resPath))
		{
			return;
		}
		string text = Path.Combine(resPath, "zipmarkers", "RawFile");
		if (!Directory.Exists(text))
		{
			return;
		}
		for (int i = 0; i < rawFileZipInfos.Count; i++)
		{
			ZipInfo zipInfo = rawFileZipInfos[i];
			if (zipInfo != null && ContainsTag(zipInfo.tag, tag))
			{
				DeleteZipMarker(text, GetZipMarkerFileName(zipInfo));
				DeleteZipMarker(text, Path.GetFileName(zipInfo.url));
			}
		}
	}

	private void EnsureLocalDownloadedTagsLoaded()
	{
		if (_localDownloadedTagsLoaded)
		{
			return;
		}
		_localDownloadedTagsLoaded = true;
		_localDownloadedTags.Clear();
		string text = PlayerPrefs.GetString("DownloadAsset.LocalDownloadedTags", string.Empty);
		if (string.IsNullOrWhiteSpace(text))
		{
			return;
		}
		string[] array = text.Split('|');
		foreach (string text2 in array)
		{
			if (!string.IsNullOrWhiteSpace(text2))
			{
				_localDownloadedTags.Add(text2.Trim());
			}
		}
	}

	private void SaveLocalDownloadedTags()
	{
		if (_localDownloadedTags.Count == 0)
		{
			PlayerPrefs.DeleteKey("DownloadAsset.LocalDownloadedTags");
			PlayerPrefs.Save();
			return;
		}
		StringBuilder stringBuilder = new StringBuilder();
		foreach (string localDownloadedTag in _localDownloadedTags)
		{
			if (stringBuilder.Length > 0)
			{
				stringBuilder.Append('|');
			}
			stringBuilder.Append(localDownloadedTag);
		}
		PlayerPrefs.SetString("DownloadAsset.LocalDownloadedTags", stringBuilder.ToString());
		PlayerPrefs.Save();
	}

	private static HashSet<string> GetPathsReferencedByOtherTags(string excludedManifestPath)
	{
		HashSet<string> hashSet = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
		string manifestDirectory = GetManifestDirectory();
		if (string.IsNullOrEmpty(manifestDirectory) || !Directory.Exists(manifestDirectory))
		{
			return hashSet;
		}
		string[] files = Directory.GetFiles(manifestDirectory, "*.manifest", SearchOption.TopDirectoryOnly);
		foreach (string text in files)
		{
			if (string.Equals(text, excludedManifestPath, StringComparison.OrdinalIgnoreCase))
			{
				continue;
			}
			string[] array = File.ReadAllLines(text);
			for (int j = 0; j < array.Length; j++)
			{
				string text2 = NormalizeCacheFilePath(array[j]);
				if (!string.IsNullOrEmpty(text2))
				{
					hashSet.Add(text2);
				}
			}
		}
		return hashSet;
	}

	private static bool ContainsTag(string packageTags, string tag)
	{
		if (string.IsNullOrWhiteSpace(packageTags) || string.IsNullOrWhiteSpace(tag))
		{
			return false;
		}
		string[] array = packageTags.Split('-');
		for (int i = 0; i < array.Length; i++)
		{
			if (string.Equals(array[i].Trim(), tag.Trim(), StringComparison.OrdinalIgnoreCase))
			{
				return true;
			}
		}
		return false;
	}

	private static string GetZipMarkerFileName(ZipInfo zipInfo)
	{
		if (zipInfo == null)
		{
			return null;
		}
		if (!string.IsNullOrEmpty(zipInfo.hash))
		{
			long.TryParse(zipInfo.size, out var result);
			return $"{zipInfo.hash}_{result}";
		}
		return Path.GetFileName(zipInfo.url);
	}

	private static void DeleteZipMarker(string markerDirectory, string markerFileName)
	{
		if (string.IsNullOrEmpty(markerFileName))
		{
			return;
		}
		string text = Path.Combine(markerDirectory, markerFileName + ".marker");
		if (!File.Exists(text))
		{
			return;
		}
		try
		{
			File.Delete(text);
			Debug.Log("[DownloadAssetManager] Deleted zip completion marker: " + text);
		}
		catch (Exception ex)
		{
			Debug.LogWarning("[DownloadAssetManager] Failed to delete zip completion marker '" + text + "': " + ex.Message);
		}
	}

	private static string GetTagManifestPath(string tag)
	{
		if (string.IsNullOrWhiteSpace(tag))
		{
			return null;
		}
		string manifestDirectory = GetManifestDirectory();
		if (!string.IsNullOrEmpty(manifestDirectory))
		{
			return Path.Combine(manifestDirectory, ToFileName(tag.Trim()) + ".manifest");
		}
		return null;
	}

	private static string GetManifestDirectory()
	{
		string resPath = LuminApplication.GetResPath();
		if (!string.IsNullOrEmpty(resPath))
		{
			return Path.Combine(resPath, "downloaded-tag-files");
		}
		return null;
	}

	private static string NormalizeCacheFilePath(string path)
	{
		if (string.IsNullOrWhiteSpace(path))
		{
			return null;
		}
		try
		{
			string text = Path.GetFullPath(YooAssetSettingsData.GetYooDefaultCacheRoot()).TrimEnd(Path.DirectorySeparatorChar, Path.AltDirectorySeparatorChar);
			char directorySeparatorChar = Path.DirectorySeparatorChar;
			string value = text + directorySeparatorChar;
			string fullPath = Path.GetFullPath(path);
			return fullPath.StartsWith(value, StringComparison.OrdinalIgnoreCase) ? fullPath : null;
		}
		catch
		{
			return null;
		}
	}

	private static string ToFileName(string value)
	{
		StringBuilder stringBuilder = new StringBuilder(value.Length * 2);
		for (int i = 0; i < value.Length; i++)
		{
			stringBuilder.Append(((int)value[i]).ToString("x2"));
		}
		return stringBuilder.ToString();
	}
}
