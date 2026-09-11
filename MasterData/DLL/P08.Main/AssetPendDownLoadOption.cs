using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

public abstract class AssetPendDownLoadOption
{
	public class AssetDownloadInfo
	{
		public string url;

		public string fileName;

		public string path;

		public ulong size;

		public string sdkPath;
	}

	private AssetPendDownLoadManager m_manager;

	protected string m_key;

	protected Dictionary<string, AssetDownloadInfo> m_pendingDownloadDict;

	private AssetPendDownLoadState m_state;

	protected ulong m_currentSize;

	public Action onSucessed;

	public Action onFailed;

	public Action onPause;

	private bool destroyed;

	protected ulong m_totalSize { get; private set; }

	public AssetPendDownLoadOption(PendType pType, string key, AssetPendDownLoadManager manager)
	{
		m_key = key;
		m_manager = manager;
		m_pendingDownloadDict = new Dictionary<string, AssetDownloadInfo>();
		switch (pType)
		{
		case PendType.Package:
			if (m_manager.assetPendDict != null)
			{
				AddResourceToDownloadQueue();
				AddVoiceToDownloadQueue();
			}
			break;
		case PendType.SingleAsset:
			AddSingleAssetToDownloadQueue();
			break;
		case PendType.SingleVoice:
			AddSingleVoiceToDownloadQueue();
			break;
		}
		m_state = AssetPendDownLoadState.None;
		destroyed = false;
	}

	public bool GetToDestroy()
	{
		return destroyed;
	}

	private void AddResourceToDownloadQueue()
	{
		m_totalSize = 0uL;
		m_currentSize = 0uL;
		if (!m_manager.assetPendDict.pendDict.ContainsKey(m_key))
		{
			return;
		}
		List<string> list = m_manager.assetPendDict.pendDict[m_key];
		for (int i = 0; i < list.Count; i++)
		{
			AssetManager.TryGetBundleFileName(list[i], out var fileName);
			if (string.IsNullOrEmpty(fileName))
			{
				continue;
			}
			string text = Platform.GetDownloadPersistentDataPath() + fileName;
			string url = GameToSDK.vClientResVersionInfo.MainDownloadUrl() + Path.GetFileName(fileName);
			AssetManager.GetAssetHashManifest().TryGetFileInfoByHash(Path.GetFileNameWithoutExtension(fileName), out var fileInfo);
			if (File.Exists(text) && fileInfo.mFileSize == new FileInfo(text).Length)
			{
				m_currentSize += (ulong)fileInfo.mFileSize;
				m_totalSize += (ulong)fileInfo.mFileSize;
				continue;
			}
			m_totalSize += (ulong)fileInfo.mFileSize;
			if (File.Exists(text))
			{
				File.Delete(text);
			}
			string directoryName = Path.GetDirectoryName(text);
			if (!Directory.Exists(directoryName))
			{
				Directory.CreateDirectory(directoryName);
			}
			if (!m_pendingDownloadDict.ContainsKey(text))
			{
				AssetDownloadInfo assetDownloadInfo = new AssetDownloadInfo();
				assetDownloadInfo.url = url;
				assetDownloadInfo.path = text;
				assetDownloadInfo.size = (ulong)fileInfo.mFileSize;
				assetDownloadInfo.fileName = fileName;
				assetDownloadInfo.sdkPath = fileName;
				m_pendingDownloadDict.Add(text, assetDownloadInfo);
			}
		}
	}

	private void AddSingleAssetToDownloadQueue()
	{
		string fileName = m_key;
		AssetManager.TryGetBundleFileName(m_key, out fileName);
		if (string.IsNullOrEmpty(fileName))
		{
			return;
		}
		string text = Platform.GetDownloadPersistentDataPath() + fileName;
		string url = GameToSDK.vClientResVersionInfo.MainDownloadUrl() + Path.GetFileName(fileName);
		AssetManager.GetAssetHashManifest().TryGetFileInfoByHash(Path.GetFileNameWithoutExtension(fileName), out var fileInfo);
		if (!File.Exists(text) || fileInfo.mFileSize != new FileInfo(text).Length)
		{
			if (File.Exists(text))
			{
				File.Delete(text);
			}
			string directoryName = Path.GetDirectoryName(text);
			if (!Directory.Exists(directoryName))
			{
				Directory.CreateDirectory(directoryName);
			}
			if (!m_pendingDownloadDict.ContainsKey(text))
			{
				AssetDownloadInfo assetDownloadInfo = new AssetDownloadInfo();
				assetDownloadInfo.url = url;
				assetDownloadInfo.path = text;
				assetDownloadInfo.size = (ulong)fileInfo.mFileSize;
				assetDownloadInfo.fileName = fileName;
				assetDownloadInfo.sdkPath = fileName;
				m_pendingDownloadDict.Add(text, assetDownloadInfo);
			}
		}
	}

	private void AddVoiceToDownloadQueue()
	{
		if (!m_manager.assetPendDict.voiceDict.ContainsKey(m_key) || CriWareExtension.m_voiceAssetHasnManifest == null)
		{
			return;
		}
		List<string> list = m_manager.assetPendDict.voiceDict[m_key];
		for (int i = 0; i < list.Count; i++)
		{
			string key = list[i];
			foreach (string item in VoicePackageManager.Instance.GetDownLoadPackage())
			{
				if (!CriWareExtension.m_voiceAssetHasnManifest.TryGetValue(item, out var value) || !value.mBundleName2FileInfo.TryGetValue(key, out var value2))
				{
					continue;
				}
				string mFilePath = value2.mFilePath;
				string text = CriWareExtension.GetDownloadPersistentDataPath() + item + "/" + mFilePath;
				string url = GameToSDK.vClientResVersionInfo.MainDownloadUrl() + Path.GetFileName(mFilePath);
				if (File.Exists(text) && value2.mFileSize == new FileInfo(text).Length)
				{
					m_currentSize += (ulong)value2.mFileSize;
					m_totalSize += (ulong)value2.mFileSize;
					continue;
				}
				m_totalSize += (ulong)value2.mFileSize;
				if (File.Exists(text))
				{
					File.Delete(text);
				}
				string directoryName = Path.GetDirectoryName(text);
				if (!Directory.Exists(directoryName))
				{
					Directory.CreateDirectory(directoryName);
				}
				if (!m_pendingDownloadDict.ContainsKey(text))
				{
					AssetDownloadInfo assetDownloadInfo = new AssetDownloadInfo();
					assetDownloadInfo.url = url;
					assetDownloadInfo.path = text;
					assetDownloadInfo.size = (ulong)value2.mFileSize;
					assetDownloadInfo.fileName = mFilePath;
					assetDownloadInfo.sdkPath = "../Voice/" + item + "/" + mFilePath;
					m_pendingDownloadDict.Add(text, assetDownloadInfo);
				}
			}
		}
	}

	private void AddSingleVoiceToDownloadQueue()
	{
		string key = m_key;
		foreach (string item in VoicePackageManager.Instance.GetDownLoadPackage())
		{
			if (!CriWareExtension.m_voiceAssetHasnManifest.TryGetValue(item, out var value) || !value.mBundleName2FileInfo.TryGetValue(key, out var value2))
			{
				continue;
			}
			string mFilePath = value2.mFilePath;
			string text = CriWareExtension.GetDownloadPersistentDataPath() + item + "/" + mFilePath;
			string url = GameToSDK.vClientResVersionInfo.MainDownloadUrl() + Path.GetFileName(mFilePath);
			if (File.Exists(text) && value2.mFileSize == new FileInfo(text).Length)
			{
				m_currentSize += (ulong)value2.mFileSize;
				m_totalSize += (ulong)value2.mFileSize;
				continue;
			}
			m_totalSize += (ulong)value2.mFileSize;
			if (File.Exists(text))
			{
				File.Delete(text);
			}
			string directoryName = Path.GetDirectoryName(text);
			if (!Directory.Exists(directoryName))
			{
				Directory.CreateDirectory(directoryName);
			}
			if (!m_pendingDownloadDict.ContainsKey(text))
			{
				AssetDownloadInfo assetDownloadInfo = new AssetDownloadInfo();
				assetDownloadInfo.url = url;
				assetDownloadInfo.path = text;
				assetDownloadInfo.size = (ulong)value2.mFileSize;
				assetDownloadInfo.fileName = mFilePath;
				assetDownloadInfo.sdkPath = "../Voice/" + item + "/" + mFilePath;
				m_pendingDownloadDict.Add(text, assetDownloadInfo);
			}
		}
	}

	public bool Start()
	{
		if (m_pendingDownloadDict.Count == 0)
		{
			OnSuccessed();
			return false;
		}
		m_state = AssetPendDownLoadState.Process;
		StartDownload();
		return true;
	}

	public string GetKey()
	{
		return m_key;
	}

	protected abstract void StartDownload();

	public abstract void Pause();

	public abstract void Cancel();

	public abstract void OnDestroy();

	public abstract void OnUpdate();

	protected void OnSuccessed()
	{
		Debug.Log("AssetPendDownLoadManager OnSuccessed " + m_key + " .");
		m_state = AssetPendDownLoadState.Success;
		onSucessed?.Invoke();
		destroyed = true;
	}

	protected void OnFailed(string error)
	{
		Debug.Log("AssetPendDownLoadManager OnFailed " + m_key + " . by error reson : " + error + ".");
		m_state = AssetPendDownLoadState.Fail;
		onFailed?.Invoke();
		destroyed = true;
	}

	protected void OnPause()
	{
		Debug.Log("AssetPendDownLoadManager OnPause " + m_key);
		m_state = AssetPendDownLoadState.Fail;
		onPause?.Invoke();
		destroyed = true;
	}

	protected void OnProcess(float process)
	{
	}

	public virtual float GetProcess()
	{
		if (m_totalSize == 0L)
		{
			return 0f;
		}
		return (float)m_currentSize / (float)m_totalSize;
	}

	public virtual string GetSpeed()
	{
		return "";
	}

	public virtual string GetProcessStr()
	{
		float num = ((m_totalSize > 1048576) ? AssetPendDownLoadManager.ConvertSize(m_totalSize, "MB") : AssetPendDownLoadManager.ConvertSize(m_totalSize, "KB"));
		string text = ((m_totalSize > 1048576) ? "MB" : "KB");
		float num2 = ((m_currentSize > 1048576) ? AssetPendDownLoadManager.ConvertSize(m_currentSize, "MB") : AssetPendDownLoadManager.ConvertSize(m_currentSize, "KB"));
		string text2 = ((m_currentSize > 1048576) ? "MB" : "KB");
		return $"{num2:F2}{text2}/{num:F2}{text}";
	}
}
