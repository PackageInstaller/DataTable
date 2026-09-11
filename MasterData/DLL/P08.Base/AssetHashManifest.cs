using System;
using System.Collections.Generic;
using UnityEngine;

public class AssetHashManifest
{
	public class AssetFileInfo
	{
		public string mBundleName;

		public string mHash;

		public int mFileSize;

		public string mFilePath;
	}

	private int appVersion;

	private int buildCode;

	private string versionName = "v0.0.0";

	public Dictionary<string, AssetFileInfo> mHash2FileInfo = new Dictionary<string, AssetFileInfo>();

	public Dictionary<string, AssetFileInfo> mFilePath2FileInfo = new Dictionary<string, AssetFileInfo>();

	public Dictionary<string, AssetFileInfo> mBundleName2FileInfo = new Dictionary<string, AssetFileInfo>();

	public AssetHashManifest()
	{
	}

	public AssetHashManifest(AssetHashList hashList)
	{
		appVersion = hashList.appVersion;
		buildCode = hashList.buildCode;
		versionName = hashList.versionName;
		mHash2FileInfo.Clear();
		mBundleName2FileInfo.Clear();
		mFilePath2FileInfo.Clear();
		for (int i = 0; i < hashList.assetHashList.Count; i++)
		{
			string[] array = hashList.assetHashList[i].Split('|');
			string mBundleName = array[0];
			string text = array[1];
			string s = array[2];
			AssetFileInfo item = new AssetFileInfo
			{
				mBundleName = mBundleName,
				mHash = text,
				mFileSize = int.Parse(s),
				mFilePath = HashToFilePath(text)
			};
			Add(item);
		}
	}

	public static string HashToFilePath(string hash)
	{
		return hash[0] + "/" + hash[1] + "/" + hash + ".ys";
	}

	public void Add(AssetFileInfo item)
	{
		try
		{
			mHash2FileInfo[item.mHash] = item;
			mFilePath2FileInfo[item.mFilePath] = item;
			if (!string.IsNullOrEmpty(item.mBundleName))
			{
				mBundleName2FileInfo.Add(item.mBundleName, item);
			}
		}
		catch (Exception ex)
		{
			Debug.LogError(item.mBundleName + " " + item.mHash + " " + item.mFilePath + " already in AssetHashManifest");
			Debug.LogError(ex.StackTrace);
		}
	}

	public bool TryGetFileInfoByBundleName(string bundleName, out AssetFileInfo hash)
	{
		return mBundleName2FileInfo.TryGetValue(bundleName, out hash);
	}

	public bool TryGetFileInfoByHash(string fileName, out AssetFileInfo fileInfo)
	{
		return mHash2FileInfo.TryGetValue(fileName, out fileInfo);
	}

	public bool TryGetFileInfoByFilePath(string filePath, out AssetFileInfo fileInfo)
	{
		return mFilePath2FileInfo.TryGetValue(filePath, out fileInfo);
	}

	public int GetClientVersion()
	{
		return appVersion;
	}

	public int GetResourceVersion()
	{
		return buildCode;
	}

	public string GetResourceVersionName()
	{
		return versionName;
	}
}
