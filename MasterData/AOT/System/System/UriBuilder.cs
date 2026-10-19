namespace System;

public class UriBuilder
{
	private bool _changed = true;

	private string _fragment = string.Empty;

	private string _host = "localhost";

	private string _password = string.Empty;

	private string _path = "/";

	private int _port = -1;

	private string _query = string.Empty;

	private string _scheme = "http";

	private string _schemeDelimiter = Uri.SchemeDelimiter;

	private Uri _uri;

	private string _username = string.Empty;

	private string Extra
	{
		set
		{
			if (value == null)
			{
				value = string.Empty;
			}
			if (value.Length > 0)
			{
				if (value[0] == '#')
				{
					Fragment = value.Substring(1);
					return;
				}
				if (value[0] != '?')
				{
					throw new ArgumentException("Extra portion of URI not valid.", "value");
				}
				int num = value.IndexOf('#');
				if (num == -1)
				{
					num = value.Length;
				}
				else
				{
					Fragment = value.Substring(num + 1);
				}
				Query = value.Substring(1, num - 1);
			}
			else
			{
				Fragment = string.Empty;
				Query = string.Empty;
			}
		}
	}

	public string Fragment
	{
		get
		{
			return _fragment;
		}
		set
		{
			if (value == null)
			{
				value = string.Empty;
			}
			if (value.Length > 0 && value[0] != '#')
			{
				value = "#" + value;
			}
			_fragment = value;
			_changed = true;
		}
	}

	public string Host
	{
		get
		{
			return _host;
		}
		set
		{
			if (value == null)
			{
				value = string.Empty;
			}
			_host = value;
			if (_host.IndexOf(':') >= 0 && _host[0] != '[')
			{
				_host = "[" + _host + "]";
			}
			_changed = true;
		}
	}

	public string Password
	{
		get
		{
			return _password;
		}
		set
		{
			if (value == null)
			{
				value = string.Empty;
			}
			_password = value;
			_changed = true;
		}
	}

	public string Path
	{
		get
		{
			return _path;
		}
		set
		{
			if (value == null || value.Length == 0)
			{
				value = "/";
			}
			_path = Uri.InternalEscapeString(value.Replace('\\', '/'));
			_changed = true;
		}
	}

	public int Port
	{
		get
		{
			return _port;
		}
		set
		{
			if (value < -1 || value > 65535)
			{
				throw new ArgumentOutOfRangeException("value");
			}
			_port = value;
			_changed = true;
		}
	}

	public string Query
	{
		get
		{
			return _query;
		}
		set
		{
			if (value == null)
			{
				value = string.Empty;
			}
			if (value.Length > 0 && value[0] != '?')
			{
				value = "?" + value;
			}
			_query = value;
			_changed = true;
		}
	}

	public string Scheme
	{
		get
		{
			return _scheme;
		}
		set
		{
			if (value == null)
			{
				value = string.Empty;
			}
			int num = value.IndexOf(':');
			if (num != -1)
			{
				value = value.Substring(0, num);
			}
			if (value.Length != 0)
			{
				if (!Uri.CheckSchemeName(value))
				{
					throw new ArgumentException("Invalid URI: The URI scheme is not valid.", "value");
				}
				value = value.ToLowerInvariant();
			}
			_scheme = value;
			_changed = true;
		}
	}

	public Uri Uri
	{
		get
		{
			if (_changed)
			{
				_uri = new Uri(ToString());
				SetFieldsFromUri(_uri);
				_changed = false;
			}
			return _uri;
		}
	}

	public string UserName
	{
		get
		{
			return _username;
		}
		set
		{
			if (value == null)
			{
				value = string.Empty;
			}
			_username = value;
			_changed = true;
		}
	}

	public UriBuilder()
	{
	}

	public UriBuilder(string uri)
	{
		Uri uri2 = new Uri(uri, UriKind.RelativeOrAbsolute);
		if (uri2.IsAbsoluteUri)
		{
			Init(uri2);
			return;
		}
		uri = Uri.UriSchemeHttp + Uri.SchemeDelimiter + uri;
		Init(new Uri(uri));
	}

	public UriBuilder(Uri uri)
	{
		if ((object)uri == null)
		{
			throw new ArgumentNullException("uri");
		}
		Init(uri);
	}

	private void Init(Uri uri)
	{
		_fragment = uri.Fragment;
		_query = uri.Query;
		_host = uri.Host;
		_path = uri.AbsolutePath;
		_port = uri.Port;
		_scheme = uri.Scheme;
		_schemeDelimiter = (uri.HasAuthority ? Uri.SchemeDelimiter : ":");
		string userInfo = uri.UserInfo;
		if (!string.IsNullOrEmpty(userInfo))
		{
			int num = userInfo.IndexOf(':');
			if (num != -1)
			{
				_password = userInfo.Substring(num + 1);
				_username = userInfo.Substring(0, num);
			}
			else
			{
				_username = userInfo;
			}
		}
		SetFieldsFromUri(uri);
	}

	public UriBuilder(string schemeName, string hostName)
	{
		Scheme = schemeName;
		Host = hostName;
	}

	public UriBuilder(string scheme, string host, int portNumber)
		: this(scheme, host)
	{
		Port = portNumber;
	}

	public UriBuilder(string scheme, string host, int port, string pathValue)
		: this(scheme, host, port)
	{
		Path = pathValue;
	}

	public UriBuilder(string scheme, string host, int port, string path, string extraValue)
		: this(scheme, host, port, path)
	{
		try
		{
			Extra = extraValue;
		}
		catch (Exception ex)
		{
			if (ex is OutOfMemoryException)
			{
				throw;
			}
			throw new ArgumentException("Extra portion of URI not valid.", "extraValue");
		}
	}

	public override bool Equals(object rparam)
	{
		if (rparam == null)
		{
			return false;
		}
		return Uri.Equals(rparam.ToString());
	}

	public override int GetHashCode()
	{
		return Uri.GetHashCode();
	}

	private void SetFieldsFromUri(Uri uri)
	{
		_fragment = uri.Fragment;
		_query = uri.Query;
		_host = uri.Host;
		_path = uri.AbsolutePath;
		_port = uri.Port;
		_scheme = uri.Scheme;
		_schemeDelimiter = (uri.HasAuthority ? Uri.SchemeDelimiter : ":");
		string userInfo = uri.UserInfo;
		if (userInfo.Length > 0)
		{
			int num = userInfo.IndexOf(':');
			if (num != -1)
			{
				_password = userInfo.Substring(num + 1);
				_username = userInfo.Substring(0, num);
			}
			else
			{
				_username = userInfo;
			}
		}
	}

	public override string ToString()
	{
		if (_username.Length == 0 && _password.Length > 0)
		{
			throw new UriFormatException("Invalid URI: The username:password construct is badly formed.");
		}
		if (_scheme.Length != 0)
		{
			UriParser syntax = UriParser.GetSyntax(_scheme);
			if (syntax != null)
			{
				_schemeDelimiter = ((syntax.InFact(UriSyntaxFlags.MustHaveAuthority) || (_host.Length != 0 && syntax.NotAny(UriSyntaxFlags.MailToLikeUri) && syntax.InFact(UriSyntaxFlags.OptionalAuthority))) ? Uri.SchemeDelimiter : ":");
			}
			else
			{
				_schemeDelimiter = ((_host.Length != 0) ? Uri.SchemeDelimiter : ":");
			}
		}
		string text = ((_scheme.Length != 0) ? (_scheme + _schemeDelimiter) : string.Empty);
		return text + _username + ((_password.Length > 0) ? (":" + _password) : string.Empty) + ((_username.Length > 0) ? "@" : string.Empty) + _host + ((_port != -1 && _host.Length > 0) ? (":" + _port) : string.Empty) + ((_host.Length > 0 && _path.Length != 0 && _path[0] != '/') ? "/" : string.Empty) + _path + _query + _fragment;
	}
}
