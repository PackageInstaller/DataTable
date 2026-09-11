namespace System.Net;

internal class CookieTokenizer
{
	private struct RecognizedAttribute
	{
		private string m_name;

		private CookieToken m_token;

		internal CookieToken Token => m_token;

		internal RecognizedAttribute(string name, CookieToken token)
		{
			m_name = name;
			m_token = token;
		}

		internal bool IsEqualTo(string value)
		{
			return string.Compare(m_name, value, StringComparison.OrdinalIgnoreCase) == 0;
		}
	}

	private bool m_eofCookie;

	private int m_index;

	private int m_length;

	private string m_name;

	private bool m_quoted;

	private int m_start;

	private CookieToken m_token;

	private int m_tokenLength;

	private string m_tokenStream;

	private string m_value;

	private static RecognizedAttribute[] RecognizedAttributes = new RecognizedAttribute[11]
	{
		new RecognizedAttribute("Path", CookieToken.Path),
		new RecognizedAttribute("Max-Age", CookieToken.MaxAge),
		new RecognizedAttribute("Expires", CookieToken.Expires),
		new RecognizedAttribute("Version", CookieToken.Version),
		new RecognizedAttribute("Domain", CookieToken.Domain),
		new RecognizedAttribute("Secure", CookieToken.Secure),
		new RecognizedAttribute("Discard", CookieToken.Discard),
		new RecognizedAttribute("Port", CookieToken.Port),
		new RecognizedAttribute("Comment", CookieToken.Comment),
		new RecognizedAttribute("CommentURL", CookieToken.CommentUrl),
		new RecognizedAttribute("HttpOnly", CookieToken.HttpOnly)
	};

	private static RecognizedAttribute[] RecognizedServerAttributes = new RecognizedAttribute[5]
	{
		new RecognizedAttribute("$Path", CookieToken.Path),
		new RecognizedAttribute("$Version", CookieToken.Version),
		new RecognizedAttribute("$Domain", CookieToken.Domain),
		new RecognizedAttribute("$Port", CookieToken.Port),
		new RecognizedAttribute("$HttpOnly", CookieToken.HttpOnly)
	};

	internal bool EndOfCookie
	{
		get
		{
			return m_eofCookie;
		}
		set
		{
			m_eofCookie = value;
		}
	}

	internal bool Eof => m_index >= m_length;

	internal string Name
	{
		get
		{
			return m_name;
		}
		set
		{
			m_name = value;
		}
	}

	internal bool Quoted
	{
		get
		{
			return m_quoted;
		}
		set
		{
			m_quoted = value;
		}
	}

	internal CookieToken Token
	{
		get
		{
			return m_token;
		}
		set
		{
			m_token = value;
		}
	}

	internal string Value
	{
		get
		{
			return m_value;
		}
		set
		{
			m_value = value;
		}
	}

	internal CookieTokenizer(string tokenStream)
	{
		m_length = tokenStream.Length;
		m_tokenStream = tokenStream;
	}

	internal string Extract()
	{
		string text = string.Empty;
		if (m_tokenLength != 0)
		{
			text = m_tokenStream.Substring(m_start, m_tokenLength);
			if (!Quoted)
			{
				text = text.Trim();
			}
		}
		return text;
	}

	internal CookieToken FindNext(bool ignoreComma, bool ignoreEquals)
	{
		m_tokenLength = 0;
		m_start = m_index;
		while (m_index < m_length && char.IsWhiteSpace(m_tokenStream[m_index]))
		{
			m_index++;
			m_start++;
		}
		CookieToken result = CookieToken.End;
		int num = 1;
		if (!Eof)
		{
			if (m_tokenStream[m_index] == '"')
			{
				Quoted = true;
				m_index++;
				bool flag = false;
				while (m_index < m_length)
				{
					char c = m_tokenStream[m_index];
					if (!flag && c == '"')
					{
						break;
					}
					if (flag)
					{
						flag = false;
					}
					else if (c == '\\')
					{
						flag = true;
					}
					m_index++;
				}
				if (m_index < m_length)
				{
					m_index++;
				}
				m_tokenLength = m_index - m_start;
				num = 0;
				ignoreComma = false;
			}
			while (m_index < m_length && m_tokenStream[m_index] != ';' && (ignoreEquals || m_tokenStream[m_index] != '=') && (ignoreComma || m_tokenStream[m_index] != ','))
			{
				if (m_tokenStream[m_index] == ',')
				{
					m_start = m_index + 1;
					m_tokenLength = -1;
					ignoreComma = false;
				}
				m_index++;
				m_tokenLength += num;
			}
			if (!Eof)
			{
				result = m_tokenStream[m_index] switch
				{
					';' => CookieToken.EndToken, 
					'=' => CookieToken.Equals, 
					_ => CookieToken.EndCookie, 
				};
				m_index++;
			}
		}
		return result;
	}

	internal CookieToken Next(bool first, bool parseResponseCookies)
	{
		Reset();
		CookieToken cookieToken = FindNext(ignoreComma: false, ignoreEquals: false);
		if (cookieToken == CookieToken.EndCookie)
		{
			EndOfCookie = true;
		}
		if (cookieToken == CookieToken.End || cookieToken == CookieToken.EndCookie)
		{
			string text = (Name = Extract());
			if (text.Length != 0)
			{
				Token = TokenFromName(parseResponseCookies);
				return CookieToken.Attribute;
			}
			return cookieToken;
		}
		Name = Extract();
		if (first)
		{
			Token = CookieToken.CookieName;
		}
		else
		{
			Token = TokenFromName(parseResponseCookies);
		}
		if (cookieToken == CookieToken.Equals)
		{
			cookieToken = FindNext(!first && Token == CookieToken.Expires, ignoreEquals: true);
			if (cookieToken == CookieToken.EndCookie)
			{
				EndOfCookie = true;
			}
			Value = Extract();
			return CookieToken.NameValuePair;
		}
		return CookieToken.Attribute;
	}

	internal void Reset()
	{
		m_eofCookie = false;
		m_name = string.Empty;
		m_quoted = false;
		m_start = m_index;
		m_token = CookieToken.Nothing;
		m_tokenLength = 0;
		m_value = string.Empty;
	}

	internal CookieToken TokenFromName(bool parseResponseCookies)
	{
		if (!parseResponseCookies)
		{
			for (int i = 0; i < RecognizedServerAttributes.Length; i++)
			{
				if (RecognizedServerAttributes[i].IsEqualTo(Name))
				{
					return RecognizedServerAttributes[i].Token;
				}
			}
		}
		else
		{
			for (int j = 0; j < RecognizedAttributes.Length; j++)
			{
				if (RecognizedAttributes[j].IsEqualTo(Name))
				{
					return RecognizedAttributes[j].Token;
				}
			}
		}
		return CookieToken.Unknown;
	}
}
