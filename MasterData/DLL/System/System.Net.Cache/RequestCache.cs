namespace System.Net.Cache;

internal abstract class RequestCache
{
	internal static readonly char[] LineSplits = new char[2] { '\r', '\n' };

	private bool _IsPrivateCache;

	private bool _CanWrite;
}
