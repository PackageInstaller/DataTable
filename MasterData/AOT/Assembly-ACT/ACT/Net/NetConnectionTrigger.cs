namespace ACT.Net;

public enum NetConnectionTrigger
{
	ConnectRequested,
	TransportConnected,
	AuthenticationStarted,
	SynchronizationStarted,
	ConnectionReady,
	NetworkDegraded,
	NetworkRecovered,
	ConnectionLost,
	ReconnectStarted,
	DisconnectRequested,
	Disconnected
}
