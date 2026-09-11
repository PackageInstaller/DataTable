using System;

[Serializable]
public class CriFsConfig
{
	public const int defaultAndroidDeviceReadBitrate = 50000000;

	public int numberOfLoaders = 16;

	public int numberOfBinders = 8;

	public int numberOfInstallers = 2;

	public int installBufferSize = CriFsPlugin.defaultInstallBufferSize / 1024;

	public int maxPath = 256;

	public string userAgentString = "";

	public bool minimizeFileDescriptorUsage;

	public bool enableCrcCheck;

	public int androidDeviceReadBitrate = 50000000;
}
