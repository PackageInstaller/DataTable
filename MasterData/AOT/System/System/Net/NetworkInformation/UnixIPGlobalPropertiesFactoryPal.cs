using System.IO;

namespace System.Net.NetworkInformation;

internal static class UnixIPGlobalPropertiesFactoryPal
{
	private static bool PlatformNeedsLibCWorkaround { get; }

	public static IPGlobalProperties Create()
	{
		if (Environment.OSVersion.Platform == PlatformID.Unix)
		{
			if (PlatformNeedsLibCWorkaround)
			{
				return new UnixNoLibCIPGlobalProperties();
			}
			MibIPGlobalProperties mibIPGlobalProperties = null;
			if (Directory.Exists("/proc"))
			{
				mibIPGlobalProperties = new MibIPGlobalProperties("/proc");
				if (File.Exists(mibIPGlobalProperties.StatisticsFile))
				{
					return mibIPGlobalProperties;
				}
			}
			if (Directory.Exists("/usr/compat/linux/proc"))
			{
				mibIPGlobalProperties = new MibIPGlobalProperties("/usr/compat/linux/proc");
				if (File.Exists(mibIPGlobalProperties.StatisticsFile))
				{
					return mibIPGlobalProperties;
				}
			}
			return new UnixIPGlobalProperties();
		}
		return new UnixIPGlobalProperties();
	}
}
