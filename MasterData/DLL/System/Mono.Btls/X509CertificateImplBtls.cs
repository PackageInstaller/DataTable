using System;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using Microsoft.Win32.SafeHandles;
using Mono.Security.Authenticode;
using Mono.Security.Cryptography;

namespace Mono.Btls;

internal class X509CertificateImplBtls : X509Certificate2ImplUnix
{
	private MonoBtlsX509 x509;

	private MonoBtlsKey nativePrivateKey;

	private X509CertificateImplCollection intermediateCerts;

	public override bool IsValid
	{
		get
		{
			if (x509 != null)
			{
				return x509.IsValid;
			}
			return false;
		}
	}

	internal MonoBtlsX509 X509
	{
		get
		{
			ThrowIfContextInvalid();
			return x509;
		}
	}

	internal MonoBtlsKey NativePrivateKey
	{
		get
		{
			ThrowIfContextInvalid();
			return nativePrivateKey;
		}
	}

	internal override X509CertificateImplCollection IntermediateCertificates => intermediateCerts;

	public override bool HasPrivateKey => nativePrivateKey != null;

	public override AsymmetricAlgorithm PrivateKey
	{
		get
		{
			if (nativePrivateKey == null)
			{
				return null;
			}
			return PKCS8.PrivateKeyInfo.DecodeRSA(nativePrivateKey.GetBytes(include_private_bits: true));
		}
		set
		{
			if (nativePrivateKey != null)
			{
				nativePrivateKey.Dispose();
			}
			try
			{
				if (value != null)
				{
					nativePrivateKey = MonoBtlsKey.CreateFromRSAPrivateKey((RSA)value);
				}
			}
			catch
			{
				nativePrivateKey = null;
			}
		}
	}

	internal X509CertificateImplBtls(MonoBtlsX509 x509)
	{
		this.x509 = x509.Copy();
	}

	private X509CertificateImplBtls(X509CertificateImplBtls other)
	{
		x509 = ((other.x509 != null) ? other.x509.Copy() : null);
		nativePrivateKey = ((other.nativePrivateKey != null) ? other.nativePrivateKey.Copy() : null);
		if (other.intermediateCerts != null)
		{
			intermediateCerts = other.intermediateCerts.Clone();
		}
	}

	internal X509CertificateImplBtls(byte[] data, MonoBtlsX509Format format)
	{
		x509 = MonoBtlsX509.LoadFromData(data, format);
	}

	internal X509CertificateImplBtls(byte[] data, SafePasswordHandle password, X509KeyStorageFlags keyStorageFlags)
	{
		if (password == null || password.IsInvalid)
		{
			try
			{
				Import(data);
				return;
			}
			catch (Exception inner)
			{
				try
				{
					ImportPkcs12(data, null);
					return;
				}
				catch
				{
					try
					{
						ImportAuthenticode(data);
						return;
					}
					catch
					{
						throw new CryptographicException(Locale.GetText("Unable to decode certificate."), inner);
					}
				}
			}
		}
		try
		{
			ImportPkcs12(data, password);
		}
		catch (Exception inner2)
		{
			try
			{
				Import(data);
			}
			catch
			{
				try
				{
					ImportAuthenticode(data);
				}
				catch
				{
					throw new CryptographicException(Locale.GetText("Unable to decode certificate."), inner2);
				}
			}
		}
	}

	public override X509CertificateImpl Clone()
	{
		ThrowIfContextInvalid();
		return new X509CertificateImplBtls(this);
	}

	protected override byte[] GetRawCertData()
	{
		ThrowIfContextInvalid();
		return X509.GetRawData(MonoBtlsX509Format.DER);
	}

	protected override void Dispose(bool disposing)
	{
		if (x509 != null)
		{
			x509.Dispose();
			x509 = null;
		}
	}

	public override RSA GetRSAPrivateKey()
	{
		if (nativePrivateKey == null)
		{
			return null;
		}
		return PKCS8.PrivateKeyInfo.DecodeRSA(nativePrivateKey.GetBytes(include_private_bits: true));
	}

	public override DSA GetDSAPrivateKey()
	{
		throw new PlatformNotSupportedException();
	}

	private void Import(byte[] data)
	{
		if (data != null)
		{
			if (data.Length != 0 && data[0] != 48)
			{
				x509 = MonoBtlsX509.LoadFromData(data, MonoBtlsX509Format.PEM);
			}
			else
			{
				x509 = MonoBtlsX509.LoadFromData(data, MonoBtlsX509Format.DER);
			}
		}
	}

	private void ImportPkcs12(byte[] data, SafePasswordHandle password)
	{
		using MonoBtlsPkcs12 monoBtlsPkcs = new MonoBtlsPkcs12();
		if (password == null || password.IsInvalid)
		{
			try
			{
				monoBtlsPkcs.Import(data, null);
			}
			catch
			{
				using SafePasswordHandle password2 = new SafePasswordHandle(string.Empty);
				monoBtlsPkcs.Import(data, password2);
			}
		}
		else
		{
			monoBtlsPkcs.Import(data, password);
		}
		x509 = monoBtlsPkcs.GetCertificate(0);
		if (monoBtlsPkcs.HasPrivateKey)
		{
			nativePrivateKey = monoBtlsPkcs.GetPrivateKey();
		}
		if (monoBtlsPkcs.Count <= 1)
		{
			return;
		}
		intermediateCerts = new X509CertificateImplCollection();
		for (int i = 0; i < monoBtlsPkcs.Count; i++)
		{
			using MonoBtlsX509 a = monoBtlsPkcs.GetCertificate(i);
			if (MonoBtlsX509.Compare(a, x509) != 0)
			{
				X509CertificateImplBtls impl = new X509CertificateImplBtls(a);
				intermediateCerts.Add(impl, takeOwnership: true);
			}
		}
	}

	private void ImportAuthenticode(byte[] data)
	{
		if (data != null)
		{
			AuthenticodeDeformatter authenticodeDeformatter = new AuthenticodeDeformatter(data);
			Import(authenticodeDeformatter.SigningCertificate.RawData);
		}
	}

	public override bool Verify(X509Certificate2 thisCertificate)
	{
		using MonoBtlsX509Chain monoBtlsX509Chain = new MonoBtlsX509Chain();
		monoBtlsX509Chain.AddCertificate(x509.Copy());
		if (intermediateCerts != null)
		{
			for (int i = 0; i < intermediateCerts.Count; i++)
			{
				X509CertificateImplBtls x509CertificateImplBtls = (X509CertificateImplBtls)intermediateCerts[i];
				monoBtlsX509Chain.AddCertificate(x509CertificateImplBtls.x509.Copy());
			}
		}
		return MonoBtlsProvider.ValidateCertificate(monoBtlsX509Chain, null);
	}
}
