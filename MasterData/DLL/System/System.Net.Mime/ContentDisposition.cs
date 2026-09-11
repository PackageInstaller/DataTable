using System.Collections.Generic;
using System.Collections.Specialized;
using System.Globalization;
using System.Text;

namespace System.Net.Mime;

public class ContentDisposition
{
	private TrackingValidationObjectDictionary _parameters;

	private string _disposition;

	private string _dispositionType;

	private bool _isChanged;

	private bool _isPersisted;

	private static readonly TrackingValidationObjectDictionary.ValidateAndParseValue s_dateParser = (object v) => new SmtpDateTime(v.ToString());

	private static readonly TrackingValidationObjectDictionary.ValidateAndParseValue s_longParser = delegate(object value)
	{
		if (!long.TryParse(value.ToString(), NumberStyles.None, CultureInfo.InvariantCulture, out var result))
		{
			throw new FormatException("The specified content disposition is invalid.");
		}
		return result;
	};

	private static readonly Dictionary<string, TrackingValidationObjectDictionary.ValidateAndParseValue> s_validators = new Dictionary<string, TrackingValidationObjectDictionary.ValidateAndParseValue>
	{
		{ "creation-date", s_dateParser },
		{ "modification-date", s_dateParser },
		{ "read-date", s_dateParser },
		{ "size", s_longParser }
	};

	public StringDictionary Parameters => _parameters ?? (_parameters = new TrackingValidationObjectDictionary(s_validators));

	public string FileName
	{
		set
		{
			if (string.IsNullOrEmpty(value))
			{
				Parameters.Remove("filename");
			}
			else
			{
				Parameters["filename"] = value;
			}
		}
	}

	public ContentDisposition()
	{
		_isChanged = true;
		_disposition = (_dispositionType = "attachment");
	}

	public override string ToString()
	{
		if (_disposition == null || _isChanged || (_parameters != null && _parameters.IsChanged))
		{
			_disposition = Encode(allowUnicode: false);
			_isChanged = false;
			_parameters.IsChanged = false;
			_isPersisted = false;
		}
		return _disposition;
	}

	internal string Encode(bool allowUnicode)
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(_dispositionType);
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
}
