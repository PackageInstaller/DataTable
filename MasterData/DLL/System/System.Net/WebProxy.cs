using System.Collections;
using System.Collections.Generic;
using System.Net.NetworkInformation;
using System.Runtime.Serialization;
using System.Text.RegularExpressions;

namespace System.Net;

[Serializable]
public class WebProxy : IWebProxy, ISerializable
{
	private bool _UseRegistry;

	private bool _BypassOnLocal;

	private bool m_EnableAutoproxy;

	private Uri _ProxyAddress;

	private ArrayList _BypassList;

	private ICredentials _Credentials;

	private Regex[] _RegExBypassList;

	private Hashtable _ProxyHostAddresses;

	private AutoWebProxyScriptEngine m_ScriptEngine;

	public ICredentials Credentials
	{
		get
		{
			return _Credentials;
		}
		set
		{
			_Credentials = value;
		}
	}

	public bool UseDefaultCredentials
	{
		get
		{
			if (!(Credentials is SystemNetworkCredential))
			{
				return false;
			}
			return true;
		}
		set
		{
			_Credentials = (value ? CredentialCache.DefaultCredentials : null);
		}
	}

	internal AutoWebProxyScriptEngine ScriptEngine => m_ScriptEngine;

	public WebProxy()
		: this(null, BypassOnLocal: false, null, null)
	{
	}

	public WebProxy(Uri Address, bool BypassOnLocal, string[] BypassList, ICredentials Credentials)
	{
		_ProxyAddress = Address;
		_BypassOnLocal = BypassOnLocal;
		if (BypassList != null)
		{
			_BypassList = new ArrayList(BypassList);
			UpdateRegExList(canThrow: true);
		}
		_Credentials = Credentials;
		m_EnableAutoproxy = true;
	}

	public WebProxy(string Address, bool BypassOnLocal)
		: this(CreateProxyUri(Address), BypassOnLocal, null, null)
	{
	}

	public Uri GetProxy(Uri destination)
	{
		if (destination == null)
		{
			throw new ArgumentNullException("destination");
		}
		if (GetProxyAuto(destination, out var proxyUri))
		{
			return proxyUri;
		}
		if (IsBypassedManual(destination))
		{
			return destination;
		}
		Hashtable proxyHostAddresses = _ProxyHostAddresses;
		Uri uri = ((proxyHostAddresses != null) ? (proxyHostAddresses[destination.Scheme] as Uri) : _ProxyAddress);
		if (!(uri != null))
		{
			return destination;
		}
		return uri;
	}

	private static Uri CreateProxyUri(string address)
	{
		if (address == null)
		{
			return null;
		}
		if (address.IndexOf("://") == -1)
		{
			address = "http://" + address;
		}
		return new Uri(address);
	}

	private void UpdateRegExList(bool canThrow)
	{
		Regex[] array = null;
		ArrayList bypassList = _BypassList;
		try
		{
			if (bypassList != null && bypassList.Count > 0)
			{
				array = new Regex[bypassList.Count];
				for (int i = 0; i < bypassList.Count; i++)
				{
					array[i] = new Regex((string)bypassList[i], RegexOptions.IgnoreCase | RegexOptions.CultureInvariant);
				}
			}
		}
		catch
		{
			if (!canThrow)
			{
				_RegExBypassList = null;
				return;
			}
			throw;
		}
		_RegExBypassList = array;
	}

	private bool IsMatchInBypassList(Uri input)
	{
		UpdateRegExList(canThrow: false);
		if (_RegExBypassList == null)
		{
			return false;
		}
		string input2 = input.Scheme + "://" + input.Host + ((!input.IsDefaultPort) ? (":" + input.Port) : "");
		for (int i = 0; i < _BypassList.Count; i++)
		{
			if (_RegExBypassList[i].IsMatch(input2))
			{
				return true;
			}
		}
		return false;
	}

	private bool IsLocal(Uri host)
	{
		string host2 = host.Host;
		if (IPAddress.TryParse(host2, out var address))
		{
			if (!IPAddress.IsLoopback(address))
			{
				return NclUtilities.IsAddressLocal(address);
			}
			return true;
		}
		int num = host2.IndexOf('.');
		if (num == -1)
		{
			return true;
		}
		string text = "." + IPGlobalProperties.InternalGetIPGlobalProperties().DomainName;
		if (text != null && text.Length == host2.Length - num && string.Compare(text, 0, host2, num, text.Length, StringComparison.OrdinalIgnoreCase) == 0)
		{
			return true;
		}
		return false;
	}

	private bool IsLocalInProxyHash(Uri host)
	{
		Hashtable proxyHostAddresses = _ProxyHostAddresses;
		if (proxyHostAddresses != null && (Uri)proxyHostAddresses[host.Scheme] == null)
		{
			return true;
		}
		return false;
	}

	public bool IsBypassed(Uri host)
	{
		if (host == null)
		{
			throw new ArgumentNullException("host");
		}
		if (IsBypassedAuto(host, out var isBypassed))
		{
			return isBypassed;
		}
		return IsBypassedManual(host);
	}

	private bool IsBypassedManual(Uri host)
	{
		if (host.IsLoopback)
		{
			return true;
		}
		if ((!(_ProxyAddress == null) || _ProxyHostAddresses != null) && (!_BypassOnLocal || !IsLocal(host)) && !IsMatchInBypassList(host))
		{
			return IsLocalInProxyHash(host);
		}
		return true;
	}

	protected WebProxy(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		bool flag = false;
		try
		{
			flag = serializationInfo.GetBoolean("_UseRegistry");
		}
		catch
		{
		}
		if (flag)
		{
			UnsafeUpdateFromRegistry();
			return;
		}
		_ProxyAddress = (Uri)serializationInfo.GetValue("_ProxyAddress", typeof(Uri));
		_BypassOnLocal = serializationInfo.GetBoolean("_BypassOnLocal");
		_BypassList = (ArrayList)serializationInfo.GetValue("_BypassList", typeof(ArrayList));
		try
		{
			UseDefaultCredentials = serializationInfo.GetBoolean("_UseDefaultCredentials");
		}
		catch
		{
		}
	}

	void ISerializable.GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		GetObjectData(serializationInfo, streamingContext);
	}

	protected virtual void GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		serializationInfo.AddValue("_BypassOnLocal", _BypassOnLocal);
		serializationInfo.AddValue("_ProxyAddress", _ProxyAddress);
		serializationInfo.AddValue("_BypassList", _BypassList);
		serializationInfo.AddValue("_UseDefaultCredentials", UseDefaultCredentials);
		if (_UseRegistry)
		{
			serializationInfo.AddValue("_UseRegistry", value: true);
		}
	}

	public static IWebProxy CreateDefaultProxy()
	{
		return new WebProxy(enableAutoproxy: true);
	}

	internal WebProxy(bool enableAutoproxy)
	{
		m_EnableAutoproxy = enableAutoproxy;
		UnsafeUpdateFromRegistry();
	}

	internal void UnsafeUpdateFromRegistry()
	{
		_UseRegistry = true;
	}

	private bool GetProxyAuto(Uri destination, out Uri proxyUri)
	{
		proxyUri = null;
		if (ScriptEngine == null)
		{
			return false;
		}
		IList<string> proxyList = null;
		if (!ScriptEngine.GetProxies(destination, out proxyList))
		{
			return false;
		}
		if (proxyList.Count > 0)
		{
			if (AreAllBypassed(proxyList, checkFirstOnly: true))
			{
				proxyUri = destination;
			}
			else
			{
				proxyUri = ProxyUri(proxyList[0]);
			}
		}
		return true;
	}

	private bool IsBypassedAuto(Uri destination, out bool isBypassed)
	{
		isBypassed = true;
		if (ScriptEngine == null)
		{
			return false;
		}
		if (!ScriptEngine.GetProxies(destination, out var proxyList))
		{
			return false;
		}
		if (proxyList.Count == 0)
		{
			isBypassed = false;
		}
		else
		{
			isBypassed = AreAllBypassed(proxyList, checkFirstOnly: true);
		}
		return true;
	}

	private static bool AreAllBypassed(IEnumerable<string> proxies, bool checkFirstOnly)
	{
		bool flag = true;
		foreach (string proxy in proxies)
		{
			flag = string.IsNullOrEmpty(proxy);
			if (checkFirstOnly || !flag)
			{
				break;
			}
		}
		return flag;
	}

	private static Uri ProxyUri(string proxyName)
	{
		if (proxyName != null && proxyName.Length != 0)
		{
			return new Uri("http://" + proxyName);
		}
		return null;
	}
}
