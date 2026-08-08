namespace System.Net.NetworkInformation;

internal class SystemGatewayIPAddressInformation : GatewayIPAddressInformation
{
	private IPAddress address;

	public override IPAddress Address => address;

	internal SystemGatewayIPAddressInformation(IPAddress address)
	{
		this.address = address;
	}
}
