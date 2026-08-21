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
		public static BigInteger AddSameSign(BigInteger bi1, BigInteger bi2)
		{
			uint num = 0u;
			uint[] data;
			uint length;
			uint[] data2;
			uint length2;
			if (bi1.length < bi2.length)
			{
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
			BigInteger bigInteger = new BigInteger(Sign.Positive, length + 1);
			uint[] data3 = bigInteger.data;
			ulong num2 = 0uL;
			do
			{
				num2 = (ulong)((long)data[num] + (long)data2[num]) + num2;
				data3[num] = (uint)num2;
				num2 >>= 32;
			}
			while (++num < length2);
			bool flag = num2 != 0;
			if (flag)
			{
				if (num < length)
				{
					do
					{
						flag = (data3[num] = data[num] + 1) == 0;
					}
					while ((++num < length) & flag);
				}
				if (flag)
				{
					data3[num] = 1u;
					num = (bigInteger.length = num + 1);
					return bigInteger;
				}
			}
			if (num < length)
			{
				do
				{
					data3[num] = data[num];
				}
				while (++num < length);
			}
			bigInteger.Normalize();
			return bigInteger;
		}

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
		42663935u, 4294967295u, 4294902417u, 4294967295u, 43450367u, 44171931u, 4294967295u, 4294902439u, 4294902446u, 4294967295u,
		4294902453u, 4294967295u, 4294967295u, 46138042u, 46858950u, 47514320u, 48366298u, 49414890u, 50463482u, 51512074u,
		52364058u, 53019428u, 53871406u, 54919998u, 55968590u, 57017182u, 57869166u, 58524536u, 59376514u, 60425106u,
		61473698u, 62522290u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 63111167u,
		4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u,
		4294967295u, 63438847u, 64422866u, 65209311u, 4294967295u, 4294967295u, 70386668u, 4294967295u, 4294967295u, 4294967295u,
		4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u,
		4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u,
		4294967295u, 4294967295u, 75038719u, 4294967295u, 75300863u, 4294902918u, 4294967295u, 4294967295u, 4294967295u, 4294967295u,
		4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u,
		4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u,
		76611583u, 1528497299u, 458842u, 1528496141u, 1881499941u, 996418865u, 624062501u, 453014116u, 6763355u, 457726747u,
		4862555u, 4938523u, 4872987u, 1764055835u, 623996965u, 453003108u, 627647835u, 1680159088u, 846210363u, 4744229u,
		1528496138u, 1528496200u, 1815425599u, 452986880u, 892485467u, 1528496232u, 1528496195u, 1528496193u, 1528496208u, 917581u,
		1832213275u, 828054272u, 1528496237u, 875573567u, 453011513u, 6829147u, 1832409883u, 928717568u, 1528496237u, 453012791u,
		7156827u, 1881496347u, 1482958129u, 452988672u, 1011035u, 826235675u, 1815688240u, 878385920u, 1528496236u, 7157554u,
		875715355u, 1528496237u, 610809151u, 808464700u, 1528512047u, 7091519u, 1881234203u, 859790107u, 460076091u, 460076123u,
		1528496190u, 8323148u, 2117294875u, 1112480512u, 1347361536u, 844831488u, 453017137u, 453005647u, 453005903u, 453006159u,
		2117415259u, 828054272u, 453017143u, 2117611867u, 828054272u, 453017145u, 2117087835u, 1213143808u, 844831488u, 1327169662u,
		1528496196u, 453017142u, 8271195u, 4411163u, 4280091u, 826235675u, 4070252u, 826235675u, 4004712u, 1881496347u,
		1348740401u, 626727680u, 1680159088u, 1528496205u, 623996965u, 453001828u, 829433179u, 4219941u, 1881496347u, 1281631537u,
		626727680u, 1680159088u, 1528496196u, 623996965u, 453002084u, 829433179u, 4285477u, 6904603u, 1765038875u, 895163136u,
		1662713961u, 559618816u, 1062935408u, 1815362355u, 1815370523u, 453000731u, 1528496184u, 1881499941u, 1684284721u, 3611392u,
		1293615114u, 811277056u, 1881489189u, 997467446u, 624633137u, 846210367u, 876311589u, 1059404581u, 623996965u, 2082812784u,
		926643237u, 1059404581u, 624193573u, 624245620u, 624895291u, 1948596080u, 992294971u, 624895341u, 1948596592u, 258286862u,
		452999973u, 589896u, 4542235u, 1633771616u, 1734829670u, 1785358697u, 1819044715u, 1852730733u, 1886416751u, 1920102769u,
		1953788787u, 1987474805u, 2021160823u, 2054846841u, 2088532859u, 2122218877u, 1515920128u, 1062935296u, 453011511u, 1815560027u,
		1109924608u, 3156251u, 4607771u, 5066523u, 993221403u, 453017141u, 4601167u, 1211453211u, 844831488u, 8271163u,
		1144344347u, 911940352u, 8271163u, 993352475u, 453017141u, 4404559u, 858938139u, 1528496254u, 8270898u, 1345474331u,
		844045056u, 1327169617u, 453005874u, 5452367u, 892427035u, 8270395u, 925981467u, 8270395u, 942758683u, 8270395u,
		959535899u, 8270395u, 808606491u, 8270395u, 825383707u, 8270395u, 858938139u, 8270395u, 875715355u, 8270395u,
		1345670939u, 894376704u, 1327169617u, 453005877u, 5453135u, 892427035u, 8271163u, 925981467u, 8271163u, 942758683u,
		8271163u, 959535899u, 8271163u, 808606491u, 8271163u, 825383707u, 8271163u, 858938139u, 8271163u, 875715355u,
		8271163u, 1345736475u, 911153920u, 1327169617u, 453005878u, 5453391u, 892427035u, 8271419u, 925981467u, 8271419u,
		942758683u, 8271419u, 959535899u, 8271419u, 808606491u, 8271419u, 825383707u, 8271419u, 858938139u, 8271419u,
		875715355u, 8271419u, 1261525787u, 626727680u, 996418921u, 5399589u, 1849056027u, 1062935296u, 1664236337u, 1666915072u,
		861608704u, 959724345u, 1528496237u, 624895283u, 2066035056u, 1025867057u, 624194597u, 829433189u, 2100525861u, 1948597541u,
		627385654u, 2066035056u, 1025867060u, 623997989u, 829433189u, 2100722469u, 1948597541u, 627385651u, 1680159088u, 7158565u,
		624188187u, 829433151u, 2100394789u, 1948597541u, 627385652u, 2066035056u, 1025867059u, 624325669u, 829433189u, 2100591397u,
		1948597541u, 627385649u, 2066035056u, 1025867062u, 624129061u, 829433189u, 992306213u, 1528496237u, 1528496205u, 829433139u,
		7169061u, 624188187u, 1680159088u, 1813708909u, 7150336u, 0u, 515396076u, 1080632197u, 2590724273u, 1089573912u,
		2917828982u, 1061334401u, 0u, 1072693248u, 0u, 1076101120u, 0u, 1079574528u, 0u, 1083129856u,
		0u, 1086556160u, 0u, 1090021888u, 0u, 1093567616u, 0u, 1097011920u, 0u, 1100470148u,
		0u, 1104006501u, 536870912u, 1107468383u, 3892314112u, 1110919286u, 2717908992u, 1114446484u, 3846176768u, 1117925532u,
		512753664u, 1121369284u, 640942080u, 1124887541u, 3932194u, 2752574u, 63u, 0u, 2621722u, 1048599u,
		38011261u, 1769172577u, 1936613756u, 1668296553u, 1919251501u, 1868767341u, 1952542829u, 1701601897u, 1953068832u, 1868767336u,
		7499628u, 256u, 0u, 0u, 65792u, 0u, 65536u, 524368u, 4294901784u, 4294967295u,
		4294967295u, 4294967295u, 4294967295u, 589823u, 196672u, 262144u, 4294901766u, 851976u, 1572884u, 4294901788u,
		3670055u, 4294901820u, 4294901824u, 4521983u, 4784127u, 5046271u, 4294901840u, 5570559u, 6226010u, 4294967295u,
		4294967295u, 4294901860u, 7209065u, 7864435u, 8847489u, 4294967295u, 9437183u, 4294901907u, 4294967295u, 4294967295u,
		4294967295u, 9961471u, 10223615u, 4294967295u, 4294967295u, 10354687u, 4294967295u, 4294967295u, 4294967295u, 4294967295u,
		4294967295u, 4294967295u, 4294967295u, 10813601u, 11141119u, 4294967295u, 11403263u, 4294967295u, 11665407u, 4294967295u,
		4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 11927551u, 12255231u, 13369539u, 14549205u,
		15728871u, 16908537u, 4294902027u, 4294967295u, 18153471u, 18743577u, 4294967295u, 4294967295u, 20119551u, 20840447u,
		20971519u, 4294902165u, 4294902168u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294902172u, 4294902235u,
		4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u,
		4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u,
		4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u,
		4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u,
		4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u,
		4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 31457279u,
		4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u,
		4294967295u, 31784959u, 32768495u, 34275847u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u,
		4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u,
		4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u, 4294967295u,
		4294967295u, 4294967295u, 4294967295u, 4294967295u, 34930687u, 4294902302u, 4294967295u, 36438568u, 36962864u, 4294967295u,
		4294967295u, 4294967295u, 4294967295u, 4294967295u, 37289983u, 1528496702u, 458842u, 1528496141u, 453011250u, 1528514651u,
		1528496202u, 1528496203u, 1528496202u, 1881499941u, 1197745457u, 626727680u, 829433193u, 624649253u, 1680159344u, 1528496200u,
		1528496194u, 1528496200u, 1528496196u, 1528496195u, 1528496193u, 1528496208u, 1528496205u, 7156017u, 1832213275u, 828054272u,
		1528496237u, 453012792u, 7157595u, 1832344347u, 878385920u, 1528496237u, 623996965u, 453007460u, 1831874907u, 811277056u,
		1831874875u, 1834687232u, 1834687232u, 1281039104u, 452986880u, 453001819u, 453003355u, 453004379u, 453002331u, 453002075u,
		218120539u, 5462811u, 1881496347u, 1348740401u, 626727680u, 1680159088u, 1528496205u, 623996965u, 453001828u, 829433179u,
		4219941u, 1881496347u, 1399072049u, 626727680u, 1680159088u, 1528496204u, 623996965u, 453002340u, 829433179u, 4416549u,
		1881496347u, 1415849265u, 626727680u, 1680159088u, 1528496193u, 453011764u, 6894939u, 623996965u, 626727779u, 2066035312u,
		757431601u, 6448165u, 1764055835u, 623996965u, 167797860u, 811277056u, 623915323u, 829433151u, 926643237u, 1059404581u,
		624062501u, 624180084u, 624895291u, 1948595056u, 992294715u, 1881489189u, 997467444u, 624633141u, 913319231u, 825979941u,
		1059404581u, 624390181u, 624442228u, 624895291u, 1948596592u, 623980859u, 453012795u, 1528496200u, 271253577u, 405606700u,
		3677362478u, 2975925344u, 4050122854u, 3647647848u, 3664559979u, 3312369773u, 3295706735u, 3295855729u, 3279183731u, 3245782133u,
		3011035767u, 4068143993u, 3632063355u
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

	public static BigInteger operator +(BigInteger bi1, BigInteger bi2)
	{
		if (bi1 == 0u)
		{
			return new BigInteger(bi2);
		}
		if (bi2 == 0u)
		{
			return new BigInteger(bi1);
		}
		return Kernel.AddSameSign(bi1, bi2);
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
