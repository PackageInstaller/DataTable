using System.Globalization;

namespace System.Net;

internal class MonoHttpDate
{
	private static readonly string rfc1123_date = "r";

	private static readonly string rfc850_date = "dddd, dd-MMM-yy HH:mm:ss G\\MT";

	private static readonly string asctime_date = "ddd MMM d HH:mm:ss yyyy";

	private static readonly string[] formats = new string[3] { rfc1123_date, rfc850_date, asctime_date };

	internal static DateTime Parse(string dateStr)
	{
		return DateTime.ParseExact(dateStr, formats, CultureInfo.InvariantCulture, DateTimeStyles.AllowWhiteSpaces).ToLocalTime();
	}
}
