namespace System.Net.NetworkInformation;

public abstract class IPInterfaceProperties
{
	public abstract UnicastIPAddressInformationCollection UnicastAddresses { get; }

	public abstract IPAddressCollection DnsAddresses { get; }

	public abstract GatewayIPAddressInformationCollection GatewayAddresses { get; }
}
