using System.Security.Cryptography.X509Certificates;
using System.Text;
using Mono.Security;
using Mono.Security.Cryptography;

namespace System.Security.Cryptography;

public class AsnEncodedData
{
	internal Oid _oid;

	internal byte[] _raw;

	public Oid Oid
	{
		get
		{
			return _oid;
		}
		set
		{
			if (value == null)
			{
				_oid = null;
			}
			else
			{
				_oid = new Oid(value);
			}
		}
	}

	public byte[] RawData
	{
		get
		{
			return _raw;
		}
		set
		{
			if (value == null)
			{
				throw new ArgumentNullException("RawData");
			}
			_raw = (byte[])value.Clone();
		}
	}

	protected AsnEncodedData()
	{
	}

	public AsnEncodedData(string oid, byte[] rawData)
	{
		_oid = new Oid(oid);
		RawData = rawData;
	}

	public AsnEncodedData(Oid oid, byte[] rawData)
	{
		Oid = oid;
		RawData = rawData;
	}

	public AsnEncodedData(AsnEncodedData asnEncodedData)
	{
		if (asnEncodedData == null)
		{
			throw new ArgumentNullException("asnEncodedData");
		}
		if (asnEncodedData._oid != null)
		{
			Oid = new Oid(asnEncodedData._oid);
		}
		RawData = asnEncodedData._raw;
	}

	public virtual void CopyFrom(AsnEncodedData asnEncodedData)
	{
		if (asnEncodedData == null)
		{
			throw new ArgumentNullException("asnEncodedData");
		}
		if (asnEncodedData._oid == null)
		{
			Oid = null;
		}
		else
		{
			Oid = new Oid(asnEncodedData._oid);
		}
		RawData = asnEncodedData._raw;
	}

	public virtual string Format(bool multiLine)
	{
		if (_raw == null)
		{
			return string.Empty;
		}
		if (_oid == null)
		{
			return Default(multiLine);
		}
		return ToString(multiLine);
	}

	internal virtual string ToString(bool multiLine)
	{
		return _oid.Value switch
		{
			"2.5.29.19" => BasicConstraintsExtension(multiLine), 
			"2.5.29.37" => EnhancedKeyUsageExtension(multiLine), 
			"2.5.29.15" => KeyUsageExtension(multiLine), 
			"2.5.29.14" => SubjectKeyIdentifierExtension(multiLine), 
			"2.5.29.17" => SubjectAltName(multiLine), 
			"2.16.840.1.113730.1.1" => NetscapeCertType(multiLine), 
			_ => Default(multiLine), 
		};
	}

	internal string Default(bool multiLine)
	{
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < _raw.Length; i++)
		{
			stringBuilder.Append(_raw[i].ToString("x2"));
			if (i != _raw.Length - 1)
			{
				stringBuilder.Append(" ");
			}
		}
		return stringBuilder.ToString();
	}

	internal string BasicConstraintsExtension(bool multiLine)
	{
		try
		{
			return new X509BasicConstraintsExtension(this, critical: false).ToString(multiLine);
		}
		catch
		{
			return string.Empty;
		}
	}

	internal string EnhancedKeyUsageExtension(bool multiLine)
	{
		try
		{
			return new X509EnhancedKeyUsageExtension(this, critical: false).ToString(multiLine);
		}
		catch
		{
			return string.Empty;
		}
	}

	internal string KeyUsageExtension(bool multiLine)
	{
		try
		{
			return new X509KeyUsageExtension(this, critical: false).ToString(multiLine);
		}
		catch
		{
			return string.Empty;
		}
	}

	internal string SubjectKeyIdentifierExtension(bool multiLine)
	{
		try
		{
			return new X509SubjectKeyIdentifierExtension(this, critical: false).ToString(multiLine);
		}
		catch
		{
			return string.Empty;
		}
	}

	internal string SubjectAltName(bool multiLine)
	{
		if (_raw.Length < 5)
		{
			return "Information Not Available";
		}
		try
		{
			ASN1 aSN = new ASN1(_raw);
			StringBuilder stringBuilder = new StringBuilder();
			for (int i = 0; i < aSN.Count; i++)
			{
				ASN1 aSN2 = aSN.get_Item(i);
				string text = null;
				string text2 = null;
				switch (aSN2.Tag)
				{
				case 129:
					text = "RFC822 Name=";
					text2 = Encoding.ASCII.GetString(aSN2.Value);
					break;
				case 130:
					text = "DNS Name=";
					text2 = Encoding.ASCII.GetString(aSN2.Value);
					break;
				default:
					text = $"Unknown ({aSN2.Tag})=";
					text2 = CryptoConvert.ToHex(aSN2.Value);
					break;
				}
				stringBuilder.Append(text);
				stringBuilder.Append(text2);
				if (multiLine)
				{
					stringBuilder.Append(Environment.NewLine);
				}
				else if (i < aSN.Count - 1)
				{
					stringBuilder.Append(", ");
				}
			}
			return stringBuilder.ToString();
		}
		catch
		{
			return string.Empty;
		}
	}

	internal string NetscapeCertType(bool multiLine)
	{
		if (_raw.Length < 4 || _raw[0] != 3 || _raw[1] != 2)
		{
			return "Information Not Available";
		}
		int num = _raw[3] >> (int)_raw[2] << (int)_raw[2];
		StringBuilder stringBuilder = new StringBuilder();
		if ((num & 0x80) == 128)
		{
			stringBuilder.Append("SSL Client Authentication");
		}
		if ((num & 0x40) == 64)
		{
			if (stringBuilder.Length > 0)
			{
				stringBuilder.Append(", ");
			}
			stringBuilder.Append("SSL Server Authentication");
		}
		if ((num & 0x20) == 32)
		{
			if (stringBuilder.Length > 0)
			{
				stringBuilder.Append(", ");
			}
			stringBuilder.Append("SMIME");
		}
		if ((num & 0x10) == 16)
		{
			if (stringBuilder.Length > 0)
			{
				stringBuilder.Append(", ");
			}
			stringBuilder.Append("Signature");
		}
		if ((num & 8) == 8)
		{
			if (stringBuilder.Length > 0)
			{
				stringBuilder.Append(", ");
			}
			stringBuilder.Append("Unknown cert type");
		}
		if ((num & 4) == 4)
		{
			if (stringBuilder.Length > 0)
			{
				stringBuilder.Append(", ");
			}
			stringBuilder.Append("SSL CA");
		}
		if ((num & 2) == 2)
		{
			if (stringBuilder.Length > 0)
			{
				stringBuilder.Append(", ");
			}
			stringBuilder.Append("SMIME CA");
		}
		if ((num & 1) == 1)
		{
			if (stringBuilder.Length > 0)
			{
				stringBuilder.Append(", ");
			}
			stringBuilder.Append("Signature CA");
		}
		stringBuilder.AppendFormat(" ({0})", num.ToString("x2"));
		return stringBuilder.ToString();
	}
}
