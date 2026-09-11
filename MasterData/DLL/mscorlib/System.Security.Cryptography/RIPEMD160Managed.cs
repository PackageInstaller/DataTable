using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public class RIPEMD160Managed : RIPEMD160
{
	private byte[] _buffer;

	private long _count;

	private uint[] _stateMD160;

	private uint[] _blockDWords;

	public RIPEMD160Managed()
	{
		if (CryptoConfig.AllowOnlyFipsAlgorithms)
		{
			throw new InvalidOperationException(Environment.GetResourceString("This implementation is not part of the Windows Platform FIPS validated cryptographic algorithms."));
		}
		_stateMD160 = new uint[5];
		_blockDWords = new uint[16];
		_buffer = new byte[64];
		InitializeState();
	}

	public override void Initialize()
	{
		InitializeState();
		Array.Clear(_blockDWords, 0, _blockDWords.Length);
		Array.Clear(_buffer, 0, _buffer.Length);
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
		_stateMD160[0] = 1732584193u;
		_stateMD160[1] = 4023233417u;
		_stateMD160[2] = 2562383102u;
		_stateMD160[3] = 271733878u;
		_stateMD160[4] = 3285377520u;
	}

	private unsafe void _HashData(byte[] partIn, int ibStart, int cbSize)
	{
		int num = cbSize;
		int num2 = ibStart;
		int num3 = (int)(_count & 0x3F);
		_count += num;
		fixed (uint* stateMD = _stateMD160)
		{
			fixed (byte* buffer = _buffer)
			{
				fixed (uint* blockDWords = _blockDWords)
				{
					if (num3 > 0 && num3 + num >= 64)
					{
						Buffer.InternalBlockCopy(partIn, num2, _buffer, num3, 64 - num3);
						num2 += 64 - num3;
						num -= 64 - num3;
						MDTransform(blockDWords, stateMD, buffer);
						num3 = 0;
					}
					while (num >= 64)
					{
						Buffer.InternalBlockCopy(partIn, num2, _buffer, 0, 64);
						num2 += 64;
						num -= 64;
						MDTransform(blockDWords, stateMD, buffer);
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
		array2[num - 1] = (byte)((num2 >> 56) & 0xFF);
		array2[num - 2] = (byte)((num2 >> 48) & 0xFF);
		array2[num - 3] = (byte)((num2 >> 40) & 0xFF);
		array2[num - 4] = (byte)((num2 >> 32) & 0xFF);
		array2[num - 5] = (byte)((num2 >> 24) & 0xFF);
		array2[num - 6] = (byte)((num2 >> 16) & 0xFF);
		array2[num - 7] = (byte)((num2 >> 8) & 0xFF);
		array2[num - 8] = (byte)(num2 & 0xFF);
		_HashData(array2, 0, array2.Length);
		Utils.DWORDToLittleEndian(array, _stateMD160, 5);
		HashValue = array;
		return array;
	}

	private unsafe static void MDTransform(uint* blockDWords, uint* state, byte* block)
	{
		uint num = *state;
		uint num2 = state[1];
		uint num3 = state[2];
		uint num4 = state[3];
		uint num5 = state[4];
		uint num6 = num;
		uint num7 = num2;
		uint num8 = num3;
		uint num9 = num4;
		uint num10 = num5;
		Utils.DWORDFromLittleEndian(blockDWords, 16, block);
		num += *blockDWords + F(num2, num3, num4);
		num = ((num << 11) | (num >> 21)) + num5;
		num3 = (num3 << 10) | (num3 >> 22);
		num5 += blockDWords[1] + F(num, num2, num3);
		num5 = ((num5 << 14) | (num5 >> 18)) + num4;
		num2 = (num2 << 10) | (num2 >> 22);
		num4 += blockDWords[2] + F(num5, num, num2);
		num4 = ((num4 << 15) | (num4 >> 17)) + num3;
		num = (num << 10) | (num >> 22);
		num3 += blockDWords[3] + F(num4, num5, num);
		num3 = ((num3 << 12) | (num3 >> 20)) + num2;
		num5 = (num5 << 10) | (num5 >> 22);
		num2 += blockDWords[4] + F(num3, num4, num5);
		num2 = ((num2 << 5) | (num2 >> 27)) + num;
		num4 = (num4 << 10) | (num4 >> 22);
		num += blockDWords[5] + F(num2, num3, num4);
		num = ((num << 8) | (num >> 24)) + num5;
		num3 = (num3 << 10) | (num3 >> 22);
		num5 += blockDWords[6] + F(num, num2, num3);
		num5 = ((num5 << 7) | (num5 >> 25)) + num4;
		num2 = (num2 << 10) | (num2 >> 22);
		num4 += blockDWords[7] + F(num5, num, num2);
		num4 = ((num4 << 9) | (num4 >> 23)) + num3;
		num = (num << 10) | (num >> 22);
		num3 += blockDWords[8] + F(num4, num5, num);
		num3 = ((num3 << 11) | (num3 >> 21)) + num2;
		num5 = (num5 << 10) | (num5 >> 22);
		num2 += blockDWords[9] + F(num3, num4, num5);
		num2 = ((num2 << 13) | (num2 >> 19)) + num;
		num4 = (num4 << 10) | (num4 >> 22);
		num += blockDWords[10] + F(num2, num3, num4);
		num = ((num << 14) | (num >> 18)) + num5;
		num3 = (num3 << 10) | (num3 >> 22);
		num5 += blockDWords[11] + F(num, num2, num3);
		num5 = ((num5 << 15) | (num5 >> 17)) + num4;
		num2 = (num2 << 10) | (num2 >> 22);
		num4 += blockDWords[12] + F(num5, num, num2);
		num4 = ((num4 << 6) | (num4 >> 26)) + num3;
		num = (num << 10) | (num >> 22);
		num3 += blockDWords[13] + F(num4, num5, num);
		num3 = ((num3 << 7) | (num3 >> 25)) + num2;
		num5 = (num5 << 10) | (num5 >> 22);
		num2 += blockDWords[14] + F(num3, num4, num5);
		num2 = ((num2 << 9) | (num2 >> 23)) + num;
		num4 = (num4 << 10) | (num4 >> 22);
		num += blockDWords[15] + F(num2, num3, num4);
		num = ((num << 8) | (num >> 24)) + num5;
		num3 = (num3 << 10) | (num3 >> 22);
		num5 += G(num, num2, num3) + blockDWords[7] + 1518500249;
		num5 = ((num5 << 7) | (num5 >> 25)) + num4;
		num2 = (num2 << 10) | (num2 >> 22);
		num4 += G(num5, num, num2) + blockDWords[4] + 1518500249;
		num4 = ((num4 << 6) | (num4 >> 26)) + num3;
		num = (num << 10) | (num >> 22);
		num3 += G(num4, num5, num) + blockDWords[13] + 1518500249;
		num3 = ((num3 << 8) | (num3 >> 24)) + num2;
		num5 = (num5 << 10) | (num5 >> 22);
		num2 += G(num3, num4, num5) + blockDWords[1] + 1518500249;
		num2 = ((num2 << 13) | (num2 >> 19)) + num;
		num4 = (num4 << 10) | (num4 >> 22);
		num += G(num2, num3, num4) + blockDWords[10] + 1518500249;
		num = ((num << 11) | (num >> 21)) + num5;
		num3 = (num3 << 10) | (num3 >> 22);
		num5 += G(num, num2, num3) + blockDWords[6] + 1518500249;
		num5 = ((num5 << 9) | (num5 >> 23)) + num4;
		num2 = (num2 << 10) | (num2 >> 22);
		num4 += G(num5, num, num2) + blockDWords[15] + 1518500249;
		num4 = ((num4 << 7) | (num4 >> 25)) + num3;
		num = (num << 10) | (num >> 22);
		num3 += G(num4, num5, num) + blockDWords[3] + 1518500249;
		num3 = ((num3 << 15) | (num3 >> 17)) + num2;
		num5 = (num5 << 10) | (num5 >> 22);
		num2 += G(num3, num4, num5) + blockDWords[12] + 1518500249;
		num2 = ((num2 << 7) | (num2 >> 25)) + num;
		num4 = (num4 << 10) | (num4 >> 22);
		num += G(num2, num3, num4) + *blockDWords + 1518500249;
		num = ((num << 12) | (num >> 20)) + num5;
		num3 = (num3 << 10) | (num3 >> 22);
		num5 += G(num, num2, num3) + blockDWords[9] + 1518500249;
		num5 = ((num5 << 15) | (num5 >> 17)) + num4;
		num2 = (num2 << 10) | (num2 >> 22);
		num4 += G(num5, num, num2) + blockDWords[5] + 1518500249;
		num4 = ((num4 << 9) | (num4 >> 23)) + num3;
		num = (num << 10) | (num >> 22);
		num3 += G(num4, num5, num) + blockDWords[2] + 1518500249;
		num3 = ((num3 << 11) | (num3 >> 21)) + num2;
		num5 = (num5 << 10) | (num5 >> 22);
		num2 += G(num3, num4, num5) + blockDWords[14] + 1518500249;
		num2 = ((num2 << 7) | (num2 >> 25)) + num;
		num4 = (num4 << 10) | (num4 >> 22);
		num += G(num2, num3, num4) + blockDWords[11] + 1518500249;
		num = ((num << 13) | (num >> 19)) + num5;
		num3 = (num3 << 10) | (num3 >> 22);
		num5 += G(num, num2, num3) + blockDWords[8] + 1518500249;
		num5 = ((num5 << 12) | (num5 >> 20)) + num4;
		num2 = (num2 << 10) | (num2 >> 22);
		num4 += H(num5, num, num2) + blockDWords[3] + 1859775393;
		num4 = ((num4 << 11) | (num4 >> 21)) + num3;
		num = (num << 10) | (num >> 22);
		num3 += H(num4, num5, num) + blockDWords[10] + 1859775393;
		num3 = ((num3 << 13) | (num3 >> 19)) + num2;
		num5 = (num5 << 10) | (num5 >> 22);
		num2 += H(num3, num4, num5) + blockDWords[14] + 1859775393;
		num2 = ((num2 << 6) | (num2 >> 26)) + num;
		num4 = (num4 << 10) | (num4 >> 22);
		num += H(num2, num3, num4) + blockDWords[4] + 1859775393;
		num = ((num << 7) | (num >> 25)) + num5;
		num3 = (num3 << 10) | (num3 >> 22);
		num5 += H(num, num2, num3) + blockDWords[9] + 1859775393;
		num5 = ((num5 << 14) | (num5 >> 18)) + num4;
		num2 = (num2 << 10) | (num2 >> 22);
		num4 += H(num5, num, num2) + blockDWords[15] + 1859775393;
		num4 = ((num4 << 9) | (num4 >> 23)) + num3;
		num = (num << 10) | (num >> 22);
		num3 += H(num4, num5, num) + blockDWords[8] + 1859775393;
		num3 = ((num3 << 13) | (num3 >> 19)) + num2;
		num5 = (num5 << 10) | (num5 >> 22);
		num2 += H(num3, num4, num5) + blockDWords[1] + 1859775393;
		num2 = ((num2 << 15) | (num2 >> 17)) + num;
		num4 = (num4 << 10) | (num4 >> 22);
		num += H(num2, num3, num4) + blockDWords[2] + 1859775393;
		num = ((num << 14) | (num >> 18)) + num5;
		num3 = (num3 << 10) | (num3 >> 22);
		num5 += H(num, num2, num3) + blockDWords[7] + 1859775393;
		num5 = ((num5 << 8) | (num5 >> 24)) + num4;
		num2 = (num2 << 10) | (num2 >> 22);
		num4 += H(num5, num, num2) + *blockDWords + 1859775393;
		num4 = ((num4 << 13) | (num4 >> 19)) + num3;
		num = (num << 10) | (num >> 22);
		num3 += H(num4, num5, num) + blockDWords[6] + 1859775393;
		num3 = ((num3 << 6) | (num3 >> 26)) + num2;
		num5 = (num5 << 10) | (num5 >> 22);
		num2 += H(num3, num4, num5) + blockDWords[13] + 1859775393;
		num2 = ((num2 << 5) | (num2 >> 27)) + num;
		num4 = (num4 << 10) | (num4 >> 22);
		num += H(num2, num3, num4) + blockDWords[11] + 1859775393;
		num = ((num << 12) | (num >> 20)) + num5;
		num3 = (num3 << 10) | (num3 >> 22);
		num5 += H(num, num2, num3) + blockDWords[5] + 1859775393;
		num5 = ((num5 << 7) | (num5 >> 25)) + num4;
		num2 = (num2 << 10) | (num2 >> 22);
		num4 += H(num5, num, num2) + blockDWords[12] + 1859775393;
		num4 = ((num4 << 5) | (num4 >> 27)) + num3;
		num = (num << 10) | (num >> 22);
		num3 += (uint)((int)(I(num4, num5, num) + blockDWords[1]) + -1894007588);
		num3 = ((num3 << 11) | (num3 >> 21)) + num2;
		num5 = (num5 << 10) | (num5 >> 22);
		num2 += (uint)((int)(I(num3, num4, num5) + blockDWords[9]) + -1894007588);
		num2 = ((num2 << 12) | (num2 >> 20)) + num;
		num4 = (num4 << 10) | (num4 >> 22);
		num += (uint)((int)(I(num2, num3, num4) + blockDWords[11]) + -1894007588);
		num = ((num << 14) | (num >> 18)) + num5;
		num3 = (num3 << 10) | (num3 >> 22);
		num5 += (uint)((int)(I(num, num2, num3) + blockDWords[10]) + -1894007588);
		num5 = ((num5 << 15) | (num5 >> 17)) + num4;
		num2 = (num2 << 10) | (num2 >> 22);
		num4 += (uint)((int)(I(num5, num, num2) + *blockDWords) + -1894007588);
		num4 = ((num4 << 14) | (num4 >> 18)) + num3;
		num = (num << 10) | (num >> 22);
		num3 += (uint)((int)(I(num4, num5, num) + blockDWords[8]) + -1894007588);
		num3 = ((num3 << 15) | (num3 >> 17)) + num2;
		num5 = (num5 << 10) | (num5 >> 22);
		num2 += (uint)((int)(I(num3, num4, num5) + blockDWords[12]) + -1894007588);
		num2 = ((num2 << 9) | (num2 >> 23)) + num;
		num4 = (num4 << 10) | (num4 >> 22);
		num += (uint)((int)(I(num2, num3, num4) + blockDWords[4]) + -1894007588);
		num = ((num << 8) | (num >> 24)) + num5;
		num3 = (num3 << 10) | (num3 >> 22);
		num5 += (uint)((int)(I(num, num2, num3) + blockDWords[13]) + -1894007588);
		num5 = ((num5 << 9) | (num5 >> 23)) + num4;
		num2 = (num2 << 10) | (num2 >> 22);
		num4 += (uint)((int)(I(num5, num, num2) + blockDWords[3]) + -1894007588);
		num4 = ((num4 << 14) | (num4 >> 18)) + num3;
		num = (num << 10) | (num >> 22);
		num3 += (uint)((int)(I(num4, num5, num) + blockDWords[7]) + -1894007588);
		num3 = ((num3 << 5) | (num3 >> 27)) + num2;
		num5 = (num5 << 10) | (num5 >> 22);
		num2 += (uint)((int)(I(num3, num4, num5) + blockDWords[15]) + -1894007588);
		num2 = ((num2 << 6) | (num2 >> 26)) + num;
		num4 = (num4 << 10) | (num4 >> 22);
		num += (uint)((int)(I(num2, num3, num4) + blockDWords[14]) + -1894007588);
		num = ((num << 8) | (num >> 24)) + num5;
		num3 = (num3 << 10) | (num3 >> 22);
		num5 += (uint)((int)(I(num, num2, num3) + blockDWords[5]) + -1894007588);
		num5 = ((num5 << 6) | (num5 >> 26)) + num4;
		num2 = (num2 << 10) | (num2 >> 22);
		num4 += (uint)((int)(I(num5, num, num2) + blockDWords[6]) + -1894007588);
		num4 = ((num4 << 5) | (num4 >> 27)) + num3;
		num = (num << 10) | (num >> 22);
		num3 += (uint)((int)(I(num4, num5, num) + blockDWords[2]) + -1894007588);
		num3 = ((num3 << 12) | (num3 >> 20)) + num2;
		num5 = (num5 << 10) | (num5 >> 22);
		num2 += (uint)((int)(J(num3, num4, num5) + blockDWords[4]) + -1454113458);
		num2 = ((num2 << 9) | (num2 >> 23)) + num;
		num4 = (num4 << 10) | (num4 >> 22);
		num += (uint)((int)(J(num2, num3, num4) + *blockDWords) + -1454113458);
		num = ((num << 15) | (num >> 17)) + num5;
		num3 = (num3 << 10) | (num3 >> 22);
		num5 += (uint)((int)(J(num, num2, num3) + blockDWords[5]) + -1454113458);
		num5 = ((num5 << 5) | (num5 >> 27)) + num4;
		num2 = (num2 << 10) | (num2 >> 22);
		num4 += (uint)((int)(J(num5, num, num2) + blockDWords[9]) + -1454113458);
		num4 = ((num4 << 11) | (num4 >> 21)) + num3;
		num = (num << 10) | (num >> 22);
		num3 += (uint)((int)(J(num4, num5, num) + blockDWords[7]) + -1454113458);
		num3 = ((num3 << 6) | (num3 >> 26)) + num2;
		num5 = (num5 << 10) | (num5 >> 22);
		num2 += (uint)((int)(J(num3, num4, num5) + blockDWords[12]) + -1454113458);
		num2 = ((num2 << 8) | (num2 >> 24)) + num;
		num4 = (num4 << 10) | (num4 >> 22);
		num += (uint)((int)(J(num2, num3, num4) + blockDWords[2]) + -1454113458);
		num = ((num << 13) | (num >> 19)) + num5;
		num3 = (num3 << 10) | (num3 >> 22);
		num5 += (uint)((int)(J(num, num2, num3) + blockDWords[10]) + -1454113458);
		num5 = ((num5 << 12) | (num5 >> 20)) + num4;
		num2 = (num2 << 10) | (num2 >> 22);
		num4 += (uint)((int)(J(num5, num, num2) + blockDWords[14]) + -1454113458);
		num4 = ((num4 << 5) | (num4 >> 27)) + num3;
		num = (num << 10) | (num >> 22);
		num3 += (uint)((int)(J(num4, num5, num) + blockDWords[1]) + -1454113458);
		num3 = ((num3 << 12) | (num3 >> 20)) + num2;
		num5 = (num5 << 10) | (num5 >> 22);
		num2 += (uint)((int)(J(num3, num4, num5) + blockDWords[3]) + -1454113458);
		num2 = ((num2 << 13) | (num2 >> 19)) + num;
		num4 = (num4 << 10) | (num4 >> 22);
		num += (uint)((int)(J(num2, num3, num4) + blockDWords[8]) + -1454113458);
		num = ((num << 14) | (num >> 18)) + num5;
		num3 = (num3 << 10) | (num3 >> 22);
		num5 += (uint)((int)(J(num, num2, num3) + blockDWords[11]) + -1454113458);
		num5 = ((num5 << 11) | (num5 >> 21)) + num4;
		num2 = (num2 << 10) | (num2 >> 22);
		num4 += (uint)((int)(J(num5, num, num2) + blockDWords[6]) + -1454113458);
		num4 = ((num4 << 8) | (num4 >> 24)) + num3;
		num = (num << 10) | (num >> 22);
		num3 += (uint)((int)(J(num4, num5, num) + blockDWords[15]) + -1454113458);
		num3 = ((num3 << 5) | (num3 >> 27)) + num2;
		num5 = (num5 << 10) | (num5 >> 22);
		num2 += (uint)((int)(J(num3, num4, num5) + blockDWords[13]) + -1454113458);
		num2 = ((num2 << 6) | (num2 >> 26)) + num;
		num4 = (num4 << 10) | (num4 >> 22);
		num6 += J(num7, num8, num9) + blockDWords[5] + 1352829926;
		num6 = ((num6 << 8) | (num6 >> 24)) + num10;
		num8 = (num8 << 10) | (num8 >> 22);
		num10 += J(num6, num7, num8) + blockDWords[14] + 1352829926;
		num10 = ((num10 << 9) | (num10 >> 23)) + num9;
		num7 = (num7 << 10) | (num7 >> 22);
		num9 += J(num10, num6, num7) + blockDWords[7] + 1352829926;
		num9 = ((num9 << 9) | (num9 >> 23)) + num8;
		num6 = (num6 << 10) | (num6 >> 22);
		num8 += J(num9, num10, num6) + *blockDWords + 1352829926;
		num8 = ((num8 << 11) | (num8 >> 21)) + num7;
		num10 = (num10 << 10) | (num10 >> 22);
		num7 += J(num8, num9, num10) + blockDWords[9] + 1352829926;
		num7 = ((num7 << 13) | (num7 >> 19)) + num6;
		num9 = (num9 << 10) | (num9 >> 22);
		num6 += J(num7, num8, num9) + blockDWords[2] + 1352829926;
		num6 = ((num6 << 15) | (num6 >> 17)) + num10;
		num8 = (num8 << 10) | (num8 >> 22);
		num10 += J(num6, num7, num8) + blockDWords[11] + 1352829926;
		num10 = ((num10 << 15) | (num10 >> 17)) + num9;
		num7 = (num7 << 10) | (num7 >> 22);
		num9 += J(num10, num6, num7) + blockDWords[4] + 1352829926;
		num9 = ((num9 << 5) | (num9 >> 27)) + num8;
		num6 = (num6 << 10) | (num6 >> 22);
		num8 += J(num9, num10, num6) + blockDWords[13] + 1352829926;
		num8 = ((num8 << 7) | (num8 >> 25)) + num7;
		num10 = (num10 << 10) | (num10 >> 22);
		num7 += J(num8, num9, num10) + blockDWords[6] + 1352829926;
		num7 = ((num7 << 7) | (num7 >> 25)) + num6;
		num9 = (num9 << 10) | (num9 >> 22);
		num6 += J(num7, num8, num9) + blockDWords[15] + 1352829926;
		num6 = ((num6 << 8) | (num6 >> 24)) + num10;
		num8 = (num8 << 10) | (num8 >> 22);
		num10 += J(num6, num7, num8) + blockDWords[8] + 1352829926;
		num10 = ((num10 << 11) | (num10 >> 21)) + num9;
		num7 = (num7 << 10) | (num7 >> 22);
		num9 += J(num10, num6, num7) + blockDWords[1] + 1352829926;
		num9 = ((num9 << 14) | (num9 >> 18)) + num8;
		num6 = (num6 << 10) | (num6 >> 22);
		num8 += J(num9, num10, num6) + blockDWords[10] + 1352829926;
		num8 = ((num8 << 14) | (num8 >> 18)) + num7;
		num10 = (num10 << 10) | (num10 >> 22);
		num7 += J(num8, num9, num10) + blockDWords[3] + 1352829926;
		num7 = ((num7 << 12) | (num7 >> 20)) + num6;
		num9 = (num9 << 10) | (num9 >> 22);
		num6 += J(num7, num8, num9) + blockDWords[12] + 1352829926;
		num6 = ((num6 << 6) | (num6 >> 26)) + num10;
		num8 = (num8 << 10) | (num8 >> 22);
		num10 += I(num6, num7, num8) + blockDWords[6] + 1548603684;
		num10 = ((num10 << 9) | (num10 >> 23)) + num9;
		num7 = (num7 << 10) | (num7 >> 22);
		num9 += I(num10, num6, num7) + blockDWords[11] + 1548603684;
		num9 = ((num9 << 13) | (num9 >> 19)) + num8;
		num6 = (num6 << 10) | (num6 >> 22);
		num8 += I(num9, num10, num6) + blockDWords[3] + 1548603684;
		num8 = ((num8 << 15) | (num8 >> 17)) + num7;
		num10 = (num10 << 10) | (num10 >> 22);
		num7 += I(num8, num9, num10) + blockDWords[7] + 1548603684;
		num7 = ((num7 << 7) | (num7 >> 25)) + num6;
		num9 = (num9 << 10) | (num9 >> 22);
		num6 += I(num7, num8, num9) + *blockDWords + 1548603684;
		num6 = ((num6 << 12) | (num6 >> 20)) + num10;
		num8 = (num8 << 10) | (num8 >> 22);
		num10 += I(num6, num7, num8) + blockDWords[13] + 1548603684;
		num10 = ((num10 << 8) | (num10 >> 24)) + num9;
		num7 = (num7 << 10) | (num7 >> 22);
		num9 += I(num10, num6, num7) + blockDWords[5] + 1548603684;
		num9 = ((num9 << 9) | (num9 >> 23)) + num8;
		num6 = (num6 << 10) | (num6 >> 22);
		num8 += I(num9, num10, num6) + blockDWords[10] + 1548603684;
		num8 = ((num8 << 11) | (num8 >> 21)) + num7;
		num10 = (num10 << 10) | (num10 >> 22);
		num7 += I(num8, num9, num10) + blockDWords[14] + 1548603684;
		num7 = ((num7 << 7) | (num7 >> 25)) + num6;
		num9 = (num9 << 10) | (num9 >> 22);
		num6 += I(num7, num8, num9) + blockDWords[15] + 1548603684;
		num6 = ((num6 << 7) | (num6 >> 25)) + num10;
		num8 = (num8 << 10) | (num8 >> 22);
		num10 += I(num6, num7, num8) + blockDWords[8] + 1548603684;
		num10 = ((num10 << 12) | (num10 >> 20)) + num9;
		num7 = (num7 << 10) | (num7 >> 22);
		num9 += I(num10, num6, num7) + blockDWords[12] + 1548603684;
		num9 = ((num9 << 7) | (num9 >> 25)) + num8;
		num6 = (num6 << 10) | (num6 >> 22);
		num8 += I(num9, num10, num6) + blockDWords[4] + 1548603684;
		num8 = ((num8 << 6) | (num8 >> 26)) + num7;
		num10 = (num10 << 10) | (num10 >> 22);
		num7 += I(num8, num9, num10) + blockDWords[9] + 1548603684;
		num7 = ((num7 << 15) | (num7 >> 17)) + num6;
		num9 = (num9 << 10) | (num9 >> 22);
		num6 += I(num7, num8, num9) + blockDWords[1] + 1548603684;
		num6 = ((num6 << 13) | (num6 >> 19)) + num10;
		num8 = (num8 << 10) | (num8 >> 22);
		num10 += I(num6, num7, num8) + blockDWords[2] + 1548603684;
		num10 = ((num10 << 11) | (num10 >> 21)) + num9;
		num7 = (num7 << 10) | (num7 >> 22);
		num9 += H(num10, num6, num7) + blockDWords[15] + 1836072691;
		num9 = ((num9 << 9) | (num9 >> 23)) + num8;
		num6 = (num6 << 10) | (num6 >> 22);
		num8 += H(num9, num10, num6) + blockDWords[5] + 1836072691;
		num8 = ((num8 << 7) | (num8 >> 25)) + num7;
		num10 = (num10 << 10) | (num10 >> 22);
		num7 += H(num8, num9, num10) + blockDWords[1] + 1836072691;
		num7 = ((num7 << 15) | (num7 >> 17)) + num6;
		num9 = (num9 << 10) | (num9 >> 22);
		num6 += H(num7, num8, num9) + blockDWords[3] + 1836072691;
		num6 = ((num6 << 11) | (num6 >> 21)) + num10;
		num8 = (num8 << 10) | (num8 >> 22);
		num10 += H(num6, num7, num8) + blockDWords[7] + 1836072691;
		num10 = ((num10 << 8) | (num10 >> 24)) + num9;
		num7 = (num7 << 10) | (num7 >> 22);
		num9 += H(num10, num6, num7) + blockDWords[14] + 1836072691;
		num9 = ((num9 << 6) | (num9 >> 26)) + num8;
		num6 = (num6 << 10) | (num6 >> 22);
		num8 += H(num9, num10, num6) + blockDWords[6] + 1836072691;
		num8 = ((num8 << 6) | (num8 >> 26)) + num7;
		num10 = (num10 << 10) | (num10 >> 22);
		num7 += H(num8, num9, num10) + blockDWords[9] + 1836072691;
		num7 = ((num7 << 14) | (num7 >> 18)) + num6;
		num9 = (num9 << 10) | (num9 >> 22);
		num6 += H(num7, num8, num9) + blockDWords[11] + 1836072691;
		num6 = ((num6 << 12) | (num6 >> 20)) + num10;
		num8 = (num8 << 10) | (num8 >> 22);
		num10 += H(num6, num7, num8) + blockDWords[8] + 1836072691;
		num10 = ((num10 << 13) | (num10 >> 19)) + num9;
		num7 = (num7 << 10) | (num7 >> 22);
		num9 += H(num10, num6, num7) + blockDWords[12] + 1836072691;
		num9 = ((num9 << 5) | (num9 >> 27)) + num8;
		num6 = (num6 << 10) | (num6 >> 22);
		num8 += H(num9, num10, num6) + blockDWords[2] + 1836072691;
		num8 = ((num8 << 14) | (num8 >> 18)) + num7;
		num10 = (num10 << 10) | (num10 >> 22);
		num7 += H(num8, num9, num10) + blockDWords[10] + 1836072691;
		num7 = ((num7 << 13) | (num7 >> 19)) + num6;
		num9 = (num9 << 10) | (num9 >> 22);
		num6 += H(num7, num8, num9) + *blockDWords + 1836072691;
		num6 = ((num6 << 13) | (num6 >> 19)) + num10;
		num8 = (num8 << 10) | (num8 >> 22);
		num10 += H(num6, num7, num8) + blockDWords[4] + 1836072691;
		num10 = ((num10 << 7) | (num10 >> 25)) + num9;
		num7 = (num7 << 10) | (num7 >> 22);
		num9 += H(num10, num6, num7) + blockDWords[13] + 1836072691;
		num9 = ((num9 << 5) | (num9 >> 27)) + num8;
		num6 = (num6 << 10) | (num6 >> 22);
		num8 += G(num9, num10, num6) + blockDWords[8] + 2053994217;
		num8 = ((num8 << 15) | (num8 >> 17)) + num7;
		num10 = (num10 << 10) | (num10 >> 22);
		num7 += G(num8, num9, num10) + blockDWords[6] + 2053994217;
		num7 = ((num7 << 5) | (num7 >> 27)) + num6;
		num9 = (num9 << 10) | (num9 >> 22);
		num6 += G(num7, num8, num9) + blockDWords[4] + 2053994217;
		num6 = ((num6 << 8) | (num6 >> 24)) + num10;
		num8 = (num8 << 10) | (num8 >> 22);
		num10 += G(num6, num7, num8) + blockDWords[1] + 2053994217;
		num10 = ((num10 << 11) | (num10 >> 21)) + num9;
		num7 = (num7 << 10) | (num7 >> 22);
		num9 += G(num10, num6, num7) + blockDWords[3] + 2053994217;
		num9 = ((num9 << 14) | (num9 >> 18)) + num8;
		num6 = (num6 << 10) | (num6 >> 22);
		num8 += G(num9, num10, num6) + blockDWords[11] + 2053994217;
		num8 = ((num8 << 14) | (num8 >> 18)) + num7;
		num10 = (num10 << 10) | (num10 >> 22);
		num7 += G(num8, num9, num10) + blockDWords[15] + 2053994217;
		num7 = ((num7 << 6) | (num7 >> 26)) + num6;
		num9 = (num9 << 10) | (num9 >> 22);
		num6 += G(num7, num8, num9) + *blockDWords + 2053994217;
		num6 = ((num6 << 14) | (num6 >> 18)) + num10;
		num8 = (num8 << 10) | (num8 >> 22);
		num10 += G(num6, num7, num8) + blockDWords[5] + 2053994217;
		num10 = ((num10 << 6) | (num10 >> 26)) + num9;
		num7 = (num7 << 10) | (num7 >> 22);
		num9 += G(num10, num6, num7) + blockDWords[12] + 2053994217;
		num9 = ((num9 << 9) | (num9 >> 23)) + num8;
		num6 = (num6 << 10) | (num6 >> 22);
		num8 += G(num9, num10, num6) + blockDWords[2] + 2053994217;
		num8 = ((num8 << 12) | (num8 >> 20)) + num7;
		num10 = (num10 << 10) | (num10 >> 22);
		num7 += G(num8, num9, num10) + blockDWords[13] + 2053994217;
		num7 = ((num7 << 9) | (num7 >> 23)) + num6;
		num9 = (num9 << 10) | (num9 >> 22);
		num6 += G(num7, num8, num9) + blockDWords[9] + 2053994217;
		num6 = ((num6 << 12) | (num6 >> 20)) + num10;
		num8 = (num8 << 10) | (num8 >> 22);
		num10 += G(num6, num7, num8) + blockDWords[7] + 2053994217;
		num10 = ((num10 << 5) | (num10 >> 27)) + num9;
		num7 = (num7 << 10) | (num7 >> 22);
		num9 += G(num10, num6, num7) + blockDWords[10] + 2053994217;
		num9 = ((num9 << 15) | (num9 >> 17)) + num8;
		num6 = (num6 << 10) | (num6 >> 22);
		num8 += G(num9, num10, num6) + blockDWords[14] + 2053994217;
		num8 = ((num8 << 8) | (num8 >> 24)) + num7;
		num10 = (num10 << 10) | (num10 >> 22);
		num7 += F(num8, num9, num10) + blockDWords[12];
		num7 = ((num7 << 8) | (num7 >> 24)) + num6;
		num9 = (num9 << 10) | (num9 >> 22);
		num6 += F(num7, num8, num9) + blockDWords[15];
		num6 = ((num6 << 5) | (num6 >> 27)) + num10;
		num8 = (num8 << 10) | (num8 >> 22);
		num10 += F(num6, num7, num8) + blockDWords[10];
		num10 = ((num10 << 12) | (num10 >> 20)) + num9;
		num7 = (num7 << 10) | (num7 >> 22);
		num9 += F(num10, num6, num7) + blockDWords[4];
		num9 = ((num9 << 9) | (num9 >> 23)) + num8;
		num6 = (num6 << 10) | (num6 >> 22);
		num8 += F(num9, num10, num6) + blockDWords[1];
		num8 = ((num8 << 12) | (num8 >> 20)) + num7;
		num10 = (num10 << 10) | (num10 >> 22);
		num7 += F(num8, num9, num10) + blockDWords[5];
		num7 = ((num7 << 5) | (num7 >> 27)) + num6;
		num9 = (num9 << 10) | (num9 >> 22);
		num6 += F(num7, num8, num9) + blockDWords[8];
		num6 = ((num6 << 14) | (num6 >> 18)) + num10;
		num8 = (num8 << 10) | (num8 >> 22);
		num10 += F(num6, num7, num8) + blockDWords[7];
		num10 = ((num10 << 6) | (num10 >> 26)) + num9;
		num7 = (num7 << 10) | (num7 >> 22);
		num9 += F(num10, num6, num7) + blockDWords[6];
		num9 = ((num9 << 8) | (num9 >> 24)) + num8;
		num6 = (num6 << 10) | (num6 >> 22);
		num8 += F(num9, num10, num6) + blockDWords[2];
		num8 = ((num8 << 13) | (num8 >> 19)) + num7;
		num10 = (num10 << 10) | (num10 >> 22);
		num7 += F(num8, num9, num10) + blockDWords[13];
		num7 = ((num7 << 6) | (num7 >> 26)) + num6;
		num9 = (num9 << 10) | (num9 >> 22);
		num6 += F(num7, num8, num9) + blockDWords[14];
		num6 = ((num6 << 5) | (num6 >> 27)) + num10;
		num8 = (num8 << 10) | (num8 >> 22);
		num10 += F(num6, num7, num8) + *blockDWords;
		num10 = ((num10 << 15) | (num10 >> 17)) + num9;
		num7 = (num7 << 10) | (num7 >> 22);
		num9 += F(num10, num6, num7) + blockDWords[3];
		num9 = ((num9 << 13) | (num9 >> 19)) + num8;
		num6 = (num6 << 10) | (num6 >> 22);
		num8 += F(num9, num10, num6) + blockDWords[9];
		num8 = ((num8 << 11) | (num8 >> 21)) + num7;
		num10 = (num10 << 10) | (num10 >> 22);
		num7 += F(num8, num9, num10) + blockDWords[11];
		num7 = ((num7 << 11) | (num7 >> 21)) + num6;
		num9 = (num9 << 10) | (num9 >> 22);
		num9 += num3 + state[1];
		state[1] = state[2] + num4 + num10;
		state[2] = state[3] + num5 + num6;
		state[3] = state[4] + num + num7;
		state[4] = *state + num2 + num8;
		*state = num9;
	}

	private static uint F(uint x, uint y, uint z)
	{
		return x ^ y ^ z;
	}

	private static uint G(uint x, uint y, uint z)
	{
		return (x & y) | (~x & z);
	}

	private static uint H(uint x, uint y, uint z)
	{
		return (x | ~y) ^ z;
	}

	private static uint I(uint x, uint y, uint z)
	{
		return (x & z) | (y & ~z);
	}

	private static uint J(uint x, uint y, uint z)
	{
		return x ^ (y | ~z);
	}
}
