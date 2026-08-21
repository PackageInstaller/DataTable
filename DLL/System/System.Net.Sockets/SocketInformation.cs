using System.Runtime.Serialization;

namespace System.Net.Sockets;

[Serializable]
public struct SocketInformation
{
	private byte[] protocolInformation;

	private SocketInformationOptions options;

	[OptionalField]
	private EndPoint remoteEndPoint;

	public byte[] ProtocolInformation
	{
		get
		{
			return protocolInformation;
		}
		set
		{
			protocolInformation = value;
		}
	}

	public SocketInformationOptions Options
	{
		get
		{
			return options;
		}
		set
		{
			options = value;
		}
	}
}
