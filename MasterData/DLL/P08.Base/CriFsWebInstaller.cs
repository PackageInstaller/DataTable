using System;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Threading;
using UnityEngine;

public class CriFsWebInstaller : CriDisposable
{
	public enum Status
	{
		Stop,
		Busy,
		Complete,
		Error
	}

	public enum Error
	{
		None,
		Timeout,
		Memory,
		LocalFs,
		DNS,
		Connection,
		SSL,
		HTTP,
		Internal
	}

	public struct StatusInfo
	{
		public Status status;

		public Error error;

		public int httpStatusCode;

		public long contentsSize;

		public long receivedSize;
	}

	public struct ModuleConfig
	{
		public uint numInstallers;

		[MarshalAs(UnmanagedType.LPStr)]
		public string proxyHost;

		public ushort proxyPort;

		[MarshalAs(UnmanagedType.LPStr)]
		public string userAgent;

		public uint inactiveTimeoutSec;

		public bool allowInsecureSSL;

		public bool crcEnabled;

		public ModulePlatformConfig platformConfig;
	}

	public struct ModulePlatformConfig
	{
		public byte reserved;

		public static ModulePlatformConfig defaultConfig
		{
			get
			{
				ModulePlatformConfig result = default(ModulePlatformConfig);
				result.reserved = 0;
				return result;
			}
		}
	}

	public const int InvalidHttpStatusCode = -1;

	public const long InvalidContentsSize = -1L;

	private IntPtr handle = IntPtr.Zero;

	public static bool isInitialized { get; private set; }

	public static bool isCrcEnabled { get; private set; }

	public static ModuleConfig defaultModuleConfig
	{
		get
		{
			ModuleConfig result = default(ModuleConfig);
			result.numInstallers = 2u;
			result.proxyHost = null;
			result.proxyPort = 0;
			result.userAgent = null;
			result.inactiveTimeoutSec = 300u;
			result.allowInsecureSSL = false;
			result.crcEnabled = false;
			result.platformConfig = ModulePlatformConfig.defaultConfig;
			return result;
		}
	}

	public CriFsWebInstaller()
	{
		criFsWebInstaller_Create(out handle);
		if (handle == IntPtr.Zero)
		{
			throw new Exception("criFsWebInstaller_Create() failed.");
		}
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.FsWeb);
	}

	~CriFsWebInstaller()
	{
		Dispose(disposing: false);
	}

	public override void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	public void Copy(string url, string dstPath)
	{
		criFsWebInstaller_Copy(handle, url, dstPath);
	}

	public void Stop()
	{
		if (handle != IntPtr.Zero)
		{
			criFsWebInstaller_Stop(handle);
		}
	}

	public StatusInfo GetStatusInfo()
	{
		StatusInfo status = default(StatusInfo);
		if (handle != IntPtr.Zero)
		{
			criFsWebInstaller_GetStatusInfo(handle, out status);
		}
		else
		{
			status.status = Status.Stop;
			status.error = Error.Internal;
			status.httpStatusCode = -1;
			status.contentsSize = -1L;
			status.receivedSize = 0L;
		}
		return status;
	}

	public bool GetCRC32(out uint ret_val)
	{
		return criFsWebInstaller_GetCRC32(handle, out ret_val) == 0;
	}

	public static void InitializeModule(ModuleConfig config)
	{
		if (isInitialized)
		{
			Debug.LogError("[CRIWARE] CriFsWebInstaller module is already initialized.");
			return;
		}
		Type criFsWebInstallerCurlExpansionClass = GetCriFsWebInstallerCurlExpansionClass();
		if (criFsWebInstallerCurlExpansionClass != null)
		{
			MethodInfo method = criFsWebInstallerCurlExpansionClass.GetMethod("SetupCurlContext");
			if (method == null)
			{
				Debug.LogError("[CRIWARE] ERROR: CriFsWebInstallerCurl.SetupCurlContext method is not found.");
			}
			else
			{
				method.Invoke(null, new object[1] { true });
			}
		}
		CriFsPlugin.InitializeLibrary();
		criFsWebInstaller_Initialize(ref config);
		isCrcEnabled = config.crcEnabled;
		isInitialized = true;
	}

	private static Type GetCriFsWebInstallerCurlExpansionClass()
	{
		return Type.GetType("CriWare.CriFsWebInstallerCurl, CriMw.CriWare.FsModuleCurl.Runtime");
	}

	public static void FinalizeModule()
	{
		if (!isInitialized)
		{
			Debug.LogError("[CRIWARE] CriFsWebInstaller module is not initialized.");
			return;
		}
		CriDisposableObjectManager.CallOnModuleFinalization(CriDisposableObjectManager.ModuleType.FsWeb);
		criFsWebInstaller_Finalize();
		CriFsPlugin.FinalizeLibrary();
		isInitialized = false;
	}

	public static void ExecuteMain()
	{
		criFsWebInstaller_ExecuteMain();
	}

	public static bool SetRequestHeader(string field, string value)
	{
		return criFsWebInstaller_SetRequestHeader(field, value) == 0;
	}

	private void Dispose(bool disposing)
	{
		CriDisposableObjectManager.Unregister(this);
		if (!(handle != IntPtr.Zero))
		{
			return;
		}
		if (GetStatusInfo().status != Status.Stop)
		{
			Stop();
			while (true)
			{
				ExecuteMain();
				if (GetStatusInfo().status == Status.Stop)
				{
					break;
				}
				Thread.Sleep(1);
			}
		}
		criFsWebInstaller_Destroy(handle);
		handle = IntPtr.Zero;
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsWebInstaller_Initialize([In] ref ModuleConfig config);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsWebInstaller_Finalize();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsWebInstaller_ExecuteMain();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsWebInstaller_Create(out IntPtr installer);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsWebInstaller_Destroy(IntPtr installer);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsWebInstaller_Copy(IntPtr installer, string url, string dstPath);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsWebInstaller_Stop(IntPtr installer);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsWebInstaller_GetStatusInfo(IntPtr installer, out StatusInfo status);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsWebInstaller_GetCRC32(IntPtr installer, out uint crc32);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsWebInstaller_SetRequestHeader(string field, string value);
}
