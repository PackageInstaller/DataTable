using System.Globalization;

namespace System.Net;

internal class CookieParser
{
	private CookieTokenizer m_tokenizer;

	internal CookieParser(string cookieString)
	{
		m_tokenizer = new CookieTokenizer(cookieString);
	}

	internal Cookie Get()
	{
		Cookie cookie = null;
		bool flag = false;
		bool flag2 = false;
		bool flag3 = false;
		bool flag4 = false;
		bool flag5 = false;
		bool flag6 = false;
		bool flag7 = false;
		bool flag8 = false;
		bool flag9 = false;
		do
		{
			CookieToken cookieToken = m_tokenizer.Next(cookie == null, parseResponseCookies: true);
			if (cookie == null && (cookieToken == CookieToken.NameValuePair || cookieToken == CookieToken.Attribute))
			{
				cookie = new Cookie();
				if (!cookie.InternalSetName(m_tokenizer.Name))
				{
					cookie.InternalSetName(string.Empty);
				}
				cookie.Value = m_tokenizer.Value;
				continue;
			}
			switch (cookieToken)
			{
			case CookieToken.NameValuePair:
				switch (m_tokenizer.Token)
				{
				case CookieToken.Comment:
					if (!flag)
					{
						flag = true;
						cookie.Comment = m_tokenizer.Value;
					}
					break;
				case CookieToken.CommentUrl:
					if (!flag2)
					{
						flag2 = true;
						if (Uri.TryCreate(CheckQuoted(m_tokenizer.Value), UriKind.Absolute, out var result3))
						{
							cookie.CommentUri = result3;
						}
					}
					break;
				case CookieToken.Domain:
					if (!flag3)
					{
						flag3 = true;
						cookie.Domain = CheckQuoted(m_tokenizer.Value);
						cookie.IsQuotedDomain = m_tokenizer.Quoted;
					}
					break;
				case CookieToken.Expires:
					if (!flag4)
					{
						flag4 = true;
						if (DateTime.TryParse(CheckQuoted(m_tokenizer.Value), CultureInfo.InvariantCulture, DateTimeStyles.AllowWhiteSpaces, out var result4))
						{
							cookie.Expires = result4;
						}
						else
						{
							cookie.InternalSetName(string.Empty);
						}
					}
					break;
				case CookieToken.MaxAge:
					if (!flag4)
					{
						flag4 = true;
						if (int.TryParse(CheckQuoted(m_tokenizer.Value), out var result2))
						{
							cookie.Expires = DateTime.Now.AddSeconds(result2);
						}
						else
						{
							cookie.InternalSetName(string.Empty);
						}
					}
					break;
				case CookieToken.Path:
					if (!flag5)
					{
						flag5 = true;
						cookie.Path = m_tokenizer.Value;
					}
					break;
				case CookieToken.Port:
					if (!flag6)
					{
						flag6 = true;
						try
						{
							cookie.Port = m_tokenizer.Value;
						}
						catch
						{
							cookie.InternalSetName(string.Empty);
						}
					}
					break;
				case CookieToken.Version:
					if (!flag7)
					{
						flag7 = true;
						if (int.TryParse(CheckQuoted(m_tokenizer.Value), out var result))
						{
							cookie.Version = result;
							cookie.IsQuotedVersion = m_tokenizer.Quoted;
						}
						else
						{
							cookie.InternalSetName(string.Empty);
						}
					}
					break;
				}
				break;
			case CookieToken.Attribute:
				switch (m_tokenizer.Token)
				{
				case CookieToken.Discard:
					if (!flag9)
					{
						flag9 = true;
						cookie.Discard = true;
					}
					break;
				case CookieToken.Secure:
					if (!flag8)
					{
						flag8 = true;
						cookie.Secure = true;
					}
					break;
				case CookieToken.HttpOnly:
					cookie.HttpOnly = true;
					break;
				case CookieToken.Port:
					if (!flag6)
					{
						flag6 = true;
						cookie.Port = string.Empty;
					}
					break;
				}
				break;
			}
		}
		while (!m_tokenizer.Eof && !m_tokenizer.EndOfCookie);
		return cookie;
	}

	internal static string CheckQuoted(string value)
	{
		if (value.Length < 2 || value[0] != '"' || value[value.Length - 1] != '"')
		{
			return value;
		}
		if (value.Length != 2)
		{
			return value.Substring(1, value.Length - 2);
		}
		return string.Empty;
	}
}
