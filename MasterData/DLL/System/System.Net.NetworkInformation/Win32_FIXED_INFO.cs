namespace System.Net.NetworkInformation;

internal struct Win32_FIXED_INFO
{
	public string HostName;

	public string DomainName;

	public IntPtr CurrentDnsServer;

	public Win32_IP_ADDR_STRING DnsServerList;

	public NetBiosNodeType NodeType;

	public string ScopeId;

	public uint EnableRouting;

	public uint EnableProxy;

	public uint EnableDns;
}
