using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public class CryptoConfig
{
	private static readonly object lockObject = new object();

	private static Dictionary<string, Type> algorithms;

	[MonoLimitation("nothing is FIPS certified so it never make sense to restrict to this (empty) subset")]
	public static bool AllowOnlyFipsAlgorithms => false;

	public static object CreateFromName(string name)
	{
		return CreateFromName(name, null);
	}

	public static object CreateFromName(string name, params object[] args)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		Type value = null;
		switch (name.ToLowerInvariant())
		{
		case "system.security.cryptography.dsacryptoserviceprovider":
		case "system.security.cryptography.dsa":
		case "dsa":
			return new DSACryptoServiceProvider();
		case "system.security.cryptography.dsasignaturedeformatter":
			return new DSASignatureDeformatter();
		case "system.security.cryptography.dsasignatureformatter":
			return new DSASignatureFormatter();
		case "system.security.cryptography.dsasignaturedescription":
		case "http://www.w3.org/2000/09/xmldsig#dsa-sha1":
			return new DSASignatureDescription();
		case "system.security.cryptography.descryptoserviceprovider":
		case "system.security.cryptography.des":
		case "des":
			return new DESCryptoServiceProvider();
		case "system.security.cryptography.hmacmd5":
		case "hmacmd5":
			return new HMACMD5();
		case "system.security.cryptography.hmacripemd160":
		case "hmacripemd160":
		case "http://www.w3.org/2001/04/xmldsig-more#hmac-ripemd160":
			return new HMACRIPEMD160();
		case "system.security.cryptography.keyedhashalgorithm":
		case "system.security.cryptography.hmac":
		case "system.security.cryptography.hmacsha1":
		case "hmacsha1":
		case "http://www.w3.org/2000/09/xmldsig#hmac-sha1":
			return new HMACSHA1();
		case "system.security.cryptography.hmacsha256":
		case "hmacsha256":
		case "http://www.w3.org/2001/04/xmldsig-more#hmac-sha256":
			return new HMACSHA256();
		case "system.security.cryptography.hmacsha384":
		case "hmacsha384":
		case "http://www.w3.org/2001/04/xmldsig-more#hmac-sha384":
			return new HMACSHA384();
		case "system.security.cryptography.hmacsha512":
		case "hmacsha512":
		case "http://www.w3.org/2001/04/xmldsig-more#hmac-sha512":
			return new HMACSHA512();
		case "system.security.cryptography.mactripledes":
		case "mactripledes":
			return new MACTripleDES();
		case "system.security.cryptography.md5cryptoserviceprovider":
		case "system.security.cryptography.md5":
		case "md5":
			return new MD5CryptoServiceProvider();
		case "system.security.cryptography.rc2cryptoserviceprovider":
		case "system.security.cryptography.rc2":
		case "rc2":
			return new RC2CryptoServiceProvider();
		case "system.security.cryptography.symmetricalgorithm":
		case "system.security.cryptography.rijndaelmanaged":
		case "system.security.cryptography.rijndael":
		case "rijndael":
			return new RijndaelManaged();
		case "system.security.cryptography.ripemd160managed":
		case "system.security.cryptography.ripemd160":
		case "ripemd-160":
		case "ripemd160":
			return new RIPEMD160Managed();
		case "system.security.cryptography.rngcryptoserviceprovider":
		case "system.security.cryptography.randomnumbergenerator":
		case "randomnumbergenerator":
			return new RNGCryptoServiceProvider();
		case "system.security.cryptography.asymmetricalgorithm":
		case "system.security.cryptography.rsa":
		case "rsa":
			return new RSACryptoServiceProvider();
		case "system.security.cryptography.rsapkcs1signaturedeformatter":
			return new RSAPKCS1SignatureDeformatter();
		case "system.security.cryptography.rsapkcs1signatureformatter":
			return new RSAPKCS1SignatureFormatter();
		case "system.security.cryptography.rsapkcs1sha1signaturedescription":
		case "http://www.w3.org/2000/09/xmldsig#rsa-sha1":
			return new RSAPKCS1SHA1SignatureDescription();
		case "system.security.cryptography.rsapkcs1sha256signaturedescription":
		case "http://www.w3.org/2001/04/xmldsig-more#rsa-sha256":
			return new RSAPKCS1SHA256SignatureDescription();
		case "system.security.cryptography.rsapkcs1sha384signaturedescription":
		case "http://www.w3.org/2001/04/xmldsig-more#rsa-sha384":
			return new RSAPKCS1SHA384SignatureDescription();
		case "system.security.cryptography.rsapkcs1sha512signaturedescription":
		case "http://www.w3.org/2001/04/xmldsig-more#rsa-sha512":
			return new RSAPKCS1SHA512SignatureDescription();
		case "system.security.cryptography.hashalgorithm":
		case "system.security.cryptography.sha1":
		case "system.security.cryptography.sha1cryptoserviceprovider":
		case "sha1":
		case "system.security.cryptography.sha1cng":
		case "sha":
		case "http://www.w3.org/2000/09/xmldsig#sha1":
			return new SHA1CryptoServiceProvider();
		case "system.security.cryptography.sha1managed":
			return new SHA1Managed();
		case "system.security.cryptography.sha256managed":
		case "system.security.cryptography.sha256":
		case "system.security.cryptography.sha256cryptoserviceprovider":
		case "system.security.cryptography.sha256cng":
		case "sha256":
		case "sha-256":
		case "http://www.w3.org/2001/04/xmlenc#sha256":
			return new SHA256Managed();
		case "system.security.cryptography.sha384managed":
		case "system.security.cryptography.sha384":
		case "system.security.cryptography.sha384cryptoserviceprovider":
		case "system.security.cryptography.sha384cng":
		case "sha384":
		case "sha-384":
		case "http://www.w3.org/2001/04/xmldsig-more#sha384":
			return new SHA384Managed();
		case "system.security.cryptography.sha512managed":
		case "system.security.cryptography.sha512":
		case "system.security.cryptography.sha512cryptoserviceprovider":
		case "system.security.cryptography.sha512cng":
		case "sha512":
		case "sha-512":
		case "http://www.w3.org/2001/04/xmlenc#sha512":
			return new SHA512Managed();
		case "system.security.cryptography.tripledescryptoserviceprovider":
		case "system.security.cryptography.tripledes":
		case "triple des":
		case "tripledes":
		case "3des":
			return new TripleDESCryptoServiceProvider();
		case "x509chain":
			value = Type.GetType("System.Security.Cryptography.X509Certificates.X509Chain, System");
			break;
		case "2.5.29.15":
			value = Type.GetType("System.Security.Cryptography.X509Certificates.X509KeyUsageExtension, System");
			break;
		case "2.5.29.19":
			value = Type.GetType("System.Security.Cryptography.X509Certificates.X509BasicConstraintsExtension, System");
			break;
		case "2.5.29.14":
			value = Type.GetType("System.Security.Cryptography.X509Certificates.X509SubjectKeyIdentifierExtension, System");
			break;
		case "2.5.29.37":
			value = Type.GetType("System.Security.Cryptography.X509Certificates.X509EnhancedKeyUsageExtension, System");
			break;
		case "aes":
			value = Type.GetType("System.Security.Cryptography.AesCryptoServiceProvider, System.Core");
			break;
		}
		if (value == null)
		{
			lock (lockObject)
			{
				Dictionary<string, Type> dictionary = algorithms;
				if (dictionary != null && dictionary.TryGetValue(name, out value))
				{
					try
					{
						return Activator.CreateInstance(value, args);
					}
					catch
					{
					}
				}
			}
			value = Type.GetType(name);
		}
		try
		{
			return Activator.CreateInstance(value, args);
		}
		catch
		{
			return null;
		}
	}

	public static string MapNameToOID(string name)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		switch (name.ToLowerInvariant())
		{
		case "system.security.cryptography.sha1cryptoserviceprovider":
		case "system.security.cryptography.sha1cng":
		case "system.security.cryptography.sha1managed":
		case "system.security.cryptography.sha1":
		case "sha1":
			return "1.3.14.3.2.26";
		case "system.security.cryptography.md5cryptoserviceprovider":
		case "system.security.cryptography.md5":
		case "md5":
			return "1.2.840.113549.2.5";
		case "system.security.cryptography.sha256cryptoserviceprovider":
		case "system.security.cryptography.sha256cng":
		case "system.security.cryptography.sha256managed":
		case "system.security.cryptography.sha256":
		case "sha256":
			return "2.16.840.1.101.3.4.2.1";
		case "system.security.cryptography.sha384cryptoserviceprovider":
		case "system.security.cryptography.sha384cng":
		case "system.security.cryptography.sha384managed":
		case "system.security.cryptography.sha384":
		case "sha384":
			return "2.16.840.1.101.3.4.2.2";
		case "system.security.cryptography.sha512cryptoserviceprovider":
		case "system.security.cryptography.sha512cng":
		case "system.security.cryptography.sha512managed":
		case "system.security.cryptography.sha512":
		case "sha512":
			return "2.16.840.1.101.3.4.2.3";
		case "system.security.cryptography.ripemd160managed":
		case "system.security.cryptography.ripemd160":
		case "ripemd160":
			return "1.3.36.3.2.1";
		case "tripledeskeywrap":
			return "1.2.840.113549.1.9.16.3.6";
		case "des":
			return "1.3.14.3.2.7";
		case "tripledes":
			return "1.2.840.113549.3.7";
		case "rc2":
			return "1.2.840.113549.3.2";
		default:
			return null;
		}
	}

	public static byte[] EncodeOID(string str)
	{
		if (str == null)
		{
			throw new ArgumentNullException("str");
		}
		char[] separator = new char[1] { '.' };
		string[] array = str.Split(separator);
		if (array.Length < 2)
		{
			throw new CryptographicUnexpectedOperationException(Locale.GetText("OID must have at least two parts"));
		}
		byte[] array2 = new byte[str.Length];
		try
		{
			byte b = Convert.ToByte(array[0]);
			byte b2 = Convert.ToByte(array[1]);
			array2[2] = Convert.ToByte(b * 40 + b2);
		}
		catch
		{
			throw new CryptographicUnexpectedOperationException(Locale.GetText("Invalid OID"));
		}
		int num = 3;
		for (int i = 2; i < array.Length; i++)
		{
			long num2 = Convert.ToInt64(array[i]);
			if (num2 > 127)
			{
				byte[] array3 = EncodeLongNumber(num2);
				Buffer.BlockCopy(array3, 0, array2, num, array3.Length);
				num += array3.Length;
			}
			else
			{
				array2[num++] = Convert.ToByte(num2);
			}
		}
		int num3 = 2;
		byte[] array4 = new byte[num];
		array4[0] = 6;
		if (num > 127)
		{
			throw new CryptographicUnexpectedOperationException(Locale.GetText("OID > 127 bytes"));
		}
		array4[1] = Convert.ToByte(num - 2);
		Buffer.BlockCopy(array2, num3, array4, num3, num - num3);
		return array4;
	}

	private static byte[] EncodeLongNumber(long x)
	{
		if (x > int.MaxValue || x < int.MinValue)
		{
			throw new OverflowException(Locale.GetText("Part of OID doesn't fit in Int32"));
		}
		long num = x;
		int num2 = 1;
		while (num > 127)
		{
			num >>= 7;
			num2++;
		}
		byte[] array = new byte[num2];
		for (int i = 0; i < num2; i++)
		{
			num = x >> 7 * i;
			num &= 0x7F;
			if (i != 0)
			{
				num += 128;
			}
			array[num2 - i - 1] = Convert.ToByte(num);
		}
		return array;
	}
}
