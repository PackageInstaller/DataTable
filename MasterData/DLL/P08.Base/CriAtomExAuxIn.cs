using System;
using System.Runtime.InteropServices;

public class CriAtomExAuxIn : CriDisposable
{
	public struct Config
	{
		public int maxChannels;

		public int maxSamplingRate;

		public CriAtomEx.SoundRendererType soundRendererType;

		public static Config Default => new Config
		{
			maxChannels = 2,
			maxSamplingRate = 48000,
			soundRendererType = CriAtomEx.SoundRendererType.Asr
		};
	}

	private const string errorInvalidHandle = "[CRIWARE] Invalid native handle of CriAtomExAuxIn.";

	private IntPtr handle = IntPtr.Zero;

	private CriAudioReadStream inputReadStream;

	public CriAtomExAuxIn(Config? config = null)
	{
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Atom);
		Config config2 = (config.HasValue ? config.Value : Config.Default);
		handle = criAtomAuxIn_Create(ref config2, IntPtr.Zero, 0);
	}

	~CriAtomExAuxIn()
	{
		Dispose();
	}

	public override void Dispose()
	{
		if (handle != IntPtr.Zero)
		{
			criAtomAuxIn_Destroy(handle);
			handle = IntPtr.Zero;
		}
		GC.SuppressFinalize(this);
		CriDisposableObjectManager.Unregister(this);
	}

	public void Start()
	{
		criAtomAuxIn_Start(handle);
	}

	public void Stop()
	{
		if (!(handle == IntPtr.Zero))
		{
			criAtomAuxIn_Stop(handle);
		}
	}

	public void SetFormat(int numChannels, int samplingRate)
	{
		criAtomAuxIn_SetFormat(handle, numChannels, samplingRate);
	}

	public void GetFormat(out int numChannels, out int samplingRate)
	{
		criAtomAuxIn_GetFormat(handle, out numChannels, out samplingRate);
	}

	public void SetVolume(float volume)
	{
		criAtomAuxIn_SetVolume(handle, volume);
	}

	public void SetFrequencyRatio(float frequencyRatio)
	{
		criAtomAuxIn_SetFrequencyRatio(handle, frequencyRatio);
	}

	public void SetBusSendLevel(string busName, float level)
	{
		criAtomAuxIn_SetBusSendLevelByName(handle, busName, level);
	}

	public void SetInputReadStream(CriAudioReadStream stream)
	{
		inputReadStream = stream;
		criAtomAuxIn_SetInputReadStream(handle, stream.callbackFunction, stream.callbackPointer);
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomAuxIn_Create([In] ref Config config, IntPtr work, int work_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomAuxIn_Destroy(IntPtr aux_in);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomAuxIn_Start(IntPtr aux_in);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomAuxIn_Stop(IntPtr aux_in);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomAuxIn_SetVolume(IntPtr aux_in, float volume);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomAuxIn_SetFrequencyRatio(IntPtr aux_in, float ratio);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomAuxIn_SetBusSendLevelByName(IntPtr aux_in, string bus_name, float level);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomAuxIn_SetFormat(IntPtr aux_in, int num_channels, int sampling_rate);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomAuxIn_GetFormat(IntPtr aux_in, out int num_channels, out int sampling_rate);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomAuxIn_SetInputReadStream(IntPtr aux_in, IntPtr stream_cbfunc, IntPtr stream_ptr);
}
