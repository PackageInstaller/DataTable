using System;
using System.Threading.Tasks;

namespace GameFramework.Network;

public interface INetworkChannel
{
	string Name { get; }

	bool Connected { get; }

	INetworkSubscription<EventArgs> Events();

	INetworkSubscription<INotification> Received();

	Task Connect(string hostname, int port, int timeoutMilliseconds);

	Task<T> Send<T>(IRequest request) where T : IResponse;

	Task<T> Send<T>(IRequest request, int timeoutMilliseconds) where T : IResponse;

	Task Send(INotification notification);

	Task Disconnect();

	Task Reconnect();

	Task Shutdown();

	void Dispose();
}
