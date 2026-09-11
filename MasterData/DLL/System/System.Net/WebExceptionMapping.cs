using System.Threading;

namespace System.Net;

internal static class WebExceptionMapping
{
	private static readonly string[] s_Mapping = new string[21];

	internal static string GetWebStatusString(WebExceptionStatus status)
	{
		int num = (int)status;
		if (num >= s_Mapping.Length || num < 0)
		{
			throw new InternalException();
		}
		string text = Volatile.Read(ref s_Mapping[num]);
		if (text == null)
		{
			text = "net_webstatus_" + status;
			Volatile.Write(ref s_Mapping[num], text);
		}
		return text;
	}
}
