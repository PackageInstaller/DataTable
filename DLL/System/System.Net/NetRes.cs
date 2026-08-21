using System.Globalization;

namespace System.Net;

internal class NetRes
{
	public static string GetWebStatusString(string Res, WebExceptionStatus Status)
	{
		string arg = global::SR.GetString(WebExceptionMapping.GetWebStatusString(Status));
		string format = global::SR.GetString(Res);
		return string.Format(CultureInfo.CurrentCulture, format, arg);
	}

	public static string GetWebStatusString(WebExceptionStatus Status)
	{
		return global::SR.GetString(WebExceptionMapping.GetWebStatusString(Status));
	}

	public static string GetWebStatusCodeString(FtpStatusCode statusCode, string statusDescription)
	{
		int num = (int)statusCode;
		string text = "(" + num.ToString(NumberFormatInfo.InvariantInfo) + ")";
		string text2 = null;
		try
		{
			text2 = global::SR.GetString("net_ftpstatuscode_" + statusCode, null);
		}
		catch
		{
		}
		if (text2 != null && text2.Length > 0)
		{
			text = text + " " + text2;
		}
		else if (statusDescription != null && statusDescription.Length > 0)
		{
			text = text + " " + statusDescription;
		}
		return text;
	}
}
