using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public class SHA256Managed : SHA256
{
	private byte[] _buffer;

	private long _count;

	private uint[] _stateSHA256;

	private uint[] _W;

	private static readonly uint[] _K = new uint[64]
	{
		1116352408u, 1899447441u, 3049323471u, 3921009573u, 961987163u, 1508970993u, 2453635748u, 2870763221u, 3624381080u, 310598401u,
		607225278u, 1426881987u, 1925078388u, 2162078206u, 2614888103u, 3248222580u, 3835390401u, 4022224774u, 264347078u, 604807628u,
		770255983u, 1249150122u, 1555081692u, 1996064986u, 2554220882u, 2821834349u, 2952996808u, 3210313671u, 3336571891u, 3584528711u,
		113926993u, 338241895u, 666307205u, 773529912u, 1294757372u, 1396182291u, 1695183700u, 1986661051u, 2177026350u, 2456956037u,
		2730485921u, 2820302411u, 3259730800u, 3345764771u, 3516065817u, 3600352804u, 4094571909u, 275423344u, 430227734u, 506948616u,
		659060556u, 883997877u, 958139571u, 1322822218u, 1537002063u, 1747873779u, 1955562222u, 2024104815u, 2227730452u, 2361852424u,
		2428436474u, 2756734187u, 3204031479u, 3329325298u
	};

	public SHA256Managed()
	{
		if (CryptoConfig.AllowOnlyFipsAlgorithms)
		{
			throw new InvalidOperationException(Environment.GetResourceString("This implementation is not part of the Windows Platform FIPS validated cryptographic algorithms."));
		}
		_stateSHA256 = new uint[8];
		_buffer = new byte[64];
		_W = new uint[64];
		InitializeState();
	}

	public override void Initialize()
	{
		InitializeState();
		Array.Clear(_buffer, 0, _buffer.Length);
		Array.Clear(_W, 0, _W.Length);
	}

	protected override void HashCore(byte[] rgb, int ibStart, int cbSize)
	{
		_HashData(rgb, ibStart, cbSize);
	}

	protected override byte[] HashFinal()
	{
		return _EndHash();
	}

	private void InitializeState()
	{
		_count = 0L;
		_stateSHA256[0] = 1779033703u;
		_stateSHA256[1] = 3144134277u;
		_stateSHA256[2] = 1013904242u;
		_stateSHA256[3] = 2773480762u;
		_stateSHA256[4] = 1359893119u;
		_stateSHA256[5] = 2600822924u;
		_stateSHA256[6] = 528734635u;
		_stateSHA256[7] = 1541459225u;
	}

	private unsafe void _HashData(byte[] partIn, int ibStart, int cbSize)
	{
		int num = cbSize;
		int num2 = ibStart;
		int num3 = (int)(_count & 0x3F);
		_count += num;
		fixed (uint* stateSHA = _stateSHA256)
		{
			fixed (byte* buffer = _buffer)
			{
				fixed (uint* w = _W)
				{
					if (num3 > 0 && num3 + num >= 64)
					{
						Buffer.InternalBlockCopy(partIn, num2, _buffer, num3, 64 - num3);
						num2 += 64 - num3;
						num -= 64 - num3;
						SHATransform(w, stateSHA, buffer);
						num3 = 0;
					}
					while (num >= 64)
					{
						Buffer.InternalBlockCopy(partIn, num2, _buffer, 0, 64);
						num2 += 64;
						num -= 64;
						SHATransform(w, stateSHA, buffer);
					}
					if (num > 0)
					{
						Buffer.InternalBlockCopy(partIn, num2, _buffer, num3, num);
					}
				}
			}
		}
	}

	private byte[] _EndHash()
	{
		byte[] array = new byte[32];
		int num = 64 - (int)(_count & 0x3F);
		if (num <= 8)
		{
			num += 64;
		}
		byte[] array2 = new byte[num];
		array2[0] = 128;
		long num2 = _count * 8;
		array2[num - 8] = (byte)((num2 >> 56) & 0xFF);
		array2[num - 7] = (byte)((num2 >> 48) & 0xFF);
		array2[num - 6] = (byte)((num2 >> 40) & 0xFF);
		array2[num - 5] = (byte)((num2 >> 32) & 0xFF);
		array2[num - 4] = (byte)((num2 >> 24) & 0xFF);
		array2[num - 3] = (byte)((num2 >> 16) & 0xFF);
		array2[num - 2] = (byte)((num2 >> 8) & 0xFF);
		array2[num - 1] = (byte)(num2 & 0xFF);
		_HashData(array2, 0, array2.Length);
		Utils.DWORDToBigEndian(array, _stateSHA256, 8);
		HashValue = array;
		return array;
	}

	private unsafe static void SHATransform(uint* expandedBuffer, uint* state, byte* block)
	{
		uint num = *state;
		uint num2 = state[1];
		uint num3 = state[2];
		uint num4 = state[3];
		uint num5 = state[4];
		uint num6 = state[5];
		uint num7 = state[6];
		uint num8 = state[7];
		Utils.DWORDFromBigEndian(expandedBuffer, 16, block);
		SHA256Expand(expandedBuffer);
		int num9;
		for (num9 = 0; num9 < 64; num9++)
		{
			uint num10 = num8 + Sigma_1(num5) + Ch(num5, num6, num7) + _K[num9] + expandedBuffer[num9];
			uint num11 = num4 + num10;
			uint num12 = num10 + Sigma_0(num) + Maj(num, num2, num3);
			num9++;
			num10 = num7 + Sigma_1(num11) + Ch(num11, num5, num6) + _K[num9] + expandedBuffer[num9];
			uint num13 = num3 + num10;
			uint num14 = num10 + Sigma_0(num12) + Maj(num12, num, num2);
			num9++;
			num10 = num6 + Sigma_1(num13) + Ch(num13, num11, num5) + _K[num9] + expandedBuffer[num9];
			uint num15 = num2 + num10;
			uint num16 = num10 + Sigma_0(num14) + Maj(num14, num12, num);
			num9++;
			num10 = num5 + Sigma_1(num15) + Ch(num15, num13, num11) + _K[num9] + expandedBuffer[num9];
			uint num17 = num + num10;
			uint num18 = num10 + Sigma_0(num16) + Maj(num16, num14, num12);
			num9++;
			num10 = num11 + Sigma_1(num17) + Ch(num17, num15, num13) + _K[num9] + expandedBuffer[num9];
			num8 = num12 + num10;
			num4 = num10 + Sigma_0(num18) + Maj(num18, num16, num14);
			num9++;
			num10 = num13 + Sigma_1(num8) + Ch(num8, num17, num15) + _K[num9] + expandedBuffer[num9];
			num7 = num14 + num10;
			num3 = num10 + Sigma_0(num4) + Maj(num4, num18, num16);
			num9++;
			num10 = num15 + Sigma_1(num7) + Ch(num7, num8, num17) + _K[num9] + expandedBuffer[num9];
			num6 = num16 + num10;
			num2 = num10 + Sigma_0(num3) + Maj(num3, num4, num18);
			num9++;
			num10 = num17 + Sigma_1(num6) + Ch(num6, num7, num8) + _K[num9] + expandedBuffer[num9];
			num5 = num18 + num10;
			num = num10 + Sigma_0(num2) + Maj(num2, num3, num4);
		}
		*state += num;
		state[1] += num2;
		state[2] += num3;
		state[3] += num4;
		state[4] += num5;
		state[5] += num6;
		state[6] += num7;
		state[7] += num8;
	}

	private static uint RotateRight(uint x, int n)
	{
		return (x >> n) | (x << 32 - n);
	}

	private static uint Ch(uint x, uint y, uint z)
	{
		return (x & y) ^ ((x ^ 0xFFFFFFFFu) & z);
	}

	private static uint Maj(uint x, uint y, uint z)
	{
		return (x & y) ^ (x & z) ^ (y & z);
	}

	private static uint sigma_0(uint x)
	{
		return RotateRight(x, 7) ^ RotateRight(x, 18) ^ (x >> 3);
	}

	private static uint sigma_1(uint x)
	{
		return RotateRight(x, 17) ^ RotateRight(x, 19) ^ (x >> 10);
	}

	private static uint Sigma_0(uint x)
	{
		return RotateRight(x, 2) ^ RotateRight(x, 13) ^ RotateRight(x, 22);
	}

	private static uint Sigma_1(uint x)
	{
		return RotateRight(x, 6) ^ RotateRight(x, 11) ^ RotateRight(x, 25);
	}

	private unsafe static void SHA256Expand(uint* x)
	{
		for (int i = 16; i < 64; i++)
		{
			x[i] = sigma_1(x[i - 2]) + x[i - 7] + sigma_0(x[i - 15]) + x[i - 16];
		}
	}
}
