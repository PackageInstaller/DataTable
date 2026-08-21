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

	public string Path
	{
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
