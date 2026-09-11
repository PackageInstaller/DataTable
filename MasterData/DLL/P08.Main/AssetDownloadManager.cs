using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using YSDownloadCore;

public class AssetDownloadManager : MonoBehaviour
{
	private const int MAX_TRY_TIMES = 5;

	public bool configLoaded;

	private ulong m_totalSize;

	private ulong m_currentSize;

	private Dictionary<string, DownloadRequest> m_processingRequest = new Dictionary<string, DownloadRequest>();

	private Action<float> onProgressUpdate;

	private Action onSucessed;

	private Action onFailed;

	private Dictionary<string, AssetDownloadInfo> m_pendingDownloadDict = new Dictionary<string, AssetDownloadInfo>();

	private ESDKDownloadedResult m_sdk_download_result;

	public static AssetDownloadManager Instance { get; private set; }

	public static void Create()
	{
		if (!UnityEngine.Object.FindObjectOfType(typeof(AssetDownloadManager)))
		{
			GameObject obj = new GameObject("AssetDownloadManager", typeof(AssetDownloadManager));
			UnityEngine.Object.DontDestroyOnLoad(obj);
			Instance = obj.GetComponent<AssetDownloadManager>();
			Instance.InitRootUrl();
		}
	}

	public static void Destroy()
	{
		if (!(Instance == null))
		{
			Instance.StopAll();
			UnityEngine.Object.DestroyImmediate(Instance.gameObject);
			Instance = null;
		}
	}

	private void Update()
	{
		if (GameMain.isUseNewHotFix)
		{
			if (m_sdk_download_result == ESDKDownloadedResult.Failed)
			{
				onFailed?.Invoke();
			}
			else if (m_sdk_download_result == ESDKDownloadedResult.Successed)
			{
				onSucessed?.Invoke();
			}
		}
	}

	public void InitRootUrl()
	{
		configLoaded = true;
		m_processingRequest.Clear();
		m_pendingDownloadDict.Clear();
	}

	public void StopAll()
	{
		foreach (KeyValuePair<string, DownloadRequest> item in m_processingRequest)
		{
			item.Value.Pure();
		}
		m_processingRequest.Clear();
		m_pendingDownloadDict.Clear();
		if (GameMain.isUseNewHotFix)
		{
			YsDownloadEvent instance = YsDownloadEvent.Instance;
			instance.ProgressEvent = (YsDownloadEvent.ProgressDelegate)Delegate.Combine(instance.ProgressEvent, new YsDownloadEvent.ProgressDelegate(OnSDKDownLoadProgressUpdate));
			YsDownloadEvent instance2 = YsDownloadEvent.Instance;
			instance2.SingleTaskEvent = (YsDownloadEvent.SingleTaskDelegate)Delegate.Combine(instance2.SingleTaskEvent, new YsDownloadEvent.SingleTaskDelegate(OnSDKDownLoadSingleComplete));
			YsDownloadEvent instance3 = YsDownloadEvent.Instance;
			instance3.AllTaskEvent = (YsDownloadEvent.AllTaskDelegate)Delegate.Combine(instance3.AllTaskEvent, new YsDownloadEvent.AllTaskDelegate(OnSDKDownLoadAllTaskComplete));
			YsDownloadSDK.Instance.onDestroy();
		}
	}

	public static bool CheckResourcesNeedDownload(string[] paths)
	{
		bool result = false;
		if (paths == null || paths.Length < 0)
		{
			return result;
		}
		for (int i = 0; i < paths.Length; i++)
		{
			string resourceHashFileName = GetResourceHashFileName(Asset.RemapVariantPath(paths[i]));
			if (!string.IsNullOrEmpty(resourceHashFileName) && !File.Exists(Platform.GetDownloadPersistentDataPath() + resourceHashFileName) && !File.Exists(Platform.GetDownloadPath() + resourceHashFileName))
			{
				result = true;
			}
		}
		return result;
	}

	public static bool CheckVoiceNeedDownload(string[] paths)
	{
		bool result = false;
		if (paths == null || paths.Length < 0)
		{
			return result;
		}
		string localizationFlag = CriWareExtension.localizationFlag;
		try
		{
			foreach (string item in VoicePackageManager.Instance.GetDownLoadPackage())
			{
				CriWareExtension.localizationFlag = item;
				for (int i = 0; i < paths.Length; i++)
				{
					bool voiceHashFileName = GetVoiceHashFileName(paths[i], out var filePath);
					if (!string.IsNullOrEmpty(filePath) && !voiceHashFileName)
					{
						result = true;
					}
				}
			}
			return result;
		}
		finally
		{
			CriWareExtension.localizationFlag = localizationFlag;
		}
	}

	public void AddResourceToDownloadQueue(string[] paths)
	{
		if (paths == null || paths.Length < 0)
		{
			return;
		}
		for (int i = 0; i < paths.Length; i++)
		{
			string resourceHashFileName = GetResourceHashFileName(Asset.RemapVariantPath(paths[i]));
			if (string.IsNullOrEmpty(resourceHashFileName))
			{
				continue;
			}
			string text = Platform.GetDownloadPersistentDataPath() + resourceHashFileName;
			string url = GameToSDK.vClientResVersionInfo.MainDownloadUrl() + Path.GetFileName(resourceHashFileName);
			AssetManager.GetAssetHashManifest().TryGetFileInfoByHash(Path.GetFileNameWithoutExtension(resourceHashFileName), out var fileInfo);
			if (!File.Exists(text) || fileInfo.mFileSize != new FileInfo(text).Length)
			{
				if (File.Exists(text))
				{
					File.Delete(text);
				}
				if (!m_pendingDownloadDict.ContainsKey(text))
				{
					AssetDownloadInfo assetDownloadInfo = new AssetDownloadInfo();
					assetDownloadInfo.url = url;
					assetDownloadInfo.path = text;
					assetDownloadInfo.size = (ulong)fileInfo.mFileSize;
					assetDownloadInfo.fileName = resourceHashFileName;
					assetDownloadInfo.isVoice = false;
					m_pendingDownloadDict.Add(text, assetDownloadInfo);
				}
			}
		}
	}

	public void AddVoiceToDownloadQueue(string[] paths)
	{
		if (paths == null || paths.Length < 0)
		{
			return;
		}
		AssetHashManifest assetHashManifest = CriWareExtension.GetAssetHashManifest();
		if (assetHashManifest == null)
		{
			return;
		}
		string localizationFlag = CriWareExtension.localizationFlag;
		try
		{
			foreach (string item in VoicePackageManager.Instance.GetDownLoadPackage())
			{
				CriWareExtension.localizationFlag = item;
				assetHashManifest = CriWareExtension.GetAssetHashManifest();
				for (int i = 0; i < paths.Length; i++)
				{
					bool voiceHashFileName = GetVoiceHashFileName(paths[i], out var filePath);
					if (string.IsNullOrEmpty(filePath))
					{
						continue;
					}
					string text = CriWareExtension.GetDownloadPersistentDataPath() + CriWareExtension.localizationFlag + "/" + filePath;
					string url = GameToSDK.vClientResVersionInfo.MainDownloadUrl() + Path.GetFileName(filePath);
					bool flag = assetHashManifest.TryGetFileInfoByHash(Path.GetFileNameWithoutExtension(filePath), out var fileInfo);
					if (!flag)
					{
						flag = AssetManager.GetAssetHashManifest().TryGetFileInfoByHash(Path.GetFileNameWithoutExtension(filePath), out fileInfo);
					}
					if (voiceHashFileName)
					{
						continue;
					}
					if (!flag)
					{
						Debug.LogWarning(filePath + " 不在hash表中, 无法获取文件大小, 跳过");
					}
					else if (!File.Exists(text) || fileInfo.mFileSize != new FileInfo(text).Length)
					{
						if (File.Exists(text))
						{
							File.Delete(text);
						}
						if (!m_pendingDownloadDict.ContainsKey(text))
						{
							AssetDownloadInfo assetDownloadInfo = new AssetDownloadInfo();
							assetDownloadInfo.url = url;
							assetDownloadInfo.path = text;
							assetDownloadInfo.size = (ulong)fileInfo.mFileSize;
							assetDownloadInfo.fileName = filePath;
							assetDownloadInfo.isVoice = true;
							m_pendingDownloadDict.Add(text, assetDownloadInfo);
						}
					}
				}
			}
		}
		finally
		{
			CriWareExtension.localizationFlag = localizationFlag;
		}
	}

	private void OnSDKDownLoadProgressUpdate(long currentOffset, int totalCount, int completedCount, int failedCount, string downloadSpeedStr)
	{
	}

	private void OnSDKDownLoadSingleComplete(int result, string filePath, long size, string urlFileName, string msg)
	{
		if (result == 0 && string.IsNullOrEmpty(msg))
		{
			m_processingRequest.Remove(urlFileName);
			m_currentSize += (ulong)size;
		}
	}

	private void OnSDKDownLoadAllTaskComplete(int result, string msg)
	{
		if (result == 0)
		{
			m_sdk_download_result = ESDKDownloadedResult.Successed;
			return;
		}
		if (!string.IsNullOrEmpty(msg) && GameMain.IsDiskFull(msg))
		{
			Debug.LogError("====>>>> 热更下载资源,磁盘空间已满");
			string errorInfo = GameMain.ConvertErrorInfo(msg);
			if (!MessageBox.CanCallShow())
			{
				return;
			}
			UnityMainThreadDispatcher.Instance.Enqueue(delegate
			{
				MessageBox.Show("MESSAGE_BOX_TITLE_ERROR".GetGameMainTextString(), errorInfo, delegate
				{
					Debug.LogError("OnSDKDownLoadAllTaskComplete 下载失败");
					m_sdk_download_result = ESDKDownloadedResult.Failed;
				});
			});
			return;
		}
		if (!string.IsNullOrEmpty(msg) && msg == "cancel")
		{
			m_sdk_download_result = ESDKDownloadedResult.Failed;
			return;
		}
		string gameMainTextString = "CHEACK_LOCAL_NETWORK_STATUS_TITLE".GetGameMainTextString();
		if (MessageBox.CanCallShow())
		{
			MessageBox.Show("MESSAGE_BOX_TITLE_ERROR".GetGameMainTextString(), gameMainTextString, delegate
			{
				m_sdk_download_result = ESDKDownloadedResult.Failed;
			});
		}
		else
		{
			m_sdk_download_result = ESDKDownloadedResult.Failed;
		}
	}

	public void Run(Action<float> onProgressUpdate, Action onSuccessed, Action onFailed)
	{
		if (m_pendingDownloadDict.Count <= 0)
		{
			onSuccessed?.Invoke();
			return;
		}
		m_currentSize = 0uL;
		m_totalSize = 0uL;
		this.onProgressUpdate = onProgressUpdate;
		onSucessed = onSuccessed;
		this.onFailed = onFailed;
		m_sdk_download_result = ESDKDownloadedResult.None;
		List<string> list = new List<string>();
		foreach (KeyValuePair<string, AssetDownloadInfo> item in m_pendingDownloadDict)
		{
			AssetDownloadInfo value = item.Value;
			if (!m_processingRequest.ContainsKey(value.path))
			{
				m_totalSize += value.size;
				if (GameMain.isUseNewHotFix)
				{
					string relativePath = Path.GetRelativePath(Platform.GetDownloadPersistentDataPath(), value.path);
					string arg = (value.isVoice ? relativePath : value.fileName);
					list.Add($"{arg},{value.size},{Path.GetFileName(value.fileName)}");
				}
				else
				{
					DownloadRequest value2 = Asset.StartDownloadWitchCache(value.url, value.path, OnDownloadCallback);
					m_processingRequest[value.path] = value2;
				}
			}
		}
		if (GameMain.isUseNewHotFix)
		{
			YsDownloadEvent instance = YsDownloadEvent.Instance;
			instance.ProgressEvent = (YsDownloadEvent.ProgressDelegate)Delegate.Combine(instance.ProgressEvent, new YsDownloadEvent.ProgressDelegate(OnSDKDownLoadProgressUpdate));
			YsDownloadEvent instance2 = YsDownloadEvent.Instance;
			instance2.SingleTaskEvent = (YsDownloadEvent.SingleTaskDelegate)Delegate.Combine(instance2.SingleTaskEvent, new YsDownloadEvent.SingleTaskDelegate(OnSDKDownLoadSingleComplete));
			YsDownloadEvent instance3 = YsDownloadEvent.Instance;
			instance3.AllTaskEvent = (YsDownloadEvent.AllTaskDelegate)Delegate.Combine(instance3.AllTaskEvent, new YsDownloadEvent.AllTaskDelegate(OnSDKDownLoadAllTaskComplete));
			YsDownloadSDK.Instance.SetSpeedMode(isLong: true);
			YsDownloadSDK.Instance.Download(GameToSDK.vClientResVersionInfo.MainDownloadUrl(), Platform.GetDownloadPersistentDataPath(), list.ToArray());
		}
	}

	private void OnDownloadCallback(DownloadRequest www)
	{
		string text = (string)www.userData;
		if (!m_processingRequest.ContainsKey(text))
		{
			return;
		}
		if (www.isDone && string.IsNullOrEmpty(www.GetError()))
		{
			if (File.Exists(text))
			{
				m_currentSize += (ulong)new FileInfo(text).Length;
				onProgressUpdate?.Invoke((float)m_currentSize / (float)m_totalSize);
			}
			www.Dispose();
			m_processingRequest.Remove(text);
			if (m_processingRequest.Count == 0)
			{
				onSucessed?.Invoke();
			}
		}
		else if (!string.IsNullOrEmpty(www.GetError()) && GameMain.IsDiskFull(www.GetError()))
		{
			Debug.LogError("====>>>> 磁盘空间已满");
			string content = GameMain.ConvertErrorInfo(www.GetError());
			www.Dispose();
			if (MessageBox.CanCallShow())
			{
				MessageBox.Show("MESSAGE_BOX_TITLE_ERROR".GetGameMainTextString(), content, delegate
				{
					onFailed?.Invoke();
				});
			}
		}
		else if (www.retryUrlIndex > 5)
		{
			www.Dispose();
			string gameMainTextString = "CHEACK_LOCAL_NETWORK_STATUS_TITLE".GetGameMainTextString();
			if (MessageBox.CanCallShow())
			{
				MessageBox.Show("MESSAGE_BOX_TITLE_ERROR".GetGameMainTextString(), gameMainTextString, delegate
				{
					onFailed?.Invoke();
				});
			}
		}
		else
		{
			string[] array = GameToSDK.vClientResVersionInfo.AllDownloadUrls();
			string newUrl = array[++www.retryUrlIndex % array.Length] + Path.GetFileName(m_pendingDownloadDict[text].fileName);
			DownloadManager.Instance.TryFixFailedRequest(www, newUrl);
		}
	}

	private static string GetResourceHashFileName(string path)
	{
		string assetName = string.Empty;
		string assetBundleName = string.Empty;
		string fileName = string.Empty;
		if (path.EndsWith(".awb") || path.EndsWith(".acb") || path.EndsWith(".usm"))
		{
			AssetManager.TryGetBundleFileName(path, out fileName);
			return fileName;
		}
		AssetManager.TryGetAssetNameAndBundleName(path, out assetName, out assetBundleName);
		if (string.IsNullOrEmpty(assetBundleName))
		{
			return string.Empty;
		}
		AssetManager.TryGetBundleFileName(assetBundleName, out fileName);
		return fileName;
	}

	private static bool GetVoiceHashFileName(string path, out string filePath)
	{
		if (string.IsNullOrEmpty(path))
		{
			filePath = string.Empty;
			return false;
		}
		bool result = CriWareExtension.TryGetFilePath(path, out filePath);
		if (!CriWareExtension.TryGetBundleFileName(path, out filePath) && !AssetManager.TryGetBundleFileName(path, out filePath))
		{
			filePath = string.Empty;
		}
		return result;
	}
}
