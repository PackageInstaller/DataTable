namespace ACT.Net;

public enum NetConnectionState
{
	Idle,
	Connecting,
	TransportConnected,
	Authenticating,
	Synchronizing,
	Online,
	Degraded,
	Reconnecting,
	Closing,
	Disconnected
}
