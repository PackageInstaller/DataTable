using System;
using System.Runtime.InteropServices;
using AOT;

public class CriAtomExOutputAnalyzer : CriDisposable
{
	public delegate void PcmCaptureCallback(float[] dataL, float[] dataR, int numChannels, int numData);

	public struct Config
	{
		public bool enableLevelmeter;

		public bool enableSpectrumAnalyzer;

		public bool enablePcmCapture;

		public bool enablePcmCaptureCallback;

		public int numSpectrumAnalyzerBands;

		public int numCapturedPcmSamples;
	}

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	protected delegate void InternalPcmCaptureCallback(IntPtr dataL, IntPtr dataR, int numChannels, int numData);

	public const int MaximumSpectrumBands = 512;

	protected IntPtr handle = IntPtr.Zero;

	protected CriAtomExPlayer player;

	protected string busName;

	protected int numBands = 8;

	protected int numCapturedPcmSamples = 4096;

	protected PcmCaptureCallback userPcmCaptureCallback;

	protected float[] dataL;

	protected float[] dataR;

	protected const int pcmCapturerNumMaxData = 512;

	protected static IntPtr InternalCallbackFunctionPointer = IntPtr.Zero;

	protected static InternalPcmCaptureCallback DelegateObject;

	protected static float[] DataL;

	protected static float[] DataR;

	protected static PcmCaptureCallback UserPcmCaptureCallback = null;

	public IntPtr nativeHandle => handle;

	public CriAtomExOutputAnalyzer(Config config)
	{
		InitializeWithConfig(config);
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Atom);
	}

	public override void Dispose()
	{
		Dispose(disposing: true);
	}

	protected void Dispose(bool disposing)
	{
		CriDisposableObjectManager.Unregister(this);
		if (handle != IntPtr.Zero)
		{
			DetachExPlayer();
			DetachDspBus();
			criAtomExOutputAnalyzer_Destroy(handle);
			handle = IntPtr.Zero;
		}
		if (disposing)
		{
			GC.SuppressFinalize(this);
		}
	}

	public bool AttachExPlayer(CriAtomExPlayer player)
	{
		if (player == null || !player.isAvailable || handle == IntPtr.Zero)
		{
			return false;
		}
		DetachExPlayer();
		DetachDspBus();
		criAtomExOutputAnalyzer_AttachExPlayer(handle, player.nativeHandle);
		this.player = player;
		return true;
	}

	public void DetachExPlayer()
	{
		if (player != null && player.isAvailable && !(handle == IntPtr.Zero))
		{
			criAtomExOutputAnalyzer_DetachExPlayer(handle, player.nativeHandle);
			player = null;
		}
	}

	public bool AttachDspBus(string busName)
	{
		if (busName == null || handle == IntPtr.Zero)
		{
			return false;
		}
		DetachExPlayer();
		DetachDspBus();
		criAtomExOutputAnalyzer_AttachDspBusByName(handle, busName);
		this.busName = busName;
		return true;
	}

	public void DetachDspBus()
	{
		if (busName != null && !(handle == IntPtr.Zero))
		{
			criAtomExOutputAnalyzer_DetachDspBusByName(handle, busName);
			busName = null;
		}
	}

	public float GetRms(int channel)
	{
		if ((player == null && busName == null) || handle == IntPtr.Zero)
		{
			return 0f;
		}
		if (player != null && player.GetStatus() != CriAtomExPlayer.Status.Playing && player.GetStatus() != CriAtomExPlayer.Status.Prep)
		{
			return 0f;
		}
		return criAtomExOutputAnalyzer_GetRms(handle, channel);
	}

	public void GetSpectrumLevels(ref float[] levels)
	{
		if ((player != null || busName != null) && !(handle == IntPtr.Zero))
		{
			if (levels == null || levels.Length < numBands)
			{
				levels = new float[numBands];
			}
			Marshal.Copy(criAtomExOutputAnalyzer_GetSpectrumLevels(handle), levels, 0, numBands);
		}
	}

	public void GetPcmData(ref float[] data, int ch)
	{
		if ((player != null || busName != null) && !(handle == IntPtr.Zero))
		{
			if (data == null || data.Length < numCapturedPcmSamples)
			{
				data = new float[numCapturedPcmSamples];
			}
			IntPtr intPtr = criAtomExOutputAnalyzer_GetPcmData(handle, ch);
			if (intPtr != IntPtr.Zero)
			{
				Marshal.Copy(intPtr, data, 0, numCapturedPcmSamples);
			}
		}
	}

	public void SetPcmCaptureCallback(PcmCaptureCallback callback)
	{
		userPcmCaptureCallback = callback;
	}

	public void ExecutePcmCaptureCallback()
	{
		if (InternalCallbackFunctionPointer == IntPtr.Zero)
		{
			DelegateObject = Callback;
			InternalCallbackFunctionPointer = Marshal.GetFunctionPointerForDelegate(DelegateObject);
		}
		UserPcmCaptureCallback = userPcmCaptureCallback;
		DataL = dataL;
		DataR = dataR;
		criAtomExOutputAnalyzer_ExecuteQueuedPcmCapturerCallbacks(handle, InternalCallbackFunctionPointer);
		UserPcmCaptureCallback = null;
		DataL = null;
		DataR = null;
	}

	[Obsolete("Use SetPcmCaptureCallback(PcmCaptureCallback) and ExecutePcmCaptureCallback()")]
	public void ExecutePcmCaptureCallback(PcmCaptureCallback callback)
	{
		userPcmCaptureCallback = callback;
		ExecutePcmCaptureCallback();
	}

	protected CriAtomExOutputAnalyzer()
	{
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Atom);
	}

	~CriAtomExOutputAnalyzer()
	{
		Dispose(disposing: false);
	}

	protected void InitializeWithConfig(Config config)
	{
		handle = criAtomExOutputAnalyzer_Create(ref config);
		if (handle == IntPtr.Zero)
		{
			throw new Exception("criAtomExOutputAnalyzer_Create() failed.");
		}
		numBands = config.numSpectrumAnalyzerBands;
		numCapturedPcmSamples = config.numCapturedPcmSamples;
		if (config.enablePcmCaptureCallback && dataL == null)
		{
			dataL = new float[512];
			dataR = new float[512];
		}
	}

	[MonoPInvokeCallback(typeof(InternalPcmCaptureCallback))]
	private static void Callback(IntPtr ptrL, IntPtr ptrR, int numChannels, int numData)
	{
		if (DataL != null)
		{
			Marshal.Copy(ptrL, DataL, 0, numData);
			if (numChannels > 1)
			{
				Marshal.Copy(ptrR, DataR, 0, numData);
			}
			if (UserPcmCaptureCallback != null)
			{
				UserPcmCaptureCallback(DataL, DataR, numChannels, numData);
			}
		}
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	protected static extern IntPtr criAtomExOutputAnalyzer_Create([In] ref Config config);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	protected static extern void criAtomExOutputAnalyzer_Destroy(IntPtr analyzer);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	protected static extern void criAtomExOutputAnalyzer_AttachExPlayer(IntPtr analyzer, IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	protected static extern void criAtomExOutputAnalyzer_DetachExPlayer(IntPtr analyzer, IntPtr player);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	protected static extern void criAtomExOutputAnalyzer_AttachDspBusByName(IntPtr analyzer, string busName);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	protected static extern void criAtomExOutputAnalyzer_DetachDspBusByName(IntPtr analyzer, string busName);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	protected static extern float criAtomExOutputAnalyzer_GetRms(IntPtr analyzer, int channel);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	protected static extern IntPtr criAtomExOutputAnalyzer_GetSpectrumLevels(IntPtr analyzer);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	protected static extern IntPtr criAtomExOutputAnalyzer_GetPcmData(IntPtr analyzer, int ch);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	protected static extern void criAtomExOutputAnalyzer_ExecuteQueuedPcmCapturerCallbacks(IntPtr analyzer, IntPtr callback);
}
