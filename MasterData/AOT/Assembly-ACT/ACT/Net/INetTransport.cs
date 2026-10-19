using System;
using System.Threading.Tasks;

namespace ACT.Net;

internal interface INetTransport
{
	bool Connected { get; }

	bool CanSend { get; }

	bool IsDisconnectNotificationPending { get; }

	event Action<ArraySegment<byte>> DataReceived;

	event Action Disconnected;

	Task<bool> ConnectAsync(string host, int port, int timeoutMilliseconds);

	bool Send(ArraySegment<byte> data);

	void Disconnect();

	void Tick();

	void DebugLog();
}
