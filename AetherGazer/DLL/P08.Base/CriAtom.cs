using System;
using System.Collections;
using System.IO;
using System.Runtime.InteropServices;
using AOT;
using CriWare;
using UnityEngine;

[AddComponentMenu("CRIWARE/CRI Atom")]
public class CriAtom : CriMonoBehaviour
{
	public enum SpeakerMapping
	{
		Auto,
		Monaural,
		Stereo,
		Ch5_1,
		Ch7_1,
		Ch5_1_2,
		Ch7_1_2,
		Ch7_1_4,
		Ch7_1_4_4,
		Ambisonics1p,
		Ambisonics2p,
		Ambisonics3p,
		Object,
		Custom
	}

	protected class NativeMethods
	{
		internal static int criAtom_GetThreadPriority_ANDROID()
		{
			return 0;
		}

		internal static void criAtom_SetThreadPriority_ANDROID(int prio)
		{
		}
	}

	public string acfFile = "";

	private bool acfIsLoading;

	public CriAtomCueSheet[] cueSheets = new CriAtomCueSheet[0];

	public string dspBusSetting = "";

	public bool dontDestroyOnLoad;

	private static CriAtomExSequencer.EventCallback eventUserCallback;

	private static CriAtomExSequencer.EventCbFunc eventUserCbFunc;

	private static CriAtomExBeatSync.CbFunc obsoleteBeatSyncFunc;

	private GCHandle acfRegisterGCHandle;

	public bool dontRemoveExistsCueSheet;

	internal static bool HasUserCallback => eventUserCallback != null;

	internal static bool HasBeatSyncCallback => beatsyncUserCbFunc != null;

	internal static bool HasCueLinkCallback => cueLinkUserCbFunc != null;

	private static CriAtom instance { get; set; }

	public static bool CueSheetsAreLoading
	{
		get
		{
			if (instance == null)
			{
				return false;
			}
			CriAtomCueSheet[] array = instance.cueSheets;
			for (int i = 0; i < array.Length; i++)
			{
				if (array[i].IsLoading)
				{
					return true;
				}
			}
			return false;
		}
	}

	internal static event CriAtomExSequencer.EventCallback OnEventSequencerCallback
	{
		add
		{
			RegisterEventCallbackChain(value);
		}
		remove
		{
			UnregisterEventCallbackChain(value);
		}
	}

	private static event CriAtomExBeatSync.CbFunc beatsyncUserCbFunc;

	internal static event CriAtomExBeatSync.CbFunc OnBeatSyncCallback
	{
		add
		{
			RegisterBeatSyncCallbackChain(value);
		}
		remove
		{
			UnregisterBeatSyncCallbackChain(value);
		}
	}

	private static event CriAtomEx.CueLinkCbFunc cueLinkUserCbFunc;

	internal static event CriAtomEx.CueLinkCbFunc OnCueLinkCallback
	{
		add
		{
			RegisterCueLinkCallbackChain(value);
		}
		remove
		{
			UnregisterCueLinkCallbackChain(value);
		}
	}

	public static void AttachDspBusSetting(string settingName)
	{
		instance.dspBusSetting = settingName;
		if (!string.IsNullOrEmpty(settingName))
		{
			CriAtomEx.AttachDspBusSetting(settingName);
		}
		else
		{
			CriAtomEx.DetachDspBusSetting();
		}
	}

	public static void DetachDspBusSetting()
	{
		instance.dspBusSetting = "";
		CriAtomEx.DetachDspBusSetting();
	}

	public static CriAtomCueSheet GetCueSheet(string name)
	{
		return instance.GetCueSheetInternal(name);
	}

	public static CriAtomCueSheet AddCueSheet(string name, string acbFile, string awbFile, CriFsBinder binder = null)
	{
		CriAtomCueSheet criAtomCueSheet = instance.AddCueSheetInternal(name, acbFile, awbFile, binder);
		if (Application.isPlaying)
		{
			criAtomCueSheet.acb = instance.LoadAcbFile(binder, acbFile, awbFile);
		}
		return criAtomCueSheet;
	}

	public static CriAtomCueSheet AddCueSheetAsync(string name, string acbFile, string awbFile, CriFsBinder binder = null, bool loadAwbOnMemory = false)
	{
		CriAtomCueSheet criAtomCueSheet = instance.AddCueSheetInternal(name, acbFile, awbFile, binder);
		if (Application.isPlaying)
		{
			instance.LoadAcbFileAsync(criAtomCueSheet, binder, acbFile, awbFile, loadAwbOnMemory);
		}
		return criAtomCueSheet;
	}

	public static CriAtomCueSheet AddCueSheet(string name, byte[] acbData, string awbFile, CriFsBinder awbBinder = null)
	{
		CriAtomCueSheet criAtomCueSheet = instance.AddCueSheetInternal(name, "", awbFile, awbBinder);
		if (Application.isPlaying)
		{
			criAtomCueSheet.acb = instance.LoadAcbData(acbData, awbBinder, awbFile);
		}
		return criAtomCueSheet;
	}

	public static CriAtomCueSheet AddCueSheetAsync(string name, byte[] acbData, string awbFile, CriFsBinder awbBinder = null, bool loadAwbOnMemory = false)
	{
		CriAtomCueSheet criAtomCueSheet = instance.AddCueSheetInternal(name, "", awbFile, awbBinder);
		if (Application.isPlaying)
		{
			instance.LoadAcbDataAsync(criAtomCueSheet, acbData, awbBinder, awbFile, loadAwbOnMemory);
		}
		return criAtomCueSheet;
	}

	public static void RemoveCueSheet(string name)
	{
		if (!(instance == null))
		{
			instance.RemoveCueSheetInternal(name);
		}
	}

	public static CriAtomExAcb GetAcb(string cueSheetName)
	{
		CriAtomCueSheet[] array = instance.cueSheets;
		foreach (CriAtomCueSheet criAtomCueSheet in array)
		{
			if (cueSheetName == criAtomCueSheet.name)
			{
				return criAtomCueSheet.acb;
			}
		}
		Debug.LogWarning("[CRIWARE] Cue sheet named \"" + cueSheetName + "\" is not loaded.");
		return null;
	}

	public static void SetCategoryVolume(string name, float volume)
	{
		CriAtomExCategory.SetVolume(name, volume);
	}

	public static void SetCategoryVolume(int id, float volume)
	{
		CriAtomExCategory.SetVolume(id, volume);
	}

	public static float GetCategoryVolume(string name)
	{
		return CriAtomExCategory.GetVolume(name);
	}

	public static float GetCategoryVolume(int id)
	{
		return CriAtomExCategory.GetVolume(id);
	}

	public static void SetBusAnalyzer(string busName, bool sw)
	{
		if (sw)
		{
			CriAtomExAsr.AttachBusAnalyzer(busName, 50, 1000);
		}
		else
		{
			CriAtomExAsr.DetachBusAnalyzer(busName);
		}
	}

	public static void SetBusAnalyzer(bool sw)
	{
		if (sw)
		{
			CriAtomExAsr.AttachBusAnalyzer(50, 1000);
		}
		else
		{
			CriAtomExAsr.DetachBusAnalyzer();
		}
	}

	public static CriAtomExAsr.BusAnalyzerInfo GetBusAnalyzerInfo(string busName)
	{
		CriAtomExAsr.GetBusAnalyzerInfo(busName, out var info);
		return info;
	}

	[Obsolete("Use CriAtom.GetBusAnalyzerInfo(string busName)")]
	public static CriAtomExAsr.BusAnalyzerInfo GetBusAnalyzerInfo(int busId)
	{
		CriAtomExAsr.GetBusAnalyzerInfo(busId, out var info);
		return info;
	}

	public void Setup()
	{
		if (instance != null && instance != this)
		{
			GameObject obj = instance.gameObject;
			instance.Shutdown();
			CriAtomEx.UnregisterAcf();
			UnityEngine.Object.Destroy(obj);
		}
		instance = this;
		CriAtomPlugin.InitializeLibrary();
		if (!string.IsNullOrEmpty(acfFile))
		{
			string text = Path.Combine(Common.persistentDataPath, acfFile);
			if (!File.Exists(text))
			{
				text = Path.Combine(Common.streamingAssetsPath, acfFile);
			}
			CriAtomEx.RegisterAcf(null, text);
		}
		if (!string.IsNullOrEmpty(dspBusSetting))
		{
			AttachDspBusSetting(dspBusSetting);
		}
		CriAtomCueSheet[] array = cueSheets;
		foreach (CriAtomCueSheet criAtomCueSheet in array)
		{
			criAtomCueSheet.acb = LoadAcbFile(null, criAtomCueSheet.acbFile, criAtomCueSheet.awbFile);
		}
		if (dontDestroyOnLoad)
		{
			UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
		}
	}

	public void Shutdown()
	{
		CriAtomCueSheet[] array = cueSheets;
		foreach (CriAtomCueSheet criAtomCueSheet in array)
		{
			if (criAtomCueSheet.acb != null)
			{
				criAtomCueSheet.acb.Dispose();
				criAtomCueSheet.acb = null;
			}
		}
		CriAtomPlugin.FinalizeLibrary();
		if (instance == this)
		{
			instance = null;
		}
	}

	private void Awake()
	{
		if (!(instance != null) || !(instance != this))
		{
			return;
		}
		if (instance.acfFile != acfFile)
		{
			GameObject obj = instance.gameObject;
			instance.Shutdown();
			CriAtomEx.UnregisterAcf();
			UnityEngine.Object.Destroy(obj);
			return;
		}
		if (instance.dspBusSetting != dspBusSetting)
		{
			AttachDspBusSetting(dspBusSetting);
		}
		instance.MargeCueSheet(cueSheets, dontRemoveExistsCueSheet);
		UnityEngine.Object.Destroy(base.gameObject);
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (!(instance != null))
		{
			Setup();
		}
	}

	private void OnDestroy()
	{
		if (!(this != instance))
		{
			if (beatsyncUserCbFunc != null)
			{
				beatsyncUserCbFunc = null;
				CriAtomPlugin.CRIWAREC6A6ABD9(IntPtr.Zero);
			}
			if (acfRegisterGCHandle.IsAllocated)
			{
				CriAtomEx.UnregisterAcf();
				acfRegisterGCHandle.Free();
			}
			Shutdown();
		}
	}

	public override void CriInternalUpdate()
	{
	}

	public override void CriInternalLateUpdate()
	{
	}

	public CriAtomCueSheet GetCueSheetInternal(string name)
	{
		for (int i = 0; i < cueSheets.Length; i++)
		{
			CriAtomCueSheet criAtomCueSheet = cueSheets[i];
			if (criAtomCueSheet.name == name)
			{
				return criAtomCueSheet;
			}
		}
		return null;
	}

	public CriAtomCueSheet AddCueSheetInternal(string name, string acbFile, string awbFile, CriFsBinder binder)
	{
		CriAtomCueSheet[] array = new CriAtomCueSheet[cueSheets.Length + 1];
		cueSheets.CopyTo(array, 0);
		cueSheets = array;
		CriAtomCueSheet criAtomCueSheet = new CriAtomCueSheet();
		cueSheets[cueSheets.Length - 1] = criAtomCueSheet;
		if (string.IsNullOrEmpty(name))
		{
			criAtomCueSheet.name = Path.GetFileNameWithoutExtension(acbFile);
		}
		else
		{
			criAtomCueSheet.name = name;
		}
		criAtomCueSheet.acbFile = acbFile;
		criAtomCueSheet.awbFile = awbFile;
		return criAtomCueSheet;
	}

	public void RemoveCueSheetInternal(string name)
	{
		int num = -1;
		for (int i = 0; i < cueSheets.Length; i++)
		{
			if (name == cueSheets[i].name)
			{
				num = i;
			}
		}
		if (num >= 0)
		{
			CriAtomCueSheet criAtomCueSheet = cueSheets[num];
			if (criAtomCueSheet.acb != null)
			{
				criAtomCueSheet.acb.Dispose();
				criAtomCueSheet.acb = null;
			}
			CriAtomCueSheet[] destinationArray = new CriAtomCueSheet[cueSheets.Length - 1];
			Array.Copy(cueSheets, 0, destinationArray, 0, num);
			Array.Copy(cueSheets, num + 1, destinationArray, num, cueSheets.Length - num - 1);
			cueSheets = destinationArray;
		}
	}

	private void MargeCueSheet(CriAtomCueSheet[] newCueSheets, bool newDontRemoveExistsCueSheet)
	{
		if (!newDontRemoveExistsCueSheet)
		{
			int i = 0;
			while (i < cueSheets.Length)
			{
				if (Array.FindIndex(newCueSheets, (CriAtomCueSheet sheet) => sheet.name == cueSheets[i].name) < 0)
				{
					RemoveCueSheet(cueSheets[i].name);
				}
				else
				{
					i++;
				}
			}
		}
		foreach (CriAtomCueSheet criAtomCueSheet in newCueSheets)
		{
			if (GetCueSheetInternal(criAtomCueSheet.name) == null)
			{
				AddCueSheet(null, criAtomCueSheet.acbFile, criAtomCueSheet.awbFile);
			}
		}
	}

	private CriAtomExAcb LoadAcbFile(CriFsBinder binder, string acbFile, string awbFile)
	{
		if (string.IsNullOrEmpty(acbFile))
		{
			return null;
		}
		string pFilePath = acbFile;
		if (!CriWareExtension.TryGetFilePath(pFilePath, out pFilePath) && binder == null && Common.IsStreamingAssetsPath(pFilePath))
		{
			pFilePath = Path.Combine(Common.streamingAssetsPath, pFilePath);
		}
		string pFilePath2 = awbFile;
		if (!string.IsNullOrEmpty(pFilePath2) && !CriWareExtension.TryGetFilePath(pFilePath2, out pFilePath2) && binder == null && Common.IsStreamingAssetsPath(pFilePath2))
		{
			pFilePath2 = Path.Combine(Common.streamingAssetsPath, pFilePath2);
		}
		return CriAtomExAcb.LoadAcbFile(binder, pFilePath, pFilePath2);
	}

	private CriAtomExAcb LoadAcbData(byte[] acbData, CriFsBinder binder, string awbFile)
	{
		if (acbData == null)
		{
			return null;
		}
		string pFilePath = awbFile;
		if (!string.IsNullOrEmpty(pFilePath) && !CriWareExtension.TryGetFilePath(pFilePath, out pFilePath) && binder == null && Common.IsStreamingAssetsPath(pFilePath))
		{
			pFilePath = Path.Combine(Common.streamingAssetsPath, pFilePath);
		}
		return CriAtomExAcb.LoadAcbData(acbData, binder, pFilePath);
	}

	private void LoadAcbFileAsync(CriAtomCueSheet cueSheet, CriFsBinder binder, string acbFile, string awbFile, bool loadAwbOnMemory)
	{
		if (!string.IsNullOrEmpty(acbFile))
		{
			StartCoroutine(LoadAcbFileCoroutine(cueSheet, binder, acbFile, awbFile, loadAwbOnMemory));
		}
	}

	private IEnumerator LoadAcbFileCoroutine(CriAtomCueSheet cueSheet, CriFsBinder binder, string acbPath, string awbPath, bool loadAwbOnMemory)
	{
		cueSheet.loaderStatus = CriAtomExAcbLoader.Status.Loading;
		if (!CriWareExtension.TryGetFilePath(acbPath, out acbPath) && binder == null && Common.IsStreamingAssetsPath(acbPath))
		{
			acbPath = Path.Combine(Common.streamingAssetsPath, acbPath);
		}
		if (!string.IsNullOrEmpty(awbPath) && !CriWareExtension.TryGetFilePath(awbPath, out awbPath) && binder == null && Common.IsStreamingAssetsPath(awbPath))
		{
			awbPath = Path.Combine(Common.streamingAssetsPath, awbPath);
		}
		while (acfIsLoading)
		{
			yield return null;
		}
		using CriAtomExAcbLoader asyncLoader = CriAtomExAcbLoader.LoadAcbFileAsync(binder, acbPath, awbPath, loadAwbOnMemory);
		if (asyncLoader == null)
		{
			cueSheet.loaderStatus = CriAtomExAcbLoader.Status.Error;
			yield break;
		}
		while (true)
		{
			switch (cueSheet.loaderStatus = asyncLoader.GetStatus())
			{
			case CriAtomExAcbLoader.Status.Error:
				break;
			case CriAtomExAcbLoader.Status.Complete:
				cueSheet.acb = asyncLoader.MoveAcb();
				break;
			default:
				yield return null;
				continue;
			}
			break;
		}
	}

	private void LoadAcbDataAsync(CriAtomCueSheet cueSheet, byte[] acbData, CriFsBinder awbBinder, string awbFile, bool loadAwbOnMemory)
	{
		StartCoroutine(LoadAcbDataCoroutine(cueSheet, acbData, awbBinder, awbFile, loadAwbOnMemory));
	}

	private IEnumerator LoadAcbDataCoroutine(CriAtomCueSheet cueSheet, byte[] acbData, CriFsBinder awbBinder, string awbPath, bool loadAwbOnMemory)
	{
		cueSheet.loaderStatus = CriAtomExAcbLoader.Status.Loading;
		if (!string.IsNullOrEmpty(awbPath) && !CriWareExtension.TryGetFilePath(awbPath, out awbPath) && awbBinder == null && Common.IsStreamingAssetsPath(awbPath))
		{
			awbPath = Path.Combine(Common.streamingAssetsPath, awbPath);
		}
		while (acfIsLoading)
		{
			yield return null;
		}
		using CriAtomExAcbLoader asyncLoader = CriAtomExAcbLoader.LoadAcbDataAsync(acbData, awbBinder, awbPath, loadAwbOnMemory);
		if (asyncLoader == null)
		{
			cueSheet.loaderStatus = CriAtomExAcbLoader.Status.Error;
			yield break;
		}
		while (true)
		{
			switch (cueSheet.loaderStatus = asyncLoader.GetStatus())
			{
			case CriAtomExAcbLoader.Status.Error:
				break;
			case CriAtomExAcbLoader.Status.Complete:
				cueSheet.acb = asyncLoader.MoveAcb();
				break;
			default:
				yield return null;
				continue;
			}
			break;
		}
	}

	[MonoPInvokeCallback(typeof(CriAtomExSequencer.EventCbFunc))]
	public static void SequenceEventCallbackFromNative(string eventString)
	{
		if (eventUserCbFunc != null)
		{
			eventUserCbFunc(eventString);
		}
	}

	[MonoPInvokeCallback(typeof(CriAtomExSequencer.EventCallback))]
	private static void SequenceCallbackFromNative(ref CriAtomExSequencer.CriAtomExSequenceEventInfo criAtomExSequenceInfo)
	{
		if (eventUserCallback != null)
		{
			eventUserCallback(ref criAtomExSequenceInfo);
		}
	}

	[MonoPInvokeCallback(typeof(CriAtomExBeatSync.CbFunc))]
	public static void BeatSyncCallbackFromNative(ref CriAtomExBeatSync.Info info)
	{
		if (beatsyncUserCbFunc != null)
		{
			beatsyncUserCbFunc(ref info);
		}
	}

	[MonoPInvokeCallback(typeof(CriAtomEx.CueLinkCbFunc))]
	public static void CueLinkCallbackFromNative(ref CriAtomEx.CueLinkInfo info)
	{
		if (cueLinkUserCbFunc != null)
		{
			cueLinkUserCbFunc(ref info);
		}
	}

	public static void SetEventCallback(CriAtomExSequencer.EventCbFunc func, string separator)
	{
		IntPtr cbfunc = IntPtr.Zero;
		eventUserCbFunc = func;
		if (func != null)
		{
			cbfunc = Marshal.GetFunctionPointerForDelegate<CriAtomExSequencer.EventCbFunc>(SequenceEventCallbackFromNative);
		}
		CriAtomPlugin.CRIWARE327AA439(cbfunc, separator);
	}

	private static void RegisterEventCallbackChain(CriAtomExSequencer.EventCallback func)
	{
		_ = IntPtr.Zero;
		if (eventUserCallback == null)
		{
			CriAtomPlugin.CRIWAREEC96E4D7(Marshal.GetFunctionPointerForDelegate<CriAtomExSequencer.EventCallback>(SequenceCallbackFromNative));
		}
		eventUserCallback = (CriAtomExSequencer.EventCallback)Delegate.Combine(eventUserCallback, func);
	}

	private static void UnregisterEventCallbackChain(CriAtomExSequencer.EventCallback func)
	{
		eventUserCallback = (CriAtomExSequencer.EventCallback)Delegate.Remove(eventUserCallback, func);
		if (eventUserCallback == null)
		{
			CriAtomPlugin.CRIWAREEC96E4D7(IntPtr.Zero);
		}
	}

	public static void SetBeatSyncCallback(CriAtomExBeatSync.CbFunc func)
	{
		Debug.LogWarning("[CRIWARE] This function(CriAtom.SetBeatSyncCallback) is deprecated. Use CriAtomExBeatSync class.");
		if (func == null)
		{
			UnregisterBeatSyncCallbackChain(obsoleteBeatSyncFunc);
			obsoleteBeatSyncFunc = null;
			return;
		}
		if (obsoleteBeatSyncFunc != null)
		{
			UnregisterBeatSyncCallbackChain(obsoleteBeatSyncFunc);
		}
		obsoleteBeatSyncFunc = func;
		RegisterBeatSyncCallbackChain(obsoleteBeatSyncFunc);
	}

	private static void RegisterBeatSyncCallbackChain(CriAtomExBeatSync.CbFunc func)
	{
		if (beatsyncUserCbFunc == null)
		{
			CriAtomPlugin.CRIWAREC6A6ABD9(Marshal.GetFunctionPointerForDelegate<CriAtomExBeatSync.CbFunc>(BeatSyncCallbackFromNative));
		}
		beatsyncUserCbFunc += func;
	}

	private static void UnregisterBeatSyncCallbackChain(CriAtomExBeatSync.CbFunc func)
	{
		beatsyncUserCbFunc -= func;
		if (beatsyncUserCbFunc == null)
		{
			CriAtomPlugin.CRIWAREC6A6ABD9(IntPtr.Zero);
		}
	}

	private static void RegisterCueLinkCallbackChain(CriAtomEx.CueLinkCbFunc func)
	{
		if (cueLinkUserCbFunc == null)
		{
			CriAtomPlugin.CRIWARE43BC08E6(Marshal.GetFunctionPointerForDelegate<CriAtomEx.CueLinkCbFunc>(CueLinkCallbackFromNative));
		}
		cueLinkUserCbFunc += func;
	}

	private static void UnregisterCueLinkCallbackChain(CriAtomEx.CueLinkCbFunc func)
	{
		cueLinkUserCbFunc -= func;
		if (cueLinkUserCbFunc == null)
		{
			CriAtomPlugin.CRIWARE43BC08E6(IntPtr.Zero);
		}
	}

	public static int GetThreadPriorityANDROID()
	{
		return NativeMethods.criAtom_GetThreadPriority_ANDROID();
	}

	public static void SetThreadPriorityANDROID(int prio)
	{
		NativeMethods.criAtom_SetThreadPriority_ANDROID(prio);
	}
}
