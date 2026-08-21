using System;
using System.Runtime.InteropServices;

public class CriAtomExAsr
{
	private struct BusAnalyzerConfig
	{
		public int interval;

		public int peakHoldTime;
	}

	public struct BusAnalyzerInfo
	{
		public int numChannels;

		[MarshalAs(UnmanagedType.ByValArray, SizeConst = 16)]
		public float[] rmsLevels;

		[MarshalAs(UnmanagedType.ByValArray, SizeConst = 16)]
		public float[] peakLevels;

		[MarshalAs(UnmanagedType.ByValArray, SizeConst = 16)]
		public float[] peakHoldLevels;

		public BusAnalyzerInfo(byte[] data)
		{
			if (data != null)
			{
				numChannels = BitConverter.ToInt32(data, 0);
				rmsLevels = new float[16];
				for (int i = 0; i < 16; i++)
				{
					rmsLevels[i] = BitConverter.ToSingle(data, 4 + i * 4);
				}
				peakLevels = new float[16];
				for (int j = 0; j < 16; j++)
				{
					peakLevels[j] = BitConverter.ToSingle(data, 68 + j * 4);
				}
				peakHoldLevels = new float[16];
				for (int k = 0; k < 16; k++)
				{
					peakHoldLevels[k] = BitConverter.ToSingle(data, 132 + k * 4);
				}
			}
			else
			{
				numChannels = 0;
				rmsLevels = new float[16];
				peakLevels = new float[16];
				peakHoldLevels = new float[16];
			}
		}
	}

	public static void AttachBusAnalyzer(string busName, int interval, int peakHoldTime)
	{
		BusAnalyzerConfig config = default(BusAnalyzerConfig);
		config.interval = interval;
		config.peakHoldTime = peakHoldTime;
		criAtomExAsr_AttachBusAnalyzerByName(busName, ref config);
	}

	public static void AttachBusAnalyzer(int interval, int peakHoldTime)
	{
		int num = criAtomExAsrRack_GetNumBuses(0);
		BusAnalyzerConfig config = default(BusAnalyzerConfig);
		config.interval = interval;
		config.peakHoldTime = peakHoldTime;
		for (int i = 0; i < num; i++)
		{
			criAtomExAsr_AttachBusAnalyzer(i, ref config);
		}
	}

	public static void DetachBusAnalyzer(string busName)
	{
		criAtomExAsr_DetachBusAnalyzerByName(busName);
	}

	public static void DetachBusAnalyzer()
	{
		for (int i = 0; i < 8; i++)
		{
			criAtomExAsr_DetachBusAnalyzer(i);
		}
	}

	public static void GetBusAnalyzerInfo(string busName, out BusAnalyzerInfo info)
	{
		using CriStructMemory<BusAnalyzerInfo> criStructMemory = new CriStructMemory<BusAnalyzerInfo>();
		criAtomExAsr_GetBusAnalyzerInfoByName(busName, criStructMemory.ptr);
		info = new BusAnalyzerInfo(criStructMemory.bytes);
	}

	[Obsolete("Use CriAtomExAsr.GetBusAnalyzerInfo(string busName, out BusAnalyzerInfo info)")]
	public static void GetBusAnalyzerInfo(int busId, out BusAnalyzerInfo info)
	{
		using CriStructMemory<BusAnalyzerInfo> criStructMemory = new CriStructMemory<BusAnalyzerInfo>();
		criAtomExAsr_GetBusAnalyzerInfo(busId, criStructMemory.ptr);
		info = new BusAnalyzerInfo(criStructMemory.bytes);
	}

	public static void SetBusVolume(string busName, float volume)
	{
		criAtomExAsr_SetBusVolumeByName(busName, volume);
	}

	[Obsolete("Use CriAtomExAsr.SetBusVolume(string busName, float volume)")]
	public static void SetBusVolume(int busId, float volume)
	{
		criAtomExAsr_SetBusVolume(busId, volume);
	}

	public static void SetBusSendLevel(string busName, string sendTo, float level)
	{
		criAtomExAsr_SetBusSendLevelByName(busName, sendTo, level);
	}

	[Obsolete("Use CriAtomExAsr.SetBusSendLevel(string busName, string sendTo, float level)")]
	public static void SetBusSendLevel(int busId, int sendTo, float level)
	{
		criAtomExAsr_SetBusSendLevel(busId, sendTo, level);
	}

	public static void SetBusMatrix(string busName, int inputChannels, int outputChannels, float[] matrix)
	{
		criAtomExAsr_SetBusMatrixByName(busName, inputChannels, outputChannels, matrix);
	}

	[Obsolete("Use CriAtomExAsr.SetBusMatrix(string busName, int inputChannels, int outputChannels, float[] matrix)")]
	public static void SetBusMatrix(int busId, int inputChannels, int outputChannels, float[] matrix)
	{
		criAtomExAsr_SetBusMatrix(busId, inputChannels, outputChannels, matrix);
	}

	public static void SetEffectBypass(string busName, string effectName, bool bypass)
	{
		criAtomExAsr_SetEffectBypass(busName, effectName, bypass);
	}

	public static void SetEffectParameter(string busName, string effectName, uint parameterIndex, float parameterValue)
	{
		criAtomExAsr_SetEffectParameter(busName, effectName, parameterIndex, parameterValue);
		criAtomExAsr_UpdateEffectParameters(busName, effectName);
	}

	public static float GetEffectParameter(string busName, string effectName, uint parameterIndex)
	{
		return criAtomExAsr_GetEffectParameter(busName, effectName, parameterIndex);
	}

	public static bool RegisterEffectInterface(IntPtr afx_interface)
	{
		return criAtomExAsr_RegisterEffectInterface(afx_interface);
	}

	public static void UnregisterEffectInterface(IntPtr afx_interface)
	{
		criAtomExAsr_UnregisterEffectInterface(afx_interface);
	}

	public static void GetBusVolume(string busName, out float volume)
	{
		criAtomExAsr_GetBusVolumeByName(busName, out volume);
	}

	public static void EnableBinauralizer(bool enabled)
	{
		criAtomExAsr_EnableBinauralizer(enabled);
	}

	public static bool IsEnabledBinauralizer()
	{
		return criAtomExAsr_IsEnabledBinauralizer();
	}

	public static int GetPcmOutput(int outputChannels, int outputSamples, float[][] buffer)
	{
		return 0;
	}

	public static int GetNumBufferedPcmOutputSamples()
	{
		return 0;
	}

	public static void SetPcmBufferSize(int numSamples)
	{
	}

	public static void PauseOutputVoice(bool sw)
	{
		criAtomExAsr_PauseOutputVoice(sw);
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsr_AttachBusAnalyzerByName(string busName, ref BusAnalyzerConfig config);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsr_AttachBusAnalyzer(int busNo, ref BusAnalyzerConfig config);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsr_DetachBusAnalyzerByName(string busName);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsr_DetachBusAnalyzer(int busNo);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsr_GetBusAnalyzerInfoByName(string busName, IntPtr info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsr_GetBusAnalyzerInfo(int busNo, IntPtr info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsr_SetBusVolumeByName(string busName, float volume);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsr_SetBusVolume(int busNo, float volume);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsr_SetBusSendLevelByName(string busName, string sendtoName, float level);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsr_SetBusSendLevel(int busNo, int sendtoNo, float level);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsr_SetBusMatrixByName(string busName, int inputChannels, int outputChannels, [MarshalAs(UnmanagedType.LPArray)] float[] matrix);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsr_SetBusMatrix(int busNo, int inputChannels, int outputChannels, [MarshalAs(UnmanagedType.LPArray)] float[] matrix);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsr_SetEffectBypass(string busName, string effectName, bool bypass);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsr_UpdateEffectParameters(string busName, string effectName);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsr_SetEffectParameter(string busName, string effectName, uint parameterIndex, float parameterValue);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern float criAtomExAsr_GetEffectParameter(string busName, string effectName, uint parameterIndex);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAsr_RegisterEffectInterface(IntPtr afx_interface);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsr_UnregisterEffectInterface(IntPtr afx_interface);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsr_EnableBinauralizer(bool enabled);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAsr_IsEnabledBinauralizer();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsr_PauseOutputVoice(bool sw);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAsrRack_GetNumBuses(int rackId);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAsr_GetBusVolumeByName(string busName, out float volume);
}
