using System.Runtime.CompilerServices;

namespace System.Runtime.InteropServices;

public static class RuntimeInformation
{
	private static readonly Architecture _osArchitecture;

	private static readonly Architecture _processArchitecture;

	private static readonly OSPlatform _osPlatform;

	static RuntimeInformation()
	{
		string runtimeArchitecture = GetRuntimeArchitecture();
		string oSName = GetOSName();
		switch (runtimeArchitecture)
		{
		case "arm":
			_osArchitecture = (Environment.Is64BitOperatingSystem ? Architecture.Arm64 : Architecture.Arm);
			_processArchitecture = Architecture.Arm;
			break;
		case "armv8":
			_osArchitecture = (Environment.Is64BitOperatingSystem ? Architecture.Arm64 : Architecture.Arm);
			_processArchitecture = Architecture.Arm64;
			break;
		case "x86":
			_osArchitecture = (Environment.Is64BitOperatingSystem ? Architecture.X64 : Architecture.X86);
			_processArchitecture = Architecture.X86;
			break;
		case "x86-64":
			_osArchitecture = (Environment.Is64BitOperatingSystem ? Architecture.X64 : Architecture.X86);
			_processArchitecture = Architecture.X64;
			break;
		default:
			_osArchitecture = (Environment.Is64BitOperatingSystem ? Architecture.X64 : Architecture.X86);
			_processArchitecture = (Environment.Is64BitProcess ? Architecture.X64 : Architecture.X86);
			break;
		}
		switch (oSName)
		{
		case "linux":
			_osPlatform = OSPlatform.Linux;
			break;
		case "osx":
			_osPlatform = OSPlatform.OSX;
			break;
		case "windows":
			_osPlatform = OSPlatform.Windows;
			break;
		case "solaris":
			_osPlatform = OSPlatform.Create("SOLARIS");
			break;
		case "freebsd":
			_osPlatform = OSPlatform.Create("FREEBSD");
			break;
		case "netbsd":
			_osPlatform = OSPlatform.Create("NETBSD");
			break;
		case "openbsd":
			_osPlatform = OSPlatform.Create("OPENBSD");
			break;
		case "aix":
			_osPlatform = OSPlatform.Create("AIX");
			break;
		case "hpux":
			_osPlatform = OSPlatform.Create("HPUX");
			break;
		case "haiku":
			_osPlatform = OSPlatform.Create("HAIKU");
			break;
		case "wasm":
			_osPlatform = OSPlatform.Create("BROWSER");
			break;
		default:
			_osPlatform = OSPlatform.Create("UNKNOWN");
			break;
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern string GetRuntimeArchitecture();

	[MethodImpl((MethodImplOptions)4096)]
	private static extern string GetOSName();

	public static bool IsOSPlatform(OSPlatform osPlatform)
	{
		return _osPlatform == osPlatform;
	}
}
