using System.Collections.Generic;
using System.Threading;

namespace System.Net;

internal static class NclUtilities
{
	private static volatile IPAddress[] _LocalAddresses;

	private static object _LocalAddressesLock;

	internal static string _LocalDomainName;

	internal static IPAddress[] LocalAddresses
	{
		get
		{
			IPAddress[] localAddresses = _LocalAddresses;
			if (localAddresses != null)
			{
				return localAddresses;
			}
			lock (LocalAddressesLock)
			{
				localAddresses = _LocalAddresses;
				if (localAddresses != null)
				{
					return localAddresses;
				}
				List<IPAddress> list = new List<IPAddress>();
				try
				{
					IPHostEntry localHost = GetLocalHost();
					if (localHost != null)
					{
						if (localHost.HostName != null)
						{
							int num = localHost.HostName.IndexOf('.');
							if (num != -1)
							{
								_LocalDomainName = localHost.HostName.Substring(num);
							}
						}
						IPAddress[] addressList = localHost.AddressList;
						if (addressList != null)
						{
							IPAddress[] array = addressList;
							foreach (IPAddress item in array)
							{
								list.Add(item);
							}
						}
					}
				}
				catch
				{
				}
				localAddresses = new IPAddress[list.Count];
				int num2 = 0;
				foreach (IPAddress item2 in list)
				{
					localAddresses[num2] = item2;
					num2++;
				}
				_LocalAddresses = localAddresses;
				return localAddresses;
			}
		}
	}

	private static object LocalAddressesLock
	{
		get
		{
			if (_LocalAddressesLock == null)
			{
				Interlocked.CompareExchange(ref _LocalAddressesLock, new object(), null);
			}
			return _LocalAddressesLock;
		}
	}

	internal static bool IsFatal(Exception exception)
	{
		if (exception != null)
		{
			if (!(exception is OutOfMemoryException) && !(exception is StackOverflowException))
			{
				return exception is ThreadAbortException;
			}
			return true;
		}
		return false;
	}

	internal static bool IsAddressLocal(IPAddress ipAddress)
	{
		IPAddress[] localAddresses = LocalAddresses;
		for (int i = 0; i < localAddresses.Length; i++)
		{
			if (ipAddress.Equals(localAddresses[i], compareScopeId: false))
			{
				return true;
			}
		}
		return false;
	}

	private static IPHostEntry GetLocalHost()
	{
		return Dns.GetHostByName(Dns.GetHostName());
	}
}
