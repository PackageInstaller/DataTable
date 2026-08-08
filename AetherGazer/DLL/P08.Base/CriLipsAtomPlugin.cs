using System;
using System.Runtime.InteropServices;

public static class CriLipsAtomPlugin
{
	public const string pluginName = "cri_lips_unity";

	public const CallingConvention pluginCallingConvention = CallingConvention.Cdecl;

	private static int initializationCount;

	public static bool isInitialized => initializationCount > 0;

	public static void InitializeLibrary(uint maxHandles = 8u)
	{
		initializationCount++;
		if (initializationCount == 1)
		{
			if (IsLibraryInitialized())
			{
				FinalizeLibrary();
				initializationCount = 1;
			}
			CriAtomPlugin.InitializeLibrary();
			CriLipsPlugin.InitializeLibrary();
			criLipsAtom_SetExternalBridgeInterface(criAtomEx_GetLipsAtomBridgeInterface(), criBase_GetLipsBaseBridgeInterface());
			criLipsAtomUnity_Initialize(maxHandles);
		}
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
			CriDisposableObjectManager.DisposeAll(CriDisposableObjectManager.ModuleType.Lips);
			criLipsAtomUnity_Finalize();
			CriAtomPlugin.FinalizeLibrary();
		}
	}

	public static uint GetMemoryUsage()
	{
		return criLipsAtomUnity_GetAllocatedHeapSize();
	}

	public static void AttachAnalyzerToPlayer(CriAtomExPlayer player, CriLipsAtomAnalyzer analyzer)
	{
		if (player != null && player.isAvailable && analyzer != null && analyzer.isAvailable)
		{
			criLipsAtom_AttachAnalyzerToPlayer(player.nativeHandle, analyzer.nativeHandle);
		}
	}

	public static bool IsAnalyzerAttachedToPlayer(CriLipsAtomAnalyzer analyzer)
	{
		return criLipsAtom_IsAnalyzerAttachedToPlayer(analyzer.nativeHandle) != 0;
	}

	public static void DetachAnalyzerFromPlayer(CriAtomExPlayer player, CriLipsAtomAnalyzer analyzer)
	{
		if (player == null || !player.isAvailable)
		{
			DetachAnalyzerFromInvalidPlayer(analyzer);
		}
		else if (analyzer != null && analyzer.isAvailable)
		{
			criLipsAtom_DetachAnalyzerFromPlayer(player.nativeHandle, analyzer.nativeHandle);
		}
	}

	public static void DetachAnalyzerFromInvalidPlayer(CriLipsAtomAnalyzer analyzer)
	{
		if (analyzer != null && analyzer.isAvailable)
		{
			criLipsAtom_DetachAnalyzerFromInvalidPlayer(analyzer.nativeHandle);
		}
	}

	public static bool IsLibraryInitialized()
	{
		return criLipsAtomUnity_IsInitialized();
	}

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criLipsAtom_SetExternalBridgeInterface(IntPtr atom_bridge, IntPtr base_bridge);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomEx_GetLipsAtomBridgeInterface();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criBase_GetLipsBaseBridgeInterface();

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criLipsAtomUnity_Initialize(uint maxHandles);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criLipsAtomUnity_IsInitialized();

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criLipsAtomUnity_Finalize();

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern uint criLipsAtomUnity_GetAllocatedHeapSize();

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criLipsAtom_AttachAnalyzerToPlayer(IntPtr player, IntPtr analyzer);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criLipsAtom_IsAnalyzerAttachedToPlayer(IntPtr analyzer);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criLipsAtom_DetachAnalyzerFromPlayer(IntPtr player, IntPtr analyzer);

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criLipsAtom_DetachAnalyzerFromInvalidPlayer(IntPtr analyzer);
}
