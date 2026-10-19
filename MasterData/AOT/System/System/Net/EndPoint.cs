using System.Net.Sockets;

namespace System.Net;

[Serializable]
public abstract class EndPoint
{
	public virtual AddressFamily AddressFamily
	{
		get
		{
			throw ExceptionHelper.PropertyNotImplementedException;
		}
	}

	public virtual SocketAddress Serialize()
	{
		throw ExceptionHelper.MethodNotImplementedException;
	}

	public virtual EndPoint Create(SocketAddress socketAddress)
	{
		throw ExceptionHelper.MethodNotImplementedException;
	}
}
