namespace System.Net.NetworkInformation;

internal struct Win32_FIXED_INFO_Marshal
{
	public unsafe fixed byte HostName[132];

	public unsafe fixed byte DomainName[132];

	public IntPtr CurrentDnsServer;

	public Win32_IP_ADDR_STRING DnsServerList;

	public NetBiosNodeType NodeType;

	public unsafe fixed byte ScopeId[260];

	public uint EnableRouting;

	public uint EnableProxy;

	public uint EnableDns;
}
