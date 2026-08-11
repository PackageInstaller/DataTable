using System.Globalization;
using System.Net.Sockets;

namespace System.Net;

[Serializable]
public class IPEndPoint : EndPoint
{
	public const int MinPort = 0;

	public const int MaxPort = 65535;

	private IPAddress _address;

	private int _port;

	internal const int AnyPort = 0;

	internal static IPEndPoint Any = new IPEndPoint(IPAddress.Any, 0);

	internal static IPEndPoint IPv6Any = new IPEndPoint(IPAddress.IPv6Any, 0);

	public override AddressFamily AddressFamily => _address.AddressFamily;

	public IPAddress Address
	{
		get
		{
			return _address;
		}
		set
		{
			_address = value;
		}
	}

	public int Port
	{
		get
		{
			return _port;
		}
		set
		{
			if (!TcpValidationHelpers.ValidatePortNumber(value))
			{
				throw new ArgumentOutOfRangeException("value");
			}
			_port = value;
		}
	}

	public IPEndPoint(long address, int port)
	{
		if (!TcpValidationHelpers.ValidatePortNumber(port))
		{
			throw new ArgumentOutOfRangeException("port");
		}
		_port = port;
		_address = new IPAddress(address);
	}

	public IPEndPoint(IPAddress address, int port)
	{
		if (address == null)
		{
			throw new ArgumentNullException("address");
		}
		if (!TcpValidationHelpers.ValidatePortNumber(port))
		{
			throw new ArgumentOutOfRangeException("port");
		}
		_port = port;
		_address = address;
	}

	public override string ToString()
	{
		return string.Format((_address.AddressFamily == AddressFamily.InterNetworkV6) ? "[{0}]:{1}" : "{0}:{1}", _address.ToString(), Port.ToString(NumberFormatInfo.InvariantInfo));
	}

	public override SocketAddress Serialize()
	{
		return new SocketAddress(Address, Port);
	}

	public override EndPoint Create(SocketAddress socketAddress)
	{
		if (socketAddress.Family != AddressFamily)
		{
			throw new ArgumentException(global::SR.Format("The AddressFamily {0} is not valid for the {1} end point, use {2} instead.", socketAddress.Family.ToString(), GetType().FullName, AddressFamily.ToString()), "socketAddress");
		}
		if (socketAddress.Size < 8)
		{
			throw new ArgumentException(global::SR.Format("The supplied {0} is an invalid size for the {1} end point.", socketAddress.GetType().FullName, GetType().FullName), "socketAddress");
		}
		return socketAddress.GetIPEndPoint();
	}

	public override bool Equals(object comparand)
	{
		if (comparand is IPEndPoint iPEndPoint && iPEndPoint._address.Equals(_address))
		{
			return iPEndPoint._port == _port;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return _address.GetHashCode() ^ _port;
	}
}
