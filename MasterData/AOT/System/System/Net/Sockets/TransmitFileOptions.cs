namespace System.Net.Sockets;

[Flags]
public enum TransmitFileOptions
{
	UseDefaultWorkerThread = 0,
	Disconnect = 1,
	ReuseSocket = 2,
	WriteBehind = 4,
	UseSystemThread = 0x10,
	UseKernelApc = 0x20
}
