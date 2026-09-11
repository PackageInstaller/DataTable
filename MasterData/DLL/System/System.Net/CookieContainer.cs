using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Net.NetworkInformation;
using System.Text;
using System.Threading;

namespace System.Net;

[Serializable]
public class CookieContainer
{
	public const int DefaultCookieLimit = 300;

	public const int DefaultPerDomainCookieLimit = 20;

	public const int DefaultCookieLengthLimit = 4096;

	private static readonly HeaderVariantInfo[] HeaderInfo = new HeaderVariantInfo[2]
	{
		new HeaderVariantInfo("Set-Cookie", CookieVariant.Rfc2109),
		new HeaderVariantInfo("Set-Cookie2", CookieVariant.Rfc2965)
	};

	private Hashtable m_domainTable = new Hashtable();

	private int m_maxCookieSize = 4096;

	private int m_maxCookies = 300;

	private int m_maxCookiesPerDomain = 20;

	private int m_count;

	private string m_fqdnMyDomain = string.Empty;

	public int Capacity
	{
		get
		{
			return m_maxCookies;
		}
		set
		{
			if (value <= 0 || (value < m_maxCookiesPerDomain && m_maxCookiesPerDomain != int.MaxValue))
			{
				throw new ArgumentOutOfRangeException("value", global::SR.GetString("'{0}' has to be greater than '{1}' and less than '{2}'.", "Capacity", 0, m_maxCookiesPerDomain));
			}
			if (value < m_maxCookies)
			{
				m_maxCookies = value;
				AgeCookies(null);
			}
			m_maxCookies = value;
		}
	}

	public int Count => m_count;

	public int MaxCookieSize
	{
		get
		{
			return m_maxCookieSize;
		}
		set
		{
			if (value <= 0)
			{
				throw new ArgumentOutOfRangeException("value");
			}
			m_maxCookieSize = value;
		}
	}

	public int PerDomainCapacity
	{
		get
		{
			return m_maxCookiesPerDomain;
		}
		set
		{
			if (value <= 0 || (value > m_maxCookies && value != int.MaxValue))
			{
				throw new ArgumentOutOfRangeException("value");
			}
			if (value < m_maxCookiesPerDomain)
			{
				m_maxCookiesPerDomain = value;
				AgeCookies(null);
			}
			m_maxCookiesPerDomain = value;
		}
	}

	public CookieContainer()
	{
		string domainName = IPGlobalProperties.InternalGetIPGlobalProperties().DomainName;
		if (domainName != null && domainName.Length > 1)
		{
			m_fqdnMyDomain = "." + domainName;
		}
	}

	public CookieContainer(int capacity)
		: this()
	{
		if (capacity <= 0)
		{
			throw new ArgumentException(global::SR.GetString("The specified value must be greater than 0."), "Capacity");
		}
		m_maxCookies = capacity;
	}

	public CookieContainer(int capacity, int perDomainCapacity, int maxCookieSize)
		: this(capacity)
	{
		if (perDomainCapacity != int.MaxValue && (perDomainCapacity <= 0 || perDomainCapacity > capacity))
		{
			throw new ArgumentOutOfRangeException("perDomainCapacity", global::SR.GetString("'{0}' has to be greater than '{1}' and less than '{2}'.", "PerDomainCapacity", 0, capacity));
		}
		m_maxCookiesPerDomain = perDomainCapacity;
		if (maxCookieSize <= 0)
		{
			throw new ArgumentException(global::SR.GetString("The specified value must be greater than 0."), "MaxCookieSize");
		}
		m_maxCookieSize = maxCookieSize;
	}

	public void Add(Cookie cookie)
	{
		if (cookie == null)
		{
			throw new ArgumentNullException("cookie");
		}
		if (cookie.Domain.Length == 0)
		{
			throw new ArgumentException(global::SR.GetString("The parameter '{0}' cannot be an empty string."), "cookie.Domain");
		}
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(cookie.Secure ? Uri.UriSchemeHttps : Uri.UriSchemeHttp).Append(Uri.SchemeDelimiter);
		if (!cookie.DomainImplicit && cookie.Domain[0] == '.')
		{
			stringBuilder.Append("0");
		}
		stringBuilder.Append(cookie.Domain);
		if (cookie.PortList != null)
		{
			stringBuilder.Append(":").Append(cookie.PortList[0]);
		}
		stringBuilder.Append(cookie.Path);
		if (!Uri.TryCreate(stringBuilder.ToString(), UriKind.Absolute, out var result))
		{
			throw new CookieException(global::SR.GetString("The '{0}'='{1}' part of the cookie is invalid.", "Domain", cookie.Domain));
		}
		Cookie cookie2 = cookie.Clone();
		cookie2.VerifySetDefaults(cookie2.Variant, result, IsLocalDomain(result.Host), m_fqdnMyDomain, set_default: true, isThrow: true);
		Add(cookie2, throwOnError: true);
	}

	private void AddRemoveDomain(string key, PathList value)
	{
		lock (m_domainTable.SyncRoot)
		{
			if (value == null)
			{
				m_domainTable.Remove(key);
			}
			else
			{
				m_domainTable[key] = value;
			}
		}
	}

	internal void Add(Cookie cookie, bool throwOnError)
	{
		if (cookie.Value.Length > m_maxCookieSize)
		{
			if (throwOnError)
			{
				throw new CookieException(global::SR.GetString("The value size of the cookie is '{0}'. This exceeds the configured maximum size, which is '{1}'.", cookie.ToString(), m_maxCookieSize));
			}
			return;
		}
		try
		{
			PathList pathList;
			lock (m_domainTable.SyncRoot)
			{
				pathList = (PathList)m_domainTable[cookie.DomainKey];
				if (pathList == null)
				{
					pathList = new PathList();
					AddRemoveDomain(cookie.DomainKey, pathList);
				}
			}
			int cookiesCount = pathList.GetCookiesCount();
			CookieCollection cookieCollection;
			lock (pathList.SyncRoot)
			{
				cookieCollection = (CookieCollection)pathList[cookie.Path];
				if (cookieCollection == null)
				{
					cookieCollection = new CookieCollection();
					pathList[cookie.Path] = cookieCollection;
				}
			}
			if (cookie.Expired)
			{
				lock (cookieCollection)
				{
					int num = cookieCollection.IndexOf(cookie);
					if (num != -1)
					{
						cookieCollection.RemoveAt(num);
						m_count--;
					}
					return;
				}
			}
			if ((cookiesCount >= m_maxCookiesPerDomain && !AgeCookies(cookie.DomainKey)) || (m_count >= m_maxCookies && !AgeCookies(null)))
			{
				return;
			}
			lock (cookieCollection)
			{
				m_count += cookieCollection.InternalAdd(cookie, isStrict: true);
			}
		}
		catch (Exception ex)
		{
			if (ex is ThreadAbortException || ex is StackOverflowException || ex is OutOfMemoryException)
			{
				throw;
			}
			if (throwOnError)
			{
				throw new CookieException(global::SR.GetString("An error occurred when adding a cookie to the container."), ex);
			}
		}
	}

	private bool AgeCookies(string domain)
	{
		if (m_maxCookies == 0 || m_maxCookiesPerDomain == 0)
		{
			m_domainTable = new Hashtable();
			m_count = 0;
			return false;
		}
		int num = 0;
		DateTime dateTime = DateTime.MaxValue;
		CookieCollection cookieCollection = null;
		int num2 = 0;
		int num3 = 0;
		float num4 = 1f;
		if (m_count > m_maxCookies)
		{
			num4 = (float)m_maxCookies / (float)m_count;
		}
		lock (m_domainTable.SyncRoot)
		{
			foreach (DictionaryEntry item in m_domainTable)
			{
				PathList pathList;
				if (domain == null)
				{
					_ = (string)item.Key;
					pathList = (PathList)item.Value;
				}
				else
				{
					pathList = (PathList)m_domainTable[domain];
				}
				num2 = 0;
				lock (pathList.SyncRoot)
				{
					foreach (CookieCollection value in pathList.Values)
					{
						num3 = ExpireCollection(value);
						num += num3;
						m_count -= num3;
						num2 += value.Count;
						DateTime dateTime2;
						if (value.Count > 0 && (dateTime2 = value.TimeStamp(CookieCollection.Stamp.Check)) < dateTime)
						{
							cookieCollection = value;
							dateTime = dateTime2;
						}
					}
				}
				int num5 = Math.Min((int)((float)num2 * num4), Math.Min(m_maxCookiesPerDomain, m_maxCookies) - 1);
				if (num2 <= num5)
				{
					continue;
				}
				Array array;
				Array array2;
				lock (pathList.SyncRoot)
				{
					array = Array.CreateInstance(typeof(CookieCollection), pathList.Count);
					array2 = Array.CreateInstance(typeof(DateTime), pathList.Count);
					foreach (CookieCollection value2 in pathList.Values)
					{
						array2.SetValue(value2.TimeStamp(CookieCollection.Stamp.Check), num3);
						array.SetValue(value2, num3);
						num3++;
					}
				}
				Array.Sort(array2, array);
				num3 = 0;
				for (int i = 0; i < array.Length; i++)
				{
					CookieCollection cookieCollection4 = (CookieCollection)array.GetValue(i);
					lock (cookieCollection4)
					{
						while (num2 > num5 && cookieCollection4.Count > 0)
						{
							cookieCollection4.RemoveAt(0);
							num2--;
							m_count--;
							num++;
						}
					}
					if (num2 <= num5)
					{
						break;
					}
				}
				if (num2 > num5 && domain != null)
				{
					return false;
				}
			}
		}
		if (domain != null)
		{
			return true;
		}
		if (num != 0)
		{
			return true;
		}
		if (dateTime == DateTime.MaxValue)
		{
			return false;
		}
		lock (cookieCollection)
		{
			while (m_count >= m_maxCookies && cookieCollection.Count > 0)
			{
				cookieCollection.RemoveAt(0);
				m_count--;
			}
		}
		return true;
	}

	private int ExpireCollection(CookieCollection cc)
	{
		lock (cc)
		{
			int count = cc.Count;
			for (int num = count - 1; num >= 0; num--)
			{
				if (cc[num].Expired)
				{
					cc.RemoveAt(num);
				}
			}
			return count - cc.Count;
		}
	}

	public void Add(CookieCollection cookies)
	{
		if (cookies == null)
		{
			throw new ArgumentNullException("cookies");
		}
		foreach (Cookie cookie in cookies)
		{
			Add(cookie);
		}
	}

	internal bool IsLocalDomain(string host)
	{
		int num = host.IndexOf('.');
		if (num == -1)
		{
			return true;
		}
		switch (host)
		{
		case "127.0.0.1":
		case "::1":
		case "0:0:0:0:0:0:0:1":
			return true;
		default:
		{
			if (string.Compare(m_fqdnMyDomain, 0, host, num, m_fqdnMyDomain.Length, StringComparison.OrdinalIgnoreCase) == 0)
			{
				return true;
			}
			string[] array = host.Split('.');
			if (array != null && array.Length == 4 && array[0] == "127")
			{
				int i;
				for (i = 1; i < 4; i++)
				{
					switch (array[i].Length)
					{
					case 3:
						if (array[i][2] < '0' || array[i][2] > '9')
						{
							break;
						}
						goto case 2;
					case 2:
						if (array[i][1] < '0' || array[i][1] > '9')
						{
							break;
						}
						goto case 1;
					case 1:
						if (array[i][0] >= '0' && array[i][0] <= '9')
						{
							continue;
						}
						break;
					}
					break;
				}
				if (i == 4)
				{
					return true;
				}
			}
			return false;
		}
		}
	}

	public void Add(Uri uri, Cookie cookie)
	{
		if (uri == null)
		{
			throw new ArgumentNullException("uri");
		}
		if (cookie == null)
		{
			throw new ArgumentNullException("cookie");
		}
		Cookie cookie2 = cookie.Clone();
		cookie2.VerifySetDefaults(cookie2.Variant, uri, IsLocalDomain(uri.Host), m_fqdnMyDomain, set_default: true, isThrow: true);
		Add(cookie2, throwOnError: true);
	}

	public void Add(Uri uri, CookieCollection cookies)
	{
		if (uri == null)
		{
			throw new ArgumentNullException("uri");
		}
		if (cookies == null)
		{
			throw new ArgumentNullException("cookies");
		}
		bool isLocalDomain = IsLocalDomain(uri.Host);
		foreach (Cookie cookie2 in cookies)
		{
			Cookie cookie = cookie2.Clone();
			cookie.VerifySetDefaults(cookie.Variant, uri, isLocalDomain, m_fqdnMyDomain, set_default: true, isThrow: true);
			Add(cookie, throwOnError: true);
		}
	}

	internal CookieCollection CookieCutter(Uri uri, string headerName, string setCookieHeader, bool isThrow)
	{
		CookieCollection cookieCollection = new CookieCollection();
		CookieVariant variant = CookieVariant.Unknown;
		if (headerName == null)
		{
			variant = CookieVariant.Rfc2109;
		}
		else
		{
			for (int i = 0; i < HeaderInfo.Length; i++)
			{
				if (string.Compare(headerName, HeaderInfo[i].Name, StringComparison.OrdinalIgnoreCase) == 0)
				{
					variant = HeaderInfo[i].Variant;
				}
			}
		}
		bool isLocalDomain = IsLocalDomain(uri.Host);
		try
		{
			CookieParser cookieParser = new CookieParser(setCookieHeader);
			while (true)
			{
				Cookie cookie = cookieParser.Get();
				if (cookie == null)
				{
					break;
				}
				if (ValidationHelper.IsBlankString(cookie.Name))
				{
					if (isThrow)
					{
						throw new CookieException(global::SR.GetString("Cookie format error."));
					}
				}
				else if (cookie.VerifySetDefaults(variant, uri, isLocalDomain, m_fqdnMyDomain, set_default: true, isThrow))
				{
					cookieCollection.InternalAdd(cookie, isStrict: true);
				}
			}
		}
		catch (Exception ex)
		{
			if (ex is ThreadAbortException || ex is StackOverflowException || ex is OutOfMemoryException)
			{
				throw;
			}
			if (isThrow)
			{
				throw new CookieException(global::SR.GetString("An error occurred when parsing the Cookie header for Uri '{0}'.", uri.AbsoluteUri), ex);
			}
		}
		foreach (Cookie item in cookieCollection)
		{
			Add(item, isThrow);
		}
		return cookieCollection;
	}

	public CookieCollection GetCookies(Uri uri)
	{
		if (uri == null)
		{
			throw new ArgumentNullException("uri");
		}
		return InternalGetCookies(uri);
	}

	internal CookieCollection InternalGetCookies(Uri uri)
	{
		bool isSecure = uri.Scheme == Uri.UriSchemeHttps;
		int port = uri.Port;
		CookieCollection cookieCollection = new CookieCollection();
		List<string> list = new List<string>();
		List<string> list2 = new List<string>();
		string host = uri.Host;
		list.Add(host);
		list.Add("." + host);
		int num = host.IndexOf('.');
		if (num == -1)
		{
			if (m_fqdnMyDomain != null && m_fqdnMyDomain.Length != 0)
			{
				list.Add(host + m_fqdnMyDomain);
				list.Add(m_fqdnMyDomain);
			}
		}
		else
		{
			list.Add(host.Substring(num));
			if (host.Length > 2)
			{
				int num2 = host.LastIndexOf('.', host.Length - 2);
				if (num2 > 0)
				{
					num2 = host.LastIndexOf('.', num2 - 1);
				}
				if (num2 != -1)
				{
					while (num < num2 && (num = host.IndexOf('.', num + 1)) != -1)
					{
						list2.Add(host.Substring(num));
					}
				}
			}
		}
		BuildCookieCollectionFromDomainMatches(uri, isSecure, port, cookieCollection, list, matchOnlyPlainCookie: false);
		BuildCookieCollectionFromDomainMatches(uri, isSecure, port, cookieCollection, list2, matchOnlyPlainCookie: true);
		return cookieCollection;
	}

	private void BuildCookieCollectionFromDomainMatches(Uri uri, bool isSecure, int port, CookieCollection cookies, List<string> domainAttribute, bool matchOnlyPlainCookie)
	{
		for (int i = 0; i < domainAttribute.Count; i++)
		{
			bool flag = false;
			bool flag2 = false;
			PathList pathList;
			lock (m_domainTable.SyncRoot)
			{
				pathList = (PathList)m_domainTable[domainAttribute[i]];
			}
			if (pathList == null)
			{
				continue;
			}
			lock (pathList.SyncRoot)
			{
				foreach (DictionaryEntry item in pathList)
				{
					string text = (string)item.Key;
					if (uri.AbsolutePath.StartsWith(CookieParser.CheckQuoted(text)))
					{
						flag = true;
						CookieCollection cookieCollection = (CookieCollection)item.Value;
						cookieCollection.TimeStamp(CookieCollection.Stamp.Set);
						MergeUpdateCollections(cookies, cookieCollection, port, isSecure, matchOnlyPlainCookie);
						if (text == "/")
						{
							flag2 = true;
						}
					}
					else if (flag)
					{
						break;
					}
				}
			}
			if (!flag2)
			{
				CookieCollection cookieCollection2 = (CookieCollection)pathList["/"];
				if (cookieCollection2 != null)
				{
					cookieCollection2.TimeStamp(CookieCollection.Stamp.Set);
					MergeUpdateCollections(cookies, cookieCollection2, port, isSecure, matchOnlyPlainCookie);
				}
			}
			if (pathList.Count == 0)
			{
				AddRemoveDomain(domainAttribute[i], null);
			}
		}
	}

	private void MergeUpdateCollections(CookieCollection destination, CookieCollection source, int port, bool isSecure, bool isPlainOnly)
	{
		lock (source)
		{
			for (int i = 0; i < source.Count; i++)
			{
				bool flag = false;
				Cookie cookie = source[i];
				if (cookie.Expired)
				{
					source.RemoveAt(i);
					m_count--;
					i--;
					continue;
				}
				if (!isPlainOnly || cookie.Variant == CookieVariant.Plain)
				{
					if (cookie.PortList != null)
					{
						int[] portList = cookie.PortList;
						for (int j = 0; j < portList.Length; j++)
						{
							if (portList[j] == port)
							{
								flag = true;
								break;
							}
						}
					}
					else
					{
						flag = true;
					}
				}
				if (cookie.Secure && !isSecure)
				{
					flag = false;
				}
				if (flag)
				{
					destination.InternalAdd(cookie, isStrict: false);
				}
			}
		}
	}

	public string GetCookieHeader(Uri uri)
	{
		if (uri == null)
		{
			throw new ArgumentNullException("uri");
		}
		string optCookie;
		return GetCookieHeader(uri, out optCookie);
	}

	internal string GetCookieHeader(Uri uri, out string optCookie2)
	{
		CookieCollection cookieCollection = InternalGetCookies(uri);
		string text = string.Empty;
		string text2 = string.Empty;
		foreach (Cookie item in cookieCollection)
		{
			text = text + text2 + item.ToString();
			text2 = "; ";
		}
		optCookie2 = (cookieCollection.IsOtherVersionSeen ? ("$Version=" + 1.ToString(NumberFormatInfo.InvariantInfo)) : string.Empty);
		return text;
	}

	public void SetCookies(Uri uri, string cookieHeader)
	{
		if (uri == null)
		{
			throw new ArgumentNullException("uri");
		}
		if (cookieHeader == null)
		{
			throw new ArgumentNullException("cookieHeader");
		}
		CookieCutter(uri, null, cookieHeader, isThrow: true);
	}
}
