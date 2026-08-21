namespace System.Net.NetworkInformation;

internal class Win32IPGlobalProperties : IPGlobalProperties
{
	public override string DomainName => Win32NetworkInterface.FixedInfo.DomainName;
}
