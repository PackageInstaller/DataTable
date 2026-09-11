using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using LuaInterface;
using UnityEngine;
using YSDownloadCore;

public class AssetPendDownLoadManager : MonoBehaviour
{
	private static List<Pend> m_pendDownLoadQueue = new List<Pend>();

	private static AssetPendDownLoadManager m_instance;

	public AssetPendDownLoadOption cur_option;

	private List<string> assetPendList;

	public List<string> downloaded_keys = new List<string>();

	private Dictionary<string, int> sizeDict = new Dictionary<string, int>();

	private Dictionary<string, ulong> key_size_Dict = new Dictionary<string, ulong>();

	public const int KB_QUANTITY = 1024;

	public const int MB_QUANTITY = 1048576;

	public const int GB_QUANTITY = 1073741824;

	private bool _voiceHashCopyed;

	private MethodInfo _GetDiskFreeSpaceEx;

	public static AssetPendDownLoadManager instance
	{
		get
		{
			if (m_instance == null)
			{
				GameObject obj = new GameObject("AssetPendDownLoadManager");
				m_instance = obj.AddComponent<AssetPendDownLoadManager>();
				UnityEngine.Object.DontDestroyOnLoad(obj);
				m_instance.Init();
			}
			return m_instance;
		}
	}

	public AssetPendDict assetPendDict { get; private set; }

	public bool disable
	{
		get
		{
			if (assetPendDict != null)
			{
				return assetPendDict.disable;
			}
			return true;
		}
	}

	protected void Init()
	{
		assetPendDict = GameMain.mServerAssetPendDict;
		if (GameMain.isUseNewHotFix)
		{
			YsDownloadSDK.Instance.SetSpeedMode(isLong: true);
		}
		InitAssetPendSize();
		key_size_Dict = new Dictionary<string, ulong>();
		string assetPendPath = GetAssetPendPath();
		if (File.Exists(assetPendPath))
		{
			try
			{
				using TextReader textReader = new StreamReader(assetPendPath);
				string[] arry = textReader.ReadToEnd().Split(',');
				downloaded_keys = arry.toList<string>();
				textReader.Close();
				return;
			}
			catch (Exception ex)
			{
				downloaded_keys = new List<string>();
				Debug.LogError("GenerateAssetPendPathList Cannot read " + assetPendPath + ": " + ex.Message);
				return;
			}
		}
		downloaded_keys = new List<string>();
	}

	private void Save2File(string name, PendType pType)
	{
		switch (pType)
		{
		case PendType.Package:
			SaveKey(name);
			break;
		case PendType.SingleAsset:
			SaveSingleAssetName(name);
			break;
		case PendType.SingleVoice:
			SaveSingleVoiceName(name);
			break;
		default:
			Debug.LogError("未知的类型");
			break;
		}
	}

	public void SaveKey(string key)
	{
		if (downloaded_keys.Contains(key))
		{
			return;
		}
		downloaded_keys.Add(key);
		string assetPendPath = GetAssetPendPath();
		using TextWriter textWriter = new StreamWriter(assetPendPath, append: false);
		if (textWriter == null)
		{
			Debug.LogError("Cannot write to " + assetPendPath);
			return;
		}
		textWriter.Write(string.Join(",", downloaded_keys), true);
		textWriter.Flush();
		textWriter.Close();
	}

	public void ResavaKeys()
	{
		string assetPendPath = GetAssetPendPath();
		using TextWriter textWriter = new StreamWriter(assetPendPath, append: false);
		if (textWriter == null)
		{
			Debug.LogError("Cannot write to " + assetPendPath);
			return;
		}
		textWriter.Write(string.Join(",", downloaded_keys), true);
		textWriter.Flush();
		textWriter.Close();
	}

	public void SaveSingleAssetName(string name)
	{
		string singleAssetPath = GetSingleAssetPath();
		using TextWriter textWriter = new StreamWriter(singleAssetPath, append: true);
		if (textWriter == null)
		{
			Debug.LogError("Cannot write to " + singleAssetPath);
			return;
		}
		textWriter.WriteLine(name);
		textWriter.Flush();
		textWriter.Close();
	}

	public void SaveSingleVoiceName(string name)
	{
		string singleVoicePath = GetSingleVoicePath();
		using TextWriter textWriter = new StreamWriter(singleVoicePath, append: true);
		if (textWriter == null)
		{
			Debug.LogError("Cannot write to " + singleVoicePath);
			return;
		}
		textWriter.WriteLine(name);
		textWriter.Flush();
		textWriter.Close();
	}

	public void SaveDownloadingPendFile()
	{
		List<string> list = new List<string>();
		foreach (Pend item in m_pendDownLoadQueue)
		{
			if (item.type == PendType.Package)
			{
				list.Add(item.name);
			}
		}
		string downloadingPendPath = GetDownloadingPendPath();
		using TextWriter textWriter = new StreamWriter(downloadingPendPath, append: false);
		if (textWriter == null)
		{
			Debug.LogError("Cannot write to " + downloadingPendPath);
			return;
		}
		textWriter.Write(string.Join(",", list), true);
		textWriter.Flush();
		textWriter.Close();
	}

	public bool CheckAssetPendDownloaded(PendType pType, string key)
	{
		if (downloaded_keys.Contains(key))
		{
			return true;
		}
		if (assetPendDict != null)
		{
			switch (pType)
			{
			case PendType.Package:
				if (IsPermanentAssetPend(key))
				{
					return true;
				}
				if (assetPendDict.pendDict.ContainsKey(key) || assetPendDict.voiceDict.ContainsKey(key))
				{
					return false;
				}
				break;
			case PendType.SingleAsset:
			{
				string item = Asset.RemapVariantPath(key);
				return !assetPendDict.assetList.Contains(item);
			}
			case PendType.SingleVoice:
				return !assetPendDict.voiceList.Contains(key);
			}
		}
		return true;
	}

	public bool IsDownloadingQueue(string key)
	{
		return m_pendDownLoadQueue.Exists((Pend t) => t.name == key);
	}

	public bool IsPermanentAssetPend(string key)
	{
		return assetPendDict.permanentList.Contains(key);
	}

	public bool IsDownloading()
	{
		return m_pendDownLoadQueue.Count > 0;
	}

	public List<string> GetAssetPendList()
	{
		if (assetPendList != null)
		{
			return assetPendList;
		}
		if (assetPendDict == null)
		{
			assetPendList = new List<string>();
			return assetPendList;
		}
		List<string> list = new List<string>();
		foreach (string key in assetPendDict.pendDict.Keys)
		{
			if (!list.Contains(key))
			{
				list.Add(key);
			}
		}
		foreach (string key2 in assetPendDict.voiceDict.Keys)
		{
			if (!list.Contains(key2))
			{
				list.Add(key2);
			}
		}
		assetPendList = list;
		return assetPendList;
	}

	public List<string> GetDownloadingPendList()
	{
		List<string> list = new List<string>();
		string downloadingPendPath = GetDownloadingPendPath();
		try
		{
			if (!File.Exists(downloadingPendPath))
			{
				return list;
			}
			using TextReader textReader = new StreamReader(downloadingPendPath);
			string[] array = textReader.ReadToEnd().Split(',');
			foreach (string item in array)
			{
				list.Add(item);
			}
		}
		catch (Exception ex)
		{
			Debug.LogError("GenerateAssetPendPathList Cannot read " + downloadingPendPath + ": " + ex.Message);
		}
		return list;
	}

	public List<string> GetRemoveAssetList(object[] keyArray)
	{
		List<string> list = new List<string>();
		for (int i = 0; i < downloaded_keys.Count; i++)
		{
			string text = downloaded_keys[i];
			if (keyArray.Contains(text) || !assetPendDict.pendDict.ContainsKey(text))
			{
				continue;
			}
			foreach (string item in assetPendDict.pendDict[text])
			{
				list.Add(item);
			}
		}
		for (int j = 0; j < m_pendDownLoadQueue.Count; j++)
		{
			string text2 = m_pendDownLoadQueue[j].name;
			if (keyArray.Contains(text2) || !assetPendDict.pendDict.ContainsKey(text2))
			{
				continue;
			}
			foreach (string item2 in assetPendDict.pendDict[text2])
			{
				list.Add(item2);
			}
		}
		return list.Union(GetDownloadSingleAsset()).ToList();
	}

	public List<string> GetDownloadSingleAsset()
	{
		List<string> list = new List<string>();
		string singleAssetPath = GetSingleAssetPath();
		if (File.Exists(singleAssetPath))
		{
			try
			{
				using StreamReader streamReader = new StreamReader(singleAssetPath);
				string value;
				while ((value = streamReader.ReadLine()) != null)
				{
					string item = (string)Convert.ChangeType(value, typeof(string));
					list.Add(item);
				}
			}
			catch (Exception ex)
			{
				Console.WriteLine("读取文件时出错: " + ex.Message);
			}
		}
		return list;
	}

	public List<string> GetRemoveVoiceList(object[] keyArray)
	{
		List<string> list = new List<string>();
		for (int i = 0; i < downloaded_keys.Count; i++)
		{
			string text = downloaded_keys[i];
			if (keyArray.Contains(text) || !assetPendDict.voiceDict.ContainsKey(text))
			{
				continue;
			}
			foreach (string item in assetPendDict.voiceDict[text])
			{
				list.Add(item);
			}
		}
		for (int j = 0; j < m_pendDownLoadQueue.Count; j++)
		{
			string text2 = m_pendDownLoadQueue[j].name;
			if (keyArray.Contains(text2) || !assetPendDict.voiceDict.ContainsKey(text2))
			{
				continue;
			}
			foreach (string item2 in assetPendDict.voiceDict[text2])
			{
				list.Add(item2);
			}
		}
		return list.Union(GetDownloadSingleVoice()).ToList();
	}

	public List<string> GetDownloadSingleVoice()
	{
		List<string> list = new List<string>();
		string singleVoicePath = GetSingleVoicePath();
		if (File.Exists(singleVoicePath))
		{
			try
			{
				using StreamReader streamReader = new StreamReader(singleVoicePath);
				string value;
				while ((value = streamReader.ReadLine()) != null)
				{
					string item = (string)Convert.ChangeType(value, typeof(string));
					list.Add(item);
				}
			}
			catch (Exception ex)
			{
				Console.WriteLine("读取文件时出错: " + ex.Message);
			}
		}
		return list;
	}

	public void ContinueDownLoadPackage()
	{
		List<string> downloadingPendList = GetDownloadingPendList();
		if (downloadingPendList.Count <= 0)
		{
			return;
		}
		foreach (string key in downloadingPendList)
		{
			Action successAction = delegate
			{
				Save2File(key, PendType.Package);
				m_pendDownLoadQueue.RemoveAt(0);
				SaveDownloadingPendFile();
			};
			Action failAction = delegate
			{
				m_pendDownLoadQueue.RemoveAt(0);
				SaveDownloadingPendFile();
			};
			m_pendDownLoadQueue.Insert(0, new Pend
			{
				type = PendType.Package,
				name = key,
				successAction = successAction,
				failAction = failAction
			});
		}
		Pend pend = m_pendDownLoadQueue[0];
		StartAssetPendDownload(pend.type, pend.name, pend.successAction, pend.failAction, pend.pauseAction);
	}

	public void AddPendList(object[] keyArray, Action<string> onSuccessed, Action<string> onFailed, Action<string> onPause)
	{
		List<Pend> pendList = new List<Pend>();
		for (int i = 0; i < keyArray.Length; i++)
		{
			string key = (string)keyArray[i];
			Action successAction = delegate
			{
				Save2File(key, PendType.Package);
				m_pendDownLoadQueue.RemoveAll((Pend t) => t.name == key);
				SaveDownloadingPendFile();
				onSuccessed(key);
			};
			Action failAction = delegate
			{
				if (IsAllAssetDownloaded(key))
				{
					Debug.Log("下载失败但检测到下载完成: " + key);
					Save2File(key, PendType.Package);
				}
				m_pendDownLoadQueue.RemoveAll((Pend t) => t.name == key);
				SaveDownloadingPendFile();
				onFailed(key);
			};
			Action pauseAction = delegate
			{
				SaveDownloadingPendFile();
				onPause(key);
			};
			Pend item = new Pend
			{
				type = PendType.Package,
				name = key,
				successAction = successAction,
				failAction = failAction,
				pauseAction = pauseAction
			};
			pendList.Add(item);
		}
		bool flag = false;
		if (m_pendDownLoadQueue.Count > 0)
		{
			if (pendList[0].name == m_pendDownLoadQueue[0].name)
			{
				int i2;
				for (i2 = 1; i2 < pendList.Count; i2++)
				{
					m_pendDownLoadQueue.RemoveAll((Pend t) => t.name == pendList[i2].name);
					m_pendDownLoadQueue.Insert(1, pendList[i2]);
				}
				SaveDownloadingPendFile();
				return;
			}
			flag = true;
		}
		for (int num = pendList.Count - 1; num >= 0; num--)
		{
			m_pendDownLoadQueue.Insert(0, pendList[num]);
		}
		SaveDownloadingPendFile();
		if (flag)
		{
			cur_option?.Pause();
			return;
		}
		Pend pend = m_pendDownLoadQueue[0];
		StartAssetPendDownload(pend.type, pend.name, pend.successAction, pend.failAction, pend.pauseAction);
	}

	public void AddPend(PendType pType, string key, Action<string> onSuccessed, Action<string> onFailed, Action<string> onPause)
	{
		string remapKey = ((pType == PendType.SingleAsset) ? Asset.RemapVariantPath(key) : key);
		if (pType == PendType.SingleAsset)
		{
			if (AssetManager.TryGetAssetNameAndBundleName(remapKey, out var _, out var assetBundleName))
			{
				remapKey = assetBundleName;
			}
			else
			{
				Debug.LogError("无法获取" + remapKey + "的AB包名称!");
			}
		}
		m_pendDownLoadQueue.Exists((Pend t) => t.name == remapKey);
		m_pendDownLoadQueue.RemoveAll((Pend t) => t.name == remapKey);
		Action action = delegate
		{
			key_size_Dict.Clear();
			Save2File(remapKey, pType);
			m_pendDownLoadQueue.RemoveAll((Pend t) => t.name == remapKey);
			SaveDownloadingPendFile();
			onSuccessed(remapKey);
		};
		Action action2 = delegate
		{
			if (IsAllAssetDownloaded(key))
			{
				Debug.Log("下载失败但检测到下载完成: " + key);
				Save2File(key, PendType.Package);
			}
			m_pendDownLoadQueue.RemoveAll((Pend t) => t.name == remapKey);
			SaveDownloadingPendFile();
			onFailed(remapKey);
		};
		Action action3 = delegate
		{
			SaveDownloadingPendFile();
			onPause(remapKey);
		};
		m_pendDownLoadQueue.Insert(0, new Pend
		{
			type = pType,
			name = remapKey,
			successAction = action,
			failAction = action2,
			pauseAction = action3
		});
		SaveDownloadingPendFile();
		if (m_pendDownLoadQueue.Count > 1)
		{
			cur_option?.Pause();
		}
		if (cur_option == null)
		{
			StartAssetPendDownload(pType, remapKey, action, action2, action3);
		}
	}

	public bool StartAssetPendDownload(PendType pType, string key, Action onSuccessed, Action onFailed, Action onPause)
	{
		if (CheckAssetPendDownloaded(pType, key))
		{
			onSuccessed();
			return true;
		}
		if (cur_option != null)
		{
			Debug.Log("StartAssetPendDownload last not over");
			return false;
		}
		AssetPendDownLoadOption assetPendDownLoadOption = new AssetPendDownLoadPCSDKOption(pType, key, this);
		assetPendDownLoadOption.onSucessed = onSuccessed;
		assetPendDownLoadOption.onFailed = onFailed;
		assetPendDownLoadOption.onPause = onPause;
		if (assetPendDownLoadOption.Start())
		{
			cur_option = assetPendDownLoadOption;
		}
		return true;
	}

	public bool StopAssetPendDownload(string key)
	{
		m_pendDownLoadQueue.RemoveAll((Pend t) => t.name == key);
		SaveDownloadingPendFile();
		if (cur_option != null && cur_option.GetKey() == key)
		{
			cur_option.Pause();
		}
		return true;
	}

	public bool CancelAssetPendDownload(string key)
	{
		m_pendDownLoadQueue.RemoveAll((Pend t) => t.name == key);
		SaveDownloadingPendFile();
		if (cur_option != null && cur_option.GetKey() == key)
		{
			cur_option.Cancel();
		}
		return true;
	}

	public void StartNextAssetPendDownload()
	{
		if (m_pendDownLoadQueue.Count != 0)
		{
			Pend pend = m_pendDownLoadQueue[0];
			StartAssetPendDownload(pend.type, pend.name, pend.successAction, pend.failAction, pend.pauseAction);
		}
	}

	public string GetAssetPendPath()
	{
		return DownloadPackageMgr.Instance.GetAssetPendPath();
	}

	public string GetSingleAssetPath()
	{
		return DownloadPackageMgr.Instance.GetSingleAssetPath();
	}

	public string GetSingleVoicePath()
	{
		return DownloadPackageMgr.Instance.GetSingleVoicePath();
	}

	public string GetDownloadingPendPath()
	{
		return DownloadPackageMgr.Instance.GetDownloadingPendPath();
	}

	public string GetFormatSizeStr(ulong size)
	{
		string text = "KB";
		ulong num = size / 1024;
		if (num > 1000)
		{
			text = "MB";
			num /= 1024;
		}
		if (num > 1000)
		{
			text = "GB";
		}
		return $"{ConvertSize(size, text):F2}{text}";
	}

	public static float ConvertSize(float totalSize, string unit)
	{
		float num = totalSize;
		switch (unit)
		{
		case "KB":
			num /= 1024f;
			break;
		case "MB":
			num /= 1048576f;
			break;
		case "GB":
			num /= 1.0737418E+09f;
			break;
		}
		return num;
	}

	private void InitAssetPendSize()
	{
		sizeDict = new Dictionary<string, int>();
		if (assetPendDict == null)
		{
			return;
		}
		AssetHashManifest assetHashManifest = AssetManager.GetAssetHashManifest();
		if (assetHashManifest != null)
		{
			foreach (string item in assetPendDict.allPend)
			{
				if (assetHashManifest.mBundleName2FileInfo.TryGetValue(item, out var value))
				{
					_ = Platform.GetDownloadPersistentDataPath() + value.mFilePath;
					sizeDict.TryAdd(item, value.mFileSize);
				}
			}
		}
		if (CriWareExtension.m_voiceAssetHasnManifest == null)
		{
			return;
		}
		foreach (string item2 in assetPendDict.allVoice)
		{
			foreach (string item3 in VoicePackageManager.Instance.GetDownLoadPackage())
			{
				if (CriWareExtension.m_voiceAssetHasnManifest.TryGetValue(item3, out var value2) && value2.mBundleName2FileInfo.TryGetValue(item2, out var value3))
				{
					string mFilePath = value3.mFilePath;
					_ = CriWareExtension.GetDownloadPersistentDataPath() + item3 + "/" + mFilePath;
					if (sizeDict.ContainsKey(item2))
					{
						sizeDict[item2] += value3.mFileSize;
					}
					else
					{
						sizeDict.Add(item2, value3.mFileSize);
					}
				}
			}
		}
	}

	public void UpdateAssetPendSize()
	{
		InitAssetPendSize();
		key_size_Dict.Clear();
	}

	public string GetAssetPendSizeStr(string key)
	{
		return GetFormatSizeStr(GetAssetPendSize(key));
	}

	public ulong GetAssetPendSize(string key)
	{
		if (assetPendDict == null)
		{
			return 0uL;
		}
		if (key_size_Dict.ContainsKey(key))
		{
			return key_size_Dict[key];
		}
		ulong num = 0uL;
		if (assetPendDict.pendDict.ContainsKey(key))
		{
			foreach (string item in assetPendDict.pendDict[key])
			{
				if (sizeDict.TryGetValue(item, out var value))
				{
					num += (ulong)value;
				}
			}
		}
		if (assetPendDict.voiceDict.ContainsKey(key))
		{
			foreach (string item2 in assetPendDict.voiceDict[key])
			{
				if (sizeDict.TryGetValue(item2, out var value2))
				{
					num += (ulong)value2;
				}
			}
		}
		key_size_Dict.Add(key, num);
		return num;
	}

	public string GetAssetPendExistSizeStr(string key)
	{
		return GetFormatSizeStr(GetAssetPendExistSize(key));
	}

	public ulong GetAssetPendExistSize(string key)
	{
		if (assetPendDict == null)
		{
			return 0uL;
		}
		ulong num = 0uL;
		if (assetPendDict.pendDict.ContainsKey(key))
		{
			foreach (string item in assetPendDict.pendDict[key])
			{
				if (ExistAssetBundle(item) && sizeDict.TryGetValue(item, out var value))
				{
					num += (ulong)value;
				}
			}
		}
		if (assetPendDict.voiceDict.ContainsKey(key))
		{
			foreach (string item2 in assetPendDict.voiceDict[key])
			{
				foreach (string item3 in VoicePackageManager.Instance.GetDownLoadPackage())
				{
					if (CriWareExtension.m_voiceAssetHasnManifest.TryGetValue(item3, out var value2) && value2.mBundleName2FileInfo.TryGetValue(item2, out var value3))
					{
						string mFilePath = value3.mFilePath;
						string text = CriWareExtension.GetDownloadPersistentDataPath() + item3 + "/" + mFilePath;
						if (File.Exists(text) && value3.mFileSize == new FileInfo(text).Length)
						{
							num += (ulong)value3.mFileSize;
						}
					}
				}
			}
		}
		return num;
	}

	public string GetRemoveAssetPendListSize(object[] keyArray, float voiceSize)
	{
		ulong num = 0uL;
		List<string> removeAssetList = GetRemoveAssetList(keyArray);
		List<string> removeVoiceList = GetRemoveVoiceList(keyArray);
		List<string> list = new List<string>();
		List<string> list2 = new List<string>();
		for (int i = 0; i < keyArray.Length; i++)
		{
			string key = (string)keyArray[i];
			if (assetPendDict.pendDict.ContainsKey(key))
			{
				foreach (string item in assetPendDict.pendDict[key])
				{
					if (!list.Contains(item) && !removeAssetList.Contains(item) && sizeDict.TryGetValue(item, out var value))
					{
						num += (ulong)value;
						list.Add(item);
					}
				}
			}
			if (!assetPendDict.voiceDict.ContainsKey(key))
			{
				continue;
			}
			foreach (string item2 in assetPendDict.voiceDict[key])
			{
				if (!list2.Contains(item2) && !removeVoiceList.Contains(item2) && sizeDict.TryGetValue(item2, out var value2))
				{
					num += (ulong)value2;
					list2.Add(item2);
				}
			}
		}
		return GetFormatSizeStr(num + (ulong)(voiceSize * 1024f * 1024f));
	}

	public ulong GetSingleAssetSize()
	{
		ulong num = 0uL;
		GetCanRemoveSingleAssetList(out var assetList, out var _);
		foreach (string item in assetList)
		{
			AssetManager.TryGetBundleFileName(item, out var fileName);
			if (!string.IsNullOrEmpty(fileName))
			{
				AssetManager.GetAssetHashManifest().TryGetFileInfoByHash(Path.GetFileNameWithoutExtension(fileName), out var fileInfo);
				num += (ulong)fileInfo.mFileSize;
			}
		}
		return num;
	}

	public ulong GetSingleVoiceSize()
	{
		ulong num = 0uL;
		GetCanRemoveSingleVoiceList(out var voiceList, out var _);
		foreach (string item in voiceList)
		{
			foreach (string item2 in VoicePackageManager.Instance.GetDownLoadPackage())
			{
				if (CriWareExtension.m_voiceAssetHasnManifest.TryGetValue(item2, out var value) && value.mBundleName2FileInfo.TryGetValue(item, out var value2))
				{
					num += (ulong)value2.mFileSize;
				}
			}
		}
		return num;
	}

	public string GetSingleAssetAndVoiceSize()
	{
		ulong size = GetSingleAssetSize() + GetSingleVoiceSize();
		return GetFormatSizeStr(size);
	}

	public string GetCurOptionKey()
	{
		if (cur_option != null)
		{
			return cur_option.GetKey();
		}
		return "";
	}

	public float GetProcess()
	{
		if (cur_option != null)
		{
			return cur_option.GetProcess();
		}
		return 0f;
	}

	public string GetProcessStr()
	{
		if (cur_option != null)
		{
			return cur_option.GetProcessStr();
		}
		return "";
	}

	public string GetSpeedStr()
	{
		if (cur_option != null)
		{
			return cur_option.GetSpeed();
		}
		return "";
	}

	private void Update()
	{
		if (cur_option != null)
		{
			if (cur_option.GetToDestroy())
			{
				cur_option.OnDestroy();
				cur_option = null;
			}
			else
			{
				cur_option.OnUpdate();
			}
		}
		else
		{
			StartNextAssetPendDownload();
		}
	}

	private void OnDestroy()
	{
		if (GameMain.isUseNewHotFix)
		{
			YsDownloadSDK.Instance.onDestroy();
		}
		if (cur_option != null)
		{
			cur_option.OnDestroy();
			cur_option = null;
		}
	}

	public bool ExistAssetBundle(string bundleName)
	{
		AssetManager.TryGetBundleFileName(bundleName, out var fileName);
		AssetManager.GetAssetHashManifest().TryGetFileInfoByHash(Path.GetFileNameWithoutExtension(fileName), out var fileInfo);
		if (string.IsNullOrEmpty(fileName))
		{
			return false;
		}
		string text = Platform.GetDownloadPersistentDataPath() + fileName;
		if (File.Exists(text) && fileInfo.mFileSize != new FileInfo(text).Length)
		{
			return true;
		}
		return false;
	}

	public bool ExistVoice(string voiceName)
	{
		foreach (string item in VoicePackageManager.Instance.GetDownLoadPackage())
		{
			if (CriWareExtension.m_voiceAssetHasnManifest.TryGetValue(item, out var value) && value.mBundleName2FileInfo.TryGetValue(voiceName, out var value2))
			{
				string mFilePath = value2.mFilePath;
				string text = CriWareExtension.GetDownloadPersistentDataPath() + item + "/" + mFilePath;
				if (File.Exists(text) && value2.mFileSize == new FileInfo(text).Length)
				{
					return true;
				}
			}
		}
		return false;
	}

	public void RemovePackage(string key)
	{
		List<string> list = GetAssetList(key);
		foreach (string downloaded_key in downloaded_keys)
		{
			if (downloaded_key != key)
			{
				List<string> assetList = GetAssetList(downloaded_key);
				list = list.Except(assetList).ToList();
			}
		}
		foreach (Pend item in m_pendDownLoadQueue)
		{
			string text = item.name;
			if (text != key)
			{
				List<string> assetList2 = GetAssetList(text);
				list = list.Except(assetList2).ToList();
			}
		}
		List<string> list2 = GetVoiceList(key);
		foreach (string downloaded_key2 in downloaded_keys)
		{
			if (downloaded_key2 != key)
			{
				List<string> voiceList = GetVoiceList(downloaded_key2);
				list2 = list2.Except(voiceList).ToList();
			}
		}
		foreach (Pend item2 in m_pendDownLoadQueue)
		{
			string text2 = item2.name;
			if (text2 != key)
			{
				List<string> voiceList2 = GetVoiceList(text2);
				list2 = list2.Except(voiceList2).ToList();
			}
		}
		RemoveAsset(list);
		RemoveVoice(list2);
		downloaded_keys.Remove(key);
		key_size_Dict.Clear();
		ResavaKeys();
	}

	public List<string> GetAssetList(string key)
	{
		List<string> list = new List<string>();
		if (assetPendDict.pendDict.ContainsKey(key))
		{
			foreach (string item in assetPendDict.pendDict[key])
			{
				list.Add(item);
			}
		}
		return list;
	}

	public List<string> GetVoiceList(string key)
	{
		List<string> list = new List<string>();
		if (assetPendDict.voiceDict.ContainsKey(key))
		{
			foreach (string item in assetPendDict.voiceDict[key])
			{
				list.Add(item);
			}
		}
		return list;
	}

	public void RemoveAsset(List<string> assetList)
	{
		foreach (string asset in assetList)
		{
			AssetManager.TryGetBundleFileName(asset, out var fileName);
			string filePath = Platform.GetDownloadPersistentDataPath() + fileName;
			DeletFile(filePath);
		}
		key_size_Dict.Clear();
	}

	public void RemoveVoice(List<string> voiceList)
	{
		foreach (string voice in voiceList)
		{
			foreach (string item in VoicePackageManager.Instance.GetDownLoadPackage())
			{
				if (CriWareExtension.m_voiceAssetHasnManifest.TryGetValue(item, out var value) && value.mBundleName2FileInfo.TryGetValue(voice, out var value2))
				{
					string mFilePath = value2.mFilePath;
					string filePath = CriWareExtension.GetDownloadPersistentDataPath() + item + "/" + mFilePath;
					DeletFile(filePath);
				}
			}
		}
		key_size_Dict.Clear();
	}

	public void DeleteSingleAsset()
	{
		GetCanRemoveSingleAssetList(out var assetList, out var keepList);
		string singleAssetPath = GetSingleAssetPath();
		using (TextWriter textWriter = new StreamWriter(singleAssetPath, append: false))
		{
			if (textWriter == null)
			{
				Debug.LogError("Cannot write to " + singleAssetPath);
				return;
			}
			for (int i = 0; i < keepList.Count; i++)
			{
				textWriter.WriteLine(keepList[i]);
			}
			textWriter.Flush();
			textWriter.Close();
		}
		RemoveAsset(assetList);
	}

	public void GetCanRemoveSingleAssetList(out List<string> assetList, out List<string> keepList)
	{
		assetList = GetDownloadSingleAsset();
		keepList = new List<string>();
		object[] array = (LuaHelper.CallFunction("GetAllLoadingImageList")[0] as LuaTable).ToArray();
		for (int i = 0; i < array.Length; i++)
		{
			AssetManager.TryGetAssetNameAndBundleName((string)array[i], out var _, out var assetBundleName);
			AssetManager.TryGetBundleFileName(assetBundleName, out var fileName);
			if (assetList.Contains(fileName))
			{
				assetList.Remove(fileName);
				keepList.Add(fileName);
			}
		}
		List<string> list = downloaded_keys.ToList();
		foreach (Pend item in m_pendDownLoadQueue)
		{
			if (item.type == PendType.Package)
			{
				list.Add(item.name);
			}
		}
		foreach (string item2 in list)
		{
			List<string> value = new List<string>();
			if (!assetPendDict.pendDict.TryGetValue(item2, out value))
			{
				continue;
			}
			foreach (string item3 in value)
			{
				if (assetList.Contains(item3))
				{
					assetList.Remove(item3);
					keepList.Add(item3);
				}
			}
		}
	}

	public void DeleteSingleVoice()
	{
		GetCanRemoveSingleVoiceList(out var voiceList, out var keepList);
		string singleVoicePath = GetSingleVoicePath();
		using (TextWriter textWriter = new StreamWriter(singleVoicePath, append: false))
		{
			if (textWriter == null)
			{
				Debug.LogError("Cannot write to " + singleVoicePath);
				return;
			}
			for (int i = 0; i < keepList.Count; i++)
			{
				textWriter.WriteLine(keepList[i]);
			}
			textWriter.Flush();
			textWriter.Close();
		}
		RemoveVoice(voiceList);
	}

	public void GetCanRemoveSingleVoiceList(out List<string> voiceList, out List<string> keepList)
	{
		voiceList = GetDownloadSingleVoice();
		keepList = new List<string>();
		List<string> list = downloaded_keys.ToList();
		foreach (Pend item in m_pendDownLoadQueue)
		{
			if (item.type == PendType.Package)
			{
				list.Add(item.name);
			}
		}
		foreach (string item2 in list)
		{
			List<string> value = new List<string>();
			if (!assetPendDict.voiceDict.TryGetValue(item2, out value))
			{
				continue;
			}
			foreach (string item3 in value)
			{
				if (voiceList.Contains(item3))
				{
					voiceList.Remove(item3);
					keepList.Add(item3);
				}
			}
		}
	}

	public void DeletFile(string filePath)
	{
		try
		{
			if (File.Exists(filePath))
			{
				File.Delete(filePath);
			}
		}
		catch (Exception ex)
		{
			Debug.Log("Delete " + filePath + " fail!" + ex);
		}
	}

	public float GetVoicePackageSize(string abbr)
	{
		float realtimeSinceStartup = Time.realtimeSinceStartup;
		ulong num = 0uL;
		bool flag = VoicePackageManager.Instance.IsHavePackage(abbr);
		string text = CriWareExtension.GetDownloadPersistentDataPath() + abbr + "/";
		VoiceAssetHashList voiceAssetHashList = null;
		string text2 = text + $"voice_hash_{abbr}_{VoicePackageManager.Instance.GetVoicePackageVersion(abbr)}_temp.bytes";
		if (File.Exists(text2))
		{
			try
			{
				voiceAssetHashList = Platform.GetJsonFile<VoiceAssetHashList>(text2);
				if (!_voiceHashCopyed && voiceAssetHashList != null)
				{
					File.Copy(text2, text + $"voice_hash_{abbr}_{VoicePackageManager.Instance.GetVoicePackageVersion(abbr)}.bytes", overwrite: true);
					_voiceHashCopyed = true;
				}
			}
			catch (Exception exception)
			{
				Debug.LogError("无法获取语音hash! path: " + text2);
				Debug.LogException(exception);
			}
		}
		if (voiceAssetHashList == null)
		{
			text2 = text + $"voice_hash_{abbr}_{VoicePackageManager.Instance.GetVoicePackageVersion(abbr)}.bytes";
			if (File.Exists(text2))
			{
				try
				{
					voiceAssetHashList = Platform.GetJsonFile<VoiceAssetHashList>(text2);
				}
				catch (Exception exception2)
				{
					Debug.LogError("无法获取语音hash! path: " + text2);
					Debug.LogException(exception2);
				}
			}
		}
		if (voiceAssetHashList == null)
		{
			Debug.Log("找不到" + text2 + "或无法获取语音hash, 返回全包大小");
			return VoicePackageManager.Instance.GetPackageSize(abbr);
		}
		if (flag)
		{
			for (int i = 0; i < voiceAssetHashList.assetHashList.Count; i++)
			{
				string[] array = voiceAssetHashList.assetHashList[i].Split('|');
				string hash = array[1];
				int num2 = int.Parse(array[2]);
				FileInfo fileInfo = new FileInfo(text + AssetHashManifest.HashToFilePath(hash));
				if (fileInfo.Exists && fileInfo.Length == num2)
				{
					num += (ulong)num2;
				}
			}
		}
		else
		{
			Dictionary<string, ulong> dictionary = new Dictionary<string, ulong>();
			List<string> list = DownloadPackageMgr.Instance.GenerateAllAssetPendPathList(GameMain.mServerAssetPendDict, isVoice: true);
			for (int j = 0; j < voiceAssetHashList.assetHashList.Count; j++)
			{
				string[] array2 = voiceAssetHashList.assetHashList[j].Split('|');
				string text3 = array2[0].Replace("_" + abbr, "") ?? "";
				string text4 = array2[1];
				int num3 = int.Parse(array2[2]);
				if (!HotFixSkipUtil.CheckVoiceCanSkip(text3))
				{
					FileInfo fileInfo2 = new FileInfo(text + AssetHashManifest.HashToFilePath(text4));
					if ((!fileInfo2.Exists || fileInfo2.Length != num3) && !list.Contains(text3) && !dictionary.ContainsKey(text4))
					{
						dictionary[text4] = (ulong)num3;
						num += (ulong)num3;
					}
				}
			}
		}
		Debug.Log($"获取语音包大小时间: {Time.realtimeSinceStartup - realtimeSinceStartup}");
		return (float)num / 1024f / 1024f;
	}

	public long CheckSpaceToDownload(string[] keyList)
	{
		long num = 20971520L;
		long num2 = 0L;
		string[] array = keyList;
		foreach (string key in array)
		{
			num2 += (long)GetAssetPendSize(key);
		}
		string text = Path.GetPathRoot(Application.streamingAssetsPath).Replace('/', '\\');
		array = Directory.GetLogicalDrives();
		foreach (string text2 in array)
		{
			if (!(text2 == "C:\\") && !(text2 == text))
			{
				continue;
			}
			if (_GetDiskFreeSpaceEx == null)
			{
				Assembly[] assemblies = AppDomain.CurrentDomain.GetAssemblies();
				foreach (Assembly assembly in assemblies)
				{
					if (assembly.FullName.StartsWith("YSPCSDK"))
					{
						Type type = assembly.GetType("YSMixCore.YSMixUtils");
						_GetDiskFreeSpaceEx = type.GetMethod("GetDiskFreeSpaceEx");
					}
				}
			}
			object[] array2 = new object[4] { text2, null, null, null };
			if ((bool)_GetDiskFreeSpaceEx.Invoke(null, array2) && (long)(ulong)array2[1] < num2 + num)
			{
				return -num2;
			}
		}
		return num2;
	}

	public bool IsAllAssetDownloaded(string key)
	{
		if (assetPendDict.pendDict.TryGetValue(key, out var value))
		{
			foreach (string item in value)
			{
				AssetManager.TryGetBundleFileName(item, out var fileName);
				if (!string.IsNullOrEmpty(fileName))
				{
					string text = Platform.GetDownloadPersistentDataPath() + fileName;
					AssetManager.GetAssetHashManifest().TryGetFileInfoByHash(Path.GetFileNameWithoutExtension(fileName), out var fileInfo);
					if (!File.Exists(text) || fileInfo.mFileSize != new FileInfo(text).Length)
					{
						return false;
					}
				}
			}
		}
		if (assetPendDict.voiceDict.TryGetValue(key, out var value2) && CriWareExtension.m_voiceAssetHasnManifest != null)
		{
			foreach (string item2 in VoicePackageManager.Instance.GetDownLoadPackage())
			{
				if (!CriWareExtension.m_voiceAssetHasnManifest.TryGetValue(item2, out var value3))
				{
					continue;
				}
				foreach (string item3 in value2)
				{
					if (value3.mBundleName2FileInfo.TryGetValue(item3, out var value4))
					{
						string mFilePath = value4.mFilePath;
						string text2 = CriWareExtension.GetDownloadPersistentDataPath() + item2 + "/" + mFilePath;
						if (!File.Exists(text2) || value4.mFileSize != new FileInfo(text2).Length)
						{
							return false;
						}
					}
				}
			}
		}
		return true;
	}
}
