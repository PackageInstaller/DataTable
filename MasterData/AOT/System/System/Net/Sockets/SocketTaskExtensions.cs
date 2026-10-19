using System.Threading.Tasks;

namespace System.Net.Sockets;

public static class SocketTaskExtensions
{
	public static Task ConnectAsync(this Socket socket, string host, int port)
	{
		return Task.Factory.FromAsync((string targetHost, int targetPort, AsyncCallback callback, object state) => ((Socket)state).BeginConnect(targetHost, targetPort, callback, state), (IAsyncResult asyncResult) =>
		{
			((Socket)asyncResult.AsyncState).EndConnect(asyncResult);
		}, host, port, socket);
	}
}
