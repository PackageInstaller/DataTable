using System.Runtime.InteropServices;
using Mono.Security.Cryptography;

namespace System.Security.Cryptography;

[ComVisible(true)]
public sealed class RSACryptoServiceProvider : RSA
{
	private static volatile CspProviderFlags s_UseMachineKeyStore;

	private KeyPairPersistence store;

	private bool persistKey;

	private bool persisted;

	private bool privateKeyExportable = true;

	private bool m_disposed;

	private RSAManaged rsa;

	public static bool UseMachineKeyStore => s_UseMachineKeyStore == CspProviderFlags.UseMachineKeyStore;

	public override int KeySize
	{
		get
		{
			if (rsa == null)
			{
				return KeySizeValue;
			}
			return rsa.KeySize;
		}
	}

	[ComVisible(false)]
	public bool PublicOnly => rsa.PublicOnly;

	public override byte[] Encrypt(byte[] data, RSAEncryptionPadding padding)
	{
		if (data == null)
		{
			throw new ArgumentNullException("data");
		}
		if (padding == null)
		{
			throw new ArgumentNullException("padding");
		}
		if (padding == RSAEncryptionPadding.Pkcs1)
		{
			return Encrypt(data, fOAEP: false);
		}
		if (padding == RSAEncryptionPadding.OaepSHA1)
		{
			return Encrypt(data, fOAEP: true);
		}
		throw PaddingModeNotSupported();
	}

	public override byte[] Decrypt(byte[] data, RSAEncryptionPadding padding)
	{
		if (data == null)
		{
			throw new ArgumentNullException("data");
		}
		if (padding == null)
		{
			throw new ArgumentNullException("padding");
		}
		if (padding == RSAEncryptionPadding.Pkcs1)
		{
			return Decrypt(data, fOAEP: false);
		}
		if (padding == RSAEncryptionPadding.OaepSHA1)
		{
			return Decrypt(data, fOAEP: true);
		}
		throw PaddingModeNotSupported();
	}

	private static Exception PaddingModeNotSupported()
	{
		return new CryptographicException(Environment.GetResourceString("Specified padding mode is not valid for this algorithm."));
	}

	public RSACryptoServiceProvider()
		: this(1024)
	{
	}

	public RSACryptoServiceProvider(CspParameters parameters)
		: this(1024, parameters)
	{
	}

	public RSACryptoServiceProvider(int dwKeySize)
	{
		Common(dwKeySize, parameters: false);
	}

	public RSACryptoServiceProvider(int dwKeySize, CspParameters parameters)
	{
		bool flag = parameters != null;
		Common(dwKeySize, flag);
		if (flag)
		{
			Common(parameters);
		}
	}

	private void Common(int dwKeySize, bool parameters)
	{
		LegalKeySizesValue = new KeySizes[1];
		LegalKeySizesValue[0] = new KeySizes(384, 16384, 8);
		base.KeySize = dwKeySize;
		rsa = new RSAManaged(KeySize);
		rsa.KeyGenerated += OnKeyGenerated;
		persistKey = parameters;
		if (!parameters)
		{
			CspParameters cspParameters = new CspParameters(1);
			if (UseMachineKeyStore)
			{
				cspParameters.Flags |= CspProviderFlags.UseMachineKeyStore;
			}
			store = new KeyPairPersistence(cspParameters);
		}
	}

	private void Common(CspParameters p)
	{
		store = new KeyPairPersistence(p);
		bool flag = store.Load();
		bool num = (p.Flags & CspProviderFlags.UseExistingKey) != 0;
		privateKeyExportable = (p.Flags & CspProviderFlags.UseNonExportableKey) == 0;
		if (num && !flag)
		{
			throw new CryptographicException("Keyset does not exist");
		}
		if (store.KeyValue != null)
		{
			persisted = true;
			FromXmlString(store.KeyValue);
		}
	}

	~RSACryptoServiceProvider()
	{
		Dispose(disposing: false);
	}

	public byte[] Decrypt(byte[] rgb, bool fOAEP)
	{
		if (rgb == null)
		{
			throw new ArgumentNullException("rgb");
		}
		if (rgb.Length > KeySize / 8)
		{
			throw new CryptographicException(Environment.GetResourceString("The data to be decrypted exceeds the maximum for this modulus of {0} bytes.", KeySize / 8));
		}
		if (m_disposed)
		{
			throw new ObjectDisposedException("rsa");
		}
		AsymmetricKeyExchangeDeformatter asymmetricKeyExchangeDeformatter = null;
		asymmetricKeyExchangeDeformatter = ((!fOAEP) ? ((AsymmetricKeyExchangeDeformatter)new RSAPKCS1KeyExchangeDeformatter(rsa)) : ((AsymmetricKeyExchangeDeformatter)new RSAOAEPKeyExchangeDeformatter(rsa)));
		return asymmetricKeyExchangeDeformatter.DecryptKeyExchange(rgb);
	}

	public override byte[] DecryptValue(byte[] rgb)
	{
		if (!rsa.IsCrtPossible)
		{
			throw new CryptographicException("Incomplete private key - missing CRT.");
		}
		return rsa.DecryptValue(rgb);
	}

	public byte[] Encrypt(byte[] rgb, bool fOAEP)
	{
		AsymmetricKeyExchangeFormatter asymmetricKeyExchangeFormatter = null;
		asymmetricKeyExchangeFormatter = ((!fOAEP) ? ((AsymmetricKeyExchangeFormatter)new RSAPKCS1KeyExchangeFormatter(rsa)) : ((AsymmetricKeyExchangeFormatter)new RSAOAEPKeyExchangeFormatter(rsa)));
		return asymmetricKeyExchangeFormatter.CreateKeyExchange(rgb);
	}

	public override byte[] EncryptValue(byte[] rgb)
	{
		return rsa.EncryptValue(rgb);
	}

	public override RSAParameters ExportParameters(bool includePrivateParameters)
	{
		if (includePrivateParameters && !privateKeyExportable)
		{
			throw new CryptographicException("cannot export private key");
		}
		RSAParameters result = rsa.ExportParameters(includePrivateParameters);
		if (includePrivateParameters)
		{
			if (result.D == null)
			{
				throw new ArgumentNullException("Missing D parameter for the private key.");
			}
			if (result.P == null || result.Q == null || result.DP == null || result.DQ == null || result.InverseQ == null)
			{
				throw new CryptographicException("Missing some CRT parameters for the private key.");
			}
		}
		return result;
	}

	public override void ImportParameters(RSAParameters parameters)
	{
		rsa.ImportParameters(parameters);
	}

	private string GetHashNameFromOID(string oid)
	{
		return oid switch
		{
			"1.3.14.3.2.26" => "SHA1", 
			"1.2.840.113549.2.5" => "MD5", 
			"2.16.840.1.101.3.4.2.1" => "SHA256", 
			"2.16.840.1.101.3.4.2.2" => "SHA384", 
			"2.16.840.1.101.3.4.2.3" => "SHA512", 
			_ => throw new CryptographicException(oid + " is an unsupported hash algorithm for RSA signing"), 
		};
	}

	public bool VerifyHash(byte[] rgbHash, string str, byte[] rgbSignature)
	{
		if (rgbHash == null)
		{
			throw new ArgumentNullException("rgbHash");
		}
		if (rgbSignature == null)
		{
			throw new ArgumentNullException("rgbSignature");
		}
		HashAlgorithm hash = HashAlgorithm.Create((str == null) ? "SHA1" : GetHashNameFromOID(str));
		return PKCS1.Verify_v15(this, hash, rgbHash, rgbSignature);
	}

	protected override void Dispose(bool disposing)
	{
		if (!m_disposed)
		{
			if (persisted && !persistKey)
			{
				store.Remove();
			}
			if (rsa != null)
			{
				rsa.Clear();
			}
			m_disposed = true;
		}
	}

	private void OnKeyGenerated(object sender, EventArgs e)
	{
		if (persistKey && !persisted)
		{
			store.KeyValue = ToXmlString(!rsa.PublicOnly);
			store.Save();
			persisted = true;
		}
	}
}
