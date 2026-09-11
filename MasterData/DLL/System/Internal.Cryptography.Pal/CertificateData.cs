using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;

namespace Internal.Cryptography.Pal;

internal struct CertificateData
{
	internal struct AlgorithmIdentifier
	{
		internal string AlgorithmId;

		internal byte[] Parameters;
	}

	internal byte[] RawData;

	internal byte[] SubjectPublicKeyInfo;

	internal int Version;

	internal byte[] SerialNumber;

	internal AlgorithmIdentifier TbsSignature;

	internal X500DistinguishedName Issuer;

	internal DateTime NotBefore;

	internal DateTime NotAfter;

	internal X500DistinguishedName Subject;

	internal AlgorithmIdentifier PublicKeyAlgorithm;

	internal byte[] PublicKey;

	internal byte[] IssuerUniqueId;

	internal byte[] SubjectUniqueId;

	internal List<X509Extension> Extensions;

	internal AlgorithmIdentifier SignatureAlgorithm;

	internal byte[] SignatureValue;

	internal CertificateData(byte[] rawData)
	{
		DerSequenceReader derSequenceReader = new DerSequenceReader(rawData);
		DerSequenceReader derSequenceReader2 = derSequenceReader.ReadSequence();
		if (derSequenceReader2.PeekTag() == 160)
		{
			DerSequenceReader derSequenceReader3 = derSequenceReader2.ReadSequence();
			Version = derSequenceReader3.ReadInteger();
		}
		else
		{
			if (derSequenceReader2.PeekTag() != 2)
			{
				throw new CryptographicException("ASN1 corrupted data.");
			}
			Version = 0;
		}
		if (Version < 0 || Version > 2)
		{
			throw new CryptographicException();
		}
		SerialNumber = derSequenceReader2.ReadIntegerBytes();
		DerSequenceReader derSequenceReader4 = derSequenceReader2.ReadSequence();
		TbsSignature.AlgorithmId = derSequenceReader4.ReadOidAsString();
		TbsSignature.Parameters = (derSequenceReader4.HasData ? derSequenceReader4.ReadNextEncodedValue() : Array.Empty<byte>());
		if (derSequenceReader4.HasData)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		Issuer = new X500DistinguishedName(derSequenceReader2.ReadNextEncodedValue());
		DerSequenceReader derSequenceReader5 = derSequenceReader2.ReadSequence();
		NotBefore = derSequenceReader5.ReadX509Date();
		NotAfter = derSequenceReader5.ReadX509Date();
		if (derSequenceReader5.HasData)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		Subject = new X500DistinguishedName(derSequenceReader2.ReadNextEncodedValue());
		SubjectPublicKeyInfo = derSequenceReader2.ReadNextEncodedValue();
		DerSequenceReader derSequenceReader6 = new DerSequenceReader(SubjectPublicKeyInfo);
		DerSequenceReader derSequenceReader7 = derSequenceReader6.ReadSequence();
		PublicKeyAlgorithm.AlgorithmId = derSequenceReader7.ReadOidAsString();
		PublicKeyAlgorithm.Parameters = (derSequenceReader7.HasData ? derSequenceReader7.ReadNextEncodedValue() : Array.Empty<byte>());
		if (derSequenceReader7.HasData)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		PublicKey = derSequenceReader6.ReadBitString();
		if (derSequenceReader6.HasData)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		if (Version > 0 && derSequenceReader2.HasData && derSequenceReader2.PeekTag() == 161)
		{
			IssuerUniqueId = derSequenceReader2.ReadBitString();
		}
		else
		{
			IssuerUniqueId = null;
		}
		if (Version > 0 && derSequenceReader2.HasData && derSequenceReader2.PeekTag() == 162)
		{
			SubjectUniqueId = derSequenceReader2.ReadBitString();
		}
		else
		{
			SubjectUniqueId = null;
		}
		Extensions = new List<X509Extension>();
		if (Version > 1 && derSequenceReader2.HasData && derSequenceReader2.PeekTag() == 163)
		{
			DerSequenceReader derSequenceReader8 = derSequenceReader2.ReadSequence();
			derSequenceReader8 = derSequenceReader8.ReadSequence();
			while (derSequenceReader8.HasData)
			{
				DerSequenceReader derSequenceReader9 = derSequenceReader8.ReadSequence();
				string oid = derSequenceReader9.ReadOidAsString();
				bool critical = false;
				if (derSequenceReader9.PeekTag() == 1)
				{
					critical = derSequenceReader9.ReadBoolean();
				}
				byte[] rawData2 = derSequenceReader9.ReadOctetString();
				Extensions.Add(new X509Extension(oid, rawData2, critical));
				if (derSequenceReader9.HasData)
				{
					throw new CryptographicException("ASN1 corrupted data.");
				}
			}
		}
		if (derSequenceReader2.HasData)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		DerSequenceReader derSequenceReader10 = derSequenceReader.ReadSequence();
		SignatureAlgorithm.AlgorithmId = derSequenceReader10.ReadOidAsString();
		SignatureAlgorithm.Parameters = (derSequenceReader10.HasData ? derSequenceReader10.ReadNextEncodedValue() : Array.Empty<byte>());
		if (derSequenceReader10.HasData)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		SignatureValue = derSequenceReader.ReadBitString();
		if (derSequenceReader.HasData)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		RawData = rawData;
	}

	public string GetNameInfo(X509NameType nameType, bool forIssuer)
	{
		if (nameType == X509NameType.SimpleName)
		{
			string simpleNameInfo = GetSimpleNameInfo(forIssuer ? Issuer : Subject);
			if (simpleNameInfo != null)
			{
				return simpleNameInfo;
			}
		}
		string text = (forIssuer ? "2.5.29.18" : "2.5.29.17");
		GeneralNameType? generalNameType = null;
		string otherOid = null;
		switch (nameType)
		{
		case X509NameType.DnsName:
		case X509NameType.DnsFromAlternativeName:
			generalNameType = GeneralNameType.DnsName;
			break;
		case X509NameType.SimpleName:
		case X509NameType.EmailName:
			generalNameType = GeneralNameType.Rfc822Name;
			break;
		case X509NameType.UpnName:
			generalNameType = GeneralNameType.OtherName;
			otherOid = "1.3.6.1.4.1.311.20.2.3";
			break;
		case X509NameType.UrlName:
			generalNameType = GeneralNameType.UniformResourceIdentifier;
			break;
		}
		if (generalNameType.HasValue)
		{
			foreach (X509Extension extension in Extensions)
			{
				if (extension.Oid.Value == text)
				{
					string text2 = FindAltNameMatch(extension.RawData, generalNameType.Value, otherOid);
					if (text2 != null)
					{
						return text2;
					}
				}
			}
		}
		string text3 = null;
		switch (nameType)
		{
		case X509NameType.EmailName:
			text3 = "1.2.840.113549.1.9.1";
			break;
		case X509NameType.DnsName:
			text3 = "2.5.4.3";
			break;
		}
		if (text3 != null)
		{
			foreach (KeyValuePair<string, string> item in ReadReverseRdns(forIssuer ? Issuer : Subject))
			{
				if (item.Key == text3)
				{
					return item.Value;
				}
			}
		}
		return "";
	}

	private static string GetSimpleNameInfo(X500DistinguishedName name)
	{
		string text = null;
		string text2 = null;
		string text3 = null;
		string text4 = null;
		foreach (KeyValuePair<string, string> item in ReadReverseRdns(name))
		{
			string key = item.Key;
			string value = item.Value;
			switch (key)
			{
			case "2.5.4.3":
				return value;
			case "2.5.4.11":
				text = value;
				continue;
			case "2.5.4.10":
				text2 = value;
				continue;
			case "1.2.840.113549.1.9.1":
				text3 = value;
				continue;
			}
			if (text4 == null)
			{
				text4 = value;
			}
		}
		return text ?? text2 ?? text3 ?? text4;
	}

	private static string FindAltNameMatch(byte[] extensionBytes, GeneralNameType matchType, string otherOid)
	{
		byte b = (byte)(0x80 | (byte)matchType);
		if (matchType == GeneralNameType.OtherName)
		{
			b |= 0x20;
		}
		DerSequenceReader derSequenceReader = new DerSequenceReader(extensionBytes);
		while (derSequenceReader.HasData)
		{
			if (derSequenceReader.PeekTag() != b)
			{
				derSequenceReader.SkipValue();
				continue;
			}
			switch (matchType)
			{
			case GeneralNameType.OtherName:
			{
				DerSequenceReader derSequenceReader2 = derSequenceReader.ReadSequence();
				if (derSequenceReader2.ReadOidAsString() == otherOid)
				{
					if (derSequenceReader2.PeekTag() != 160)
					{
						throw new CryptographicException("ASN1 corrupted data.");
					}
					derSequenceReader2 = derSequenceReader2.ReadSequence();
					return derSequenceReader2.ReadUtf8String();
				}
				break;
			}
			case GeneralNameType.Rfc822Name:
			case GeneralNameType.DnsName:
			case GeneralNameType.UniformResourceIdentifier:
				return derSequenceReader.ReadIA5String();
			default:
				derSequenceReader.SkipValue();
				break;
			}
		}
		return null;
	}

	private static IEnumerable<KeyValuePair<string, string>> ReadReverseRdns(X500DistinguishedName name)
	{
		DerSequenceReader derSequenceReader = new DerSequenceReader(name.RawData);
		Stack<DerSequenceReader> rdnReaders = new Stack<DerSequenceReader>();
		while (derSequenceReader.HasData)
		{
			rdnReaders.Push(derSequenceReader.ReadSet());
		}
		while (rdnReaders.Count > 0)
		{
			DerSequenceReader rdnReader = rdnReaders.Pop();
			while (rdnReader.HasData)
			{
				DerSequenceReader derSequenceReader2 = rdnReader.ReadSequence();
				string key = derSequenceReader2.ReadOidAsString();
				DerSequenceReader.DerTag derTag = (DerSequenceReader.DerTag)derSequenceReader2.PeekTag();
				string text = null;
				switch (derTag)
				{
				case DerSequenceReader.DerTag.BMPString:
					text = derSequenceReader2.ReadBMPString();
					break;
				case DerSequenceReader.DerTag.IA5String:
					text = derSequenceReader2.ReadIA5String();
					break;
				case DerSequenceReader.DerTag.PrintableString:
					text = derSequenceReader2.ReadPrintableString();
					break;
				case DerSequenceReader.DerTag.UTF8String:
					text = derSequenceReader2.ReadUtf8String();
					break;
				case DerSequenceReader.DerTag.T61String:
					text = derSequenceReader2.ReadT61String();
					break;
				}
				if (text != null)
				{
					yield return new KeyValuePair<string, string>(key, text);
				}
			}
		}
	}
}
