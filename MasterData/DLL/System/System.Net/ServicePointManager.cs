using System.Collections.Concurrent;
using System.Net.Security;
using System.Threading;

namespace System.Net;

public class ServicePointManager
{
	internal class SPKey
	{
		private Uri uri;

		private Uri proxy;

		private bool use_connect;

		public bool UsesProxy => proxy != null;

		public SPKey(Uri uri, Uri proxy, bool use_connect)
		{
			this.uri = uri;
			this.proxy = proxy;
			this.use_connect = use_connect;
		}

		public override int GetHashCode()
		{
			return ((23 * 31 + (use_connect ? 1 : 0)) * 31 + uri.GetHashCode()) * 31 + ((proxy != null) ? proxy.GetHashCode() : 0);
		}

		public override bool Equals(object obj)
		{
			SPKey sPKey = obj as SPKey;
			if (obj == null)
			{
				return false;
			}
			if (!uri.Equals(sPKey.uri))
			{
				return false;
			}
			if (use_connect != sPKey.use_connect || UsesProxy != sPKey.UsesProxy)
			{
				return false;
			}
			if (UsesProxy && !proxy.Equals(sPKey.proxy))
			{
				return false;
			}
			return true;
		}
	}

	private static ConcurrentDictionary<SPKey, ServicePoint> servicePoints;

	private static ICertificatePolicy policy;

	private static int defaultConnectionLimit;

	private static int maxServicePointIdleTime;

	private static int maxServicePoints;

	private static int dnsRefreshTimeout;

	private static bool _checkCRL;

	private static SecurityProtocolType _securityProtocol;

	private static bool expectContinue;

	private static bool useNagle;

	private static ServerCertValidationCallback server_cert_cb;

	private static bool tcp_keepalive;

	private static int tcp_keepalive_time;

	private static int tcp_keepalive_interval;

	public const int DefaultNonPersistentConnectionLimit = 4;

	public const int DefaultPersistentConnectionLimit = 10;

	[Obsolete("Use ServerCertificateValidationCallback instead", false)]
	public static ICertificatePolicy CertificatePolicy
	{
		get
		{
			if (policy == null)
			{
				Interlocked.CompareExchange(ref policy, new DefaultCertificatePolicy(), null);
			}
			return policy;
		}
		set
		{
			policy = value;
		}
	}

	[System.MonoTODO("CRL checks not implemented")]
	public static bool CheckCertificateRevocationList
	{
		get
		{
			return _checkCRL;
		}
		set
		{
			_checkCRL = false;
		}
	}

	public static int DefaultConnectionLimit
	{
		get
		{
			return defaultConnectionLimit;
		}
		set
		{
			if (value <= 0)
			{
				throw new ArgumentOutOfRangeException("value");
			}
			defaultConnectionLimit = value;
		}
	}

	public static int DnsRefreshTimeout
	{
		get
		{
			return dnsRefreshTimeout;
		}
		set
		{
			dnsRefreshTimeout = Math.Max(-1, value);
		}
	}

	[System.MonoTODO]
	public static bool EnableDnsRoundRobin
	{
		get
		{
			throw GetMustImplement();
		}
		set
		{
			throw GetMustImplement();
		}
	}

	public static int MaxServicePointIdleTime
	{
		get
		{
			return maxServicePointIdleTime;
		}
		set
		{
			if (value < -2 || value > int.MaxValue)
			{
				throw new ArgumentOutOfRangeException("value");
			}
			maxServicePointIdleTime = value;
		}
	}

	public static int MaxServicePoints
	{
		get
		{
			return maxServicePoints;
		}
		set
		{
			if (value < 0)
			{
				throw new ArgumentException("value");
			}
			maxServicePoints = value;
		}
	}

	[System.MonoTODO]
	public static bool ReusePort
	{
		get
		{
			return false;
		}
		set
		{
			throw new NotImplementedException();
		}
	}

	public static SecurityProtocolType SecurityProtocol
	{
		get
		{
			return _securityProtocol;
		}
		set
		{
			_securityProtocol = value;
		}
	}

	internal static ServerCertValidationCallback ServerCertValidationCallback => server_cert_cb;

	public static RemoteCertificateValidationCallback ServerCertificateValidationCallback
	{
		get
		{
			if (server_cert_cb == null)
			{
				return null;
			}
			return server_cert_cb.ValidationCallback;
		}
		set
		{
			if (value == null)
			{
				server_cert_cb = null;
			}
			else
			{
				server_cert_cb = new ServerCertValidationCallback(value);
			}
		}
	}

	[System.MonoTODO("Always returns EncryptionPolicy.RequireEncryption.")]
	public static EncryptionPolicy EncryptionPolicy => EncryptionPolicy.RequireEncryption;

	public static bool Expect100Continue
	{
		get
		{
			return expectContinue;
		}
		set
		{
			expectContinue = value;
		}
	}

	public static bool UseNagleAlgorithm
	{
		get
		{
			return useNagle;
		}
		set
		{
			useNagle = value;
		}
	}

	internal static bool DisableStrongCrypto => false;

	internal static bool DisableSendAuxRecord => false;

	[Obsolete("This API is no longer supported.", true)]
	public static CipherSuitesCallback ClientCipherSuitesCallback { get; set; }

	[Obsolete("This API is no longer supported.", true)]
	public static CipherSuitesCallback ServerCipherSuitesCallback { get; set; }

	static ServicePointManager()
	{
		servicePoints = new ConcurrentDictionary<SPKey, ServicePoint>();
		defaultConnectionLimit = 10;
		maxServicePointIdleTime = 100000;
		maxServicePoints = 0;
		dnsRefreshTimeout = 120000;
		_checkCRL = false;
		_securityProtocol = SecurityProtocolType.SystemDefault;
		expectContinue = true;
	}

	private ServicePointManager()
	{
	}

	internal static ICertificatePolicy GetLegacyCertificatePolicy()
	{
		return policy;
	}

	private static Exception GetMustImplement()
	{
		return new NotImplementedException();
	}

	public static void SetTcpKeepAlive(bool enabled, int keepAliveTime, int keepAliveInterval)
	{
		if (enabled)
		{
			if (keepAliveTime <= 0)
			{
				throw new ArgumentOutOfRangeException("keepAliveTime", "Must be greater than 0");
			}
			if (keepAliveInterval <= 0)
			{
				throw new ArgumentOutOfRangeException("keepAliveInterval", "Must be greater than 0");
			}
		}
		tcp_keepalive = enabled;
		tcp_keepalive_time = keepAliveTime;
		tcp_keepalive_interval = keepAliveInterval;
	}

	public static ServicePoint FindServicePoint(Uri address)
	{
		return FindServicePoint(address, null);
	}

	public static ServicePoint FindServicePoint(string uriString, IWebProxy proxy)
	{
		return FindServicePoint(new Uri(uriString), proxy);
	}

	public static ServicePoint FindServicePoint(Uri address, IWebProxy proxy)
	{
		if (address == null)
		{
			throw new ArgumentNullException("address");
		}
		Uri uri = new Uri(address.Scheme + "://" + address.Authority);
		bool flag = false;
		bool flag2 = false;
		if (proxy != null && !proxy.IsBypassed(address))
		{
			flag = true;
			bool num = address.Scheme == "https";
			address = proxy.GetProxy(address);
			if (address.Scheme != "http")
			{
				throw new NotSupportedException("Proxy scheme not supported.");
			}
			if (num && address.Scheme == "http")
			{
				flag2 = true;
			}
		}
		address = new Uri(address.Scheme + "://" + address.Authority);
		SPKey key = new SPKey(uri, flag ? address : null, flag2);
		lock (servicePoints)
		{
			if (servicePoints.TryGetValue(key, out var value))
			{
				return value;
			}
			if (maxServicePoints > 0 && servicePoints.Count >= maxServicePoints)
			{
				throw new InvalidOperationException("maximum number of service points reached");
			}
			int connectionLimit = defaultConnectionLimit;
			value = new ServicePoint(key, address, connectionLimit, maxServicePointIdleTime);
			value.Expect100Continue = expectContinue;
			value.UseNagleAlgorithm = useNagle;
			value.UsesProxy = flag;
			value.UseConnect = flag2;
			value.SetTcpKeepAlive(tcp_keepalive, tcp_keepalive_time, tcp_keepalive_interval);
			return servicePoints.GetOrAdd(key, value);
		}
	}

	internal static void CloseConnectionGroup(string connectionGroupName)
	{
		lock (servicePoints)
		{
			foreach (ServicePoint value in servicePoints.Values)
			{
				value.CloseConnectionGroup(connectionGroupName);
			}
		}
	}

	internal static void RemoveServicePoint(ServicePoint sp)
	{
		servicePoints.TryRemove(sp.Key, out var _);
	}
}
