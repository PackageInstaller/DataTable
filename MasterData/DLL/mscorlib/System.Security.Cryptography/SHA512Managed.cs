using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public class SHA512Managed : SHA512
{
	private byte[] _buffer;

	private ulong _count;

	private ulong[] _stateSHA512;

	private ulong[] _W;

	private static readonly ulong[] _K;

	public SHA512Managed()
	{
		if (CryptoConfig.AllowOnlyFipsAlgorithms)
		{
			throw new InvalidOperationException(Environment.GetResourceString("This implementation is not part of the Windows Platform FIPS validated cryptographic algorithms."));
		}
		_stateSHA512 = new ulong[8];
		_buffer = new byte[128];
		_W = new ulong[80];
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
		_count = 0uL;
		_stateSHA512[0] = 7640891576956012808uL;
		_stateSHA512[1] = 13503953896175478587uL;
		_stateSHA512[2] = 4354685564936845355uL;
		_stateSHA512[3] = 11912009170470909681uL;
		_stateSHA512[4] = 5840696475078001361uL;
		_stateSHA512[5] = 11170449401992604703uL;
		_stateSHA512[6] = 2270897969802886507uL;
		_stateSHA512[7] = 6620516959819538809uL;
	}

	private unsafe void _HashData(byte[] partIn, int ibStart, int cbSize)
	{
		int num = cbSize;
		int num2 = ibStart;
		int num3 = (int)(_count & 0x7F);
		_count += (ulong)num;
		fixed (ulong* stateSHA = _stateSHA512)
		{
			fixed (byte* buffer = _buffer)
			{
				fixed (ulong* w = _W)
				{
					if (num3 > 0 && num3 + num >= 128)
					{
						Buffer.InternalBlockCopy(partIn, num2, _buffer, num3, 128 - num3);
						num2 += 128 - num3;
						num -= 128 - num3;
						SHATransform(w, stateSHA, buffer);
						num3 = 0;
					}
					while (num >= 128)
					{
						Buffer.InternalBlockCopy(partIn, num2, _buffer, 0, 128);
						num2 += 128;
						num -= 128;
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
		byte[] array = new byte[64];
		int num = 128 - (int)(_count & 0x7F);
		if (num <= 16)
		{
			num += 128;
		}
		byte[] array2 = new byte[num];
		array2[0] = 128;
		ulong num2 = _count * 8;
		array2[num - 8] = (byte)((num2 >> 56) & 0xFF);
		array2[num - 7] = (byte)((num2 >> 48) & 0xFF);
		array2[num - 6] = (byte)((num2 >> 40) & 0xFF);
		array2[num - 5] = (byte)((num2 >> 32) & 0xFF);
		array2[num - 4] = (byte)((num2 >> 24) & 0xFF);
		array2[num - 3] = (byte)((num2 >> 16) & 0xFF);
		array2[num - 2] = (byte)((num2 >> 8) & 0xFF);
		array2[num - 1] = (byte)(num2 & 0xFF);
		_HashData(array2, 0, array2.Length);
		Utils.QuadWordToBigEndian(array, _stateSHA512, 8);
		HashValue = array;
		return array;
	}

	private unsafe static void SHATransform(ulong* expandedBuffer, ulong* state, byte* block)
	{
		ulong num = *state;
		ulong num2 = state[1];
		ulong num3 = state[2];
		ulong num4 = state[3];
		ulong num5 = state[4];
		ulong num6 = state[5];
		ulong num7 = state[6];
		ulong num8 = state[7];
		Utils.QuadWordFromBigEndian(expandedBuffer, 16, block);
		SHA512Expand(expandedBuffer);
		int num9;
		for (num9 = 0; num9 < 80; num9++)
		{
			ulong num10 = num8 + Sigma_1(num5) + Ch(num5, num6, num7) + _K[num9] + expandedBuffer[num9];
			ulong num11 = num4 + num10;
			ulong num12 = num10 + Sigma_0(num) + Maj(num, num2, num3);
			num9++;
			num10 = num7 + Sigma_1(num11) + Ch(num11, num5, num6) + _K[num9] + expandedBuffer[num9];
			ulong num13 = num3 + num10;
			ulong num14 = num10 + Sigma_0(num12) + Maj(num12, num, num2);
			num9++;
			num10 = num6 + Sigma_1(num13) + Ch(num13, num11, num5) + _K[num9] + expandedBuffer[num9];
			ulong num15 = num2 + num10;
			ulong num16 = num10 + Sigma_0(num14) + Maj(num14, num12, num);
			num9++;
			num10 = num5 + Sigma_1(num15) + Ch(num15, num13, num11) + _K[num9] + expandedBuffer[num9];
			ulong num17 = num + num10;
			ulong num18 = num10 + Sigma_0(num16) + Maj(num16, num14, num12);
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

	private static ulong RotateRight(ulong x, int n)
	{
		return (x >> n) | (x << 64 - n);
	}

	private static ulong Ch(ulong x, ulong y, ulong z)
	{
		return (x & y) ^ ((x ^ 0xFFFFFFFFFFFFFFFFuL) & z);
	}

	private static ulong Maj(ulong x, ulong y, ulong z)
	{
		return (x & y) ^ (x & z) ^ (y & z);
	}

	private static ulong Sigma_0(ulong x)
	{
		return RotateRight(x, 28) ^ RotateRight(x, 34) ^ RotateRight(x, 39);
	}

	private static ulong Sigma_1(ulong x)
	{
		return RotateRight(x, 14) ^ RotateRight(x, 18) ^ RotateRight(x, 41);
	}

	private static ulong sigma_0(ulong x)
	{
		return RotateRight(x, 1) ^ RotateRight(x, 8) ^ (x >> 7);
	}

	private static ulong sigma_1(ulong x)
	{
		return RotateRight(x, 19) ^ RotateRight(x, 61) ^ (x >> 6);
	}

	private unsafe static void SHA512Expand(ulong* x)
	{
		for (int i = 16; i < 80; i++)
		{
			x[i] = sigma_1(x[i - 2]) + x[i - 7] + sigma_0(x[i - 15]) + x[i - 16];
		}
	}

	static SHA512Managed()
	{
		//IL_000d: Field data (rva=0x6d0) could not be found in any section!
		//IL_000d: Field data (rva=0x6d0) could not be found in any section!
		ulong[] array = new ulong[80];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		_K = array;
	}
}
