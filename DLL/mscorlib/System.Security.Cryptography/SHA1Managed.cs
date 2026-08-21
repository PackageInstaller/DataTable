using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public class SHA1Managed : SHA1
{
	private byte[] _buffer;

	private long _count;

	private uint[] _stateSHA1;

	private uint[] _expandedBuffer;

	public SHA1Managed()
	{
		if (CryptoConfig.AllowOnlyFipsAlgorithms)
		{
			throw new InvalidOperationException(Environment.GetResourceString("This implementation is not part of the Windows Platform FIPS validated cryptographic algorithms."));
		}
		_stateSHA1 = new uint[5];
		_buffer = new byte[64];
		_expandedBuffer = new uint[80];
		InitializeState();
	}

	public override void Initialize()
	{
		InitializeState();
		Array.Clear(_buffer, 0, _buffer.Length);
		Array.Clear(_expandedBuffer, 0, _expandedBuffer.Length);
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
		_stateSHA1[0] = 1732584193u;
		_stateSHA1[1] = 4023233417u;
		_stateSHA1[2] = 2562383102u;
		_stateSHA1[3] = 271733878u;
		_stateSHA1[4] = 3285377520u;
	}

	private unsafe void _HashData(byte[] partIn, int ibStart, int cbSize)
	{
		int num = cbSize;
		int num2 = ibStart;
		int num3 = (int)(_count & 0x3F);
		_count += num;
		fixed (uint* stateSHA = _stateSHA1)
		{
			fixed (byte* buffer = _buffer)
			{
				fixed (uint* expandedBuffer = _expandedBuffer)
				{
					if (num3 > 0 && num3 + num >= 64)
					{
						Buffer.InternalBlockCopy(partIn, num2, _buffer, num3, 64 - num3);
						num2 += 64 - num3;
						num -= 64 - num3;
						SHATransform(expandedBuffer, stateSHA, buffer);
						num3 = 0;
					}
					while (num >= 64)
					{
						Buffer.InternalBlockCopy(partIn, num2, _buffer, 0, 64);
						num2 += 64;
						num -= 64;
						SHATransform(expandedBuffer, stateSHA, buffer);
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
		byte[] array = new byte[20];
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
		Utils.DWORDToBigEndian(array, _stateSHA1, 5);
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
		Utils.DWORDFromBigEndian(expandedBuffer, 16, block);
		SHAExpand(expandedBuffer);
		int i;
		for (i = 0; i < 20; i += 5)
		{
			num5 += ((num << 5) | (num >> 27)) + (num4 ^ (num2 & (num3 ^ num4))) + expandedBuffer[i] + 1518500249;
			num2 = (num2 << 30) | (num2 >> 2);
			num4 += ((num5 << 5) | (num5 >> 27)) + (num3 ^ (num & (num2 ^ num3))) + expandedBuffer[i + 1] + 1518500249;
			num = (num << 30) | (num >> 2);
			num3 += ((num4 << 5) | (num4 >> 27)) + (num2 ^ (num5 & (num ^ num2))) + expandedBuffer[i + 2] + 1518500249;
			num5 = (num5 << 30) | (num5 >> 2);
			num2 += ((num3 << 5) | (num3 >> 27)) + (num ^ (num4 & (num5 ^ num))) + expandedBuffer[i + 3] + 1518500249;
			num4 = (num4 << 30) | (num4 >> 2);
			num += ((num2 << 5) | (num2 >> 27)) + (num5 ^ (num3 & (num4 ^ num5))) + expandedBuffer[i + 4] + 1518500249;
			num3 = (num3 << 30) | (num3 >> 2);
		}
		for (; i < 40; i += 5)
		{
			num5 += ((num << 5) | (num >> 27)) + (num2 ^ num3 ^ num4) + expandedBuffer[i] + 1859775393;
			num2 = (num2 << 30) | (num2 >> 2);
			num4 += ((num5 << 5) | (num5 >> 27)) + (num ^ num2 ^ num3) + expandedBuffer[i + 1] + 1859775393;
			num = (num << 30) | (num >> 2);
			num3 += ((num4 << 5) | (num4 >> 27)) + (num5 ^ num ^ num2) + expandedBuffer[i + 2] + 1859775393;
			num5 = (num5 << 30) | (num5 >> 2);
			num2 += ((num3 << 5) | (num3 >> 27)) + (num4 ^ num5 ^ num) + expandedBuffer[i + 3] + 1859775393;
			num4 = (num4 << 30) | (num4 >> 2);
			num += ((num2 << 5) | (num2 >> 27)) + (num3 ^ num4 ^ num5) + expandedBuffer[i + 4] + 1859775393;
			num3 = (num3 << 30) | (num3 >> 2);
		}
		for (; i < 60; i += 5)
		{
			num5 += (uint)((int)(((num << 5) | (num >> 27)) + ((num2 & num3) | (num4 & (num2 | num3))) + expandedBuffer[i]) + -1894007588);
			num2 = (num2 << 30) | (num2 >> 2);
			num4 += (uint)((int)(((num5 << 5) | (num5 >> 27)) + ((num & num2) | (num3 & (num | num2))) + expandedBuffer[i + 1]) + -1894007588);
			num = (num << 30) | (num >> 2);
			num3 += (uint)((int)(((num4 << 5) | (num4 >> 27)) + ((num5 & num) | (num2 & (num5 | num))) + expandedBuffer[i + 2]) + -1894007588);
			num5 = (num5 << 30) | (num5 >> 2);
			num2 += (uint)((int)(((num3 << 5) | (num3 >> 27)) + ((num4 & num5) | (num & (num4 | num5))) + expandedBuffer[i + 3]) + -1894007588);
			num4 = (num4 << 30) | (num4 >> 2);
			num += (uint)((int)(((num2 << 5) | (num2 >> 27)) + ((num3 & num4) | (num5 & (num3 | num4))) + expandedBuffer[i + 4]) + -1894007588);
			num3 = (num3 << 30) | (num3 >> 2);
		}
		for (; i < 80; i += 5)
		{
			num5 += (uint)((int)(((num << 5) | (num >> 27)) + (num2 ^ num3 ^ num4) + expandedBuffer[i]) + -899497514);
			num2 = (num2 << 30) | (num2 >> 2);
			num4 += (uint)((int)(((num5 << 5) | (num5 >> 27)) + (num ^ num2 ^ num3) + expandedBuffer[i + 1]) + -899497514);
			num = (num << 30) | (num >> 2);
			num3 += (uint)((int)(((num4 << 5) | (num4 >> 27)) + (num5 ^ num ^ num2) + expandedBuffer[i + 2]) + -899497514);
			num5 = (num5 << 30) | (num5 >> 2);
			num2 += (uint)((int)(((num3 << 5) | (num3 >> 27)) + (num4 ^ num5 ^ num) + expandedBuffer[i + 3]) + -899497514);
			num4 = (num4 << 30) | (num4 >> 2);
			num += (uint)((int)(((num2 << 5) | (num2 >> 27)) + (num3 ^ num4 ^ num5) + expandedBuffer[i + 4]) + -899497514);
			num3 = (num3 << 30) | (num3 >> 2);
		}
		*state += num;
		state[1] += num2;
		state[2] += num3;
		state[3] += num4;
		state[4] += num5;
	}

	private unsafe static void SHAExpand(uint* x)
	{
		for (int i = 16; i < 80; i++)
		{
			uint num = x[i - 3] ^ x[i - 8] ^ x[i - 14] ^ x[i - 16];
			x[i] = (num << 1) | (num >> 31);
		}
	}
}
