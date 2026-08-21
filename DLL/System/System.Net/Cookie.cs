using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Runtime.CompilerServices;
using System.Runtime.Serialization;

namespace System.Net;

[Serializable]
public sealed class Cookie
{
	internal static readonly char[] PortSplitDelimiters;

	internal static readonly char[] Reserved2Name;

	internal static readonly char[] Reserved2Value;

	private static Comparer staticComparer;

	private string m_comment = string.Empty;

	private Uri m_commentUri;

	private CookieVariant m_cookieVariant = CookieVariant.Plain;

	private bool m_discard;

	private string m_domain = string.Empty;

	private bool m_domain_implicit = true;

	private DateTime m_expires = DateTime.MinValue;

	private string m_name = string.Empty;

	private string m_path = string.Empty;

	private bool m_path_implicit = true;

	private string m_port = string.Empty;

	private bool m_port_implicit = true;

	private int[] m_port_list;

	private bool m_secure;

	[OptionalField]
	private bool m_httpOnly;

	private DateTime m_timeStamp = DateTime.Now;

	private string m_value = string.Empty;

	private int m_version;

	private string m_domainKey = string.Empty;

	internal bool IsQuotedVersion;

	internal bool IsQuotedDomain;

	public string Comment
	{
		get
		{
			return m_comment;
		}
		set
		{
			if (value == null)
			{
				value = string.Empty;
			}
			m_comment = value;
		}
	}

	public Uri CommentUri
	{
		set
		{
			m_commentUri = value;
		}
	}

	public bool HttpOnly
	{
		set
		{
			m_httpOnly = value;
		}
	}

	public bool Discard
	{
		set
		{
			m_discard = value;
		}
	}

	public string Domain
	{
		get
		{
			return m_domain;
		}
		set
		{
			m_domain = ((value == null) ? string.Empty : value);
			m_domain_implicit = false;
			m_domainKey = string.Empty;
		}
	}

	private string _Domain
	{
		get
		{
			if (!Plain && !m_domain_implicit && m_domain.Length != 0)
			{
				return "$Domain=" + (IsQuotedDomain ? "\"" : string.Empty) + m_domain + (IsQuotedDomain ? "\"" : string.Empty);
			}
			return string.Empty;
		}
	}

	internal bool DomainImplicit
	{
		get
		{
			return m_domain_implicit;
		}
		set
		{
			m_domain_implicit = value;
		}
	}

	public bool Expired
	{
		get
		{
			if (m_expires != DateTime.MinValue)
			{
				return m_expires.ToLocalTime() <= DateTime.Now;
			}
			return false;
		}
	}

	public DateTime Expires
	{
		set
		{
			m_expires = value;
		}
	}

	public string Name
	{
		get
		{
			return m_name;
		}
		set
		{
			if (ValidationHelper.IsBlankString(value) || !InternalSetName(value))
			{
				throw new CookieException(global::SR.GetString("The '{0}'='{1}' part of the cookie is invalid.", "Name", (value == null) ? "<null>" : value));
			}
		}
	}

	public string Path
	{
		get
		{
			return m_path;
		}
		set
		{
			m_path = ((value == null) ? string.Empty : value);
			m_path_implicit = false;
		}
	}

	private string _Path
	{
		get
		{
			if (!Plain && !m_path_implicit && m_path.Length != 0)
			{
				return "$Path=" + m_path;
			}
			return string.Empty;
		}
	}

	internal bool Plain => Variant == CookieVariant.Plain;

	public string Port
	{
		set
		{
			m_port_implicit = false;
			if (value == null || value.Length == 0)
			{
				m_port = string.Empty;
				return;
			}
			if (value[0] != '"' || value[value.Length - 1] != '"')
			{
				throw new CookieException(global::SR.GetString("The '{0}'='{1}' part of the cookie is invalid.", "Port", value));
			}
			string[] array = value.Split(PortSplitDelimiters);
			List<int> list = new List<int>();
			for (int i = 0; i < array.Length; i++)
			{
				if (array[i] != string.Empty)
				{
					if (!int.TryParse(array[i], out var result))
					{
						throw new CookieException(global::SR.GetString("The '{0}'='{1}' part of the cookie is invalid.", "Port", value));
					}
					if (result < 0 || result > 65535)
					{
						throw new CookieException(global::SR.GetString("The '{0}'='{1}' part of the cookie is invalid.", "Port", value));
					}
					list.Add(result);
				}
			}
			m_port_list = list.ToArray();
			m_port = value;
			m_version = 1;
			m_cookieVariant = CookieVariant.Rfc2965;
		}
	}

	internal int[] PortList => m_port_list;

	private string _Port
	{
		get
		{
			if (!m_port_implicit)
			{
				return "$Port" + ((m_port.Length == 0) ? string.Empty : ("=" + m_port));
			}
			return string.Empty;
		}
	}

	public bool Secure
	{
		get
		{
			return m_secure;
		}
		set
		{
			m_secure = value;
		}
	}

	public string Value
	{
		get
		{
			return m_value;
		}
		set
		{
			m_value = ((value == null) ? string.Empty : value);
		}
	}

	internal CookieVariant Variant => m_cookieVariant;

	internal string DomainKey
	{
		get
		{
			if (!m_domain_implicit)
			{
				return m_domainKey;
			}
			return Domain;
		}
	}

	public int Version
	{
		get
		{
			return m_version;
		}
		set
		{
			if (value < 0)
			{
				throw new ArgumentOutOfRangeException("value");
			}
			m_version = value;
			if (value > 0 && m_cookieVariant < CookieVariant.Rfc2109)
			{
				m_cookieVariant = CookieVariant.Rfc2109;
			}
		}
	}

	private string _Version
	{
		get
		{
			if (Version != 0)
			{
				return "$Version=" + (IsQuotedVersion ? "\"" : string.Empty) + m_version.ToString(NumberFormatInfo.InvariantInfo) + (IsQuotedVersion ? "\"" : string.Empty);
			}
			return string.Empty;
		}
	}

	public Cookie()
	{
	}

	public Cookie(string name, string value)
	{
		Name = name;
		m_value = value;
	}

	internal bool InternalSetName(string value)
	{
		if (ValidationHelper.IsBlankString(value) || value[0] == '$' || value.IndexOfAny(Reserved2Name) != -1)
		{
			m_name = string.Empty;
			return false;
		}
		m_name = value;
		return true;
	}

	internal Cookie Clone()
	{
		Cookie cookie = new Cookie(m_name, m_value);
		if (!m_port_implicit)
		{
			cookie.Port = m_port;
		}
		if (!m_path_implicit)
		{
			cookie.Path = m_path;
		}
		cookie.Domain = m_domain;
		cookie.DomainImplicit = m_domain_implicit;
		cookie.m_timeStamp = m_timeStamp;
		cookie.Comment = m_comment;
		cookie.CommentUri = m_commentUri;
		cookie.HttpOnly = m_httpOnly;
		cookie.Discard = m_discard;
		cookie.Expires = m_expires;
		cookie.Version = m_version;
		cookie.Secure = m_secure;
		cookie.m_cookieVariant = m_cookieVariant;
		return cookie;
	}

	private static bool IsDomainEqualToHost(string domain, string host)
	{
		if (host.Length + 1 == domain.Length && string.Compare(host, 0, domain, 1, host.Length, StringComparison.OrdinalIgnoreCase) == 0)
		{
			return true;
		}
		return false;
	}

	internal bool VerifySetDefaults(CookieVariant variant, Uri uri, bool isLocalDomain, string localDomain, bool set_default, bool isThrow)
	{
		string host = uri.Host;
		int port = uri.Port;
		string absolutePath = uri.AbsolutePath;
		bool flag = true;
		if (set_default)
		{
			if (Version == 0)
			{
				variant = CookieVariant.Plain;
			}
			else if (Version == 1 && variant == CookieVariant.Unknown)
			{
				variant = CookieVariant.Rfc2109;
			}
			m_cookieVariant = variant;
		}
		if (m_name == null || m_name.Length == 0 || m_name[0] == '$' || m_name.IndexOfAny(Reserved2Name) != -1)
		{
			if (isThrow)
			{
				throw new CookieException(global::SR.GetString("The '{0}'='{1}' part of the cookie is invalid.", "Name", (m_name == null) ? "<null>" : m_name));
			}
			return false;
		}
		if (m_value == null || ((m_value.Length <= 2 || m_value[0] != '"' || m_value[m_value.Length - 1] != '"') && m_value.IndexOfAny(Reserved2Value) != -1))
		{
			if (isThrow)
			{
				throw new CookieException(global::SR.GetString("The '{0}'='{1}' part of the cookie is invalid.", "Value", (m_value == null) ? "<null>" : m_value));
			}
			return false;
		}
		if (Comment != null && (Comment.Length <= 2 || Comment[0] != '"' || Comment[Comment.Length - 1] != '"') && Comment.IndexOfAny(Reserved2Value) != -1)
		{
			if (isThrow)
			{
				throw new CookieException(global::SR.GetString("The '{0}'='{1}' part of the cookie is invalid.", "Comment", Comment));
			}
			return false;
		}
		if (Path != null && (Path.Length <= 2 || Path[0] != '"' || Path[Path.Length - 1] != '"') && Path.IndexOfAny(Reserved2Value) != -1)
		{
			if (isThrow)
			{
				throw new CookieException(global::SR.GetString("The '{0}'='{1}' part of the cookie is invalid.", "Path", Path));
			}
			return false;
		}
		if (set_default && m_domain_implicit)
		{
			m_domain = host;
		}
		else
		{
			if (!m_domain_implicit)
			{
				string text = m_domain;
				if (!DomainCharsTest(text))
				{
					if (isThrow)
					{
						throw new CookieException(global::SR.GetString("The '{0}'='{1}' part of the cookie is invalid.", "Domain", (text == null) ? "<null>" : text));
					}
					return false;
				}
				if (text[0] != '.')
				{
					if (variant != CookieVariant.Rfc2965 && variant != CookieVariant.Plain)
					{
						if (isThrow)
						{
							throw new CookieException(global::SR.GetString("The '{0}'='{1}' part of the cookie is invalid.", "Domain", m_domain));
						}
						return false;
					}
					text = "." + text;
				}
				int num = host.IndexOf('.');
				if (isLocalDomain && string.Compare(localDomain, text, StringComparison.OrdinalIgnoreCase) == 0)
				{
					flag = true;
				}
				else if (text.IndexOf('.', 1, text.Length - 2) == -1)
				{
					if (!IsDomainEqualToHost(text, host))
					{
						flag = false;
					}
				}
				else if (variant == CookieVariant.Plain)
				{
					if (!IsDomainEqualToHost(text, host) && (host.Length <= text.Length || string.Compare(host, host.Length - text.Length, text, 0, text.Length, StringComparison.OrdinalIgnoreCase) != 0))
					{
						flag = false;
					}
				}
				else if ((num == -1 || text.Length != host.Length - num || string.Compare(host, num, text, 0, text.Length, StringComparison.OrdinalIgnoreCase) != 0) && !IsDomainEqualToHost(text, host))
				{
					flag = false;
				}
				if (flag)
				{
					m_domainKey = text.ToLower(CultureInfo.InvariantCulture);
				}
			}
			else if (string.Compare(host, m_domain, StringComparison.OrdinalIgnoreCase) != 0)
			{
				flag = false;
			}
			if (!flag)
			{
				if (isThrow)
				{
					throw new CookieException(global::SR.GetString("The '{0}'='{1}' part of the cookie is invalid.", "Domain", m_domain));
				}
				return false;
			}
		}
		if (set_default && m_path_implicit)
		{
			switch (m_cookieVariant)
			{
			case CookieVariant.Plain:
				m_path = absolutePath;
				break;
			case CookieVariant.Rfc2109:
				m_path = absolutePath.Substring(0, absolutePath.LastIndexOf('/'));
				break;
			default:
				m_path = absolutePath.Substring(0, absolutePath.LastIndexOf('/') + 1);
				break;
			}
		}
		else if (!absolutePath.StartsWith(CookieParser.CheckQuoted(m_path)))
		{
			if (isThrow)
			{
				throw new CookieException(global::SR.GetString("The '{0}'='{1}' part of the cookie is invalid.", "Path", m_path));
			}
			return false;
		}
		if (set_default && !m_port_implicit && m_port.Length == 0)
		{
			m_port_list = new int[1] { port };
		}
		if (!m_port_implicit)
		{
			flag = false;
			int[] port_list = m_port_list;
			for (int i = 0; i < port_list.Length; i++)
			{
				if (port_list[i] == port)
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				if (isThrow)
				{
					throw new CookieException(global::SR.GetString("The '{0}'='{1}' part of the cookie is invalid.", "Port", m_port));
				}
				return false;
			}
		}
		return true;
	}

	private static bool DomainCharsTest(string name)
	{
		if (name == null || name.Length == 0)
		{
			return false;
		}
		foreach (char c in name)
		{
			if (c >= '0' && c <= '9')
			{
				continue;
			}
			switch (c)
			{
			case '-':
			case '.':
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'g':
			case 'h':
			case 'i':
			case 'j':
			case 'k':
			case 'l':
			case 'm':
			case 'n':
			case 'o':
			case 'p':
			case 'q':
			case 'r':
			case 's':
			case 't':
			case 'u':
			case 'v':
			case 'w':
			case 'x':
			case 'y':
			case 'z':
				continue;
			}
			if ((c < 'A' || c > 'Z') && c != '_')
			{
				return false;
			}
		}
		return true;
	}

	internal static IComparer GetComparer()
	{
		return staticComparer;
	}

	public override bool Equals(object comparand)
	{
		if (!(comparand is Cookie))
		{
			return false;
		}
		Cookie cookie = (Cookie)comparand;
		if (string.Compare(Name, cookie.Name, StringComparison.OrdinalIgnoreCase) == 0 && string.Compare(Value, cookie.Value, StringComparison.Ordinal) == 0 && string.Compare(Path, cookie.Path, StringComparison.Ordinal) == 0 && string.Compare(Domain, cookie.Domain, StringComparison.OrdinalIgnoreCase) == 0)
		{
			return Version == cookie.Version;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (Name + "=" + Value + ";" + Path + "; " + Domain + "; " + Version).GetHashCode();
	}

	public override string ToString()
	{
		string domain = _Domain;
		string path = _Path;
		string port = _Port;
		string version = _Version;
		string text = ((version.Length == 0) ? string.Empty : (version + "; ")) + Name + "=" + Value + ((path.Length == 0) ? string.Empty : ("; " + path)) + ((domain.Length == 0) ? string.Empty : ("; " + domain)) + ((port.Length == 0) ? string.Empty : ("; " + port));
		if (text == "=")
		{
			return string.Empty;
		}
		return text;
	}

	static Cookie()
	{
		//IL_0022: Field data (rva=0x8b0) could not be found in any section!
		//IL_0022: Field data (rva=0x8b0) could not be found in any section!
		//IL_000c: Field data (rva=0x818) could not be found in any section!
		//IL_000c: Field data (rva=0x818) could not be found in any section!
		char[] array = new char[3];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		PortSplitDelimiters = array;
		char[] array2 = new char[7];
		RuntimeHelpers.InitializeArray(array2, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		Reserved2Name = array2;
		Reserved2Value = new char[2] { ';', ',' };
		staticComparer = new Comparer();
	}
}
