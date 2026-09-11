using System.Runtime.Serialization;

namespace System.Net.Sockets;

[Serializable]
public struct SocketInformation
{
	private byte[] protocolInformation;

	private SocketInformationOptions options;

	[OptionalField]
	private EndPoint remoteEndPoint;

	public byte[] ProtocolInformation => protocolInformation;

	public SocketInformationOptions Options => options;
}
