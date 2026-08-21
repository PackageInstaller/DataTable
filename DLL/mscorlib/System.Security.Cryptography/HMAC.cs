using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public abstract class HMAC : KeyedHashAlgorithm
{
	private int blockSizeValue = 64;

	internal string m_hashName;

	internal HashAlgorithm m_hash1;

	internal HashAlgorithm m_hash2;

	private byte[] m_inner;

	private byte[] m_outer;

	private bool m_hashing;

	protected int BlockSizeValue
	{
		get
		{
			return blockSizeValue;
		}
		set
		{
			blockSizeValue = value;
		}
	}

	public override byte[] Key
	{
		get
		{
			return (byte[])KeyValue.Clone();
		}
		set
		{
			if (m_hashing)
			{
				throw new CryptographicException(Environment.GetResourceString("Hash key cannot be changed after the first write to the stream."));
			}
			InitializeKey(value);
		}
	}

	private void UpdateIOPadBuffers()
	{
		if (m_inner == null)
		{
			m_inner = new byte[BlockSizeValue];
		}
		if (m_outer == null)
		{
			m_outer = new byte[BlockSizeValue];
		}
		for (int i = 0; i < BlockSizeValue; i++)
		{
			m_inner[i] = 54;
			m_outer[i] = 92;
		}
		for (int i = 0; i < KeyValue.Length; i++)
		{
			m_inner[i] ^= KeyValue[i];
			m_outer[i] ^= KeyValue[i];
		}
	}

	internal void InitializeKey(byte[] key)
	{
		m_inner = null;
		m_outer = null;
		if (key.Length > BlockSizeValue)
		{
			KeyValue = m_hash1.ComputeHash(key);
		}
		else
		{
			KeyValue = (byte[])key.Clone();
		}
		UpdateIOPadBuffers();
	}

	public new static HMAC Create()
	{
		return new HMACSHA1();
	}

	public override void Initialize()
	{
		m_hash1.Initialize();
		m_hash2.Initialize();
		m_hashing = false;
	}

	protected override void HashCore(byte[] rgb, int ib, int cb)
	{
		if (!m_hashing)
		{
			m_hash1.TransformBlock(m_inner, 0, m_inner.Length, m_inner, 0);
			m_hashing = true;
		}
		m_hash1.TransformBlock(rgb, ib, cb, rgb, ib);
	}

	protected override byte[] HashFinal()
	{
		if (!m_hashing)
		{
			m_hash1.TransformBlock(m_inner, 0, m_inner.Length, m_inner, 0);
			m_hashing = true;
		}
		m_hash1.TransformFinalBlock(EmptyArray<byte>.Value, 0, 0);
		byte[] hashValue = m_hash1.HashValue;
		m_hash2.TransformBlock(m_outer, 0, m_outer.Length, m_outer, 0);
		m_hash2.TransformBlock(hashValue, 0, hashValue.Length, hashValue, 0);
		m_hashing = false;
		m_hash2.TransformFinalBlock(EmptyArray<byte>.Value, 0, 0);
		return m_hash2.HashValue;
	}

	protected override void Dispose(bool disposing)
	{
		if (disposing)
		{
			if (m_hash1 != null)
			{
				((IDisposable)m_hash1).Dispose();
			}
			if (m_hash2 != null)
			{
				((IDisposable)m_hash2).Dispose();
			}
			if (m_inner != null)
			{
				Array.Clear(m_inner, 0, m_inner.Length);
			}
			if (m_outer != null)
			{
				Array.Clear(m_outer, 0, m_outer.Length);
			}
		}
		base.Dispose(disposing);
	}
}
