using System.Net.Sockets;
using System.Threading;

namespace Telepathy;

internal class ClientConnectionState : ConnectionState
{
	public Thread receiveThread;

	public volatile bool Connecting;

	public readonly MagnificentReceivePipe receivePipe;

	public bool Connected
	{
		get
		{
			if (client != null && client.Client != null)
			{
				return client.Client.Connected;
			}
			return false;
		}
	}

	public ClientConnectionState(int MaxMessageSize)
		: base(new TcpClient(), MaxMessageSize)
	{
		receivePipe = new MagnificentReceivePipe(MaxMessageSize);
	}

	public void Dispose()
	{
		client.Close();
		receiveThread?.Interrupt();
		Connecting = false;
		sendPipe.Clear();
		client = null;
	}
}
