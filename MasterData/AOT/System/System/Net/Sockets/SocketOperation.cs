namespace System.Net.Sockets;

internal enum SocketOperation
{
	Accept,
	Connect,
	Receive,
	ReceiveFrom,
	Send,
	SendTo,
	RecvJustCallback,
	SendJustCallback,
	Disconnect,
	AcceptReceive,
	ReceiveGeneric,
	SendGeneric
}
