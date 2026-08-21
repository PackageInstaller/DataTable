namespace Ase;

public class NetworkReconnectMessager : NetworkNotifyMessager
{
	public NetworkSystem.NetworkConnectState NetworkConnectState;

	public bool IsReconnecting => NetworkConnectState == NetworkSystem.NetworkConnectState.Connecting;

	public bool IsFailed => NetworkConnectState == NetworkSystem.NetworkConnectState.Disconnected;

	public bool IsSuccess => NetworkConnectState == NetworkSystem.NetworkConnectState.Connected;

	public NetworkReconnectMessager(object sender, NetworkSystem.NetworkConnectState networkConnectState)
		: base(sender)
	{
		NetworkConnectState = networkConnectState;
	}
}
