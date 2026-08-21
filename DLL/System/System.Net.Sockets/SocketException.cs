using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Runtime.Serialization;

namespace System.Net.Sockets;

[Serializable]
public class SocketException : Win32Exception
{
	[NonSerialized]
	private EndPoint m_EndPoint;

	public override string Message
	{
		get
		{
			if (m_EndPoint == null)
			{
				return base.Message;
			}
			return base.Message + " " + m_EndPoint.ToString();
		}
	}

	public SocketError SocketErrorCode => (SocketError)base.NativeErrorCode;

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int WSAGetLastError_icall();

	public SocketException()
		: base(WSAGetLastError_icall())
	{
	}

	internal SocketException(int error, string message)
		: base(error, message)
	{
	}

	public SocketException(int errorCode)
		: base(errorCode)
	{
	}

	internal SocketException(SocketError socketError)
		: base((int)socketError)
	{
	}

	protected SocketException(SerializationInfo serializationInfo, StreamingContext streamingContext)
		: base(serializationInfo, streamingContext)
	{
	}
}
