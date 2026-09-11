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
		0u, 1075970048u, 0u, 1073741824u, 0u, 1074266112u, 0u, 1072693248u, 0u, 1070596096u,
		0u, 1071644672u, 0u, 1072168960u, 0u, 1068498944u, 0u, 1069547520u, 0u, 1070071808u,
		0u, 1076887552u, 0u, 1076101120u, 0u, 1079574528u, 0u, 1083129856u, 0u, 0u,
		0u, 1072693248u, 0u, 1073741824u, 0u, 1074266112u, 2576980378u, 1064933785u, 2576980378u, 1067030937u,
		858993459u, 1067660083u, 2576980378u, 1068079513u, 2576980378u, 1069128089u, 858993459u, 1069757235u, 2576980378u, 1070176665u,
		0u, 1073217536u, 0u, 1074003968u, 0u, 1074528256u, 0u, 1074921472u, 0u, 1075183616u,
		0u, 1075445760u, 0u, 1075707904u
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
