using System;
using System.Security.Cryptography;
using Mono.Math.Prime;
using Mono.Math.Prime.Generator;

namespace Mono.Math;

internal class BigInteger
{
	public enum Sign
	{
		Negative = -1,
		Zero,
		Positive
	}

	internal sealed class ModulusRing
	{
		private BigInteger mod;

		private BigInteger constant;

		public ModulusRing(BigInteger modulus)
		{
			mod = modulus;
			uint num = mod.length << 1;
			constant = new BigInteger(Sign.Positive, num + 1);
			constant.data[num] = 1u;
			constant /= mod;
		}

		public void BarrettReduction(BigInteger x)
		{
			BigInteger bigInteger = mod;
			uint length = bigInteger.length;
			uint num = length + 1;
			uint num2 = length - 1;
			if (x.length >= length)
			{
				if (x.data.Length < x.length)
				{
					throw new IndexOutOfRangeException("x out of range");
				}
				BigInteger bigInteger2 = new BigInteger(Sign.Positive, x.length - num2 + constant.length);
				Kernel.Multiply(x.data, num2, x.length - num2, constant.data, 0u, constant.length, bigInteger2.data, 0u);
				uint length2 = ((x.length > num) ? num : x.length);
				x.length = length2;
				x.Normalize();
				BigInteger bigInteger3 = new BigInteger(Sign.Positive, num);
				Kernel.MultiplyMod2p32pmod(bigInteger2.data, (int)num, (int)(bigInteger2.length - num), bigInteger.data, 0, (int)bigInteger.length, bigInteger3.data, 0, (int)num);
				bigInteger3.Normalize();
				if (bigInteger3 <= x)
				{
					Kernel.MinusEq(x, bigInteger3);
				}
				else
				{
					BigInteger bigInteger4 = new BigInteger(Sign.Positive, num + 1);
					bigInteger4.data[num] = 1u;
					Kernel.MinusEq(bigInteger4, bigInteger3);
					Kernel.PlusEq(x, bigInteger4);
				}
				while (x >= bigInteger)
				{
					Kernel.MinusEq(x, bigInteger);
				}
			}
		}

		public BigInteger Multiply(BigInteger a, BigInteger b)
		{
			if (a == 0u || b == 0u)
			{
				return 0;
			}
			if (a > mod)
			{
				a %= mod;
			}
			if (b > mod)
			{
				b %= mod;
			}
			BigInteger bigInteger = a * b;
			BarrettReduction(bigInteger);
			return bigInteger;
		}

		public BigInteger Difference(BigInteger a, BigInteger b)
		{
			Sign sign = Kernel.Compare(a, b);
			BigInteger bigInteger;
			switch (sign)
			{
			case Sign.Zero:
				return 0;
			case Sign.Positive:
				bigInteger = a - b;
				break;
			case Sign.Negative:
				bigInteger = b - a;
				break;
			default:
				throw new Exception();
			}
			if (bigInteger >= mod)
			{
				if (bigInteger.length >= mod.length << 1)
				{
					bigInteger %= mod;
				}
				else
				{
					BarrettReduction(bigInteger);
				}
			}
			if (sign == Sign.Negative)
			{
				bigInteger = mod - bigInteger;
			}
			return bigInteger;
		}

		public BigInteger Pow(BigInteger a, BigInteger k)
		{
			BigInteger bigInteger = new BigInteger(1u);
			if (k == 0u)
			{
				return bigInteger;
			}
			BigInteger bigInteger2 = a;
			if (k.TestBit(0))
			{
				bigInteger = a;
			}
			for (int i = 1; i < k.BitCount(); i++)
			{
				bigInteger2 = Multiply(bigInteger2, bigInteger2);
				if (k.TestBit(i))
				{
					bigInteger = Multiply(bigInteger2, bigInteger);
				}
			}
			return bigInteger;
		}

		public BigInteger Pow(uint b, BigInteger exp)
		{
			return Pow(new BigInteger(b), exp);
		}
	}

	private sealed class Kernel
	{
		public static BigInteger Subtract(BigInteger big, BigInteger small)
		{
			BigInteger bigInteger = new BigInteger(Sign.Positive, big.length);
			uint[] data = bigInteger.data;
			uint[] data2 = big.data;
			uint[] data3 = small.data;
			uint num = 0u;
			uint num2 = 0u;
			do
			{
				uint num3 = data3[num];
				num2 = ((((num3 += num2) < num2) | ((data[num] = data2[num] - num3) > ~num3)) ? 1u : 0u);
			}
			while (++num < small.length);
			if (num != big.length)
			{
				if (num2 == 1)
				{
					do
					{
						data[num] = data2[num] - 1;
					}
					while (data2[num++] == 0 && num < big.length);
					if (num == big.length)
					{
						goto IL_00b8;
					}
				}
				do
				{
					data[num] = data2[num];
				}
				while (++num < big.length);
			}
			goto IL_00b8;
			IL_00b8:
			bigInteger.Normalize();
			return bigInteger;
		}

		public static void MinusEq(BigInteger big, BigInteger small)
		{
			uint[] data = big.data;
			uint[] data2 = small.data;
			uint num = 0u;
			uint num2 = 0u;
			do
			{
				uint num3 = data2[num];
				num2 = ((((num3 += num2) < num2) | ((data[num] -= num3) > ~num3)) ? 1u : 0u);
			}
			while (++num < small.length);
			if (num != big.length && num2 == 1)
			{
				do
				{
					data[num]--;
				}
				while (data[num++] == 0 && num < big.length);
			}
			while (big.length != 0 && big.data[big.length - 1] == 0)
			{
				big.length--;
			}
			if (big.length == 0)
			{
				big.length++;
			}
		}

		public static void PlusEq(BigInteger bi1, BigInteger bi2)
		{
			uint num = 0u;
			bool flag = false;
			uint[] data;
			uint length;
			uint[] data2;
			uint length2;
			if (bi1.length < bi2.length)
			{
				flag = true;
				data = bi2.data;
				length = bi2.length;
				data2 = bi1.data;
				length2 = bi1.length;
			}
			else
			{
				data = bi1.data;
				length = bi1.length;
				data2 = bi2.data;
				length2 = bi2.length;
			}
			uint[] data3 = bi1.data;
			ulong num2 = 0uL;
			do
			{
				num2 += (ulong)((long)data[num] + (long)data2[num]);
				data3[num] = (uint)num2;
				num2 >>= 32;
			}
			while (++num < length2);
			bool flag2 = num2 != 0;
			if (flag2)
			{
				if (num < length)
				{
					do
					{
						flag2 = (data3[num] = data[num] + 1) == 0;
					}
					while ((++num < length) & flag2);
				}
				if (flag2)
				{
					data3[num] = 1u;
					num = (bi1.length = num + 1);
					return;
				}
			}
			if (flag && num < length - 1)
			{
				do
				{
					data3[num] = data[num];
				}
				while (++num < length);
			}
			bi1.length = length + 1;
			bi1.Normalize();
		}

		public static Sign Compare(BigInteger bi1, BigInteger bi2)
		{
			uint num = bi1.length;
			uint num2 = bi2.length;
			while (num != 0 && bi1.data[num - 1] == 0)
			{
				num--;
			}
			while (num2 != 0 && bi2.data[num2 - 1] == 0)
			{
				num2--;
			}
			if (num == 0 && num2 == 0)
			{
				return Sign.Zero;
			}
			if (num < num2)
			{
				return Sign.Negative;
			}
			if (num > num2)
			{
				return Sign.Positive;
			}
			uint num3 = num - 1;
			while (num3 != 0 && bi1.data[num3] == bi2.data[num3])
			{
				num3--;
			}
			if (bi1.data[num3] < bi2.data[num3])
			{
				return Sign.Negative;
			}
			if (bi1.data[num3] > bi2.data[num3])
			{
				return Sign.Positive;
			}
			return Sign.Zero;
		}

		public static uint SingleByteDivideInPlace(BigInteger n, uint d)
		{
			ulong num = 0uL;
			uint length = n.length;
			while (length-- != 0)
			{
				num <<= 32;
				num |= n.data[length];
				n.data[length] = (uint)(num / d);
				num %= d;
			}
			n.Normalize();
			return (uint)num;
		}

		public static uint DwordMod(BigInteger n, uint d)
		{
			ulong num = 0uL;
			uint length = n.length;
			while (length-- != 0)
			{
				num <<= 32;
				num |= n.data[length];
				num %= d;
			}
			return (uint)num;
		}

		public static BigInteger[] DwordDivMod(BigInteger n, uint d)
		{
			BigInteger bigInteger = new BigInteger(Sign.Positive, n.length);
			ulong num = 0uL;
			uint length = n.length;
			while (length-- != 0)
			{
				num <<= 32;
				num |= n.data[length];
				bigInteger.data[length] = (uint)(num / d);
				num %= d;
			}
			bigInteger.Normalize();
			BigInteger bigInteger2 = (uint)num;
			return new BigInteger[2] { bigInteger, bigInteger2 };
		}

		public static BigInteger[] multiByteDivide(BigInteger bi1, BigInteger bi2)
		{
			if (Compare(bi1, bi2) == Sign.Negative)
			{
				return new BigInteger[2]
				{
					0,
					new BigInteger(bi1)
				};
			}
			bi1.Normalize();
			bi2.Normalize();
			if (bi2.length == 1)
			{
				return DwordDivMod(bi1, bi2.data[0]);
			}
			uint num = bi1.length + 1;
			int num2 = (int)(bi2.length + 1);
			uint num3 = 2147483648u;
			uint num4 = bi2.data[bi2.length - 1];
			int num5 = 0;
			int num6 = (int)(bi1.length - bi2.length);
			while (num3 != 0 && (num4 & num3) == 0)
			{
				num5++;
				num3 >>= 1;
			}
			BigInteger bigInteger = new BigInteger(Sign.Positive, bi1.length - bi2.length + 1);
			BigInteger bigInteger2 = bi1 << num5;
			uint[] data = bigInteger2.data;
			bi2 <<= num5;
			int num7 = (int)(num - bi2.length);
			int num8 = (int)(num - 1);
			uint num9 = bi2.data[bi2.length - 1];
			ulong num10 = bi2.data[bi2.length - 2];
			while (num7 > 0)
			{
				ulong num11 = ((ulong)data[num8] << 32) + data[num8 - 1];
				ulong num12 = num11 / num9;
				ulong num13 = num11 % num9;
				while (num12 == 4294967296L || num12 * num10 > (num13 << 32) + data[num8 - 2])
				{
					num12--;
					num13 += num9;
					if (num13 >= 4294967296L)
					{
						break;
					}
				}
				uint num14 = 0u;
				int num15 = num8 - num2 + 1;
				ulong num16 = 0uL;
				uint num17 = (uint)num12;
				do
				{
					num16 += (ulong)((long)bi2.data[num14] * (long)num17);
					uint num18 = data[num15];
					data[num15] -= (uint)(int)num16;
					num16 >>= 32;
					if (data[num15] > num18)
					{
						num16++;
					}
					num14++;
					num15++;
				}
				while (num14 < num2);
				num15 = num8 - num2 + 1;
				num14 = 0u;
				if (num16 != 0L)
				{
					num17--;
					ulong num19 = 0uL;
					do
					{
						num19 = (ulong)((long)data[num15] + (long)bi2.data[num14]) + num19;
						data[num15] = (uint)num19;
						num19 >>= 32;
						num14++;
						num15++;
					}
					while (num14 < num2);
				}
				bigInteger.data[num6--] = num17;
				num8--;
				num7--;
			}
			bigInteger.Normalize();
			bigInteger2.Normalize();
			BigInteger[] array = new BigInteger[2] { bigInteger, bigInteger2 };
			if (num5 != 0)
			{
				BigInteger[] array2 = array;
				array2[1] >>= num5;
			}
			return array;
		}

		public static BigInteger LeftShift(BigInteger bi, int n)
		{
			if (n == 0)
			{
				return new BigInteger(bi, bi.length + 1);
			}
			int num = n >> 5;
			n &= 0x1F;
			BigInteger bigInteger = new BigInteger(Sign.Positive, bi.length + 1 + (uint)num);
			uint num2 = 0u;
			uint length = bi.length;
			if (n != 0)
			{
				uint num3 = 0u;
				for (; num2 < length; num2++)
				{
					uint num4 = bi.data[num2];
					bigInteger.data[num2 + num] = (num4 << n) | num3;
					num3 = num4 >> 32 - n;
				}
				bigInteger.data[num2 + num] = num3;
			}
			else
			{
				for (; num2 < length; num2++)
				{
					bigInteger.data[num2 + num] = bi.data[num2];
				}
			}
			bigInteger.Normalize();
			return bigInteger;
		}

		public static BigInteger RightShift(BigInteger bi, int n)
		{
			if (n == 0)
			{
				return new BigInteger(bi);
			}
			int num = n >> 5;
			int num2 = n & 0x1F;
			BigInteger bigInteger = new BigInteger(Sign.Positive, (uint)((int)bi.length - num + 1));
			uint num3 = (uint)(bigInteger.data.Length - 1);
			if (num2 != 0)
			{
				uint num4 = 0u;
				while (num3-- != 0)
				{
					uint num5 = bi.data[num3 + num];
					bigInteger.data[num3] = (num5 >> n) | num4;
					num4 = num5 << 32 - n;
				}
			}
			else
			{
				while (num3-- != 0)
				{
					bigInteger.data[num3] = bi.data[num3 + num];
				}
			}
			bigInteger.Normalize();
			return bigInteger;
		}

		public static BigInteger MultiplyByDword(BigInteger n, uint f)
		{
			BigInteger bigInteger = new BigInteger(Sign.Positive, n.length + 1);
			uint num = 0u;
			ulong num2 = 0uL;
			do
			{
				num2 += (ulong)((long)n.data[num] * (long)f);
				bigInteger.data[num] = (uint)num2;
				num2 >>= 32;
			}
			while (++num < n.length);
			bigInteger.data[num] = (uint)num2;
			bigInteger.Normalize();
			return bigInteger;
		}

		public unsafe static void Multiply(uint[] x, uint xOffset, uint xLen, uint[] y, uint yOffset, uint yLen, uint[] d, uint dOffset)
		{
			fixed (uint* ptr = x)
			{
				fixed (uint* ptr2 = y)
				{
					fixed (uint* ptr3 = d)
					{
						uint* ptr4 = ptr + xOffset;
						uint* ptr5 = ptr4 + xLen;
						uint* ptr6 = ptr2 + yOffset;
						uint* ptr7 = ptr6 + yLen;
						uint* ptr8 = ptr3 + dOffset;
						while (ptr4 < ptr5)
						{
							if (*ptr4 != 0)
							{
								ulong num = 0uL;
								uint* ptr9 = ptr8;
								uint* ptr10 = ptr6;
								while (ptr10 < ptr7)
								{
									num += (ulong)((long)(*ptr4) * (long)(*ptr10) + *ptr9);
									*ptr9 = (uint)num;
									num >>= 32;
									ptr10++;
									ptr9++;
								}
								if (num != 0L)
								{
									*ptr9 = (uint)num;
								}
							}
							ptr4++;
							ptr8++;
						}
					}
				}
			}
		}

		public unsafe static void MultiplyMod2p32pmod(uint[] x, int xOffset, int xLen, uint[] y, int yOffest, int yLen, uint[] d, int dOffset, int mod)
		{
			fixed (uint* ptr = x)
			{
				fixed (uint* ptr2 = y)
				{
					fixed (uint* ptr3 = d)
					{
						uint* ptr4 = ptr + xOffset;
						uint* ptr5 = ptr4 + xLen;
						uint* ptr6 = ptr2 + yOffest;
						uint* ptr7 = ptr6 + yLen;
						uint* ptr8 = ptr3 + dOffset;
						uint* ptr9 = ptr8 + mod;
						while (ptr4 < ptr5)
						{
							if (*ptr4 != 0)
							{
								ulong num = 0uL;
								uint* ptr10 = ptr8;
								uint* ptr11 = ptr6;
								while (ptr11 < ptr7 && ptr10 < ptr9)
								{
									num += (ulong)((long)(*ptr4) * (long)(*ptr11) + *ptr10);
									*ptr10 = (uint)num;
									num >>= 32;
									ptr11++;
									ptr10++;
								}
								if (num != 0L && ptr10 < ptr9)
								{
									*ptr10 = (uint)num;
								}
							}
							ptr4++;
							ptr8++;
						}
					}
				}
			}
		}

		public static uint modInverse(BigInteger bi, uint modulus)
		{
			uint num = modulus;
			uint num2 = bi % modulus;
			uint num3 = 0u;
			uint num4 = 1u;
			while (true)
			{
				switch (num2)
				{
				case 1u:
					return num4;
				default:
					num3 += num / num2 * num4;
					num %= num2;
					switch (num)
					{
					case 1u:
						return modulus - num3;
					default:
						goto IL_002d;
					case 0u:
						break;
					}
					break;
				case 0u:
					break;
				}
				break;
				IL_002d:
				num4 += num2 / num * num3;
				num2 %= num;
			}
			return 0u;
		}

		public static BigInteger modInverse(BigInteger bi, BigInteger modulus)
		{
			if (modulus.length == 1)
			{
				return modInverse(bi, modulus.data[0]);
			}
			BigInteger[] array = new BigInteger[2] { 0, 1 };
			BigInteger[] array2 = new BigInteger[2];
			BigInteger[] array3 = new BigInteger[2] { 0, 0 };
			int num = 0;
			BigInteger bi2 = modulus;
			BigInteger bigInteger = bi;
			ModulusRing modulusRing = new ModulusRing(modulus);
			while (bigInteger != 0u)
			{
				if (num > 1)
				{
					BigInteger bigInteger2 = modulusRing.Difference(array[0], array[1] * array2[0]);
					array[0] = array[1];
					array[1] = bigInteger2;
				}
				BigInteger[] array4 = multiByteDivide(bi2, bigInteger);
				array2[0] = array2[1];
				array2[1] = array4[0];
				array3[0] = array3[1];
				array3[1] = array4[1];
				bi2 = bigInteger;
				bigInteger = array4[1];
				num++;
			}
			if (array3[0] != 1u)
			{
				throw new ArithmeticException("No inverse!");
			}
			return modulusRing.Difference(array[0], array[1] * array2[0]);
		}
	}

	private uint length = 1u;

	private uint[] data;

	internal static readonly uint[] smallPrimes = new uint[783]
	{
		2u, 3u, 5u, 7u, 11u, 13u, 17u, 19u, 23u, 29u,
		31u, 37u, 41u, 43u, 47u, 53u, 59u, 61u, 67u, 71u,
		73u, 79u, 83u, 89u, 97u, 101u, 103u, 107u, 109u, 113u,
		127u, 131u, 137u, 139u, 149u, 151u, 157u, 163u, 167u, 173u,
		179u, 181u, 191u, 193u, 197u, 199u, 211u, 223u, 227u, 229u,
		233u, 239u, 241u, 251u, 257u, 263u, 269u, 271u, 277u, 281u,
		283u, 293u, 307u, 311u, 313u, 317u, 331u, 337u, 347u, 349u,
		353u, 359u, 367u, 373u, 379u, 383u, 389u, 397u, 401u, 409u,
		419u, 421u, 431u, 433u, 439u, 443u, 449u, 457u, 461u, 463u,
		467u, 479u, 487u, 491u, 499u, 503u, 509u, 521u, 523u, 541u,
		547u, 557u, 563u, 569u, 571u, 577u, 587u, 593u, 599u, 601u,
		607u, 613u, 617u, 619u, 631u, 641u, 643u, 647u, 653u, 659u,
		661u, 673u, 677u, 683u, 691u, 701u, 709u, 719u, 727u, 733u,
		739u, 743u, 751u, 757u, 761u, 769u, 773u, 787u, 797u, 809u,
		811u, 821u, 823u, 827u, 829u, 839u, 853u, 857u, 859u, 863u,
		877u, 881u, 883u, 887u, 907u, 911u, 919u, 929u, 937u, 941u,
		947u, 953u, 967u, 971u, 977u, 983u, 991u, 997u, 1009u, 1013u,
		1019u, 1021u, 1031u, 1033u, 1039u, 1049u, 1051u, 1061u, 1063u, 1069u,
		1087u, 1091u, 1093u, 1097u, 1103u, 1109u, 1117u, 1123u, 1129u, 1151u,
		1153u, 1163u, 1171u, 1181u, 1187u, 1193u, 1201u, 1213u, 1217u, 1223u,
		1229u, 1231u, 1237u, 1249u, 1259u, 1277u, 1279u, 1283u, 1289u, 1291u,
		1297u, 1301u, 1303u, 1307u, 1319u, 1321u, 1327u, 1361u, 1367u, 1373u,
		1381u, 1399u, 1409u, 1423u, 1427u, 1429u, 1433u, 1439u, 1447u, 1451u,
		1453u, 1459u, 1471u, 1481u, 1483u, 1487u, 1489u, 1493u, 1499u, 1511u,
		1523u, 1531u, 1543u, 1549u, 1553u, 1559u, 1567u, 1571u, 1579u, 1583u,
		1597u, 1601u, 1607u, 1609u, 1613u, 1619u, 1621u, 1627u, 1637u, 1657u,
		1663u, 1667u, 1669u, 1693u, 1697u, 1699u, 1709u, 1721u, 1723u, 1733u,
		1741u, 1747u, 1753u, 1759u, 1777u, 1783u, 1787u, 1789u, 1801u, 1811u,
		1823u, 1831u, 1847u, 1861u, 1867u, 1871u, 1873u, 1877u, 1879u, 1889u,
		1901u, 1907u, 1913u, 1931u, 1933u, 1949u, 1951u, 1973u, 1979u, 1987u,
		1993u, 1997u, 1999u, 2003u, 2011u, 2017u, 2027u, 2029u, 2039u, 2053u,
		2063u, 2069u, 2081u, 2083u, 2087u, 2089u, 2099u, 2111u, 2113u, 2129u,
		2131u, 2137u, 2141u, 2143u, 2153u, 2161u, 2179u, 2203u, 2207u, 2213u,
		2221u, 2237u, 2239u, 2243u, 2251u, 2267u, 2269u, 2273u, 2281u, 2287u,
		2293u, 2297u, 2309u, 2311u, 2333u, 2339u, 2341u, 2347u, 2351u, 2357u,
		2371u, 2377u, 2381u, 2383u, 2389u, 2393u, 2399u, 2411u, 2417u, 2423u,
		2437u, 2441u, 2447u, 2459u, 2467u, 2473u, 2477u, 2503u, 2521u, 2531u,
		2539u, 2543u, 2549u, 2551u, 2557u, 2579u, 2591u, 2593u, 2609u, 2617u,
		2621u, 2633u, 2647u, 2657u, 2659u, 2663u, 2671u, 2677u, 2683u, 2687u,
		2689u, 2693u, 2699u, 2707u, 2711u, 2713u, 2719u, 2729u, 2731u, 2741u,
		2749u, 2753u, 2767u, 2777u, 2789u, 2791u, 2797u, 2801u, 2803u, 2819u,
		2833u, 2837u, 2843u, 2851u, 2857u, 2861u, 2879u, 2887u, 2897u, 2903u,
		2909u, 2917u, 2927u, 2939u, 2953u, 2957u, 2963u, 2969u, 2971u, 2999u,
		3001u, 3011u, 3019u, 3023u, 3037u, 3041u, 3049u, 3061u, 3067u, 3079u,
		3083u, 3089u, 3109u, 3119u, 3121u, 3137u, 3163u, 3167u, 3169u, 3181u,
		3187u, 3191u, 3203u, 3209u, 3217u, 3221u, 3229u, 3251u, 3253u, 3257u,
		3259u, 3271u, 3299u, 3301u, 3307u, 3313u, 3319u, 3323u, 3329u, 3331u,
		3343u, 3347u, 3359u, 3361u, 3371u, 3373u, 3389u, 3391u, 3407u, 3413u,
		3433u, 3449u, 3457u, 3461u, 3463u, 3467u, 3469u, 3491u, 3499u, 3511u,
		3517u, 3527u, 3529u, 3533u, 3539u, 3541u, 3547u, 3557u, 3559u, 3571u,
		3581u, 3583u, 3593u, 3607u, 3613u, 3617u, 3623u, 3631u, 3637u, 3643u,
		3659u, 3671u, 3673u, 3677u, 3691u, 3697u, 3701u, 3709u, 3719u, 3727u,
		3733u, 3739u, 3761u, 3767u, 3769u, 3779u, 3793u, 3797u, 3803u, 3821u,
		3823u, 3833u, 3847u, 3851u, 3853u, 3863u, 3877u, 3881u, 3889u, 3907u,
		3911u, 3917u, 3919u, 3923u, 3929u, 3931u, 3943u, 3947u, 3967u, 3989u,
		4001u, 4003u, 4007u, 4013u, 4019u, 4021u, 4027u, 4049u, 4051u, 4057u,
		4073u, 4079u, 4091u, 4093u, 4099u, 4111u, 4127u, 4129u, 4133u, 4139u,
		4153u, 4157u, 4159u, 4177u, 4201u, 4211u, 4217u, 4219u, 4229u, 4231u,
		4241u, 4243u, 4253u, 4259u, 4261u, 4271u, 4273u, 4283u, 4289u, 4297u,
		4327u, 4337u, 4339u, 4349u, 4357u, 4363u, 4373u, 4391u, 4397u, 4409u,
		4421u, 4423u, 4441u, 4447u, 4451u, 4457u, 4463u, 4481u, 4483u, 4493u,
		4507u, 4513u, 4517u, 4519u, 4523u, 4547u, 4549u, 4561u, 4567u, 4583u,
		4591u, 4597u, 4603u, 4621u, 4637u, 4639u, 4643u, 4649u, 4651u, 4657u,
		4663u, 4673u, 4679u, 4691u, 4703u, 4721u, 4723u, 4729u, 4733u, 4751u,
		4759u, 4783u, 4787u, 4789u, 4793u, 4799u, 4801u, 4813u, 4817u, 4831u,
		4861u, 4871u, 4877u, 4889u, 4903u, 4909u, 4919u, 4931u, 4933u, 4937u,
		4943u, 4951u, 4957u, 4967u, 4969u, 4973u, 4987u, 4993u, 4999u, 5003u,
		5009u, 5011u, 5021u, 5023u, 5039u, 5051u, 5059u, 5077u, 5081u, 5087u,
		5099u, 5101u, 5107u, 5113u, 5119u, 5147u, 5153u, 5167u, 5171u, 5179u,
		5189u, 5197u, 5209u, 5227u, 5231u, 5233u, 5237u, 5261u, 5273u, 5279u,
		5281u, 5297u, 5303u, 5309u, 5323u, 5333u, 5347u, 5351u, 5381u, 5387u,
		5393u, 5399u, 5407u, 5413u, 5417u, 5419u, 5431u, 5437u, 5441u, 5443u,
		5449u, 5471u, 5477u, 5479u, 5483u, 5501u, 5503u, 5507u, 5519u, 5521u,
		5527u, 5531u, 5557u, 5563u, 5569u, 5573u, 5581u, 5591u, 5623u, 5639u,
		5641u, 5647u, 5651u, 5653u, 5657u, 5659u, 5669u, 5683u, 5689u, 5693u,
		5701u, 5711u, 5717u, 5737u, 5741u, 5743u, 5749u, 5779u, 5783u, 5791u,
		5801u, 5807u, 5813u, 5821u, 5827u, 5839u, 5843u, 5849u, 5851u, 5857u,
		5861u, 5867u, 5869u, 5879u, 5881u, 5897u, 5903u, 5923u, 5927u, 5939u,
		5953u, 5981u, 5987u
	};

	private static RandomNumberGenerator rng;

	private static RandomNumberGenerator Rng
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

	public BigInteger(Sign sign, uint len)
	{
		data = new uint[len];
		length = len;
	}

	public BigInteger(BigInteger bi)
	{
		data = (uint[])bi.data.Clone();
		length = bi.length;
	}

	public BigInteger(BigInteger bi, uint len)
	{
		data = new uint[len];
		for (uint num = 0u; num < bi.length; num++)
		{
			data[num] = bi.data[num];
		}
		length = bi.length;
	}

	public BigInteger(byte[] inData)
	{
		if (inData.Length == 0)
		{
			inData = new byte[1];
		}
		length = (uint)inData.Length >> 2;
		int num = inData.Length & 3;
		if (num != 0)
		{
			length++;
		}
		data = new uint[length];
		int num2 = inData.Length - 1;
		int num3 = 0;
		while (num2 >= 3)
		{
			data[num3] = (uint)((inData[num2 - 3] << 24) | (inData[num2 - 2] << 16) | (inData[num2 - 1] << 8) | inData[num2]);
			num2 -= 4;
			num3++;
		}
		switch (num)
		{
		case 1:
			data[length - 1] = inData[0];
			break;
		case 2:
			data[length - 1] = (uint)((inData[0] << 8) | inData[1]);
			break;
		case 3:
			data[length - 1] = (uint)((inData[0] << 16) | (inData[1] << 8) | inData[2]);
			break;
		}
		Normalize();
	}

	public BigInteger(uint ui)
	{
		data = new uint[1] { ui };
	}

	public static implicit operator BigInteger(uint value)
	{
		return new BigInteger(value);
	}

	public static implicit operator BigInteger(int value)
	{
		if (value < 0)
		{
			throw new ArgumentOutOfRangeException("value");
		}
		return new BigInteger((uint)value);
	}

	public static BigInteger operator -(BigInteger bi1, BigInteger bi2)
	{
		if (bi2 == 0u)
		{
			return new BigInteger(bi1);
		}
		if (bi1 == 0u)
		{
			throw new ArithmeticException("Operation would return a negative value");
		}
		return Kernel.Compare(bi1, bi2) switch
		{
			Sign.Zero => 0, 
			Sign.Positive => Kernel.Subtract(bi1, bi2), 
			Sign.Negative => throw new ArithmeticException("Operation would return a negative value"), 
			_ => throw new Exception(), 
		};
	}

	public static uint operator %(BigInteger bi, uint ui)
	{
		return Kernel.DwordMod(bi, ui);
	}

	public static BigInteger operator %(BigInteger bi1, BigInteger bi2)
	{
		return Kernel.multiByteDivide(bi1, bi2)[1];
	}

	public static BigInteger operator /(BigInteger bi1, BigInteger bi2)
	{
		return Kernel.multiByteDivide(bi1, bi2)[0];
	}

	public static BigInteger operator *(BigInteger bi1, BigInteger bi2)
	{
		if (bi1 == 0u || bi2 == 0u)
		{
			return 0;
		}
		if (bi1.data.Length < bi1.length)
		{
			throw new IndexOutOfRangeException("bi1 out of range");
		}
		if (bi2.data.Length < bi2.length)
		{
			throw new IndexOutOfRangeException("bi2 out of range");
		}
		BigInteger bigInteger = new BigInteger(Sign.Positive, bi1.length + bi2.length);
		Kernel.Multiply(bi1.data, 0u, bi1.length, bi2.data, 0u, bi2.length, bigInteger.data, 0u);
		bigInteger.Normalize();
		return bigInteger;
	}

	public static BigInteger operator *(BigInteger bi, int i)
	{
		if (i < 0)
		{
			throw new ArithmeticException("Operation would return a negative value");
		}
		return i switch
		{
			0 => 0, 
			1 => new BigInteger(bi), 
			_ => Kernel.MultiplyByDword(bi, (uint)i), 
		};
	}

	public static BigInteger operator <<(BigInteger bi1, int shiftVal)
	{
		return Kernel.LeftShift(bi1, shiftVal);
	}

	public static BigInteger operator >>(BigInteger bi1, int shiftVal)
	{
		return Kernel.RightShift(bi1, shiftVal);
	}

	public static BigInteger GenerateRandom(int bits, RandomNumberGenerator rng)
	{
		int num = bits >> 5;
		int num2 = bits & 0x1F;
		if (num2 != 0)
		{
			num++;
		}
		BigInteger bigInteger = new BigInteger(Sign.Positive, (uint)(num + 1));
		byte[] src = new byte[num << 2];
		rng.GetBytes(src);
		Buffer.BlockCopy(src, 0, bigInteger.data, 0, num << 2);
		if (num2 != 0)
		{
			uint num3 = (uint)(1 << num2 - 1);
			bigInteger.data[num - 1] |= num3;
			num3 = uint.MaxValue >> 32 - num2;
			bigInteger.data[num - 1] &= num3;
		}
		else
		{
			bigInteger.data[num - 1] |= 2147483648u;
		}
		bigInteger.Normalize();
		return bigInteger;
	}

	public static BigInteger GenerateRandom(int bits)
	{
		return GenerateRandom(bits, Rng);
	}

	public void Randomize(RandomNumberGenerator rng)
	{
		if (!(this == 0u))
		{
			int num = BitCount();
			int num2 = num >> 5;
			int num3 = num & 0x1F;
			if (num3 != 0)
			{
				num2++;
			}
			byte[] src = new byte[num2 << 2];
			rng.GetBytes(src);
			Buffer.BlockCopy(src, 0, data, 0, num2 << 2);
			if (num3 != 0)
			{
				uint num4 = (uint)(1 << num3 - 1);
				data[num2 - 1] |= num4;
				num4 = uint.MaxValue >> 32 - num3;
				data[num2 - 1] &= num4;
			}
			else
			{
				data[num2 - 1] |= 2147483648u;
			}
			Normalize();
		}
	}

	public void Randomize()
	{
		Randomize(Rng);
	}

	public int BitCount()
	{
		Normalize();
		uint num = data[length - 1];
		uint num2 = 2147483648u;
		uint num3 = 32u;
		while (num3 != 0 && (num & num2) == 0)
		{
			num3--;
			num2 >>= 1;
		}
		return (int)(num3 + (length - 1 << 5));
	}

	public bool TestBit(uint bitNum)
	{
		uint num = bitNum >> 5;
		byte b = (byte)(bitNum & 0x1F);
		uint num2 = (uint)(1 << (int)b);
		return (data[num] & num2) != 0;
	}

	public bool TestBit(int bitNum)
	{
		if (bitNum < 0)
		{
			throw new IndexOutOfRangeException("bitNum out of range");
		}
		uint num = (uint)bitNum >> 5;
		byte b = (byte)(bitNum & 0x1F);
		uint num2 = (uint)(1 << (int)b);
		return (data[num] | num2) == data[num];
	}

	public void SetBit(uint bitNum)
	{
		SetBit(bitNum, value: true);
	}

	public void SetBit(uint bitNum, bool value)
	{
		uint num = bitNum >> 5;
		if (num < length)
		{
			uint num2 = (uint)(1 << (int)(bitNum & 0x1F));
			if (value)
			{
				data[num] |= num2;
			}
			else
			{
				data[num] &= ~num2;
			}
		}
	}

	public int LowestSetBit()
	{
		if (this == 0u)
		{
			return -1;
		}
		int i;
		for (i = 0; !TestBit(i); i++)
		{
		}
		return i;
	}

	public byte[] GetBytes()
	{
		if (this == 0u)
		{
			return new byte[1];
		}
		int num = BitCount();
		int num2 = num >> 3;
		if ((num & 7) != 0)
		{
			num2++;
		}
		byte[] array = new byte[num2];
		int num3 = num2 & 3;
		if (num3 == 0)
		{
			num3 = 4;
		}
		int num4 = 0;
		for (int num5 = (int)(length - 1); num5 >= 0; num5--)
		{
			uint num6 = data[num5];
			for (int num7 = num3 - 1; num7 >= 0; num7--)
			{
				array[num4 + num7] = (byte)(num6 & 0xFF);
				num6 >>= 8;
			}
			num4 += num3;
			num3 = 4;
		}
		return array;
	}

	public static bool operator ==(BigInteger bi1, uint ui)
	{
		if (bi1.length != 1)
		{
			bi1.Normalize();
		}
		if (bi1.length == 1)
		{
			return bi1.data[0] == ui;
		}
		return false;
	}

	public static bool operator !=(BigInteger bi1, uint ui)
	{
		if (bi1.length != 1)
		{
			bi1.Normalize();
		}
		if (bi1.length == 1)
		{
			return bi1.data[0] != ui;
		}
		return true;
	}

	public static bool operator ==(BigInteger bi1, BigInteger bi2)
	{
		if ((object)bi1 == bi2)
		{
			return true;
		}
		if (null == bi1 || null == bi2)
		{
			return false;
		}
		return Kernel.Compare(bi1, bi2) == Sign.Zero;
	}

	public static bool operator !=(BigInteger bi1, BigInteger bi2)
	{
		if ((object)bi1 == bi2)
		{
			return false;
		}
		if (null == bi1 || null == bi2)
		{
			return true;
		}
		return Kernel.Compare(bi1, bi2) != Sign.Zero;
	}

	public static bool operator >(BigInteger bi1, BigInteger bi2)
	{
		return Kernel.Compare(bi1, bi2) > Sign.Zero;
	}

	public static bool operator <(BigInteger bi1, BigInteger bi2)
	{
		return Kernel.Compare(bi1, bi2) < Sign.Zero;
	}

	public static bool operator >=(BigInteger bi1, BigInteger bi2)
	{
		return Kernel.Compare(bi1, bi2) >= Sign.Zero;
	}

	public static bool operator <=(BigInteger bi1, BigInteger bi2)
	{
		return Kernel.Compare(bi1, bi2) <= Sign.Zero;
	}

	public string ToString(uint radix)
	{
		return ToString(radix, "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ");
	}

	public string ToString(uint radix, string characterSet)
	{
		if (characterSet.Length < radix)
		{
			throw new ArgumentException("charSet length less than radix", "characterSet");
		}
		if (radix == 1)
		{
			throw new ArgumentException("There is no such thing as radix one notation", "radix");
		}
		if (this == 0u)
		{
			return "0";
		}
		if (this == 1u)
		{
			return "1";
		}
		string text = "";
		BigInteger bigInteger = new BigInteger(this);
		while (bigInteger != 0u)
		{
			uint index = Kernel.SingleByteDivideInPlace(bigInteger, radix);
			text = characterSet[(int)index] + text;
		}
		return text;
	}

	private void Normalize()
	{
		while (length != 0 && data[length - 1] == 0)
		{
			length--;
		}
		if (length == 0)
		{
			length++;
		}
	}

	public void Clear()
	{
		for (int i = 0; i < length; i++)
		{
			data[i] = 0u;
		}
	}

	public override int GetHashCode()
	{
		uint num = 0u;
		for (uint num2 = 0u; num2 < length; num2++)
		{
			num ^= data[num2];
		}
		return (int)num;
	}

	public override string ToString()
	{
		return ToString(10u);
	}

	public override bool Equals(object o)
	{
		if (o == null)
		{
			return false;
		}
		if (o is int)
		{
			if ((int)o >= 0)
			{
				return this == (uint)o;
			}
			return false;
		}
		BigInteger bigInteger = o as BigInteger;
		if (bigInteger == null)
		{
			return false;
		}
		return Kernel.Compare(this, bigInteger) == Sign.Zero;
	}

	public BigInteger ModInverse(BigInteger modulus)
	{
		return Kernel.modInverse(this, modulus);
	}

	public BigInteger ModPow(BigInteger exp, BigInteger n)
	{
		return new ModulusRing(n).Pow(this, exp);
	}

	public bool IsProbablePrime()
	{
		if (this <= smallPrimes[smallPrimes.Length - 1])
		{
			for (int i = 0; i < smallPrimes.Length; i++)
			{
				if (this == smallPrimes[i])
				{
					return true;
				}
			}
			return false;
		}
		for (int j = 0; j < smallPrimes.Length; j++)
		{
			if (this % smallPrimes[j] == 0)
			{
				return false;
			}
		}
		return PrimalityTests.Test(this, ConfidenceFactor.Medium);
	}

	public static BigInteger GeneratePseudoPrime(int bits)
	{
		return new SequentialSearchPrimeGeneratorBase().GenerateNewPrime(bits);
	}

	public void Incr2()
	{
		int num = 0;
		data[0] += 2u;
		if (data[0] < 2)
		{
			data[++num]++;
			while (data[num++] == 0)
			{
				data[num]++;
			}
			if (length == (uint)num)
			{
				length++;
			}
		}
	}
}
