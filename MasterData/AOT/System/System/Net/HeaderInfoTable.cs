using System.Collections;
using System.Collections.Specialized;

namespace System.Net;

internal class HeaderInfoTable
{
	private static Hashtable HeaderHashTable;

	private static HeaderInfo UnknownHeaderInfo;

	private static HeaderParser SingleParser;

	private static HeaderParser MultiParser;

	internal HeaderInfo this[string name]
	{
		get
		{
			HeaderInfo headerInfo = (HeaderInfo)HeaderHashTable[name];
			if (headerInfo == null)
			{
				return UnknownHeaderInfo;
			}
			return headerInfo;
		}
	}

	private static string[] ParseSingleValue(string value)
	{
		return new string[1] { value };
	}

	private static string[] ParseMultiValue(string value)
	{
		StringCollection stringCollection = new StringCollection();
		bool flag = false;
		int num = 0;
		char[] array = new char[value.Length];
		for (int i = 0; i < value.Length; i++)
		{
			if (value[i] == '"')
			{
				flag = !flag;
			}
			else if (value[i] == ',' && !flag)
			{
				string text = new string(array, 0, num);
				stringCollection.Add(text.Trim());
				num = 0;
				continue;
			}
			array[num++] = value[i];
		}
		if (num != 0)
		{
			string text = new string(array, 0, num);
			stringCollection.Add(text.Trim());
		}
		string[] array2 = new string[stringCollection.Count];
		stringCollection.CopyTo(array2, 0);
		return array2;
	}

	static HeaderInfoTable()
	{
		UnknownHeaderInfo = new HeaderInfo(string.Empty, requestRestricted: false, responseRestricted: false, multi: false, SingleParser);
		SingleParser = ParseSingleValue;
		MultiParser = ParseMultiValue;
		HeaderInfo[] array = new HeaderInfo[52]
		{
			new HeaderInfo("Age", requestRestricted: false, responseRestricted: false, multi: false, SingleParser),
			new HeaderInfo("Allow", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Accept", requestRestricted: true, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Authorization", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Accept-Ranges", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Accept-Charset", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Accept-Encoding", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Accept-Language", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Cookie", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Connection", requestRestricted: true, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Content-MD5", requestRestricted: false, responseRestricted: false, multi: false, SingleParser),
			new HeaderInfo("Content-Type", requestRestricted: true, responseRestricted: false, multi: false, SingleParser),
			new HeaderInfo("Cache-Control", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Content-Range", requestRestricted: false, responseRestricted: false, multi: false, SingleParser),
			new HeaderInfo("Content-Length", requestRestricted: true, responseRestricted: true, multi: false, SingleParser),
			new HeaderInfo("Content-Encoding", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Content-Language", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Content-Location", requestRestricted: false, responseRestricted: false, multi: false, SingleParser),
			new HeaderInfo("Date", requestRestricted: true, responseRestricted: false, multi: false, SingleParser),
			new HeaderInfo("ETag", requestRestricted: false, responseRestricted: false, multi: false, SingleParser),
			new HeaderInfo("Expect", requestRestricted: true, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Expires", requestRestricted: false, responseRestricted: false, multi: false, SingleParser),
			new HeaderInfo("From", requestRestricted: false, responseRestricted: false, multi: false, SingleParser),
			new HeaderInfo("Host", requestRestricted: true, responseRestricted: false, multi: false, SingleParser),
			new HeaderInfo("If-Match", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("If-Range", requestRestricted: false, responseRestricted: false, multi: false, SingleParser),
			new HeaderInfo("If-None-Match", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("If-Modified-Since", requestRestricted: true, responseRestricted: false, multi: false, SingleParser),
			new HeaderInfo("If-Unmodified-Since", requestRestricted: false, responseRestricted: false, multi: false, SingleParser),
			new HeaderInfo("Keep-Alive", requestRestricted: false, responseRestricted: true, multi: false, SingleParser),
			new HeaderInfo("Location", requestRestricted: false, responseRestricted: false, multi: false, SingleParser),
			new HeaderInfo("Last-Modified", requestRestricted: false, responseRestricted: false, multi: false, SingleParser),
			new HeaderInfo("Max-Forwards", requestRestricted: false, responseRestricted: false, multi: false, SingleParser),
			new HeaderInfo("Pragma", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Proxy-Authenticate", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Proxy-Authorization", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Proxy-Connection", requestRestricted: true, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Range", requestRestricted: true, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Referer", requestRestricted: true, responseRestricted: false, multi: false, SingleParser),
			new HeaderInfo("Retry-After", requestRestricted: false, responseRestricted: false, multi: false, SingleParser),
			new HeaderInfo("Server", requestRestricted: false, responseRestricted: false, multi: false, SingleParser),
			new HeaderInfo("Set-Cookie", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Set-Cookie2", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("TE", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Trailer", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Transfer-Encoding", requestRestricted: true, responseRestricted: true, multi: true, MultiParser),
			new HeaderInfo("Upgrade", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("User-Agent", requestRestricted: true, responseRestricted: false, multi: false, SingleParser),
			new HeaderInfo("Via", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Vary", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("Warning", requestRestricted: false, responseRestricted: false, multi: true, MultiParser),
			new HeaderInfo("WWW-Authenticate", requestRestricted: false, responseRestricted: true, multi: true, SingleParser)
		};
		HeaderHashTable = new Hashtable(array.Length * 2, CaseInsensitiveAscii.StaticInstance);
		for (int i = 0; i < array.Length; i++)
		{
			HeaderHashTable[array[i].HeaderName] = array[i];
		}
	}
}
