using System.Threading;
using System.Threading.Tasks;

namespace System.Net.Sockets;

public class TcpClient : IDisposable
{
	private Socket m_ClientSocket;

	private bool m_Active;

	private NetworkStream m_DataStream;

	private AddressFamily m_Family = AddressFamily.InterNetwork;

	private bool m_CleanedUp;

	public Socket Client
	{
		get
		{
			return m_ClientSocket;
		}
		set
		{
			m_ClientSocket = value;
		}
	}

	public int ReceiveBufferSize
	{
		set
		{
			Client.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.ReceiveBuffer, value);
		}
	}

	public int SendBufferSize
	{
		set
		{
			Client.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.SendBuffer, value);
		}
	}

	public LingerOption LingerState => (LingerOption)Client.GetSocketOption(SocketOptionLevel.Socket, SocketOptionName.Linger);

	public bool NoDelay
	{
		set
		{
			Client.SetSocketOption(SocketOptionLevel.Tcp, SocketOptionName.Debug, value ? 1 : 0);
		}
	}

	public TcpClient()
		: this(AddressFamily.InterNetwork)
	{
		_ = Logging.On;
		_ = Logging.On;
	}

	public TcpClient(AddressFamily family)
	{
		_ = Logging.On;
		if (family != AddressFamily.InterNetwork && family != AddressFamily.InterNetworkV6)
		{
			throw new ArgumentException(global::SR.GetString("'{0}' Client can only accept InterNetwork or InterNetworkV6 addresses.", "TCP"), "family");
		}
		m_Family = family;
		initialize();
		_ = Logging.On;
	}

	public void Connect(string hostname, int port)
	{
		_ = Logging.On;
		if (m_CleanedUp)
		{
			throw new ObjectDisposedException(GetType().FullName);
		}
		if (hostname == null)
		{
			throw new ArgumentNullException("hostname");
		}
		if (!ValidationHelper.ValidateTcpPort(port))
		{
			throw new ArgumentOutOfRangeException("port");
		}
		if (m_Active)
		{
			throw new SocketException(SocketError.IsConnected);
		}
		IPAddress[] hostAddresses = Dns.GetHostAddresses(hostname);
		Exception ex = null;
		Socket socket = null;
		Socket socket2 = null;
		try
		{
			if (m_ClientSocket == null)
			{
				if (Socket.OSSupportsIPv4)
				{
					socket2 = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
				}
				if (Socket.OSSupportsIPv6)
				{
					socket = new Socket(AddressFamily.InterNetworkV6, SocketType.Stream, ProtocolType.Tcp);
				}
			}
			IPAddress[] array = hostAddresses;
			foreach (IPAddress iPAddress in array)
			{
				try
				{
					if (m_ClientSocket == null)
					{
						if (iPAddress.AddressFamily == AddressFamily.InterNetwork && socket2 != null)
						{
							socket2.Connect(iPAddress, port);
							m_ClientSocket = socket2;
							socket?.Close();
						}
						else if (socket != null)
						{
							socket.Connect(iPAddress, port);
							m_ClientSocket = socket;
							socket2?.Close();
						}
						m_Family = iPAddress.AddressFamily;
						m_Active = true;
						break;
					}
					if (iPAddress.AddressFamily == m_Family)
					{
						Connect(new IPEndPoint(iPAddress, port));
						m_Active = true;
						break;
					}
				}
				catch (Exception ex2)
				{
					if (ex2 is ThreadAbortException || ex2 is StackOverflowException || ex2 is OutOfMemoryException)
					{
						throw;
					}
					ex = ex2;
				}
			}
		}
		catch (Exception ex3)
		{
			if (ex3 is ThreadAbortException || ex3 is StackOverflowException || ex3 is OutOfMemoryException)
			{
				throw;
			}
			ex = ex3;
		}
		finally
		{
			if (!m_Active)
			{
				socket?.Close();
				socket2?.Close();
				if (ex != null)
				{
					throw ex;
				}
				throw new SocketException(SocketError.NotConnected);
			}
		}
		_ = Logging.On;
	}

	public void Connect(IPEndPoint remoteEP)
	{
		_ = Logging.On;
		if (m_CleanedUp)
		{
			throw new ObjectDisposedException(GetType().FullName);
		}
		if (remoteEP == null)
		{
			throw new ArgumentNullException("remoteEP");
		}
		Client.Connect(remoteEP);
		m_Active = true;
		_ = Logging.On;
	}

	public IAsyncResult BeginConnect(string host, int port, AsyncCallback requestCallback, object state)
	{
		_ = Logging.On;
		IAsyncResult result = Client.BeginConnect(host, port, requestCallback, state);
		_ = Logging.On;
		return result;
	}

	public IAsyncResult BeginConnect(IPAddress address, int port, AsyncCallback requestCallback, object state)
	{
		_ = Logging.On;
		IAsyncResult result = Client.BeginConnect(address, port, requestCallback, state);
		_ = Logging.On;
		return result;
	}

	public void EndConnect(IAsyncResult asyncResult)
	{
		_ = Logging.On;
		Client.EndConnect(asyncResult);
		m_Active = true;
		_ = Logging.On;
	}

	public Task ConnectAsync(string host, int port)
	{
		return Task.Factory.FromAsync(BeginConnect, EndConnect, host, port, null);
	}

	public NetworkStream GetStream()
	{
		_ = Logging.On;
		if (m_CleanedUp)
		{
			throw new ObjectDisposedException(GetType().FullName);
		}
		if (!Client.Connected)
		{
			throw new InvalidOperationException(global::SR.GetString("The operation is not allowed on non-connected sockets."));
		}
		if (m_DataStream == null)
		{
			m_DataStream = new NetworkStream(Client, ownsSocket: true);
		}
		_ = Logging.On;
		return m_DataStream;
	}

	public void Close()
	{
		_ = Logging.On;
		((IDisposable)this).Dispose();
		_ = Logging.On;
	}

	protected virtual void Dispose(bool disposing)
	{
		_ = Logging.On;
		if (m_CleanedUp)
		{
			_ = Logging.On;
			return;
		}
		if (disposing)
		{
			IDisposable dataStream = m_DataStream;
			if (dataStream != null)
			{
				dataStream.Dispose();
			}
			else
			{
				Socket client = Client;
				if (client != null)
				{
					try
					{
						client.InternalShutdown(SocketShutdown.Both);
					}
					finally
					{
						client.Close();
						Client = null;
					}
				}
			}
			GC.SuppressFinalize(this);
		}
		m_CleanedUp = true;
		_ = Logging.On;
	}

	public void Dispose()
	{
		Dispose(disposing: true);
	}

	~TcpClient()
	{
		Dispose(disposing: false);
	}

	private void initialize()
	{
		Client = new Socket(m_Family, SocketType.Stream, ProtocolType.Tcp);
		m_Active = false;
	}
}
