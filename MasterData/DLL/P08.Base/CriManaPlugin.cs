using System;
using System.Reflection;
using System.Runtime.InteropServices;
using CriMana;
using CriMana.Detail;
using CriWare;
using UnityEngine;
using UnityEngine.Rendering;

public class CriManaPlugin
{
	private static int initializationCount = 0;

	private static bool isConfigured = false;

	private static bool enabledMultithreadedRendering = false;

	public static int renderingEventOffset = 1129775104;

	public static bool isInitialized => initializationCount > 0;

	public static bool isMultithreadedRenderingEnabled => enabledMultithreadedRendering;

	public static event Action OnBeforeInitialize = null;

	public static event Action OnInitialized = null;

	public static event Action OnBeforeFinalize = null;

	public static event Action OnFinalized = null;

	public static void SetConfigParameters(bool graphicsMultiThreaded, int num_decoders, int max_num_of_entries)
	{
		GraphicsDeviceType graphicsDeviceType = SystemInfo.graphicsDeviceType;
		enabledMultithreadedRendering = graphicsMultiThreaded;
		Common.criWareUnity_SetRenderingEventOffsetForMana(renderingEventOffset);
		CRIWARE8D1D64BA((int)graphicsDeviceType, enabledMultithreadedRendering, num_decoders, max_num_of_entries);
		isConfigured = true;
	}

	private static void SetupVp9()
	{
		Type vp9ExpansionClass = GetVp9ExpansionClass();
		if (vp9ExpansionClass == null)
		{
			return;
		}
		if (!IsVp9CodecSupported())
		{
			Debug.Log("[CRIWARE] VP9 video playback is not supported on the current platform.");
			return;
		}
		MethodInfo method = vp9ExpansionClass.GetMethod("SetupVp9Decoder");
		if (method == null)
		{
			Debug.LogError("[CRIWARE] ERROR: CriManaVp9.SetupVp9Decoder method is not found.");
		}
		else
		{
			method.Invoke(null, null);
		}
	}

	private static void SetupAV1()
	{
		Type aV1ExpansionClass = GetAV1ExpansionClass();
		if (aV1ExpansionClass == null)
		{
			return;
		}
		if (!IsAV1CodecSupported())
		{
			Debug.Log("[CRIWARE] AV1 video playback is not supported on the current platform.");
			return;
		}
		MethodInfo method = aV1ExpansionClass.GetMethod("SetupAV1Decoder");
		if (method == null)
		{
			Debug.LogError("[CRIWARE] ERROR: CriManaAV1.SetupAV1Decoder method is not found.");
		}
		else
		{
			method.Invoke(null, null);
		}
	}

	[Obsolete("Use CriWareVITA.EnableH264Playback and CriWareVITA.SetH264DecoderMaxSize instead.")]
	public static void SetConfigAdditonalParameters_VITA(bool use_h264_playback, int width, int height)
	{
	}

	public static void SetConfigAdditonalParameters_PC(bool use_h264_playback)
	{
		CRIWARE490C288F(use_h264_playback);
	}

	public static void UseLegacyDecoder_PC(bool useLegacyDecoder)
	{
		criManaUnity_UseLegacyDecoder_PC(useLegacyDecoder);
	}

	public static bool IsLegacyDecoderUsed_PC()
	{
		return criManaUnity_IsLegacyDecoderUsed_PC();
	}

	public static void SetConfigAdditonalParameters_ANDROID(bool enable_buffer_output_for_h264, bool enable_buffer_output_for_vp9)
	{
	}

	public static void SetConfigAdditonalParameters_WEBGL(string webworkerPath, uint heapSize)
	{
	}

	public static void InitializeLibrary()
	{
		Common.CheckBinaryVersionCompatibility();
		initializationCount++;
		if (initializationCount == 1)
		{
			if (IsLibraryInitialized())
			{
				FinalizeLibrary();
				initializationCount = 1;
			}
			if (!isConfigured)
			{
				Debug.Log("[CRIWARE] Mana initialization parameters are not configured. Initializes Mana by default parameters.");
			}
			CriFsPlugin.InitializeLibrary();
			CriAtomPlugin.InitializeLibrary();
			OnBeforeInitialize?.Invoke();
			CRIWARED28A46EF();
			OnInitialized?.Invoke();
			OnInitialized = null;
			AutoResisterRendererResourceFactories.InvokeAutoRegister();
		}
	}

	public static bool IsLibraryInitialized()
	{
		return CRIWARE95583339();
	}

	public static void FinalizeLibrary()
	{
		initializationCount--;
		if (initializationCount < 0)
		{
			initializationCount = 0;
			if (!IsLibraryInitialized())
			{
				return;
			}
		}
		if (initializationCount == 0)
		{
			CriDisposableObjectManager.CallOnModuleFinalization(CriDisposableObjectManager.ModuleType.Mana);
			OnBeforeFinalize?.Invoke();
			CRIWAREB8B70514();
			OnFinalized?.Invoke();
			OnFinalized = null;
			RendererResourceFactory.DisposeAllFactories();
			CriAtomPlugin.FinalizeLibrary();
			CriFsPlugin.FinalizeLibrary();
		}
	}

	public static bool IsCodecSupported(CodecType codecType)
	{
		switch (codecType)
		{
		case CodecType.SofdecPrime:
			return true;
		case CodecType.VP9:
			return IsVp9CodecSupported();
		case CodecType.H264:
			return IsH264CodecSupported();
		case CodecType.AV1:
			return IsAV1CodecSupported();
		default:
			Debug.LogError("[CRIWARE] Invalid format " + codecType.ToString() + " is specified to CriManaPlugin.IsCodecSupported.");
			return false;
		}
	}

	private static Type GetVp9ExpansionClass()
	{
		Type type = Type.GetType("CriManaVp9");
		if (type == null)
		{
			type = Type.GetType("CriWare.CriManaVp9, CriMw.CriWare.Vp9.Runtime");
		}
		return type;
	}

	private static Type GetAV1ExpansionClass()
	{
		Type type = Type.GetType("CriManaAV1");
		if (type == null)
		{
			type = Type.GetType("CriWare.CriManaAV1, CriMw.CriWare.AV1.Runtime");
		}
		return type;
	}

	private static bool IsAV1CodecSupported()
	{
		Type aV1ExpansionClass = GetAV1ExpansionClass();
		if (aV1ExpansionClass == null)
		{
			return false;
		}
		MethodInfo method = aV1ExpansionClass.GetMethod("SupportCurrentPlatform");
		if (method == null)
		{
			Debug.Log("function not found");
			return false;
		}
		return (bool)method.Invoke(null, null);
	}

	private static bool IsVp9CodecSupported()
	{
		Type vp9ExpansionClass = GetVp9ExpansionClass();
		if (vp9ExpansionClass == null)
		{
			return false;
		}
		MethodInfo method = vp9ExpansionClass.GetMethod("SupportCurrentPlatform");
		if (method == null)
		{
			Debug.Log("function not found");
			return false;
		}
		return (bool)method.Invoke(null, null);
	}

	private static bool IsH264CodecSupported()
	{
		return true;
	}

	public static void SetDecodeThreadPriorityAndroidExperimental(int prio)
	{
	}

	public static bool ShouldSampleRed(GraphicsDeviceType type, IntPtr tex_ptr)
	{
		return false;
	}

	public static void UseStreamerManager(bool flag)
	{
		criMana_UseStreamerManager(flag);
	}

	public static bool IsStreamerManagerUsed()
	{
		return criMana_IsStreamerManagerUsed();
	}

	public static void Lock()
	{
		CRIWARE0A412D8D();
	}

	public static void Unlock()
	{
		CRIWARE0ADE1674();
	}

	public static uint GetPrimeBufferAlignmentSize()
	{
		return CRIWARE9855F0DD();
	}

	public static bool AnalyzeMovieHeader(IntPtr data, out MovieInfo movieInfo)
	{
		movieInfo = new MovieInfo();
		return CRIWAREF7BE40E3(data, movieInfo);
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWARE8D1D64BA(int graphics_api, bool graphics_multi_threaded, int num_decoders, int num_of_max_entries);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWARED28A46EF();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern bool CRIWARE95583339();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWAREB8B70514();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern void CRIWARE8A7CBF13(bool flag);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern void CRIWARE0A412D8D();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern void CRIWARE0ADE1674();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern uint CRIWARE9855F0DD();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern void criMana_UseStreamerManager(bool flag);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern bool criMana_IsStreamerManagerUsed();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern bool CRIWAREF7BE40E3(IntPtr movie_header_ptr, [Out] MovieInfo mvinf);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern uint CRIWAREDEE99E0C();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern void criManaUnity_UseLegacyDecoder_PC(bool enable);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern bool criManaUnity_IsLegacyDecoderUsed_PC();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern void CRIWARE490C288F(bool enable);
}
