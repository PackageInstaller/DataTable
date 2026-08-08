using System.Collections.Specialized;
using System.Text;

namespace System.Net.Mime;

public class ContentType
{
	private readonly TrackingStringDictionary _parameters = new TrackingStringDictionary();

	private string _mediaType;

	private string _subType;

	private bool _isChanged;

	private string _type;

	private bool _isPersisted;

	public string Boundary
	{
		set
		{
			if (value == null || value == string.Empty)
			{
				Parameters.Remove("boundary");
			}
			else
			{
				Parameters["boundary"] = value;
			}
		}
	}

	public string CharSet
	{
		set
		{
			if (value == null || value == string.Empty)
			{
				Parameters.Remove("charset");
			}
			else
			{
				Parameters["charset"] = value;
			}
		}
	}

	public string MediaType
	{
		set
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			if (value == string.Empty)
			{
				throw new ArgumentException("This property cannot be set to an empty string.", "value");
			}
			int offset = 0;
			_mediaType = MailBnfHelper.ReadToken(value, ref offset, null);
			if (_mediaType.Length == 0 || offset >= value.Length || value[offset++] != '/')
			{
				throw new FormatException("The specified media type is invalid.");
			}
			_subType = MailBnfHelper.ReadToken(value, ref offset, null);
			if (_subType.Length == 0 || offset < value.Length)
			{
				throw new FormatException("The specified media type is invalid.");
			}
			_isChanged = true;
			_isPersisted = false;
		}
	}

	public string Name
	{
		get
		{
			string text = Parameters["name"];
			if (MimeBasePart.DecodeEncoding(text) != null)
			{
				text = MimeBasePart.DecodeHeaderValue(text);
			}
			return text;
		}
		set
		{
			if (value == null || value == string.Empty)
			{
				Parameters.Remove("name");
			}
			else
			{
				Parameters["name"] = value;
			}
		}
	}

	public StringDictionary Parameters => _parameters;

	internal bool IsChanged
	{
		get
		{
			if (!_isChanged)
			{
				if (_parameters != null)
				{
					return _parameters.IsChanged;
				}
				return false;
			}
			return true;
		}
	}

	public ContentType()
		: this("application/octet-stream")
	{
	}

	public ContentType(string contentType)
	{
		if (contentType == null)
		{
			throw new ArgumentNullException("contentType");
		}
		if (contentType == string.Empty)
		{
			throw new ArgumentException(global::SR.Format("The parameter '{0}' cannot be an empty string.", "contentType"), "contentType");
		}
		_isChanged = true;
		_type = contentType;
		ParseValue();
	}

	public override string ToString()
	{
		if (_type == null || IsChanged)
		{
			_type = Encode(allowUnicode: false);
			_isChanged = false;
			_parameters.IsChanged = false;
			_isPersisted = false;
		}
		return _type;
	}

	internal string Encode(bool allowUnicode)
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(_mediaType);
		stringBuilder.Append('/');
		stringBuilder.Append(_subType);
		foreach (string key in Parameters.Keys)
		{
			stringBuilder.Append("; ");
			EncodeToBuffer(key, stringBuilder, allowUnicode);
			stringBuilder.Append('=');
			EncodeToBuffer(_parameters[key], stringBuilder, allowUnicode);
		}
		return stringBuilder.ToString();
	}

	private static void EncodeToBuffer(string value, StringBuilder builder, bool allowUnicode)
	{
		Encoding encoding = MimeBasePart.DecodeEncoding(value);
		if (encoding != null)
		{
			builder.Append('"').Append(value).Append('"');
			return;
		}
		if ((allowUnicode && !MailBnfHelper.HasCROrLF(value)) || MimeBasePart.IsAscii(value, permitCROrLF: false))
		{
			MailBnfHelper.GetTokenOrQuotedString(value, builder, allowUnicode);
			return;
		}
		encoding = Encoding.GetEncoding("utf-8");
		builder.Append('"').Append(MimeBasePart.EncodeHeaderValue(value, encoding, MimeBasePart.ShouldUseBase64Encoding(encoding))).Append('"');
	}

	public override bool Equals(object rparam)
	{
		if (rparam != null)
		{
			return string.Equals(ToString(), rparam.ToString(), StringComparison.OrdinalIgnoreCase);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return ToString().ToLowerInvariant().GetHashCode();
	}

	private void ParseValue()
	{
		int offset = 0;
		Exception ex = null;
		try
		{
			_mediaType = MailBnfHelper.ReadToken(_type, ref offset, null);
			if (_mediaType == null || _mediaType.Length == 0 || offset >= _type.Length || _type[offset++] != '/')
			{
				ex = new FormatException("The specified content type is invalid.");
			}
			if (ex == null)
			{
				_subType = MailBnfHelper.ReadToken(_type, ref offset, null);
				if (_subType == null || _subType.Length == 0)
				{
					ex = new FormatException("The specified content type is invalid.");
				}
			}
			if (ex == null)
			{
				while (MailBnfHelper.SkipCFWS(_type, ref offset))
				{
					if (_type[offset++] != ';')
					{
						ex = new FormatException("The specified content type is invalid.");
						break;
					}
					if (!MailBnfHelper.SkipCFWS(_type, ref offset))
					{
						break;
					}
					string text = MailBnfHelper.ReadParameterAttribute(_type, ref offset, null);
					if (text == null || text.Length == 0)
					{
						ex = new FormatException("The specified content type is invalid.");
						break;
					}
					if (offset >= _type.Length || _type[offset++] != '=')
					{
						ex = new FormatException("The specified content type is invalid.");
						break;
					}
					if (!MailBnfHelper.SkipCFWS(_type, ref offset))
					{
						ex = new FormatException("The specified content type is invalid.");
						break;
					}
					string text2 = ((_type[offset] == '"') ? MailBnfHelper.ReadQuotedString(_type, ref offset, null) : MailBnfHelper.ReadToken(_type, ref offset, null));
					if (text2 == null)
					{
						ex = new FormatException("The specified content type is invalid.");
						break;
					}
					_parameters.Add(text, text2);
				}
			}
			_parameters.IsChanged = false;
		}
		catch (FormatException)
		{
			throw new FormatException("The specified content type is invalid.");
		}
		if (ex != null)
		{
			throw new FormatException("The specified content type is invalid.");
		}
	}
}
