using System.Collections;
using System.Net.Sockets;
using System.Runtime.CompilerServices;
using System.Runtime.Remoting.Messaging;
using System.Threading.Tasks;

namespace System.Net;

public static class Dns
{
	private delegate IPAddress[] GetHostAddressesCallback(string hostName);

	public static IAsyncResult BeginGetHostAddresses(string hostNameOrAddress, AsyncCallback requestCallback, object state)
	{
		if (hostNameOrAddress == null)
		{
			throw new ArgumentNullException("hostName");
		}
		if (hostNameOrAddress == "0.0.0.0" || hostNameOrAddress == "::0")
		{
			throw new ArgumentException("Addresses 0.0.0.0 (IPv4) and ::0 (IPv6) are unspecified addresses. You cannot use them as target address.", "hostNameOrAddress");
		}
		return new GetHostAddressesCallback(GetHostAddresses).BeginInvoke(hostNameOrAddress, requestCallback, state);
	}

	public static IPAddress[] EndGetHostAddresses(IAsyncResult asyncResult)
	{
		if (asyncResult == null)
		{
			throw new ArgumentNullException("asyncResult");
		}
		return ((GetHostAddressesCallback)((AsyncResult)asyncResult).AsyncDelegate).EndInvoke(asyncResult);
	}

	[MethodImpl(MethodImplOptions.InternalCall)]
	private static extern bool GetHostByName_icall(string host, out string h_name, out string[] h_aliases, out string[] h_addr_list, int hint);

	[MethodImpl(MethodImplOptions.InternalCall)]
	private static extern bool GetHostByAddr_icall(string addr, out string h_name, out string[] h_aliases, out string[] h_addr_list, int hint);

	[MethodImpl(MethodImplOptions.InternalCall)]
	private static extern bool GetHostName_icall(out string h_name);

	private static void Error_11001(string hostName)
	{
		throw new SocketException(11001, $"Could not resolve host '{hostName}'");
	}

	private static IPHostEntry hostent_to_IPHostEntry(string originalHostName, string h_name, string[] h_aliases, string[] h_addrlist)
	{
		IPHostEntry iPHostEntry = new IPHostEntry();
		ArrayList arrayList = new ArrayList();
		iPHostEntry.HostName = h_name;
		iPHostEntry.Aliases = h_aliases;
		for (int i = 0; i < h_addrlist.Length; i++)
		{
			try
			{
				IPAddress iPAddress = IPAddress.Parse(h_addrlist[i]);
				if ((Socket.OSSupportsIPv6 && iPAddress.AddressFamily == AddressFamily.InterNetworkV6) || (Socket.OSSupportsIPv4 && iPAddress.AddressFamily == AddressFamily.InterNetwork))
				{
					arrayList.Add(iPAddress);
				}
			}
			catch (ArgumentNullException)
			{
			}
		}
		if (arrayList.Count == 0)
		{
			Error_11001(originalHostName);
		}
		iPHostEntry.AddressList = arrayList.ToArray(typeof(IPAddress)) as IPAddress[];
		return iPHostEntry;
	}

	private static IPHostEntry GetHostByAddressFromString(string address, bool parse)
	{
		if (address.Equals("0.0.0.0"))
		{
			address = "127.0.0.1";
			parse = false;
		}
		if (parse)
		{
			IPAddress.Parse(address);
		}
		if (!GetHostByAddr_icall(address, out var h_name, out var h_aliases, out var h_addr_list, Socket.FamilyHint))
		{
			Error_11001(address);
		}
		return hostent_to_IPHostEntry(address, h_name, h_aliases, h_addr_list);
	}

	public static IPHostEntry GetHostEntry(string hostNameOrAddress)
	{
		if (hostNameOrAddress == null)
		{
			throw new ArgumentNullException("hostNameOrAddress");
		}
		if (hostNameOrAddress == "0.0.0.0" || hostNameOrAddress == "::0")
		{
			throw new ArgumentException("Addresses 0.0.0.0 (IPv4) and ::0 (IPv6) are unspecified addresses. You cannot use them as target address.", "hostNameOrAddress");
		}
		if (hostNameOrAddress.Length > 0 && IPAddress.TryParse(hostNameOrAddress, out var address))
		{
			return GetHostEntry(address);
		}
		return GetHostByName(hostNameOrAddress);
	}

	public static IPHostEntry GetHostEntry(IPAddress address)
	{
		if (address == null)
		{
			throw new ArgumentNullException("address");
		}
		return GetHostByAddressFromString(address.ToString(), parse: false);
	}

	public static IPAddress[] GetHostAddresses(string hostNameOrAddress)
	{
		if (hostNameOrAddress == null)
		{
			throw new ArgumentNullException("hostNameOrAddress");
		}
		if (hostNameOrAddress == "0.0.0.0" || hostNameOrAddress == "::0")
		{
			throw new ArgumentException("Addresses 0.0.0.0 (IPv4) and ::0 (IPv6) are unspecified addresses. You cannot use them as target address.", "hostNameOrAddress");
		}
		if (hostNameOrAddress.Length > 0 && IPAddress.TryParse(hostNameOrAddress, out var address))
		{
			return new IPAddress[1] { address };
		}
		return GetHostEntry(hostNameOrAddress).AddressList;
	}

	[Obsolete("Use GetHostEntry instead")]
	public static IPHostEntry GetHostByName(string hostName)
	{
		if (hostName == null)
		{
			throw new ArgumentNullException("hostName");
		}
		if (!GetHostByName_icall(hostName, out var h_name, out var h_aliases, out var h_addr_list, Socket.FamilyHint))
		{
			Error_11001(hostName);
		}
		return hostent_to_IPHostEntry(hostName, h_name, h_aliases, h_addr_list);
	}

	public static string GetHostName()
	{
		if (!GetHostName_icall(out var h_name))
		{
			Error_11001(h_name);
		}
		return h_name;
	}

	public static Task<IPAddress[]> GetHostAddressesAsync(string hostNameOrAddress)
	{
		return Task<IPAddress[]>.Factory.FromAsync(BeginGetHostAddresses, EndGetHostAddresses, hostNameOrAddress, null);
	}
}
