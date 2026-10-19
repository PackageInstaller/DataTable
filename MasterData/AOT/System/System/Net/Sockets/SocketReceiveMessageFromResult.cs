namespace System.Net.Sockets;

public struct SocketReceiveMessageFromResult
{
	public int ReceivedBytes;

	public SocketFlags SocketFlags;

	public EndPoint RemoteEndPoint;

	public IPPacketInformation PacketInformation;
}
