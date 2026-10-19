using System.Collections;
using System.Net.Sockets;
using System.Runtime.CompilerServices;
using System.Runtime.Remoting.Messaging;
using System.Threading.Tasks;

namespace System.Net;

public static class Dns
{
	private delegate IPHostEntry GetHostByNameCallback(string hostName);

	private delegate IPHostEntry ResolveCallback(string hostName);

	private delegate IPHostEntry GetHostEntryNameCallback(string hostName);

	private delegate IPHostEntry GetHostEntryIPCallback(IPAddress hostAddress);

	private delegate IPAddress[] GetHostAddressesCallback(string hostName);

	static Dns()
	{
	}

	[Obsolete("Use BeginGetHostEntry instead")]
	public static IAsyncResult BeginGetHostByName(string hostName, AsyncCallback requestCallback, object stateObject)
	{
		if (hostName == null)
		{
			throw new ArgumentNullException("hostName");
		}
		return new GetHostByNameCallback(GetHostByName).BeginInvoke(hostName, requestCallback, stateObject);
	}

	[Obsolete("Use BeginGetHostEntry instead")]
	public static IAsyncResult BeginResolve(string hostName, AsyncCallback requestCallback, object stateObject)
	{
		if (hostName == null)
		{
			throw new ArgumentNullException("hostName");
		}
		return new ResolveCallback(Resolve).BeginInvoke(hostName, requestCallback, stateObject);
	}

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

	public static IAsyncResult BeginGetHostEntry(string hostNameOrAddress, AsyncCallback requestCallback, object stateObject)
	{
		if (hostNameOrAddress == null)
		{
			throw new ArgumentNullException("hostName");
		}
		if (hostNameOrAddress == "0.0.0.0" || hostNameOrAddress == "::0")
		{
			throw new ArgumentException("Addresses 0.0.0.0 (IPv4) and ::0 (IPv6) are unspecified addresses. You cannot use them as target address.", "hostNameOrAddress");
		}
		return new GetHostEntryNameCallback(GetHostEntry).BeginInvoke(hostNameOrAddress, requestCallback, stateObject);
	}

	public static IAsyncResult BeginGetHostEntry(IPAddress address, AsyncCallback requestCallback, object stateObject)
	{
		if (address == null)
		{
			throw new ArgumentNullException("address");
		}
		return new GetHostEntryIPCallback(GetHostEntry).BeginInvoke(address, requestCallback, stateObject);
	}

	[Obsolete("Use EndGetHostEntry instead")]
	public static IPHostEntry EndGetHostByName(IAsyncResult asyncResult)
	{
		if (asyncResult == null)
		{
			throw new ArgumentNullException("asyncResult");
		}
		return ((GetHostByNameCallback)((AsyncResult)asyncResult).AsyncDelegate).EndInvoke(asyncResult);
	}

	[Obsolete("Use EndGetHostEntry instead")]
	public static IPHostEntry EndResolve(IAsyncResult asyncResult)
	{
		if (asyncResult == null)
		{
			throw new ArgumentNullException("asyncResult");
		}
		return ((ResolveCallback)((AsyncResult)asyncResult).AsyncDelegate).EndInvoke(asyncResult);
	}

	public static IPAddress[] EndGetHostAddresses(IAsyncResult asyncResult)
	{
		if (asyncResult == null)
		{
			throw new ArgumentNullException("asyncResult");
		}
		return ((GetHostAddressesCallback)((AsyncResult)asyncResult).AsyncDelegate).EndInvoke(asyncResult);
	}

	public static IPHostEntry EndGetHostEntry(IAsyncResult asyncResult)
	{
		if (asyncResult == null)
		{
			throw new ArgumentNullException("asyncResult");
		}
		AsyncResult asyncResult2 = (AsyncResult)asyncResult;
		if (asyncResult2.AsyncDelegate is GetHostEntryIPCallback)
		{
			return ((GetHostEntryIPCallback)asyncResult2.AsyncDelegate).EndInvoke(asyncResult);
		}
		return ((GetHostEntryNameCallback)asyncResult2.AsyncDelegate).EndInvoke(asyncResult);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool GetHostByName_icall(string host, out string h_name, out string[] h_aliases, out string[] h_addr_list, int hint);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool GetHostByAddr_icall(string addr, out string h_name, out string[] h_aliases, out string[] h_addr_list, int hint);

	[MethodImpl((MethodImplOptions)4096)]
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

	[Obsolete("Use GetHostEntry instead")]
	public static IPHostEntry GetHostByAddress(IPAddress address)
	{
		if (address == null)
		{
			throw new ArgumentNullException("address");
		}
		return GetHostByAddressFromString(address.ToString(), parse: false);
	}

	[Obsolete("Use GetHostEntry instead")]
	public static IPHostEntry GetHostByAddress(string address)
	{
		if (address == null)
		{
			throw new ArgumentNullException("address");
		}
		return GetHostByAddressFromString(address, parse: true);
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

	[Obsolete("Use GetHostEntry instead")]
	public static IPHostEntry Resolve(string hostName)
	{
		if (hostName == null)
		{
			throw new ArgumentNullException("hostName");
		}
		IPHostEntry iPHostEntry = null;
		try
		{
			iPHostEntry = GetHostByAddress(hostName);
		}
		catch
		{
		}
		if (iPHostEntry == null)
		{
			iPHostEntry = GetHostByName(hostName);
		}
		return iPHostEntry;
	}

	public static Task<IPAddress[]> GetHostAddressesAsync(string hostNameOrAddress)
	{
		return Task<IPAddress[]>.Factory.FromAsync(BeginGetHostAddresses, EndGetHostAddresses, hostNameOrAddress, null);
	}

	public static Task<IPHostEntry> GetHostEntryAsync(IPAddress address)
	{
		return Task<IPHostEntry>.Factory.FromAsync(BeginGetHostEntry, EndGetHostEntry, address, null);
	}

	public static Task<IPHostEntry> GetHostEntryAsync(string hostNameOrAddress)
	{
		return Task<IPHostEntry>.Factory.FromAsync(BeginGetHostEntry, EndGetHostEntry, hostNameOrAddress, null);
	}
}
