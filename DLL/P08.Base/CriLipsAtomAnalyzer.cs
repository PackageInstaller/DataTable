using System;
using System.Runtime.InteropServices;
using UnityEngine;

public class CriLipsAtomAnalyzer : CriDisposable, ICriLipsAnalyzeModule
{
	public enum DataReadoutMode
	{
		ProcessIfNoData,
		SilentIfNoData,
		ProcessAlways
	}

	public struct Config
	{
		public int maxInputSamplingRate;

		public CriLipsMouth.MorphTargetType morphTargetType;

		public DataReadoutMode dataReadoutMode;

		public CriLipsMouth.BehaviourParamsPreset behaviourParamsPreset;

		public static Config Default => new Config
		{
			maxInputSamplingRate = 48000,
			morphTargetType = CriLipsMouth.MorphTargetType.Japanese_AIUEO,
			dataReadoutMode = DataReadoutMode.ProcessIfNoData,
			behaviourParamsPreset = CriLipsMouth.BehaviourParamsPreset.Default
		};
	}

	public CriLipsMouth mouth;

	private IntPtr handle = IntPtr.Zero;

	private CriAtomExPlayer attachedPlayer;

	private int maxSamplingRate;

	public IntPtr nativeHandle => handle;

	public bool isAvailable => handle != IntPtr.Zero;

	public CriLipsAtomAnalyzer(int maxSamplingRate = 48000)
	{
		if (!CriLipsAtomPlugin.IsLibraryInitialized())
		{
			throw new Exception("CriLipsAtomPlugin is not initialized.");
		}
		Config config = Config.Default;
		config.maxInputSamplingRate = maxSamplingRate;
		handle = criLipsAtomAnalyzer_Create(ref config, IntPtr.Zero, 0);
		if (handle == IntPtr.Zero)
		{
			Debug.LogWarning("[CRIWARE] Invalid native handle of CriLipsAtomAnalyzer.");
		}
		else
		{
			mouth = new CriLipsMouth(GetNativeMouthHandle());
		}
		this.maxSamplingRate = maxSamplingRate;
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Lips);
	}

	public CriLipsAtomAnalyzer(Config config)
	{
		if (!CriLipsAtomPlugin.IsLibraryInitialized())
		{
			throw new Exception("CriLipsAtomPlugin is not initialized.");
		}
		handle = criLipsAtomAnalyzer_Create(ref config, IntPtr.Zero, 0);
		if (handle == IntPtr.Zero)
		{
			Debug.LogWarning("[CRIWARE] Invalid native handle of CriLipsAtomAnalyzer.");
		}
		else
		{
			mouth = new CriLipsMouth(GetNativeMouthHandle());
		}
		maxSamplingRate = config.maxInputSamplingRate;
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Lips);
	}

	public override void Dispose()
	{
		CriDisposableObjectManager.Unregister(this);
		if (isAvailable)
		{
			DetachFromDspBus();
			if (CriLipsAtomPlugin.IsAnalyzerAttachedToPlayer(this))
			{
				DetachFromAtomExPlayer();
			}
			criLipsAtomAnalyzer_Destroy(handle);
			mouth.Dispose();
		}
		handle = IntPtr.Zero;
		mouth = null;
		GC.SuppressFinalize(this);
	}

	public bool AttachToAtomExPlayer(CriAtomExPlayer player)
	{
		attachedPlayer = player;
		CriLipsAtomPlugin.AttachAnalyzerToPlayer(player, this);
		return true;
	}

	public bool DetachFromAtomExPlayer()
	{
		bool result = true;
		if (attachedPlayer != null && attachedPlayer.isAvailable)
		{
			CriLipsAtomPlugin.DetachAnalyzerFromPlayer(attachedPlayer, this);
			attachedPlayer = null;
			return true;
		}
		attachedPlayer = null;
		CriLipsAtomPlugin.DetachAnalyzerFromInvalidPlayer(this);
		return result;
	}

	[Obsolete("Use CriLipsAtomAnalyzer.DetachFromAtomExPlayer with no arguments")]
	public bool DetachFromAtomExPlayer(bool forceStop)
	{
		if (attachedPlayer != null && attachedPlayer.isAvailable && forceStop)
		{
			attachedPlayer.Stop(ignoresReleaseTime: true);
		}
		return DetachFromAtomExPlayer();
	}

	public bool SetSamplingRate(int samplingRate)
	{
		if (samplingRate > maxSamplingRate)
		{
			Debug.LogErrorFormat("[CRIWARE] Sampling rate should be equal to or less than {0}.", maxSamplingRate);
			return false;
		}
		if (samplingRate < 16000)
		{
			Debug.LogErrorFormat("[CRIWARE] Sampling rate should be equal to or more than {0}.", 16000);
			return false;
		}
		criLipsAtomAnalyzer_SetSamplingRate(handle, samplingRate);
		return true;
	}

	public int GetSamplingRate()
	{
		return criLipsAtomAnalyzer_GetSamplingRate(handle);
	}

	public bool SetSilenceThreshold(float volume)
	{
		if (volume > 0f)
		{
			Debug.LogErrorFormat("[CRIWARE] Silence threshold should be equal to or less than {0}.", 0f);
			return false;
		}
		criLipsAtomAnalyzer_SetSilenceThreshold(handle, volume);
		return true;
	}

	public void GetInfo(out CriLipsMouth.Info info)
	{
		info = default(CriLipsMouth.Info);
		criLipsAtomAnalyzer_GetInfo(handle, ref info);
	}

	public void GetMorphTargetBlendAmountAsJapanese(out CriLipsMouth.MorphTargetBlendAmountAsJapanese morph)
	{
		morph = default(CriLipsMouth.MorphTargetBlendAmountAsJapanese);
		criLipsAtomAnalyzer_GetMorphTargetBlendAmountJapanese(handle, ref morph);
	}

	public void GetOpenInfo(out CriLipsMouth.OpenInfo openInfo)
	{
		openInfo = default(CriLipsMouth.OpenInfo);
		criLipsAtomAnalyzer_GetOpenInfo(handle, ref openInfo);
	}

	public float GetVolume()
	{
		return criLipsAtomAnalyzer_GetVolumeDecibel(handle);
	}

	public float GetSilenceThreshold()
	{
		return criLipsAtomAnalyzer_GetSilenceThreshold(handle);
	}

	public void GetInfoAtSilence(out CriLipsMouth.Info info)
	{
		info = default(CriLipsMouth.Info);
		criLipsAtomAnalyzer_GetInfoAtSilence(handle, ref info);
	}

	public bool IsAtSilence()
	{
		return criLipsAtomAnalyzer_IsAtSilence(handle);
	}

	public bool IsAtSilenceForMouthOpen()
	{
		return criLipsAtomAnalyzer_IsAtSilenceForMouthOpen(handle);
	}

	public bool AttachToDspBus(string busName)
	{
		return criLipsAtomAnalyzer_AttachToDspBus(handle, busName);
	}

	public bool DetachFromDspBus()
	{
		return criLipsAtomAnalyzer_DetachFromDspBus(handle);
	}

	public bool IsMorphTargetBlendAmountInterpolative()
	{
		return mouth.IsMorphTargetBlendAmountInterpolative();
	}

	private IntPtr GetNativeMouthHandle()
	{
		return criLipsAtomAnalyzer_GetLipsMouthHandle(handle);
	}

	~CriLipsAtomAnalyzer()
	{
		Dispose();
	}

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criLipsAtomAnalyzer_Create(ref Config config, IntPtr work, int size);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criLipsAtomAnalyzer_Destroy(IntPtr analyzer);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criLipsAtomAnalyzer_AttachToDspBus(IntPtr analyzer, string busName);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criLipsAtomAnalyzer_DetachFromDspBus(IntPtr analyzer);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criLipsAtomAnalyzer_GetInfo(IntPtr analyzer, ref CriLipsMouth.Info info);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criLipsAtomAnalyzer_GetInfoAtSilence(IntPtr analyzer, ref CriLipsMouth.Info info);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criLipsAtomAnalyzer_SetSamplingRate(IntPtr analyzer, int samplingRate);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criLipsAtomAnalyzer_GetSamplingRate(IntPtr analyzer);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criLipsAtomAnalyzer_SetSilenceThreshold(IntPtr analyzer, float volumeDb);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern float criLipsAtomAnalyzer_GetSilenceThreshold(IntPtr analyzer);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern float criLipsAtomAnalyzer_GetVolumeDecibel(IntPtr analyzer);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criLipsAtomAnalyzer_IsAtSilence(IntPtr analyzer);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criLipsAtomAnalyzer_IsAtSilenceForMouthOpen(IntPtr analyzer);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criLipsAtomAnalyzer_GetMorphTargetBlendAmountJapanese(IntPtr analyzer, ref CriLipsMouth.MorphTargetBlendAmountAsJapanese blendAmount);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criLipsAtomAnalyzer_GetOpenInfo(IntPtr analyzer, ref CriLipsMouth.OpenInfo openInfo);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criLipsAtomAnalyzer_GetLipsMouthHandle(IntPtr analyzer);
}
