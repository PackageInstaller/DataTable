using System.Net.Sockets;
using System.Threading;

namespace Telepathy;

public class ConnectionState
{
	public TcpClient client;

	public readonly MagnificentSendPipe sendPipe;

	public ManualResetEvent sendPending = new ManualResetEvent(initialState: false);

	public ConnectionState(TcpClient client, int MaxMessageSize)
	{
		this.client = client;
		sendPipe = new MagnificentSendPipe(MaxMessageSize);
	}
}
