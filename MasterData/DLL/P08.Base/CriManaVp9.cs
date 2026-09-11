using System;
using System.Runtime.InteropServices;
using UnityEngine;
using UnityEngine.Scripting;

public static class CriManaVp9
{
	private const string scriptVersionString = "1.01.14";

	public const string cri_mana_vp9_name = "cri_mana_vpx";

	[Preserve]
	public static bool SupportCurrentPlatform()
	{
		return true;
	}

	[Preserve]
	public static void SetupVp9Decoder()
	{
		if (CriManaPlugin.IsLibraryInitialized())
		{
			Debug.LogError("[CRIWARE][VP9] Mana library is already initialized.");
			return;
		}
		IntPtr alloc_func = criWareUnity_GetAllocateFunc();
		IntPtr free_func = criWareUnity_GetDeallocateFunc();
		IntPtr usr_obj = criManaUnity_GetAllocatorManager();
		criVvp9_SetUserAllocator(alloc_func, free_func, usr_obj);
		IntPtr codec_if = criVvp9_GetInterface();
		IntPtr codecalpha_if = criVvp9_GetAlphaInterface();
		criMvPly_AttachCodecInterface(9, codec_if, codecalpha_if);
	}

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterAssembliesLoaded)]
	private static void RegisterVp9DecoderSetup()
	{
		CriManaPlugin.OnBeforeInitialize += SetupVp9Decoder;
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criWareUnity_GetAllocateFunc();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criWareUnity_GetDeallocateFunc();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criManaUnity_GetAllocatorManager();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criMvPly_AttachCodecInterface(int codec_type, IntPtr codec_if, IntPtr codecalpha_if);

	[DllImport("cri_mana_vpx", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criVvp9_SetUserAllocator(IntPtr alloc_func, IntPtr free_func, IntPtr usr_obj);

	[DllImport("cri_mana_vpx", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criVvp9_GetInterface();

	[DllImport("cri_mana_vpx", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criVvp9_GetAlphaInterface();
}
