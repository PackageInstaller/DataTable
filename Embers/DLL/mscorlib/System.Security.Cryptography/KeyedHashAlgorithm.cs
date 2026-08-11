using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public abstract class KeyedHashAlgorithm : HashAlgorithm
{
	protected byte[] KeyValue;

	public virtual byte[] Key
	{
		get
		{
			return (byte[])KeyValue.Clone();
		}
		set
		{
			if (State != 0)
			{
				throw new CryptographicException(Environment.GetResourceString("Hash key cannot be changed after the first write to the stream."));
			}
			KeyValue = (byte[])value.Clone();
		}
	}

	protected override void Dispose(bool disposing)
	{
		if (disposing)
		{
			if (KeyValue != null)
			{
				Array.Clear(KeyValue, 0, KeyValue.Length);
			}
			KeyValue = null;
		}
		base.Dispose(disposing);
	}

	public new static KeyedHashAlgorithm Create(string algName)
	{
		return (KeyedHashAlgorithm)CryptoConfig.CreateFromName(algName);
	}
}
