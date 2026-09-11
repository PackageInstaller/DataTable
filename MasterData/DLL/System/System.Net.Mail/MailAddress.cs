using System.Net.Mime;
using System.Text;

namespace System.Net.Mail;

public class MailAddress
{
	private readonly Encoding _displayNameEncoding;

	private readonly string _displayName;

	private readonly string _userName;

	private readonly string _host;

	private static readonly EncodedStreamFactory s_encoderFactory = new EncodedStreamFactory();

	public string DisplayName => _displayName;

	public string Address => _userName + "@" + _host;

	private string SmtpAddress => "<" + Address + ">";

	internal MailAddress(string displayName, string userName, string domain)
	{
		_host = domain;
		_userName = userName;
		_displayName = displayName;
		_displayNameEncoding = Encoding.GetEncoding("utf-8");
	}

	public MailAddress(string address)
		: this(address, (string)null, (Encoding)null)
	{
	}

	public MailAddress(string address, string displayName, Encoding displayNameEncoding)
	{
		if (address == null)
		{
			throw new ArgumentNullException("address");
		}
		if (address == string.Empty)
		{
			throw new ArgumentException(global::SR.Format("The parameter '{0}' cannot be an empty string.", "address"), "address");
		}
		_displayNameEncoding = displayNameEncoding ?? Encoding.GetEncoding("utf-8");
		_displayName = displayName ?? string.Empty;
		if (!string.IsNullOrEmpty(_displayName))
		{
			_displayName = MailAddressParser.NormalizeOrThrow(_displayName);
			if (_displayName.Length >= 2 && _displayName[0] == '"' && _displayName[_displayName.Length - 1] == '"')
			{
				_displayName = _displayName.Substring(1, _displayName.Length - 2);
			}
		}
		MailAddress mailAddress = MailAddressParser.ParseAddress(address);
		_host = mailAddress._host;
		_userName = mailAddress._userName;
		if (string.IsNullOrEmpty(_displayName))
		{
			_displayName = mailAddress._displayName;
		}
	}

	public override string ToString()
	{
		if (string.IsNullOrEmpty(DisplayName))
		{
			return Address;
		}
		return "\"" + DisplayName + "\" " + SmtpAddress;
	}

	public override bool Equals(object value)
	{
		if (value == null)
		{
			return false;
		}
		return ToString().Equals(value.ToString(), StringComparison.InvariantCultureIgnoreCase);
	}

	public override int GetHashCode()
	{
		return ToString().GetHashCode();
	}
}
