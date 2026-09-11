namespace System.Net.NetworkInformation;

public abstract class NetworkInterface
{
	public virtual OperationalStatus OperationalStatus
	{
		get
		{
			throw new NotImplementedException();
		}
	}

	public virtual NetworkInterfaceType NetworkInterfaceType
	{
		get
		{
			throw new NotImplementedException();
		}
	}

	public static NetworkInterface[] GetAllNetworkInterfaces()
	{
		return SystemNetworkInterface.GetNetworkInterfaces();
	}

	public virtual IPInterfaceProperties GetIPProperties()
	{
		throw new NotImplementedException();
	}

	public virtual PhysicalAddress GetPhysicalAddress()
	{
		throw new NotImplementedException();
	}
}
