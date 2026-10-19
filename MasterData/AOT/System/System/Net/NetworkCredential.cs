using System.Security;

namespace System.Net;

public class NetworkCredential : ICredentials
{
	private string m_domain;

	private string m_userName;

	private SecureString m_password;

	public string UserName
	{
		get
		{
			return InternalGetUserName();
		}
		set
		{
			if (value == null)
			{
				m_userName = string.Empty;
			}
			else
			{
				m_userName = value;
			}
		}
	}

	public string Password
	{
		get
		{
			return InternalGetPassword();
		}
		set
		{
			m_password = UnsafeNclNativeMethods.SecureStringHelper.CreateSecureString(value);
		}
	}

	public string Domain
	{
		get
		{
			return InternalGetDomain();
		}
		set
		{
			if (value == null)
			{
				m_domain = string.Empty;
			}
			else
			{
				m_domain = value;
			}
		}
	}

	public NetworkCredential(string userName, string password)
		: this(userName, password, string.Empty)
	{
	}

	public NetworkCredential(string userName, string password, string domain)
	{
		UserName = userName;
		Password = password;
		Domain = domain;
	}

	internal string InternalGetUserName()
	{
		return m_userName;
	}

	internal string InternalGetPassword()
	{
		return UnsafeNclNativeMethods.SecureStringHelper.CreateString(m_password);
	}

	internal string InternalGetDomain()
	{
		return m_domain;
	}

	public NetworkCredential GetCredential(Uri uri, string authType)
	{
		return this;
	}
}
