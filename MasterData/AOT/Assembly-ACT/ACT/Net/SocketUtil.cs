using System;
using System.Net;
using System.Net.Sockets;
using System.Text.RegularExpressions;
using ACT.Error;
using ACT.Local;

namespace ACT.Net;

public static class SocketUtil
{
	private const int NetworkResolveDetailCode = 7;

	public static string GetIPV6(string mhost, int mport)
	{
		return ResolveHostAddress(mhost);
	}

	public static TcpClient SocketClient(string serverIp, int serverPorts, out string connectHost)
	{
		getIPType(serverIp, serverPorts, out connectHost, out var ipType);
		if (string.IsNullOrEmpty(connectHost))
		{
			connectHost = serverIp;
		}
		if (TryParseConnectHost(connectHost, out var ip))
		{
			ipType = ip.AddressFamily;
		}
		TcpClient result = new TcpClient(ipType)
		{
			NoDelay = true,
			ReceiveTimeout = 50000,
			SendTimeout = 50000
		};
		NetThreadLog.Enqueue($"Socket AddressFamily: {ipType}, ConnectHost: {connectHost}");
		return result;
	}

	private static string ResolveHostAddress(string host)
	{
		try
		{
			if (TryFormatLiteralAddress(host, out var formatted))
			{
				return formatted;
			}
			IPHostEntry hostEntry = Dns.GetHostEntry(host);
			IPAddress iPAddress = null;
			IPAddress[] addressList = hostEntry.AddressList;
			foreach (IPAddress iPAddress2 in addressList)
			{
				if (iPAddress2.AddressFamily == AddressFamily.InterNetworkV6)
				{
					iPAddress = iPAddress2;
					break;
				}
			}
			if (iPAddress == null)
			{
				addressList = hostEntry.AddressList;
				foreach (IPAddress iPAddress3 in addressList)
				{
					if (iPAddress3.AddressFamily == AddressFamily.InterNetwork)
					{
						iPAddress = iPAddress3;
						break;
					}
				}
			}
			if (iPAddress == null)
			{
				ReportResolveError("Dns.GetHostEntry returned no usable address for host=" + host);
				return null;
			}
			return FormatResolvedAddress(iPAddress);
		}
		catch (Exception inner)
		{
			ReportResolveError("ResolveHostAddress failed for host=" + host, inner);
			return null;
		}
	}

	private static string FormatResolvedAddress(IPAddress ip)
	{
		if (ip.AddressFamily == AddressFamily.InterNetworkV6)
		{
			return ip.ToString() + "&&ipv6";
		}
		return ip.ToString() + "&&ipv4";
	}

	private static void getIPType(string serverIp, int serverPorts, out string newServerIp, out AddressFamily ipType)
	{
		ipType = AddressFamily.InterNetwork;
		newServerIp = serverIp;
		if (TryApplyResolvedAddress(serverIp, out newServerIp, out ipType))
		{
			return;
		}
		try
		{
			string iPV = GetIPV6(serverIp, serverPorts);
			if (string.IsNullOrEmpty(iPV))
			{
				ReportResolveError($"Failed to resolve host={serverIp}, port={serverPorts}");
			}
			else if (!TryParseResolvedAddress(iPV, out newServerIp, out ipType))
			{
				ReportResolveError("Invalid resolved address format: " + iPV);
			}
		}
		catch (Exception inner)
		{
			if (!TryApplyResolvedAddress(serverIp, out newServerIp, out ipType))
			{
				string text = ResolveHostAddress(serverIp);
				if (string.IsNullOrEmpty(text) || !TryParseResolvedAddress(text, out newServerIp, out ipType))
				{
					ReportResolveError($"getIPType failed for host={serverIp}, port={serverPorts}", inner);
				}
			}
		}
	}

	private static bool TryApplyResolvedAddress(string serverIp, out string newServerIp, out AddressFamily ipType)
	{
		newServerIp = serverIp;
		ipType = AddressFamily.InterNetwork;
		if (!TryFormatLiteralAddress(serverIp, out var formatted))
		{
			return false;
		}
		return TryParseResolvedAddress(formatted, out newServerIp, out ipType);
	}

	private static bool TryFormatLiteralAddress(string host, out string formatted)
	{
		formatted = null;
		string text = host?.Trim();
		if (string.IsNullOrEmpty(text))
		{
			return false;
		}
		if (text.StartsWith("[") && text.EndsWith("]"))
		{
			text = text.Substring(1, text.Length - 2);
		}
		if (!IPAddress.TryParse(text, out var address))
		{
			return false;
		}
		formatted = FormatResolvedAddress(address);
		return true;
	}

	private static bool TryParseConnectHost(string connectHost, out IPAddress ip)
	{
		ip = null;
		string text = connectHost?.Trim();
		if (string.IsNullOrEmpty(text))
		{
			return false;
		}
		if (text.StartsWith("[") && text.EndsWith("]"))
		{
			text = text.Substring(1, text.Length - 2);
		}
		return IPAddress.TryParse(text, out ip);
	}

	private static bool TryParseResolvedAddress(string resolved, out string newServerIp, out AddressFamily ipType)
	{
		newServerIp = null;
		ipType = AddressFamily.InterNetwork;
		string[] array = Regex.Split(resolved, "&&");
		if (array.Length < 2 || string.IsNullOrEmpty(array[0]))
		{
			return false;
		}
		newServerIp = array[0];
		if (array[1] == "ipv6")
		{
			ipType = AddressFamily.InterNetworkV6;
		}
		return true;
	}

	private static void ReportResolveError(string context, Exception inner = null)
	{
		string messageOverride = ((inner != null) ? (context + ": " + inner.Message) : context);
		LoginUtility.LogClientError(new LuminErrorException(CodeType.CLIENT, CodeModule.NETWORK, 7, null, "系统提示", messageOverride, inner));
	}
}
