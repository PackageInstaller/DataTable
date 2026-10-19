using System.Net.Sockets;
using System.Security.Cryptography.X509Certificates;

namespace System.Net;

public class ServicePoint
{
	private readonly Uri uri;

	private DateTime lastDnsResolve;

	private Version protocolVersion;

	private IPHostEntry host;

	private bool usesProxy;

	private bool sendContinue = true;

	private bool useConnect;

	private object hostE = new object();

	private bool useNagle;

	private BindIPEndPoint endPointCallback;

	private bool tcp_keepalive;

	private int tcp_keepalive_time;

	private int tcp_keepalive_interval;

	private bool disposed;

	private int connectionLeaseTimeout = -1;

	private int receiveBufferSize = -1;

	private int connectionLimit;

	private int maxIdleTime;

	private object m_ServerCertificateOrBytes;

	private object m_ClientCertificateOrBytes;

	internal ServicePointManager.SPKey Key { get; }

	private ServicePointScheduler Scheduler { get; set; }

	public Uri Address => uri;

	public int ConnectionLimit => connectionLimit;

	public virtual Version ProtocolVersion => protocolVersion;

	public bool Expect100Continue
	{
		set
		{
			SendContinue = value;
		}
	}

	public bool UseNagleAlgorithm
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

	internal bool SendContinue
	{
		get
		{
			if (sendContinue)
			{
				if (!(protocolVersion == null))
				{
					return protocolVersion == HttpVersion.Version11;
				}
				return true;
			}
			return false;
		}
		set
		{
			sendContinue = value;
		}
	}

	internal bool UsesProxy
	{
		get
		{
			return usesProxy;
		}
		set
		{
			usesProxy = value;
		}
	}

	internal bool UseConnect
	{
		get
		{
			return useConnect;
		}
		set
		{
			useConnect = value;
		}
	}

	private bool HasTimedOut
	{
		get
		{
			int dnsRefreshTimeout = ServicePointManager.DnsRefreshTimeout;
			if (dnsRefreshTimeout != -1)
			{
				return lastDnsResolve + TimeSpan.FromMilliseconds(dnsRefreshTimeout) < DateTime.UtcNow;
			}
			return false;
		}
	}

	internal IPHostEntry HostEntry
	{
		get
		{
			lock (hostE)
			{
				string text = uri.Host;
				if (uri.HostNameType == UriHostNameType.IPv6 || uri.HostNameType == UriHostNameType.IPv4)
				{
					if (host != null)
					{
						return host;
					}
					if (uri.HostNameType == UriHostNameType.IPv6)
					{
						text = text.Substring(1, text.Length - 2);
					}
					host = new IPHostEntry();
					host.AddressList = new IPAddress[1] { IPAddress.Parse(text) };
					return host;
				}
				if (!HasTimedOut && host != null)
				{
					return host;
				}
				lastDnsResolve = DateTime.UtcNow;
				try
				{
					host = Dns.GetHostEntry(text);
				}
				catch
				{
					return null;
				}
			}
			return host;
		}
	}

	internal ServicePoint(ServicePointManager.SPKey key, Uri uri, int connectionLimit, int maxIdleTime)
	{
		Key = key;
		this.uri = uri;
		this.connectionLimit = connectionLimit;
		this.maxIdleTime = maxIdleTime;
		Scheduler = new ServicePointScheduler(this, connectionLimit, maxIdleTime);
	}

	public void SetTcpKeepAlive(bool enabled, int keepAliveTime, int keepAliveInterval)
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

	internal void KeepAliveSetup(Socket socket)
	{
		if (tcp_keepalive)
		{
			byte[] array = new byte[12];
			PutBytes(array, tcp_keepalive ? 1u : 0u, 0);
			PutBytes(array, (uint)tcp_keepalive_time, 4);
			PutBytes(array, (uint)tcp_keepalive_interval, 8);
			socket.IOControl(IOControlCode.KeepAliveValues, array, null);
		}
	}

	private static void PutBytes(byte[] bytes, uint v, int offset)
	{
		if (BitConverter.IsLittleEndian)
		{
			bytes[offset] = (byte)(v & 0xFF);
			bytes[offset + 1] = (byte)((v & 0xFF00) >> 8);
			bytes[offset + 2] = (byte)((v & 0xFF0000) >> 16);
			bytes[offset + 3] = (byte)((v & 0xFF000000u) >> 24);
		}
		else
		{
			bytes[offset + 3] = (byte)(v & 0xFF);
			bytes[offset + 2] = (byte)((v & 0xFF00) >> 8);
			bytes[offset + 1] = (byte)((v & 0xFF0000) >> 16);
			bytes[offset] = (byte)((v & 0xFF000000u) >> 24);
		}
	}

	internal void SetVersion(Version version)
	{
		protocolVersion = version;
	}

	internal void SendRequest(WebOperation operation, string groupName)
	{
		lock (this)
		{
			if (disposed)
			{
				throw new ObjectDisposedException(typeof(ServicePoint).FullName);
			}
			Scheduler.SendRequest(operation, groupName);
		}
	}

	public bool CloseConnectionGroup(string connectionGroupName)
	{
		lock (this)
		{
			if (disposed)
			{
				return true;
			}
			return Scheduler.CloseConnectionGroup(connectionGroupName);
		}
	}

	internal void FreeServicePoint()
	{
		disposed = true;
		Scheduler = null;
	}

	internal void UpdateServerCertificate(X509Certificate certificate)
	{
		if (certificate != null)
		{
			m_ServerCertificateOrBytes = certificate.GetRawCertData();
		}
		else
		{
			m_ServerCertificateOrBytes = null;
		}
	}

	internal void UpdateClientCertificate(X509Certificate certificate)
	{
		if (certificate != null)
		{
			m_ClientCertificateOrBytes = certificate.GetRawCertData();
		}
		else
		{
			m_ClientCertificateOrBytes = null;
		}
	}

	internal bool CallEndPointDelegate(Socket sock, IPEndPoint remote)
	{
		if (endPointCallback == null)
		{
			return true;
		}
		int num = 0;
		while (true)
		{
			IPEndPoint iPEndPoint = null;
			try
			{
				iPEndPoint = endPointCallback(this, remote, num);
			}
			catch
			{
				return false;
			}
			if (iPEndPoint == null)
			{
				return true;
			}
			try
			{
				sock.Bind(iPEndPoint);
			}
			catch (SocketException)
			{
				num = checked(num + 1);
				continue;
			}
			break;
		}
		return true;
	}
}
