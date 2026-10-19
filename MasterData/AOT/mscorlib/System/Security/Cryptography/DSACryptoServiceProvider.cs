using System.Runtime.InteropServices;
using Mono.Security.Cryptography;

namespace System.Security.Cryptography;

[ComVisible(true)]
public sealed class DSACryptoServiceProvider : DSA
{
	private KeyPairPersistence store;

	private bool persistKey;

	private bool persisted;

	private bool privateKeyExportable = true;

	private bool m_disposed;

	private DSAManaged dsa;

	private static bool useMachineKeyStore;

	public override int KeySize => dsa.KeySize;

	[ComVisible(false)]
	public bool PublicOnly => dsa.PublicOnly;

	public DSACryptoServiceProvider()
		: this(1024)
	{
	}

	public DSACryptoServiceProvider(int dwKeySize)
	{
		Common(dwKeySize, parameters: false);
	}

	private void Common(int dwKeySize, bool parameters)
	{
		LegalKeySizesValue = new KeySizes[1];
		LegalKeySizesValue[0] = new KeySizes(512, 1024, 64);
		KeySize = dwKeySize;
		dsa = new DSAManaged(dwKeySize);
		dsa.KeyGenerated += OnKeyGenerated;
		persistKey = parameters;
		if (!parameters)
		{
			CspParameters cspParameters = new CspParameters(13);
			if (useMachineKeyStore)
			{
				cspParameters.Flags |= CspProviderFlags.UseMachineKeyStore;
			}
			store = new KeyPairPersistence(cspParameters);
		}
	}

	~DSACryptoServiceProvider()
	{
		Dispose(disposing: false);
	}

	public override DSAParameters ExportParameters(bool includePrivateParameters)
	{
		if (includePrivateParameters && !privateKeyExportable)
		{
			throw new CryptographicException(Locale.GetText("Cannot export private key"));
		}
		return dsa.ExportParameters(includePrivateParameters);
	}

	public override void ImportParameters(DSAParameters parameters)
	{
		dsa.ImportParameters(parameters);
	}

	public override bool VerifySignature(byte[] rgbHash, byte[] rgbSignature)
	{
		return dsa.VerifySignature(rgbHash, rgbSignature);
	}

	protected override void Dispose(bool disposing)
	{
		if (!m_disposed)
		{
			if (persisted && !persistKey)
			{
				store.Remove();
			}
			if (dsa != null)
			{
				dsa.Clear();
			}
			m_disposed = true;
		}
	}

	private void OnKeyGenerated(object sender, EventArgs e)
	{
		if (persistKey && !persisted)
		{
			store.KeyValue = ToXmlString(!dsa.PublicOnly);
			store.Save();
			persisted = true;
		}
	}
}
