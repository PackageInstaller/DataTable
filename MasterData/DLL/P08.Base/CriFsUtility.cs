using System.Runtime.InteropServices;

public static class CriFsUtility
{
	public const int DefaultReadUnitSize = 1048576;

	public static CriFsLoadFileRequest LoadFile(string path, int readUnitSize = 1048576)
	{
		return CriFsServer.instance.LoadFile(null, path, null, readUnitSize);
	}

	public static CriFsLoadFileRequest LoadFile(string path, CriFsRequest.DoneDelegate doneDelegate, int readUnitSize = 1048576)
	{
		return CriFsServer.instance.LoadFile(null, path, doneDelegate, readUnitSize);
	}

	public static CriFsLoadFileRequest LoadFile(CriFsBinder binder, string path, int readUnitSize = 1048576)
	{
		return CriFsServer.instance.LoadFile(binder, path, null, readUnitSize);
	}

	public static CriFsLoadAssetBundleRequest LoadAssetBundle(string path, int readUnitSize = 1048576)
	{
		return LoadAssetBundle(null, path, readUnitSize);
	}

	public static CriFsLoadAssetBundleRequest LoadAssetBundle(CriFsBinder binder, string path, int readUnitSize = 1048576)
	{
		return CriFsServer.instance.LoadAssetBundle(binder, path, readUnitSize);
	}

	public static CriFsInstallRequest Install(string srcPath, string dstPath)
	{
		return Install(null, srcPath, dstPath, null);
	}

	public static CriFsInstallRequest Install(string srcPath, string dstPath, CriFsRequest.DoneDelegate doneDeleagate)
	{
		return Install(null, srcPath, dstPath, doneDeleagate);
	}

	public static CriFsInstallRequest Install(CriFsBinder srcBinder, string srcPath, string dstPath)
	{
		return CriFsServer.instance.Install(srcBinder, srcPath, dstPath, null);
	}

	public static CriFsInstallRequest Install(CriFsBinder srcBinder, string srcPath, string dstPath, CriFsRequest.DoneDelegate doneDeleagate)
	{
		return CriFsServer.instance.Install(srcBinder, srcPath, dstPath, doneDeleagate);
	}

	public static CriFsInstallRequest WebInstall(string srcPath, string dstPath, CriFsRequest.DoneDelegate doneDeleagate)
	{
		return CriFsServer.instance.WebInstall(srcPath, dstPath, doneDeleagate);
	}

	public static CriFsBindRequest BindCpk(CriFsBinder targetBinder, string srcPath)
	{
		return BindCpk(targetBinder, null, srcPath);
	}

	public static CriFsBindRequest BindCpk(CriFsBinder targetBinder, CriFsBinder srcBinder, string srcPath)
	{
		return CriFsServer.instance.BindCpk(targetBinder, srcBinder, srcPath);
	}

	public static CriFsBindRequest BindDirectory(CriFsBinder targetBinder, string srcPath)
	{
		return CriFsServer.instance.BindDirectory(targetBinder, null, srcPath);
	}

	public static CriFsBindRequest BindDirectory(CriFsBinder targetBinder, CriFsBinder srcBinder, string srcPath)
	{
		return CriFsServer.instance.BindDirectory(targetBinder, srcBinder, srcPath);
	}

	public static CriFsBindRequest BindFile(CriFsBinder targetBinder, string srcPath)
	{
		return CriFsServer.instance.BindFile(targetBinder, null, srcPath);
	}

	public static CriFsBindRequest BindFile(CriFsBinder targetBinder, CriFsBinder srcBinder, string srcPath)
	{
		return CriFsServer.instance.BindFile(targetBinder, srcBinder, srcPath);
	}

	public static void SetUserAgentString(string userAgentString)
	{
		CRIWAREBD435512(userAgentString);
	}

	public static void SetProxyServer(string proxyPath, ushort proxyPort)
	{
		CRIWARE25339C14(proxyPath, proxyPort);
	}

	public static void SetPathSeparator(string filter)
	{
		CRIWARE4086AEC2(filter);
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool CRIWAREBD435512(string userAgentString);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool CRIWARE25339C14(string proxyPath, ushort proxyPort);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool CRIWARE4086AEC2(string filter);
}
