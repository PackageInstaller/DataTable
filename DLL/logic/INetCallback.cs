using XServer;

public interface INetCallback
{
	SimContext mSimContext { get; set; }

	CommandRouter mRouter { get; set; }

	ClientNetworkSystem mUDPClientNet { get; set; }

	void OnConnectHandler(XChannel channel, int code);

	void OnDisconnectHandler(XChannel channel, int code);

	void OnError(int code);
}
