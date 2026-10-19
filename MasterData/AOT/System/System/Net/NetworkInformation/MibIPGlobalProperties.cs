using System.IO;

namespace System.Net.NetworkInformation;

internal class MibIPGlobalProperties : UnixIPGlobalProperties
{
	public readonly string StatisticsFile;

	public readonly string StatisticsFileIPv6;

	public readonly string TcpFile;

	public readonly string Tcp6File;

	public readonly string UdpFile;

	public readonly string Udp6File;

	private static readonly char[] wsChars = new char[2] { ' ', '\t' };

	public MibIPGlobalProperties(string procDir)
	{
		StatisticsFile = Path.Combine(procDir, "net/snmp");
		StatisticsFileIPv6 = Path.Combine(procDir, "net/snmp6");
		TcpFile = Path.Combine(procDir, "net/tcp");
		Tcp6File = Path.Combine(procDir, "net/tcp6");
		UdpFile = Path.Combine(procDir, "net/udp");
		Udp6File = Path.Combine(procDir, "net/udp6");
	}
}
