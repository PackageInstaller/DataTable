using System.Collections.Generic;

namespace System.Net;

internal class AutoWebProxyScriptEngine
{
	public bool GetProxies(Uri destination, out IList<string> proxyList)
	{
		int syncStatus = 0;
		return GetProxies(destination, out proxyList, ref syncStatus);
	}

	public bool GetProxies(Uri destination, out IList<string> proxyList, ref int syncStatus)
	{
		proxyList = null;
		return false;
	}
}
