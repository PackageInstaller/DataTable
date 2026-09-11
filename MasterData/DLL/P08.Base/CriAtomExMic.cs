using System;
using System.Runtime.InteropServices;
using UnityEngine;

public class CriAtomExMic : CriDisposable
{
	public struct DeviceInfo
	{
		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 1024)]
		public string deviceId;

		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 1024)]
		public string deviceName;

		public uint deviceFlags;

		public int maxChannels;

		public int maxSamplingRate;
	}

	public struct Config
	{
		[MarshalAs(UnmanagedType.LPStr)]
		public string deviceId;

		public uint flags;

		public int numChannels;

		public int samplingRate;

		public uint frameSize;

		public uint bufferingTime;

		public IntPtr context;

		public static Config Default => new Config
		{
			deviceId = null,
			flags = 0u,
			numChannels = 1,
			samplingRate = 44100,
			frameSize = 256u,
			bufferingTime = 50u
		};
	}

	public class Effect
	{
		public IntPtr handle { get; private set; }

		public IntPtr afxInstance { get; private set; }

		public Effect(IntPtr handle, IntPtr afxInstance)
		{
			this.handle = handle;
			this.afxInstance = afxInstance;
		}
	}

	private const string errorInvalidHandle = "[CRIWARE] Invalid native handle of CriAtomMic.";

	private const string errorInvalidBufferLength = "[CRIWARE] Invalid buffer length for CriAtomMic.ReadData.";

	private const string errorInvalidNumBuffers = "[CRIWARE] Number of buffers are not same with channels of CriAtomMic.";

	private const string errorAlreadyInitialized = "[CRIWARE] CriAtomMic module is already initialized.";

	private const string errorNotInitialized = "[CRIWARE] CriAtomMic module is not initialized.";

	private IntPtr handle = IntPtr.Zero;

	private IntPtr[] bufferPointers;

	private GCHandle[] gcHandles;

	private CriAudioWriteStream outputWriteStream;

	private static int _initializationCount;

	public static bool isInitialized { get; private set; }

	public static void InitializeModule()
	{
		_initializationCount++;
		if (_initializationCount <= 1)
		{
			if (isInitialized)
			{
				Debug.LogError("[CRIWARE] CriAtomMic module is already initialized.");
				return;
			}
			criAtomMicUnity_Initialize();
			isInitialized = true;
		}
	}

	public static void FinalizeModule()
	{
		_initializationCount--;
		if (_initializationCount <= 0)
		{
			if (_initializationCount < 0)
			{
				_initializationCount = 0;
			}
			if (!isInitialized)
			{
				Debug.LogError("[CRIWARE] CriAtomMic module is not initialized.");
				return;
			}
			CriDisposableObjectManager.CallOnModuleFinalization(CriDisposableObjectManager.ModuleType.AtomMic);
			criAtomMicUnity_Finalize();
			isInitialized = false;
		}
	}

	public static void SetupOutputCategoryForMic_IOS(bool enable)
	{
	}

	public static DeviceInfo[] GetDevices()
	{
		if (!isInitialized)
		{
			Debug.LogError("[CRIWARE] CriAtomMic module is not initialized.");
			return null;
		}
		int num = criAtomMic_GetNumDevices();
		DeviceInfo[] array = new DeviceInfo[num];
		for (int i = 0; i < num; i++)
		{
			criAtomMic_GetDevice(i, out array[i]);
		}
		return array;
	}

	public static int GetNumDevices()
	{
		return criAtomMic_GetNumDevices();
	}

	public static DeviceInfo? GetDefaultDevice()
	{
		if (!isInitialized)
		{
			Debug.LogError("[CRIWARE] CriAtomMic module is not initialized.");
			return null;
		}
		DeviceInfo info = default(DeviceInfo);
		if (criAtomMic_GetDefaultDevice(out info))
		{
			return info;
		}
		return null;
	}

	public static bool IsFormatSupported(Config config)
	{
		return criAtomMic_IsFormatSupported(ref config);
	}

	public static CriAtomExMic Create(Config? config = null)
	{
		if (!isInitialized)
		{
			Debug.LogError("[CRIWARE] CriAtomMic module is not initialized.");
			return null;
		}
		Config config2 = (config.HasValue ? config.Value : Config.Default);
		IntPtr intPtr = criAtomMic_Create(ref config2, IntPtr.Zero, 0);
		if (intPtr == IntPtr.Zero)
		{
			Debug.LogWarning("Failed to open audio input device.");
			return null;
		}
		return new CriAtomExMic(intPtr);
	}

	private CriAtomExMic(IntPtr handle)
	{
		this.handle = handle;
		int numChannels = GetNumChannels();
		bufferPointers = new IntPtr[numChannels];
		gcHandles = new GCHandle[numChannels];
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.AtomMic);
	}

	~CriAtomExMic()
	{
		Dispose();
	}

	public override void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	private void Dispose(bool disposing)
	{
		CriDisposableObjectManager.Unregister(this);
		if (handle != IntPtr.Zero)
		{
			criAtomMic_Destroy(handle);
			handle = IntPtr.Zero;
		}
	}

	public void Start()
	{
		criAtomMic_Start(handle);
	}

	public void Stop()
	{
		criAtomMic_Stop(handle);
	}

	public int GetNumChannels()
	{
		return criAtomMic_GetNumChannels(handle);
	}

	public int GetSamplingRate()
	{
		return criAtomMic_GetSamplingRate(handle);
	}

	public uint GetNumBufferedSamples()
	{
		return criAtomMic_GetNumBufferedSamples(handle);
	}

	[Obsolete("Use CriWare.CriAtomExMic.GetNumBufferedSamples")]
	public uint GetNumBufferredSamples()
	{
		return GetNumBufferedSamples();
	}

	public bool IsAvailable()
	{
		if (!(handle != IntPtr.Zero))
		{
			return false;
		}
		return criAtomMic_IsAvailable(handle);
	}

	public uint ReadData(float[] bufferMono)
	{
		return ReadData(bufferMono, (uint)bufferMono.Length);
	}

	public uint ReadData(float[] bufferMono, uint numToRead)
	{
		if (outputWriteStream != null)
		{
			return 0u;
		}
		GCHandle gCHandle = GCHandle.Alloc(bufferMono, GCHandleType.Pinned);
		bufferPointers[0] = gCHandle.AddrOfPinnedObject();
		uint result = InternalReadDataFromBufferPointers(numToRead);
		InternalClearBuffers();
		return result;
	}

	public uint ReadData(float[] bufferL, float[] bufferR)
	{
		return ReadData(bufferL, bufferR, (uint)bufferL.Length);
	}

	public uint ReadData(float[] bufferL, float[] bufferR, uint numToRead)
	{
		if (outputWriteStream != null)
		{
			return 0u;
		}
		gcHandles[0] = GCHandle.Alloc(bufferL, GCHandleType.Pinned);
		gcHandles[1] = GCHandle.Alloc(bufferR, GCHandleType.Pinned);
		for (int i = 0; i < bufferPointers.Length; i++)
		{
			bufferPointers[i] = gcHandles[i].AddrOfPinnedObject();
		}
		for (int j = 2; j < bufferPointers.Length; j++)
		{
			bufferPointers[j] = IntPtr.Zero;
		}
		uint result = InternalReadDataFromBufferPointers(numToRead);
		InternalClearBuffers();
		return result;
	}

	public uint ReadData(float[][] buffers)
	{
		int numToRead = buffers[0].Length;
		for (int i = 1; i < bufferPointers.Length; i++)
		{
		}
		return ReadData(buffers, (uint)numToRead);
	}

	public uint ReadData(float[][] buffers, uint numToRead)
	{
		for (int i = 0; i < bufferPointers.Length; i++)
		{
		}
		if (outputWriteStream != null)
		{
			return 0u;
		}
		for (int j = 0; j < bufferPointers.Length; j++)
		{
			gcHandles[j] = GCHandle.Alloc(buffers[j], GCHandleType.Pinned);
			bufferPointers[j] = gcHandles[j].AddrOfPinnedObject();
		}
		uint result = InternalReadDataFromBufferPointers(numToRead);
		InternalClearBuffers();
		return result;
	}

	public void SetOutputWriteStream(CriAudioWriteStream stream)
	{
		outputWriteStream = stream;
		if (stream != null)
		{
			criAtomMic_SetOutputWriteStream(handle, stream.callbackFunction, stream.callbackPointer);
		}
		else
		{
			criAtomMic_SetOutputWriteStream(handle, IntPtr.Zero, IntPtr.Zero);
		}
	}

	public CriAudioReadStream GetOutputReadStream()
	{
		return new CriAudioReadStream(criAtomMic_GetOutputReadStream(), handle);
	}

	public Effect AttachEffect(IntPtr afxInterface, float[] configParameters)
	{
		IntPtr intPtr = criAtomMic_AttachEffect(handle, afxInterface, configParameters, (uint)configParameters.Length, IntPtr.Zero, 0);
		if (intPtr == IntPtr.Zero)
		{
			return null;
		}
		return new Effect(intPtr, criAtomMic_GetEffectInstance(handle, intPtr));
	}

	public void DetachEffect(Effect effect)
	{
		criAtomMic_DetachEffect(handle, effect.handle);
	}

	public void SetEffectParameter(Effect effect, int parameterIndex, float parameterValue)
	{
		criAtomMic_SetEffectParameter(handle, effect.handle, (uint)parameterIndex, parameterValue);
	}

	public float GetEffectParameter(Effect effect, int parameterIndex)
	{
		return criAtomMic_GetEffectParameter(handle, effect.handle, (uint)parameterIndex);
	}

	public void SetEffectBypass(Effect effect, bool bypass)
	{
		criAtomMic_SetEffectBypass(handle, effect.handle, bypass);
	}

	public void UpdateEffectParameters(Effect effect)
	{
		criAtomMic_UpdateEffectParameters(handle, effect.handle);
	}

	private uint InternalReadDataFromBufferPointers(uint numToRead)
	{
		return criAtomMic_ReadData(handle, bufferPointers, numToRead);
	}

	private void InternalClearBuffers()
	{
		for (int i = 0; i < bufferPointers.Length; i++)
		{
			if (gcHandles[i].IsAllocated)
			{
				gcHandles[i].Free();
			}
			bufferPointers[i] = IntPtr.Zero;
		}
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomMicUnity_Initialize();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomMicUnity_Finalize();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomMic_GetNumDevices();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomMic_GetDevice(int index, out DeviceInfo info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomMic_GetDefaultDevice(out DeviceInfo info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomMic_IsFormatSupported([In] ref Config config);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomMic_Create([In] ref Config config, IntPtr work, int work_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomMic_Destroy(IntPtr mic);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomMic_Start(IntPtr mic);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomMic_Stop(IntPtr mic);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomMic_GetNumChannels(IntPtr mic);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomMic_GetSamplingRate(IntPtr mic);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern uint criAtomMic_GetNumBufferedSamples(IntPtr mic);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomMic_IsAvailable(IntPtr mic);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern uint criAtomMic_ReadData(IntPtr mic, IntPtr[] data, uint num_samples);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomMic_SetOutputWriteStream(IntPtr mic, IntPtr stream_cbfunc, IntPtr stream_ptr);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomMic_GetOutputReadStream();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomMic_CalculateWorkSizeForEffect(IntPtr mic, IntPtr afx_interface, float[] config_parameters, uint num_config_parameters);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomMic_AttachEffect(IntPtr mic, IntPtr afx_interface, float[] config_parameters, uint num_config_parameters, IntPtr work, int work_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomMic_DetachEffect(IntPtr mic, IntPtr effect);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomMic_GetEffectInstance(IntPtr mic, IntPtr effect);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomMic_SetEffectBypass(IntPtr mic, IntPtr effect, bool bypass);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomMic_SetEffectParameter(IntPtr mic, IntPtr effect, uint parameter_index, float parameter_value);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern float criAtomMic_GetEffectParameter(IntPtr mic, IntPtr effect, uint parameter_index);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomMic_UpdateEffectParameters(IntPtr mic, IntPtr effect);
}
