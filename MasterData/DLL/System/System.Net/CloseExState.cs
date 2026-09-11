namespace System.Net;

[Flags]
internal enum CloseExState
{
	Normal = 0,
	Abort = 1,
	Silent = 2
}
