using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public class SHA384Managed : SHA384
{
	private byte[] _buffer;

	private ulong _count;

	private ulong[] _stateSHA384;

	private ulong[] _W;

	private static readonly ulong[] _K = new ulong[80]
	{
		4794697086780616226uL, 8158064640168781261uL, 13096744586834688815uL, 16840607885511220156uL, 4131703408338449720uL, 6480981068601479193uL, 10538285296894168987uL, 12329834152419229976uL, 15566598209576043074uL, 1334009975649890238uL,
		2608012711638119052uL, 6128411473006802146uL, 8268148722764581231uL, 9286055187155687089uL, 11230858885718282805uL, 13951009754708518548uL, 16472876342353939154uL, 17275323862435702243uL, 1135362057144423861uL, 2597628984639134821uL,
		3308224258029322869uL, 5365058923640841347uL, 6679025012923562964uL, 8573033837759648693uL, 10970295158949994411uL, 12119686244451234320uL, 12683024718118986047uL, 13788192230050041572uL, 14330467153632333762uL, 15395433587784984357uL,
		489312712824947311uL, 1452737877330783856uL, 2861767655752347644uL, 3322285676063803686uL, 5560940570517711597uL, 5996557281743188959uL, 7280758554555802590uL, 8532644243296465576uL, 9350256976987008742uL, 10552545826968843579uL,
		11727347734174303076uL, 12113106623233404929uL, 14000437183269869457uL, 14369950271660146224uL, 15101387698204529176uL, 15463397548674623760uL, 17586052441742319658uL, 1182934255886127544uL, 1847814050463011016uL, 2177327727835720531uL,
		2830643537854262169uL, 3796741975233480872uL, 4115178125766777443uL, 5681478168544905931uL, 6601373596472566643uL, 7507060721942968483uL, 8399075790359081724uL, 8693463985226723168uL, 9568029438360202098uL, 10144078919501101548uL,
		10430055236837252648uL, 11840083180663258601uL, 13761210420658862357uL, 14299343276471374635uL, 14566680578165727644uL, 15097957966210449927uL, 16922976911328602910uL, 17689382322260857208uL, 500013540394364858uL, 748580250866718886uL,
		1242879168328830382uL, 1977374033974150939uL, 2944078676154940804uL, 3659926193048069267uL, 4368137639120453308uL, 4836135668995329356uL, 5532061633213252278uL, 6448918945643986474uL, 6902733635092675308uL, 7801388544844847127uL
	};

	public SHA384Managed()
	{
		if (CryptoConfig.AllowOnlyFipsAlgorithms)
		{
			throw new InvalidOperationException(Environment.GetResourceString("This implementation is not part of the Windows Platform FIPS validated cryptographic algorithms."));
		}
		_stateSHA384 = new ulong[8];
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
		_stateSHA384[0] = 14680500436340154072uL;
		_stateSHA384[1] = 7105036623409894663uL;
		_stateSHA384[2] = 10473403895298186519uL;
		_stateSHA384[3] = 1526699215303891257uL;
		_stateSHA384[4] = 7436329637833083697uL;
		_stateSHA384[5] = 10282925794625328401uL;
		_stateSHA384[6] = 15784041429090275239uL;
		_stateSHA384[7] = 5167115440072839076uL;
	}

	private unsafe void _HashData(byte[] partIn, int ibStart, int cbSize)
	{
		int num = cbSize;
		int num2 = ibStart;
		int num3 = (int)(_count & 0x7F);
		_count += (ulong)num;
		fixed (ulong* stateSHA = _stateSHA384)
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
		byte[] array = new byte[48];
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
		Utils.QuadWordToBigEndian(array, _stateSHA384, 6);
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
		SHA384Expand(expandedBuffer);
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

	private unsafe static void SHA384Expand(ulong* x)
	{
		for (int i = 16; i < 80; i++)
		{
			x[i] = sigma_1(x[i - 2]) + x[i - 7] + sigma_0(x[i - 15]) + x[i - 16];
		}
	}
}
