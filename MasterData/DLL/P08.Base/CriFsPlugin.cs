using System.Runtime.InteropServices;
using CriWare;
using UnityEngine;

public static class CriFsPlugin
{
	private static int initializationCount = 0;

	private static bool isConfigured = false;

	public static int defaultInstallBufferSize = 4194304;

	public static int installBufferSize = defaultInstallBufferSize;

	public static bool isInitialized => initializationCount > 0;

	public static void SetConfigParameters(int num_loaders, int num_binders, int num_installers, int argInstallBufferSize, int max_path, bool minimize_file_descriptor_usage, bool enable_crc_check)
	{
		CRIWAREACF30831(num_loaders, num_binders, num_installers, max_path, minimize_file_descriptor_usage, enable_crc_check);
		installBufferSize = argInstallBufferSize;
		isConfigured = true;
	}

	public static void SetReadDeviceEnabled(int deviceId, bool enabled)
	{
		if (deviceId == 0 && !enabled)
		{
			Debug.LogError("[CRIWARE] Read Device 0 should never be disabled.");
		}
		else
		{
			criFs_SetReadDeviceEnabled(deviceId, enabled);
		}
	}

	public static void SetConfigAdditionalParameters_EDITOR(int additionalLoaders)
	{
	}

	public static void SetConfigAdditionalParameters_ANDROID(int device_read_bps)
	{
	}

	public static void SetMemoryFileSystemThreadPriorityExperimentalAndroid(int prio)
	{
	}

	public static void SetDataDecompressionThreadPriorityExperimentalAndroid(int prio)
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
				Debug.Log("[CRIWARE] FileSystem initialization parameters are not configured. Initializes FileSystem by default parameters.");
			}
			CRIWARE8BE8B0FD();
		}
	}

	public static bool IsLibraryInitialized()
	{
		return CRIWARE7F5CF698();
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
			CriFsServer.DestroyInstance();
			installBufferSize = defaultInstallBufferSize;
			CriDisposableObjectManager.CallOnModuleFinalization(CriDisposableObjectManager.ModuleType.Fs);
			CRIWARE47645696();
		}
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWAREACF30831(int num_loaders, int num_binders, int num_installers, int max_path, bool minimize_file_descriptor_usage, bool enable_crc_check);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWARE8BE8B0FD();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern bool CRIWARE7F5CF698();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void CRIWARE47645696();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern uint CRIWARE73E26CCB();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern uint criFsLoader_GetRetryCount();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFs_SetReadDeviceEnabled(int device_id, bool enabled);
}
