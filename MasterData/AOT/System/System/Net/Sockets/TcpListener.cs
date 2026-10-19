using System.Threading.Tasks;

namespace System.Net.Sockets;

public class TcpListener
{
	private IPEndPoint m_ServerSocketEP;

	private Socket m_ServerSocket;

	private bool m_Active;

	private bool m_ExclusiveAddressUse;

	public Socket Server => m_ServerSocket;

	protected bool Active => m_Active;

	public EndPoint LocalEndpoint
	{
		get
		{
			if (!m_Active)
			{
				return m_ServerSocketEP;
			}
			return m_ServerSocket.LocalEndPoint;
		}
	}

	public bool ExclusiveAddressUse
	{
		get
		{
			return m_ServerSocket.ExclusiveAddressUse;
		}
		set
		{
			if (m_Active)
			{
				throw new InvalidOperationException(SR.GetString("The TcpListener must not be listening before performing this operation."));
			}
			m_ServerSocket.ExclusiveAddressUse = value;
			m_ExclusiveAddressUse = value;
		}
	}

	public TcpListener(IPEndPoint localEP)
	{
		_ = Logging.On;
		if (localEP == null)
		{
			throw new ArgumentNullException("localEP");
		}
		m_ServerSocketEP = localEP;
		m_ServerSocket = new Socket(m_ServerSocketEP.AddressFamily, SocketType.Stream, ProtocolType.Tcp);
		_ = Logging.On;
	}

	public TcpListener(IPAddress localaddr, int port)
	{
		_ = Logging.On;
		if (localaddr == null)
		{
			throw new ArgumentNullException("localaddr");
		}
		if (!ValidationHelper.ValidateTcpPort(port))
		{
			throw new ArgumentOutOfRangeException("port");
		}
		m_ServerSocketEP = new IPEndPoint(localaddr, port);
		m_ServerSocket = new Socket(m_ServerSocketEP.AddressFamily, SocketType.Stream, ProtocolType.Tcp);
		_ = Logging.On;
	}

	[Obsolete("This method has been deprecated. Please use TcpListener(IPAddress localaddr, int port) instead. http://go.microsoft.com/fwlink/?linkid=14202")]
	public TcpListener(int port)
	{
		if (!ValidationHelper.ValidateTcpPort(port))
		{
			throw new ArgumentOutOfRangeException("port");
		}
		m_ServerSocketEP = new IPEndPoint(IPAddress.Any, port);
		m_ServerSocket = new Socket(m_ServerSocketEP.AddressFamily, SocketType.Stream, ProtocolType.Tcp);
	}

	public static TcpListener Create(int port)
	{
		_ = Logging.On;
		if (!ValidationHelper.ValidateTcpPort(port))
		{
			throw new ArgumentOutOfRangeException("port");
		}
		TcpListener tcpListener = new TcpListener(IPAddress.IPv6Any, port);
		tcpListener.Server.DualMode = true;
		_ = Logging.On;
		return tcpListener;
	}

	public void AllowNatTraversal(bool allowed)
	{
		if (m_Active)
		{
			throw new InvalidOperationException(SR.GetString("The TcpListener must not be listening before performing this operation."));
		}
		if (allowed)
		{
			m_ServerSocket.SetIPProtectionLevel(IPProtectionLevel.Unrestricted);
		}
		else
		{
			m_ServerSocket.SetIPProtectionLevel(IPProtectionLevel.EdgeRestricted);
		}
	}

	public void Start()
	{
		Start(int.MaxValue);
	}

	public void Start(int backlog)
	{
		if (backlog > int.MaxValue || backlog < 0)
		{
			throw new ArgumentOutOfRangeException("backlog");
		}
		_ = Logging.On;
		if (m_ServerSocket == null)
		{
			throw new InvalidOperationException(SR.GetString("The socket handle is not valid."));
		}
		if (m_Active)
		{
			_ = Logging.On;
			return;
		}
		m_ServerSocket.Bind(m_ServerSocketEP);
		try
		{
			m_ServerSocket.Listen(backlog);
		}
		catch (SocketException)
		{
			Stop();
			throw;
		}
		m_Active = true;
		_ = Logging.On;
	}

	public void Stop()
	{
		_ = Logging.On;
		if (m_ServerSocket != null)
		{
			m_ServerSocket.Close();
			m_ServerSocket = null;
		}
		m_Active = false;
		m_ServerSocket = new Socket(m_ServerSocketEP.AddressFamily, SocketType.Stream, ProtocolType.Tcp);
		if (m_ExclusiveAddressUse)
		{
			m_ServerSocket.ExclusiveAddressUse = true;
		}
		_ = Logging.On;
	}

	public bool Pending()
	{
		if (!m_Active)
		{
			throw new InvalidOperationException(SR.GetString("Not listening. You must call the Start() method before calling this method."));
		}
		return m_ServerSocket.Poll(0, SelectMode.SelectRead);
	}

	public Socket AcceptSocket()
	{
		_ = Logging.On;
		if (!m_Active)
		{
			throw new InvalidOperationException(SR.GetString("Not listening. You must call the Start() method before calling this method."));
		}
		Socket result = m_ServerSocket.Accept();
		_ = Logging.On;
		return result;
	}

	public TcpClient AcceptTcpClient()
	{
		_ = Logging.On;
		if (!m_Active)
		{
			throw new InvalidOperationException(SR.GetString("Not listening. You must call the Start() method before calling this method."));
		}
		TcpClient result = new TcpClient(m_ServerSocket.Accept());
		_ = Logging.On;
		return result;
	}

	public IAsyncResult BeginAcceptSocket(AsyncCallback callback, object state)
	{
		_ = Logging.On;
		if (!m_Active)
		{
			throw new InvalidOperationException(SR.GetString("Not listening. You must call the Start() method before calling this method."));
		}
		IAsyncResult result = m_ServerSocket.BeginAccept(callback, state);
		_ = Logging.On;
		return result;
	}

	public Socket EndAcceptSocket(IAsyncResult asyncResult)
	{
		_ = Logging.On;
		if (asyncResult == null)
		{
			throw new ArgumentNullException("asyncResult");
		}
		Socket result = (((!(asyncResult is SocketAsyncResult socketAsyncResult)) ? null : socketAsyncResult.socket) ?? throw new ArgumentException(SR.GetString("The IAsyncResult object was not returned from the corresponding asynchronous method on this class."), "asyncResult")).EndAccept(asyncResult);
		_ = Logging.On;
		return result;
	}

	public IAsyncResult BeginAcceptTcpClient(AsyncCallback callback, object state)
	{
		_ = Logging.On;
		if (!m_Active)
		{
			throw new InvalidOperationException(SR.GetString("Not listening. You must call the Start() method before calling this method."));
		}
		IAsyncResult result = m_ServerSocket.BeginAccept(callback, state);
		_ = Logging.On;
		return result;
	}

	public TcpClient EndAcceptTcpClient(IAsyncResult asyncResult)
	{
		_ = Logging.On;
		if (asyncResult == null)
		{
			throw new ArgumentNullException("asyncResult");
		}
		Socket acceptedSocket = (((!(asyncResult is SocketAsyncResult socketAsyncResult)) ? null : socketAsyncResult.socket) ?? throw new ArgumentException(SR.GetString("The IAsyncResult object was not returned from the corresponding asynchronous method on this class."), "asyncResult")).EndAccept(asyncResult);
		_ = Logging.On;
		return new TcpClient(acceptedSocket);
	}

	public Task<Socket> AcceptSocketAsync()
	{
		return Task<Socket>.Factory.FromAsync(BeginAcceptSocket, EndAcceptSocket, null);
	}

	public Task<TcpClient> AcceptTcpClientAsync()
	{
		return Task<TcpClient>.Factory.FromAsync(BeginAcceptTcpClient, EndAcceptTcpClient, null);
	}
}
