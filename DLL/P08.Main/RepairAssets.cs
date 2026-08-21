using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

public class RepairAssets : MonoBehaviour
{
	private static RepairAssets _repairAssets;

	private List<AssetHashManifest.AssetFileInfo> _waitingFiles;

	private int _verifyIndex;

	private bool _verifying;

	private bool _hasError;

	private static void Create()
	{
		if (_repairAssets == null)
		{
			_repairAssets = U3DUtil.Get<RepairAssets>(new GameObject("RepairAssets"));
		}
	}

	private void VerifyAssetsInternal()
	{
		_verifyIndex = 0;
		AssetHashManifest assetHashManifest = AssetManager.GetAssetHashManifest();
		if (assetHashManifest != null)
		{
			if (_waitingFiles == null)
			{
				_waitingFiles = new List<AssetHashManifest.AssetFileInfo>(assetHashManifest.mHash2FileInfo.Count);
			}
			_waitingFiles.Clear();
			foreach (KeyValuePair<string, AssetHashManifest.AssetFileInfo> item in assetHashManifest.mHash2FileInfo)
			{
				_waitingFiles.Add(item.Value);
			}
		}
		_verifying = true;
	}

	private void Update()
	{
		if (!_verifying)
		{
			return;
		}
		int i = _verifyIndex;
		_verifyIndex += 5;
		for (int verifyIndex = _verifyIndex; i < verifyIndex && i < _waitingFiles.Count; i++)
		{
			string path = Platform.GetDownloadPersistentDataPath() + _waitingFiles[i].mFilePath;
			if (!File.Exists(path))
			{
				continue;
			}
			try
			{
				string text = HashUtil.HashFile(path);
				if (_waitingFiles[i].mHash != text)
				{
					File.Delete(path);
					Debug.LogError("hash diff bundleName:" + _waitingFiles[i].mBundleName + ", fileName:" + _waitingFiles[i].mFilePath + ", fileHash:" + _waitingFiles[i].mHash + ", calc hash:" + text + " ");
					_hasError = true;
				}
			}
			catch (Exception)
			{
				Debug.LogError("calc hash exception:" + _waitingFiles[i].mBundleName + ", fileName:" + _waitingFiles[i].mFilePath + ", fileHash:" + _waitingFiles[i].mHash);
			}
		}
		if (_verifyIndex >= _waitingFiles.Count)
		{
			_verifying = false;
		}
	}

	public static void VerifyAssets()
	{
		if (_repairAssets == null)
		{
			Create();
		}
		_repairAssets.VerifyAssetsInternal();
	}

	public static bool HasError()
	{
		if (_repairAssets == null)
		{
			Create();
		}
		return _repairAssets._hasError;
	}

	public static int GetTotalVerifyCount()
	{
		if (_repairAssets == null)
		{
			Create();
		}
		return _repairAssets._waitingFiles.Count;
	}

	public static int GetCurrentVerifyIndex()
	{
		if (_repairAssets == null)
		{
			Create();
		}
		return _repairAssets._verifyIndex;
	}

	public static bool IsVerifying()
	{
		if (_repairAssets == null)
		{
			Create();
		}
		return _repairAssets._verifying;
	}

	public static void StopVerify()
	{
		UnityEngine.Object.Destroy(_repairAssets.gameObject);
	}
}
