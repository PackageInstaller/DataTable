namespace System.Net.NetworkInformation;

internal class Win32IPv4InterfaceStatistics : IPv4InterfaceStatistics
{
	private Win32_MIB_IFROW info;

	public Win32IPv4InterfaceStatistics(Win32_MIB_IFROW info)
	{
		this.info = info;
	}
}
