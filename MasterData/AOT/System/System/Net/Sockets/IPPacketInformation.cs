namespace System.Net.Sockets;

public struct IPPacketInformation
{
	private IPAddress address;

	private int networkInterface;

	public override bool Equals(object comparand)
	{
		if (comparand == null)
		{
			return false;
		}
		if (!(comparand is IPPacketInformation iPPacketInformation))
		{
			return false;
		}
		if (address.Equals(iPPacketInformation.address) && networkInterface == iPPacketInformation.networkInterface)
		{
			return true;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return address.GetHashCode() + networkInterface.GetHashCode();
	}
}
