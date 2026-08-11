using System;
using System.Security.Cryptography;
using Mono.Math;

namespace Mono.Security.Cryptography;

internal class DSAManaged : DSA
{
	public delegate void KeyGeneratedEventHandler(object sender, EventArgs e);

	private bool keypairGenerated;

	private bool m_disposed;

	private BigInteger p;

	private BigInteger q;

	private BigInteger g;

	private BigInteger x;

	private BigInteger y;

	private BigInteger j;

	private BigInteger seed;

	private int counter;

	private bool j_missing;

	private RandomNumberGenerator rng;

	private RandomNumberGenerator Random
	{
		get
		{
			if (rng == null)
			{
				rng = RandomNumberGenerator.Create();
			}
			return rng;
		}
	}

	public override int KeySize
	{
		get
		{
			if (keypairGenerated)
			{
				return p.BitCount();
			}
			return base.KeySize;
		}
	}

	public bool PublicOnly
	{
		get
		{
			if (keypairGenerated)
			{
				return x == null;
			}
			return false;
		}
	}

	public event KeyGeneratedEventHandler KeyGenerated;

	public DSAManaged(int dwKeySize)
	{
		KeySizeValue = dwKeySize;
		LegalKeySizesValue = new KeySizes[1];
		LegalKeySizesValue[0] = new KeySizes(512, 1024, 64);
	}

	~DSAManaged()
	{
		Dispose(disposing: false);
	}

	private void Generate()
	{
		GenerateParams(base.KeySize);
		GenerateKeyPair();
		keypairGenerated = true;
		if (KeyGenerated != null)
		{
			KeyGenerated(this, null);
		}
	}

	private void GenerateKeyPair()
	{
		x = BigInteger.GenerateRandom(160);
		while (x == 0u || x >= q)
		{
			x.Randomize();
		}
		y = g.ModPow(x, p);
	}

	private void add(byte[] a, byte[] b, int value)
	{
		uint num = (uint)((b[b.Length - 1] & 0xFF) + value);
		a[b.Length - 1] = (byte)num;
		num >>= 8;
		for (int num2 = b.Length - 2; num2 >= 0; num2--)
		{
			num += (uint)(b[num2] & 0xFF);
			a[num2] = (byte)num;
			num >>= 8;
		}
	}

	private void GenerateParams(int keyLength)
	{
		byte[] array = new byte[20];
		byte[] array2 = new byte[20];
		byte[] array3 = new byte[20];
		byte[] array4 = new byte[20];
		SHA1 sHA = SHA1.Create();
		int num = (keyLength - 1) / 160;
		byte[] array5 = new byte[keyLength / 8];
		bool flag = false;
		while (!flag)
		{
			do
			{
				Random.GetBytes(array);
				array2 = sHA.ComputeHash(array);
				Array.Copy(array, 0, array3, 0, array.Length);
				add(array3, array, 1);
				array3 = sHA.ComputeHash(array3);
				for (int i = 0; i != array4.Length; i++)
				{
					array4[i] = (byte)(array2[i] ^ array3[i]);
				}
				array4[0] |= 128;
				array4[19] |= 1;
				q = new BigInteger(array4);
			}
			while (!q.IsProbablePrime());
			counter = 0;
			int num2 = 2;
			while (counter < 4096)
			{
				for (int j = 0; j < num; j++)
				{
					add(array2, array, num2 + j);
					array2 = sHA.ComputeHash(array2);
					Array.Copy(array2, 0, array5, array5.Length - (j + 1) * array2.Length, array2.Length);
				}
				add(array2, array, num2 + num);
				array2 = sHA.ComputeHash(array2);
				Array.Copy(array2, array2.Length - (array5.Length - num * array2.Length), array5, 0, array5.Length - num * array2.Length);
				array5[0] |= 128;
				BigInteger bigInteger = new BigInteger(array5);
				BigInteger bigInteger2 = bigInteger % (q * 2);
				p = bigInteger - (bigInteger2 - 1);
				if (p.TestBit((uint)(keyLength - 1)) && p.IsProbablePrime())
				{
					flag = true;
					break;
				}
				counter++;
				num2 += num + 1;
			}
		}
		BigInteger exp = (p - 1) / q;
		while (true)
		{
			BigInteger bigInteger3 = BigInteger.GenerateRandom(keyLength);
			if (!(bigInteger3 <= 1) && !(bigInteger3 >= p - 1))
			{
				g = bigInteger3.ModPow(exp, p);
				if (!(g <= 1))
				{
					break;
				}
			}
		}
		seed = new BigInteger(array);
		this.j = (p - 1) / q;
	}

	private byte[] NormalizeArray(byte[] array)
	{
		int num = array.Length % 4;
		if (num > 0)
		{
			byte[] array2 = new byte[array.Length + 4 - num];
			Array.Copy(array, 0, array2, 4 - num, array.Length);
			return array2;
		}
		return array;
	}

	public override DSAParameters ExportParameters(bool includePrivateParameters)
	{
		if (m_disposed)
		{
			throw new ObjectDisposedException(Locale.GetText("Keypair was disposed"));
		}
		if (!keypairGenerated)
		{
			Generate();
		}
		if (includePrivateParameters && x == null)
		{
			throw new CryptographicException("no private key to export");
		}
		DSAParameters result = new DSAParameters
		{
			P = NormalizeArray(p.GetBytes()),
			Q = NormalizeArray(q.GetBytes()),
			G = NormalizeArray(g.GetBytes()),
			Y = NormalizeArray(y.GetBytes())
		};
		if (!j_missing)
		{
			result.J = NormalizeArray(j.GetBytes());
		}
		if (seed != 0u)
		{
			result.Seed = NormalizeArray(seed.GetBytes());
			result.Counter = counter;
		}
		if (includePrivateParameters)
		{
			byte[] bytes = x.GetBytes();
			if (bytes.Length == 20)
			{
				result.X = NormalizeArray(bytes);
			}
		}
		return result;
	}

	public override void ImportParameters(DSAParameters parameters)
	{
		if (m_disposed)
		{
			throw new ObjectDisposedException(Locale.GetText("Keypair was disposed"));
		}
		if (parameters.P == null || parameters.Q == null || parameters.G == null)
		{
			throw new CryptographicException(Locale.GetText("Missing mandatory DSA parameters (P, Q or G)."));
		}
		if (parameters.X == null && parameters.Y == null)
		{
			throw new CryptographicException(Locale.GetText("Missing both public (Y) and private (X) keys."));
		}
		p = new BigInteger(parameters.P);
		q = new BigInteger(parameters.Q);
		g = new BigInteger(parameters.G);
		if (parameters.X != null)
		{
			x = new BigInteger(parameters.X);
		}
		else
		{
			x = null;
		}
		if (parameters.Y != null)
		{
			y = new BigInteger(parameters.Y);
		}
		else
		{
			y = g.ModPow(x, p);
		}
		if (parameters.J != null)
		{
			j = new BigInteger(parameters.J);
		}
		else
		{
			j = (p - 1) / q;
			j_missing = true;
		}
		if (parameters.Seed != null)
		{
			seed = new BigInteger(parameters.Seed);
			counter = parameters.Counter;
		}
		else
		{
			seed = 0;
		}
		keypairGenerated = true;
	}

	public override bool VerifySignature(byte[] rgbHash, byte[] rgbSignature)
	{
		if (m_disposed)
		{
			throw new ObjectDisposedException(Locale.GetText("Keypair was disposed"));
		}
		if (rgbHash == null)
		{
			throw new ArgumentNullException("rgbHash");
		}
		if (rgbSignature == null)
		{
			throw new ArgumentNullException("rgbSignature");
		}
		if (rgbHash.Length != 20)
		{
			throw new CryptographicException("invalid hash length");
		}
		if (rgbSignature.Length != 40)
		{
			throw new CryptographicException("invalid signature length");
		}
		if (!keypairGenerated)
		{
			return false;
		}
		try
		{
			BigInteger bigInteger = new BigInteger(rgbHash);
			byte[] array = new byte[20];
			Array.Copy(rgbSignature, 0, array, 0, 20);
			BigInteger bigInteger2 = new BigInteger(array);
			Array.Copy(rgbSignature, 20, array, 0, 20);
			BigInteger bigInteger3 = new BigInteger(array);
			if (bigInteger2 < 0 || q <= bigInteger2)
			{
				return false;
			}
			if (bigInteger3 < 0 || q <= bigInteger3)
			{
				return false;
			}
			BigInteger bigInteger4 = bigInteger3.ModInverse(q);
			BigInteger exp = bigInteger * bigInteger4 % q;
			BigInteger exp2 = bigInteger2 * bigInteger4 % q;
			exp = g.ModPow(exp, p);
			exp2 = y.ModPow(exp2, p);
			return exp * exp2 % p % q == bigInteger2;
		}
		catch
		{
			throw new CryptographicException("couldn't compute signature verification");
		}
	}

	protected override void Dispose(bool disposing)
	{
		if (!m_disposed)
		{
			if (x != null)
			{
				x.Clear();
				x = null;
			}
			if (disposing)
			{
				if (p != null)
				{
					p.Clear();
					p = null;
				}
				if (q != null)
				{
					q.Clear();
					q = null;
				}
				if (g != null)
				{
					g.Clear();
					g = null;
				}
				if (j != null)
				{
					j.Clear();
					j = null;
				}
				if (seed != null)
				{
					seed.Clear();
					seed = null;
				}
				if (y != null)
				{
					y.Clear();
					y = null;
				}
			}
		}
		m_disposed = true;
	}
}
