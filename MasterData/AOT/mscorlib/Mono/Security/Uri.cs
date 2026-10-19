using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text;

namespace Mono.Security;

internal class Uri
{
	private struct UriScheme(string s, string d, int p)
	{
		public string scheme = s;

		public string delimiter = d;

		public int defaultPort = p;
	}

	private bool isUnixFilePath;

	private string source;

	private string scheme = string.Empty;

	private string host = string.Empty;

	private int port = -1;

	private string path = string.Empty;

	private string query = string.Empty;

	private string fragment = string.Empty;

	private string userinfo = string.Empty;

	private bool isUnc;

	private bool isOpaquePart;

	private bool userEscaped;

	private string cachedToString;

	private string cachedLocalPath;

	private int cachedHashCode;

	private bool reduce = true;

	private static readonly string hexUpperChars = "0123456789ABCDEF";

	public static readonly string SchemeDelimiter = "://";

	public static readonly string UriSchemeFile = "file";

	public static readonly string UriSchemeFtp = "ftp";

	public static readonly string UriSchemeGopher = "gopher";

	public static readonly string UriSchemeHttp = "http";

	public static readonly string UriSchemeHttps = "https";

	public static readonly string UriSchemeMailto = "mailto";

	public static readonly string UriSchemeNews = "news";

	public static readonly string UriSchemeNntp = "nntp";

	private static UriScheme[] schemes = new UriScheme[8]
	{
		new UriScheme(UriSchemeHttp, SchemeDelimiter, 80),
		new UriScheme(UriSchemeHttps, SchemeDelimiter, 443),
		new UriScheme(UriSchemeFtp, SchemeDelimiter, 21),
		new UriScheme(UriSchemeFile, SchemeDelimiter, -1),
		new UriScheme(UriSchemeMailto, ":", 25),
		new UriScheme(UriSchemeNews, ":", -1),
		new UriScheme(UriSchemeNntp, SchemeDelimiter, 119),
		new UriScheme(UriSchemeGopher, SchemeDelimiter, 70)
	};

	public string AbsolutePath => path;

	public bool IsFile => scheme == UriSchemeFile;

	public bool IsUnc => isUnc;

	public string LocalPath
	{
		get
		{
			if (cachedLocalPath != null)
			{
				return cachedLocalPath;
			}
			if (!IsFile)
			{
				return AbsolutePath;
			}
			bool flag = path.Length > 3 && path[1] == ':' && (path[2] == '\\' || path[2] == '/');
			if (!IsUnc)
			{
				string text = Unescape(path);
				if ((Path.DirectorySeparatorChar == '\\') | flag)
				{
					cachedLocalPath = text.Replace('/', '\\');
				}
				else
				{
					cachedLocalPath = text;
				}
			}
			else if (path.Length > 1 && path[1] == ':')
			{
				cachedLocalPath = Unescape(path.Replace(Path.AltDirectorySeparatorChar, Path.DirectorySeparatorChar));
			}
			else if (Path.DirectorySeparatorChar == '\\')
			{
				cachedLocalPath = "\\\\" + Unescape(host + path.Replace('/', '\\'));
			}
			else
			{
				cachedLocalPath = Unescape(path);
			}
			if (cachedLocalPath == string.Empty)
			{
				cachedLocalPath = Path.DirectorySeparatorChar.ToString();
			}
			return cachedLocalPath;
		}
	}

	public Uri(string uriString)
		: this(uriString, dontEscape: false)
	{
	}

	public Uri(string uriString, bool dontEscape)
	{
		userEscaped = dontEscape;
		source = uriString;
		Parse();
	}

	public override bool Equals(object comparant)
	{
		if (comparant == null)
		{
			return false;
		}
		Uri uri = comparant as Uri;
		if (uri == null)
		{
			if (!(comparant is string uriString))
			{
				return false;
			}
			uri = new Uri(uriString);
		}
		CultureInfo invariantCulture = CultureInfo.InvariantCulture;
		if (scheme.ToLower(invariantCulture) == uri.scheme.ToLower(invariantCulture) && userinfo.ToLower(invariantCulture) == uri.userinfo.ToLower(invariantCulture) && host.ToLower(invariantCulture) == uri.host.ToLower(invariantCulture) && port == uri.port && path == uri.path)
		{
			return query.ToLower(invariantCulture) == uri.query.ToLower(invariantCulture);
		}
		return false;
	}

	public override int GetHashCode()
	{
		if (cachedHashCode == 0)
		{
			cachedHashCode = scheme.GetHashCode() + userinfo.GetHashCode() + host.GetHashCode() + port + path.GetHashCode() + query.GetHashCode();
		}
		return cachedHashCode;
	}

	public string GetLeftPart(UriPartial part)
	{
		switch (part)
		{
		case UriPartial.Scheme:
			return scheme + GetOpaqueWiseSchemeDelimiter();
		case UriPartial.Authority:
		{
			if (host == string.Empty || scheme == UriSchemeMailto || scheme == UriSchemeNews)
			{
				return string.Empty;
			}
			StringBuilder stringBuilder2 = new StringBuilder();
			stringBuilder2.Append(scheme);
			stringBuilder2.Append(GetOpaqueWiseSchemeDelimiter());
			if (path.Length > 1 && path[1] == ':' && UriSchemeFile == scheme)
			{
				stringBuilder2.Append('/');
			}
			if (userinfo.Length > 0)
			{
				stringBuilder2.Append(userinfo).Append('@');
			}
			stringBuilder2.Append(host);
			int defaultPort = GetDefaultPort(scheme);
			if (port != -1 && port != defaultPort)
			{
				stringBuilder2.Append(':').Append(port);
			}
			return stringBuilder2.ToString();
		}
		case UriPartial.Path:
		{
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.Append(scheme);
			stringBuilder.Append(GetOpaqueWiseSchemeDelimiter());
			if (path.Length > 1 && path[1] == ':' && UriSchemeFile == scheme)
			{
				stringBuilder.Append('/');
			}
			if (userinfo.Length > 0)
			{
				stringBuilder.Append(userinfo).Append('@');
			}
			stringBuilder.Append(host);
			int defaultPort = GetDefaultPort(scheme);
			if (port != -1 && port != defaultPort)
			{
				stringBuilder.Append(':').Append(port);
			}
			stringBuilder.Append(path);
			return stringBuilder.ToString();
		}
		default:
			return null;
		}
	}

	public static int FromHex(char digit)
	{
		if ('0' <= digit && digit <= '9')
		{
			return digit - 48;
		}
		if ('a' <= digit && digit <= 'f')
		{
			return digit - 97 + 10;
		}
		if ('A' <= digit && digit <= 'F')
		{
			return digit - 65 + 10;
		}
		throw new ArgumentException("digit");
	}

	public static string HexEscape(char character)
	{
		if (character > 'ÿ')
		{
			throw new ArgumentOutOfRangeException("character");
		}
		return "%" + hexUpperChars[(character & 0xF0) >> 4] + hexUpperChars[character & 0xF];
	}

	public static char HexUnescape(string pattern, ref int index)
	{
		if (pattern == null)
		{
			throw new ArgumentException("pattern");
		}
		if (index < 0 || index >= pattern.Length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		int num = 0;
		int num2 = 0;
		do
		{
			if (index + 3 > pattern.Length || pattern[index] != '%' || !IsHexDigit(pattern[index + 1]) || !IsHexDigit(pattern[index + 2]))
			{
				if (num != 0)
				{
					break;
				}
				return pattern[index++];
			}
			index++;
			int num3 = FromHex(pattern[index++]);
			int num4 = FromHex(pattern[index++]);
			int num5 = (num3 << 4) + num4;
			if (num == 0)
			{
				if (num5 < 192)
				{
					return (char)num5;
				}
				if (num5 < 224)
				{
					num2 = num5 - 192;
					num = 2;
				}
				else if (num5 < 240)
				{
					num2 = num5 - 224;
					num = 3;
				}
				else if (num5 < 248)
				{
					num2 = num5 - 240;
					num = 4;
				}
				else if (num5 < 251)
				{
					num2 = num5 - 248;
					num = 5;
				}
				else if (num5 < 254)
				{
					num2 = num5 - 252;
					num = 6;
				}
				num2 <<= (num - 1) * 6;
			}
			else
			{
				num2 += num5 - 128 << (num - 1) * 6;
			}
			num--;
		}
		while (num > 0);
		return (char)num2;
	}

	public static bool IsHexDigit(char digit)
	{
		if (('0' > digit || digit > '9') && ('a' > digit || digit > 'f'))
		{
			if ('A' <= digit)
			{
				return digit <= 'F';
			}
			return false;
		}
		return true;
	}

	public static bool IsHexEncoding(string pattern, int index)
	{
		if (index + 3 > pattern.Length)
		{
			return false;
		}
		if (pattern[index++] == '%' && IsHexDigit(pattern[index++]))
		{
			return IsHexDigit(pattern[index]);
		}
		return false;
	}

	public override string ToString()
	{
		if (cachedToString != null)
		{
			return cachedToString;
		}
		string text = (query.StartsWith("?") ? ("?" + Unescape(query.Substring(1))) : Unescape(query));
		cachedToString = Unescape(GetLeftPart(UriPartial.Path), excludeSharp: true) + text + fragment;
		return cachedToString;
	}

	protected static string EscapeString(string str)
	{
		return EscapeString(str, escapeReserved: false, escapeHex: true, escapeBrackets: true);
	}

	internal static string EscapeString(string str, bool escapeReserved, bool escapeHex, bool escapeBrackets)
	{
		if (str == null)
		{
			return string.Empty;
		}
		StringBuilder stringBuilder = new StringBuilder();
		int length = str.Length;
		for (int i = 0; i < length; i++)
		{
			if (IsHexEncoding(str, i))
			{
				stringBuilder.Append(str.Substring(i, 3));
				i += 2;
				continue;
			}
			byte[] bytes = Encoding.UTF8.GetBytes(new char[1] { str[i] });
			int num = bytes.Length;
			for (int j = 0; j < num; j++)
			{
				char c = (char)bytes[j];
				if (c <= ' ' || c >= '\u007f' || "<>%\"{}|\\^`".IndexOf(c) != -1 || (escapeHex && c == '#') || (escapeBrackets && (c == '[' || c == ']')) || (escapeReserved && ";/?:@&=+$,".IndexOf(c) != -1))
				{
					stringBuilder.Append(HexEscape(c));
				}
				else
				{
					stringBuilder.Append(c);
				}
			}
		}
		return stringBuilder.ToString();
	}

	protected void Parse()
	{
		Parse(source);
		if (!userEscaped)
		{
			host = EscapeString(host, escapeReserved: false, escapeHex: true, escapeBrackets: false);
			path = EscapeString(path);
		}
	}

	protected string Unescape(string str)
	{
		return Unescape(str, excludeSharp: false);
	}

	internal string Unescape(string str, bool excludeSharp)
	{
		if (str == null)
		{
			return string.Empty;
		}
		StringBuilder stringBuilder = new StringBuilder();
		int length = str.Length;
		for (int i = 0; i < length; i++)
		{
			char c = str[i];
			if (c == '%')
			{
				char c2 = HexUnescape(str, ref i);
				if (excludeSharp && c2 == '#')
				{
					stringBuilder.Append("%23");
				}
				else
				{
					stringBuilder.Append(c2);
				}
				i--;
			}
			else
			{
				stringBuilder.Append(c);
			}
		}
		return stringBuilder.ToString();
	}

	private void ParseAsWindowsUNC(string uriString)
	{
		scheme = UriSchemeFile;
		port = -1;
		fragment = string.Empty;
		query = string.Empty;
		isUnc = true;
		uriString = uriString.TrimStart(new char[1] { '\\' });
		int num = uriString.IndexOf('\\');
		if (num > 0)
		{
			path = uriString.Substring(num);
			host = uriString.Substring(0, num);
		}
		else
		{
			host = uriString;
			path = string.Empty;
		}
		path = path.Replace("\\", "/");
	}

	private void ParseAsWindowsAbsoluteFilePath(string uriString)
	{
		if (uriString.Length > 2 && uriString[2] != '\\' && uriString[2] != '/')
		{
			throw new FormatException("Relative file path is not allowed.");
		}
		scheme = UriSchemeFile;
		host = string.Empty;
		port = -1;
		path = uriString.Replace("\\", "/");
		fragment = string.Empty;
		query = string.Empty;
	}

	private void ParseAsUnixAbsoluteFilePath(string uriString)
	{
		isUnixFilePath = true;
		scheme = UriSchemeFile;
		port = -1;
		fragment = string.Empty;
		query = string.Empty;
		host = string.Empty;
		path = null;
		if (uriString.StartsWith("//"))
		{
			uriString = uriString.TrimStart(new char[1] { '/' });
			path = "/" + uriString;
		}
		if (path == null)
		{
			path = uriString;
		}
	}

	private void Parse(string uriString)
	{
		if (uriString == null)
		{
			throw new ArgumentNullException("uriString");
		}
		if (uriString.Length <= 1)
		{
			throw new FormatException();
		}
		int num = 0;
		num = uriString.IndexOf(':');
		if (num < 0)
		{
			if (uriString[0] == '/')
			{
				ParseAsUnixAbsoluteFilePath(uriString);
				return;
			}
			if (uriString.StartsWith("\\\\"))
			{
				ParseAsWindowsUNC(uriString);
				return;
			}
			throw new FormatException("URI scheme was not recognized, nor input string is not recognized as an absolute file path.");
		}
		if (num == 1)
		{
			if (!char.IsLetter(uriString[0]))
			{
				throw new FormatException("URI scheme must start with alphabet character.");
			}
			ParseAsWindowsAbsoluteFilePath(uriString);
			return;
		}
		scheme = uriString.Substring(0, num).ToLower(CultureInfo.InvariantCulture);
		if (!char.IsLetter(scheme[0]))
		{
			throw new FormatException("URI scheme must start with alphabet character.");
		}
		for (int i = 1; i < scheme.Length; i++)
		{
			if (!char.IsLetterOrDigit(scheme, i))
			{
				switch (scheme[i])
				{
				case '+':
				case '-':
				case '.':
					continue;
				}
				throw new FormatException("URI scheme must consist of one of alphabet, digits, '+', '-' or '.' character.");
			}
		}
		uriString = uriString.Substring(num + 1);
		num = uriString.IndexOf('#');
		if (!IsUnc && num != -1)
		{
			fragment = uriString.Substring(num);
			uriString = uriString.Substring(0, num);
		}
		num = uriString.IndexOf('?');
		if (num != -1)
		{
			query = uriString.Substring(num);
			uriString = uriString.Substring(0, num);
			if (!userEscaped)
			{
				query = EscapeString(query);
			}
		}
		bool flag = scheme == UriSchemeFile && uriString.StartsWith("///");
		if (uriString.StartsWith("//"))
		{
			if (uriString.StartsWith("////"))
			{
				flag = false;
			}
			uriString = uriString.TrimStart(new char[1] { '/' });
			if (uriString.Length > 1 && uriString[1] == ':')
			{
				flag = false;
			}
		}
		else if (!IsPredefinedScheme(scheme))
		{
			path = uriString;
			isOpaquePart = true;
			return;
		}
		num = uriString.IndexOfAny(new char[2] { '/', '\\' });
		if (flag)
		{
			num = -1;
		}
		if (num == -1)
		{
			if (scheme != UriSchemeMailto && scheme != UriSchemeNews && scheme != UriSchemeFile)
			{
				path = "/";
			}
		}
		else
		{
			path = uriString.Substring(num);
			uriString = uriString.Substring(0, num);
		}
		num = uriString.IndexOf("@");
		if (flag)
		{
			num = -1;
		}
		if (num != -1)
		{
			userinfo = uriString.Substring(0, num);
			uriString = uriString.Remove(0, num + 1);
		}
		port = -1;
		num = uriString.LastIndexOf(":");
		if (flag)
		{
			num = -1;
		}
		if (num == 1 && scheme == UriSchemeFile && char.IsLetter(uriString[0]))
		{
			num = -1;
		}
		if (num != -1 && num != uriString.Length - 1)
		{
			string text = uriString.Remove(0, num + 1);
			if (text.Length > 1 && text[text.Length - 1] != ']')
			{
				try
				{
					port = (int)uint.Parse(text, CultureInfo.InvariantCulture);
					uriString = uriString.Substring(0, num);
				}
				catch (Exception)
				{
					throw new FormatException("Invalid URI: invalid port number");
				}
			}
		}
		if (port == -1)
		{
			port = GetDefaultPort(scheme);
		}
		host = uriString;
		if (flag)
		{
			path = "/" + uriString;
			host = string.Empty;
		}
		else if (host.Length == 2 && host[1] == ':')
		{
			path = host + path;
			host = string.Empty;
		}
		else if (isUnixFilePath)
		{
			uriString = "//" + uriString;
			host = string.Empty;
		}
		else
		{
			if (host.Length == 0)
			{
				throw new FormatException("Invalid URI: The hostname could not be parsed");
			}
			if (scheme == UriSchemeFile)
			{
				isUnc = true;
			}
		}
		if (scheme != UriSchemeMailto && scheme != UriSchemeNews && scheme != UriSchemeFile && reduce)
		{
			path = Reduce(path);
		}
	}

	private static string Reduce(string path)
	{
		path = path.Replace('\\', '/');
		string[] array = path.Split('/');
		List<string> list = new List<string>();
		int num = array.Length;
		for (int i = 0; i < num; i++)
		{
			string text = array[i];
			if (text.Length == 0 || text == ".")
			{
				continue;
			}
			if (text == "..")
			{
				if (list.Count == 0)
				{
					if (i != 1)
					{
						throw new Exception("Invalid path.");
					}
				}
				else
				{
					list.RemoveAt(list.Count - 1);
				}
			}
			else
			{
				list.Add(text);
			}
		}
		if (list.Count == 0)
		{
			return "/";
		}
		list.Insert(0, string.Empty);
		string text2 = string.Join("/", list.ToArray());
		if (path.EndsWith("/"))
		{
			text2 += "/";
		}
		return text2;
	}

	internal static string GetSchemeDelimiter(string scheme)
	{
		for (int i = 0; i < schemes.Length; i++)
		{
			if (schemes[i].scheme == scheme)
			{
				return schemes[i].delimiter;
			}
		}
		return SchemeDelimiter;
	}

	internal static int GetDefaultPort(string scheme)
	{
		for (int i = 0; i < schemes.Length; i++)
		{
			if (schemes[i].scheme == scheme)
			{
				return schemes[i].defaultPort;
			}
		}
		return -1;
	}

	private string GetOpaqueWiseSchemeDelimiter()
	{
		if (isOpaquePart)
		{
			return ":";
		}
		return GetSchemeDelimiter(scheme);
	}

	private static bool IsPredefinedScheme(string scheme)
	{
		switch (scheme)
		{
		case "http":
		case "https":
		case "file":
		case "ftp":
		case "nntp":
		case "gopher":
		case "mailto":
		case "news":
			return true;
		default:
			return false;
		}
	}
}
