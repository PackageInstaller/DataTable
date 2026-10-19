namespace System.Net;

public class IPHostEntry
{
	private string hostName;

	private string[] aliases;

	private IPAddress[] addressList;

	internal bool isTrustedHost = true;

	public string HostName
	{
		get
		{
			return hostName;
		}
		set
		{
			hostName = value;
		}
	}

	public string[] Aliases
	{
		get
		{
			return aliases;
		}
		set
		{
			aliases = value;
		}
	}

	public IPAddress[] AddressList
	{
		get
		{
			return addressList;
		}
		set
		{
			addressList = value;
		}
	}
}
