namespace System.Net;

internal enum ReadState
{
	None,
	Status,
	Headers,
	Content,
	Aborted
}
