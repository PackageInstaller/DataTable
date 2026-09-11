using System;
using System.Runtime.InteropServices;
using UnityEngine;

public class CriAtomExAsrRack : CriDisposable
{
	public struct Config
	{
		public float serverFrequency;

		public int numBuses;

		public int outputChannels;

		public CriAtom.SpeakerMapping speakerMapping;

		public int outputSamplingRate;

		public CriAtomEx.SoundRendererType soundRendererType;

		public int outputRackId;

		public IntPtr context;

		public static Config Default()
		{
			Config config = default(Config);
			SetDefaultConfig(ref config);
			return config;
		}
	}

	public struct PlatformConfig
	{
		public byte reserved;
	}

	public struct PerformanceInfo
	{
		public uint processCount;

		public uint lastProcessTime;

		public uint maxProcessTime;

		public uint averageProcessTime;

		public uint lastProcessInterval;

		public uint maxProcessInterval;

		public uint averageProcessInterval;

		public uint lastProcessSamples;

		public uint maxProcessSamples;

		public uint averageProcessSamples;
	}

	public interface IPlatformConfig
	{
		bool IsSupportedPlatform();
	}

	public enum StreamType
	{
		Music,
		Alarm,
		Dtmf,
		Notification,
		Ring,
		System,
		VoiceCall
	}

	public struct PlatformConfigAndroid : IPlatformConfig
	{
		public StreamType streamType;

		public bool enableSpatialAudio;

		public bool IsSupportedPlatform()
		{
			return false;
		}

		public static PlatformConfigAndroid Default()
		{
			PlatformConfigAndroid platformConfig = default(PlatformConfigAndroid);
			SetDefaultConfig_ANDROID(ref platformConfig);
			return platformConfig;
		}
	}

	protected class NativeMethods
	{
		internal static void criAtomExAsrRack_SetDefaultConfig_ANDROID_Macro(ref PlatformConfigAndroid config)
		{
		}
	}

	public const int defaultRackId = 0;

	public const int IllegalRackId = -1;

	private int _rackId = -1;

	private bool hasExistingRackId;

	public int rackId => _rackId;

	public static CriAtomExAsrRack Default { get; } = new CriAtomExAsrRack(0);

	[Obsolete("Use CriAtomExAsrRack.Config.Default")]
	public static Config defaultConfig
	{
		get
		{
			Config result = default(Config);
			result.serverFrequency = 60f;
			result.numBuses = 8;
			result.soundRendererType = CriAtomEx.SoundRendererType.Native;
			result.outputRackId = 0;
			result.context = IntPtr.Zero;
			result.speakerMapping = CriAtom.SpeakerMapping.Auto;
			result.outputChannels = 6;
			result.outputSamplingRate = 48000;
			return result;
		}
	}

	public CriAtomExAsrRack(Config config, IPlatformConfig platformConfig)
	{
		IntPtr intPtr = IntPtr.Zero;
		if (platformConfig != null)
		{
			if (!platformConfig.IsSupportedPlatform())
			{
				throw new InvalidOperationException("[CRIWARE] Not Supported PlatfromConfig.");
			}
			intPtr = Marshal.AllocHGlobal(Marshal.SizeOf(platformConfig.GetType()));
			Marshal.StructureToPtr(platformConfig, intPtr, fDeleteOld: false);
			config.context = intPtr;
		}
		_rackId = criAtomExAsrRack_Create(in config, IntPtr.Zero, 0);
		if (intPtr != IntPtr.Zero)
		{
			Marshal.FreeHGlobal(intPtr);
		}
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Atom);
	}

	[Obsolete("Use CriAtomExAsrRack.CriAtomExAsrRack(Config config, IPlatformConfig platformConfig)")]
	public CriAtomExAsrRack(Config config, PlatformConfig platformConfig)
	{
		_rackId = CRIWARE1F7577D1(ref config, ref platformConfig);
		if (config.context != IntPtr.Zero)
		{
			Marshal.FreeHGlobal(config.context);
		}
		if (_rackId == -1)
		{
			throw new Exception("CriAtomExAsrRack() failed.");
		}
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Atom);
	}

	public CriAtomExAsrRack(int existingRackId)
	{
		if (existingRackId == -1)
		{
			throw new Exception("Illegal rack id.");
		}
		_rackId = existingRackId;
		hasExistingRackId = true;
		if (existingRackId != 0)
		{
			CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Atom);
		}
	}

	public void AttachDspBusSetting(string settingName)
	{
		criAtomExAsrRack_AttachDspBusSetting(rackId, settingName, IntPtr.Zero, 0);
	}

	public void DetachDspBusSetting()
	{
		criAtomExAsrRack_DetachDspBusSetting(rackId);
	}

	public void ApplyDspBusSnapshot(string snapshotName, int timeMs)
	{
		criAtomExAsrRack_ApplyDspBusSnapshot(rackId, snapshotName, timeMs);
	}

	public static string GetAppliedDspBusSnapshotName(int rackId)
	{
		IntPtr intPtr = criAtomExAsrRack_GetAppliedDspBusSnapshotName(rackId);
		if (intPtr == IntPtr.Zero)
		{
			return null;
		}
		return Marshal.PtrToStringAnsi(intPtr);
	}

	public string GetAppliedDspBusSnapshotName()
	{
		IntPtr intPtr = criAtomExAsrRack_GetAppliedDspBusSnapshotName(rackId);
		if (intPtr == IntPtr.Zero)
		{
			return null;
		}
		return Marshal.PtrToStringAnsi(intPtr);
	}

	public PerformanceInfo GetPerformanceInfo()
	{
		PerformanceInfo perfInfo = default(PerformanceInfo);
		if (_rackId < 0)
		{
			Debug.LogError("[CRIWARE] This ASR Rack is not initialized.");
			return perfInfo;
		}
		criAtomExAsrRack_GetPerformanceInfo(_rackId, out perfInfo);
		return perfInfo;
	}

	public static PerformanceInfo GetPerformanceInfoByRackId(int rackId = 0)
	{
		PerformanceInfo perfInfo = default(PerformanceInfo);
		criAtomExAsrRack_GetPerformanceInfo(rackId, out perfInfo);
		return perfInfo;
	}

	public void ResetPerformanceMonitor()
	{
		criAtomExAsrRack_ResetPerformanceMonitor(_rackId);
	}

	public static void ResetPerformanceMonitorByRackId(int rackId = 0)
	{
		criAtomExAsrRack_ResetPerformanceMonitor(rackId);
	}

	public static void SetAisacControl(int rackId, string controlName, float value)
	{
		criAtomExAsrRack_SetAisacControlByName(rackId, controlName, value);
	}

	public static void SetAisacControl(int rackId, int controlId, float value)
	{
		criAtomExAsrRack_SetAisacControlById(rackId, (ushort)controlId, value);
	}

	public static void SetDefaultConfig(ref Config config)
	{
		CRIWARED7579187(ref config);
	}

	public override void Dispose()
	{
		if (rackId != 0)
		{
			CriDisposableObjectManager.Unregister(this);
			if (_rackId != -1 && !hasExistingRackId)
			{
				criAtomExAsrRack_Destroy(_rackId);
			}
			_rackId = -1;
		}
		GC.SuppressFinalize(this);
	}

	public static void GetNumRenderedSamples(int rackId, out long numSamples, out int samplingRate)
	{
		numSamples = -1L;
		samplingRate = -1;
		criAtomExAsrRack_GetNumRenderedSamples(rackId, ref numSamples, ref samplingRate);
	}

	public static int GetAmbisonicRackId()
	{
		return criAtomExAsrRack_GetAmbisonicRackId();
	}

	public static int GetChannelBasedAudioRackId()
	{
		return criAtomExAsrRack_GetChannelBasedAudioRackId();
	}

	public static int GetObjectBasedAudioRackId()
	{
		return criAtomExAsrRack_GetObjectBasedAudioRackId();
	}

	public static int GetPassThroughRackId()
	{
		return criAtomExAsrRack_GetPassThroughRackId();
	}

	~CriAtomExAsrRack()
	{
		Dispose();
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAsrRack_Create(in Config config, IntPtr work, int work_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int CRIWARE1F7577D1([In] ref Config config, [In] ref PlatformConfig platformConfig);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsrRack_Destroy(int rackId);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsrRack_AttachDspBusSetting(int rackId, string setting, IntPtr work, int workSize);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsrRack_DetachDspBusSetting(int rackId);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomExAsrRack_GetAppliedDspBusSnapshotName(int rackId);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsrRack_ApplyDspBusSnapshot(int rackId, string snapshotName, int timeMs);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWARED7579187(ref Config config);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsrRack_GetPerformanceInfo(int rackId, out PerformanceInfo perfInfo);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsrRack_ResetPerformanceMonitor(int rackId);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsrRack_SetAisacControlById(int rackId, ushort controlId, float value);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsrRack_SetAisacControlByName(int rackId, string controlName, float value);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsrRack_GetNumRenderedSamples(int rack_id, ref long num_samples, ref int sampling_rate);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAsrRack_GetAmbisonicRackId();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAsrRack_GetChannelBasedAudioRackId();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAsrRack_GetObjectBasedAudioRackId();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAsrRack_GetPassThroughRackId();

	public static void SetDefaultConfig_ANDROID(ref PlatformConfigAndroid platformConfig)
	{
		NativeMethods.criAtomExAsrRack_SetDefaultConfig_ANDROID_Macro(ref platformConfig);
	}
}
