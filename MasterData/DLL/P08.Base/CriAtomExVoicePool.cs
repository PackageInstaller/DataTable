using System;
using System.Runtime.InteropServices;

public abstract class CriAtomExVoicePool : CriDisposable
{
	public enum VoicePoolId
	{
		StandardMemory = 0,
		StandardStreaming = 1,
		HcaMxMemory = 4,
		HcaMxStreaming = 5
	}

	public enum PitchShifterMode
	{
		Music,
		Vocal,
		SoundEffect,
		Speech
	}

	public struct UsedVoicesInfo
	{
		public int numUsedVoices;

		public int numPoolVoices;
	}

	public struct PlayerConfig
	{
		public int maxChannels;

		public int maxSamplingRate;

		public bool streamingFlag;

		public int soundRendererType;

		public int decodeLatency;

		private IntPtr context;
	}

	private struct PitchShifterConfig
	{
		public int mode;

		public int windowSize;

		public int overlapTimes;
	}

	private struct ExPitchShifterConfig
	{
		public int numDsp;

		public int maxChannels;

		public int maxSamplingRate;

		public PitchShifterConfig config;
	}

	private struct TimeStretchConfig
	{
		public int reserved;
	}

	private struct ExTimeStretchConfig
	{
		public int numDsp;

		public int maxChannels;

		public int maxSamplingRate;

		public TimeStretchConfig config;
	}

	public const int StandardMemoryAsrVoicePoolId = 0;

	public const int StandardStreamingAsrVoicePoolId = 1;

	public const int StandardMemoryNsrVoicePoolId = 2;

	public const int StandardStreamingNsrVoicePoolId = 3;

	protected IntPtr _handle = IntPtr.Zero;

	protected uint _identifier;

	protected int _numVoices;

	protected int _maxChannels;

	protected int _maxSamplingRate;

	public IntPtr nativeHandle => _handle;

	public uint identifier => _identifier;

	public int numVoices => _numVoices;

	public int maxChannels => _maxChannels;

	public int maxSamplingRate => _maxSamplingRate;

	public static UsedVoicesInfo GetNumUsedVoices(VoicePoolId voicePoolId)
	{
		UsedVoicesInfo result = default(UsedVoicesInfo);
		CRIWAREA3F8BAA7((int)voicePoolId, out result.numUsedVoices, out result.numPoolVoices);
		return result;
	}

	public override void Dispose()
	{
		CriDisposableObjectManager.Unregister(this);
		if (_handle != IntPtr.Zero)
		{
			criAtomExVoicePool_Free(_handle);
			_handle = IntPtr.Zero;
		}
		GC.SuppressFinalize(this);
	}

	public UsedVoicesInfo GetNumUsedVoices()
	{
		UsedVoicesInfo result = default(UsedVoicesInfo);
		if (_handle != IntPtr.Zero)
		{
			criAtomExVoicePool_GetNumUsedVoices(_handle, out result.numUsedVoices, out result.numPoolVoices);
		}
		else
		{
			result = default(UsedVoicesInfo);
		}
		return result;
	}

	public void AttachDspTimeStretch()
	{
		if (!(_handle == IntPtr.Zero))
		{
			ExTimeStretchConfig config = default(ExTimeStretchConfig);
			config.numDsp = _numVoices;
			config.maxChannels = _maxChannels;
			config.maxSamplingRate = _maxSamplingRate;
			config.config.reserved = 0;
			criAtomExVoicePool_AttachDspTimeStretch(_handle, ref config, IntPtr.Zero, 0);
		}
	}

	public void AttachDspPitchShifter(PitchShifterMode mode = PitchShifterMode.Music, int windosSize = 1024, int overlapTimes = 4)
	{
		if (!(_handle == IntPtr.Zero))
		{
			ExPitchShifterConfig config = default(ExPitchShifterConfig);
			config.numDsp = _numVoices;
			config.maxChannels = _maxChannels;
			config.maxSamplingRate = _maxSamplingRate;
			config.config.mode = (int)mode;
			config.config.windowSize = windosSize;
			config.config.overlapTimes = overlapTimes;
			criAtomExVoicePool_AttachDspPitchShifter(_handle, ref config, IntPtr.Zero, 0);
		}
	}

	public void DetachDsp()
	{
		if (!(_handle == IntPtr.Zero))
		{
			criAtomExVoicePool_DetachDsp(_handle);
		}
	}

	~CriAtomExVoicePool()
	{
		Dispose();
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWAREA3F8BAA7(int voice_pool_id, out int num_used_voices, out int num_pool_voices);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExVoicePool_GetNumUsedVoices(IntPtr pool, out int num_used_voices, out int num_pool_voices);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern void criAtomExVoicePool_Free(IntPtr pool);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExVoicePool_AttachDspTimeStretch(IntPtr pool, ref ExTimeStretchConfig config, IntPtr work, int work_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExVoicePool_AttachDspPitchShifter(IntPtr pool, ref ExPitchShifterConfig config, IntPtr work, int work_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExVoicePool_DetachDsp(IntPtr pool);
}
