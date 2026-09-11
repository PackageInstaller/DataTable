using System.Globalization;

namespace System.Net;

internal class HttpProtocolUtils
{
	internal static string date2string(DateTime D)
	{
		DateTimeFormatInfo dateTimeFormatInfo = new DateTimeFormatInfo();
		return D.ToUniversalTime().ToString("R", dateTimeFormatInfo);
	}
}
