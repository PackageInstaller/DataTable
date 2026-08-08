using System;
using System.Runtime.InteropServices;

public class CriLipsMouth : CriDisposable, ICriLipsAnalyzeModule
{
	public enum MorphTargetType
	{
		Japanese_AIUEO,
		MAX_NUM
	}

	public enum BehaviourParamsPreset
	{
		Default,
		NoBlend
	}

	public struct Info
	{
		public float lipWidth;

		public float lipHeight;

		public float tonguePosition;

		private bool isLipWidthReleased;

		private bool isLipHeightReleased;

		private bool isLipToungueReleased;
	}

	public struct MorphTargetBlendAmountAsJapanese
	{
		public float a;

		public float i;

		public float u;

		public float e;

		public float o;
	}

	public struct OpenInfo
	{
		public float openY;
	}

	private bool hasExistingNativeHandle;

	private IntPtr handle = IntPtr.Zero;

	public IntPtr nativeHandle => handle;

	public bool isAvailable => handle != IntPtr.Zero;

	public float GetSilenceThreshold()
	{
		return criwareLLipsMouth_GetSilenceThreshold(handle);
	}

	public void GetInfo(out Info info)
	{
		info = default(Info);
		criwareLLipsMouth_GetInfo(handle, ref info);
	}

	public void GetMorphTargetBlendAmountAsJapanese(out MorphTargetBlendAmountAsJapanese morph)
	{
		morph = default(MorphTargetBlendAmountAsJapanese);
		criwareLLipsMouth_GetMorphTargetBlendAmountJapanese(handle, ref morph);
	}

	public void GetOpenInfo(out OpenInfo openInfo)
	{
		openInfo = default(OpenInfo);
		criwareLLipsMouth_GetOpenInfo(handle, ref openInfo);
	}

	public static void ConvertMorphTargetBlendAmountToArray(MorphTargetBlendAmountAsJapanese inputMorph, float[] outputArray)
	{
		outputArray[0] = inputMorph.a;
		outputArray[1] = inputMorph.i;
		outputArray[2] = inputMorph.u;
		outputArray[3] = inputMorph.e;
		outputArray[4] = inputMorph.o;
	}

	public static void ConvertArrayToMorphTargetBlendAmount(float[] inputArray, ref MorphTargetBlendAmountAsJapanese outputMorph)
	{
		outputMorph.a = inputArray[0];
		outputMorph.i = inputArray[1];
		outputMorph.u = inputArray[2];
		outputMorph.e = inputArray[3];
		outputMorph.o = inputArray[4];
	}

	public float GetVolume()
	{
		return criwareLLipsMouth_GetVolumeDecibel(handle);
	}

	public void GetInfoAtSilence(out Info info)
	{
		info = default(Info);
		criwareLLipsMouth_GetInfoAtSilence(handle, ref info);
	}

	public bool IsAtSilence()
	{
		return criwareLLipsMouth_IsAtSilence(handle);
	}

	public bool IsAtSilenceForMouthOpen()
	{
		return criwareLLipsMouth_IsAtSilenceForMouthOpen(handle);
	}

	public bool IsMorphTargetBlendAmountInterpolative()
	{
		return criwareLLipsMouth_IsMorphTargetBlendAmountInterpolative(handle);
	}

	public override void Dispose()
	{
		CriDisposableObjectManager.Unregister(this);
		if (!hasExistingNativeHandle && handle != IntPtr.Zero)
		{
			criwareLLipsMouth_Destroy(handle);
		}
		handle = IntPtr.Zero;
		GC.SuppressFinalize(this);
	}

	public CriLipsMouth(IntPtr existingNativeHandle)
	{
		if (!CriLipsAtomPlugin.IsLibraryInitialized())
		{
			throw new Exception("CriLipsAtomPlugin is not initialized.");
		}
		hasExistingNativeHandle = existingNativeHandle != IntPtr.Zero;
		if (!hasExistingNativeHandle)
		{
			throw new Exception("Null handle was set for CriLipsMouth.");
		}
		handle = existingNativeHandle;
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Lips);
	}

	~CriLipsMouth()
	{
		Dispose();
	}

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criwareLLipsMouth_Destroy(IntPtr mouth);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern float criwareLLipsMouth_GetSilenceThreshold(IntPtr mouth);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criwareLLipsMouth_GetInfo(IntPtr mouth, ref Info info);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern float criwareLLipsMouth_GetVolumeDecibel(IntPtr mouth);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criwareLLipsMouth_GetMorphTargetBlendAmountJapanese(IntPtr mouth, ref MorphTargetBlendAmountAsJapanese blend_amount);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criwareLLipsMouth_GetOpenInfo(IntPtr mouth, ref OpenInfo openInfo);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criwareLLipsMouth_IsAtSilence(IntPtr mouth);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criwareLLipsMouth_IsAtSilenceForMouthOpen(IntPtr mouth);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criwareLLipsMouth_IsMorphTargetBlendAmountInterpolative(IntPtr mouth);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criwareLLipsMouth_GetInfoAtSilence(IntPtr mouth, ref Info info);
}
