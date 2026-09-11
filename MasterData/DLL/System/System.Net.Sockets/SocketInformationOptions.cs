namespace System.Net.Sockets;

[Flags]
public enum SocketInformationOptions
{
	NonBlocking = 1,
	Connected = 2,
	Listening = 4,
	UseOnlyOverlappedIO = 8
}
