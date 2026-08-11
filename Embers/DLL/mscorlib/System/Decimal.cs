using System.Globalization;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System;

[Serializable]
[StructLayout(LayoutKind.Explicit)]
public readonly struct Decimal : IFormattable, IComparable, IConvertible, IComparable<decimal>, IEquatable<decimal>, IDeserializationCallback, ISpanFormattable
{
	[StructLayout(LayoutKind.Explicit)]
	private struct DecCalc
	{
		internal enum RoundingMode
		{
			ToEven,
			AwayFromZero,
			Truncate,
			Floor,
			Ceiling
		}

		private struct PowerOvfl(uint hi, uint mid, uint lo)
		{
			public readonly uint Hi = hi;

			public readonly ulong MidLo = ((ulong)mid << 32) + lo;
		}

		[StructLayout(LayoutKind.Explicit)]
		private struct Buf12
		{
			[FieldOffset(0)]
			public uint U0;

			[FieldOffset(4)]
			public uint U1;

			[FieldOffset(8)]
			public uint U2;

			[FieldOffset(0)]
			private ulong ulo64LE;

			[FieldOffset(4)]
			private ulong uhigh64LE;

			public ulong Low64
			{
				get
				{
					if (!BitConverter.IsLittleEndian)
					{
						return ((ulong)U1 << 32) | U0;
					}
					return ulo64LE;
				}
				set
				{
					if (BitConverter.IsLittleEndian)
					{
						ulo64LE = value;
						return;
					}
					U1 = (uint)(value >> 32);
					U0 = (uint)value;
				}
			}

			public ulong High64
			{
				get
				{
					if (!BitConverter.IsLittleEndian)
					{
						return ((ulong)U2 << 32) | U1;
					}
					return uhigh64LE;
				}
				set
				{
					if (BitConverter.IsLittleEndian)
					{
						uhigh64LE = value;
						return;
					}
					U2 = (uint)(value >> 32);
					U1 = (uint)value;
				}
			}
		}

		[StructLayout(LayoutKind.Explicit)]
		private struct Buf16
		{
			[FieldOffset(0)]
			public uint U0;

			[FieldOffset(4)]
			public uint U1;

			[FieldOffset(8)]
			public uint U2;

			[FieldOffset(12)]
			public uint U3;

			[FieldOffset(0)]
			private ulong ulo64LE;

			[FieldOffset(8)]
			private ulong uhigh64LE;

			public ulong Low64
			{
				get
				{
					if (!BitConverter.IsLittleEndian)
					{
						return ((ulong)U1 << 32) | U0;
					}
					return ulo64LE;
				}
				set
				{
					if (BitConverter.IsLittleEndian)
					{
						ulo64LE = value;
						return;
					}
					U1 = (uint)(value >> 32);
					U0 = (uint)value;
				}
			}

			public ulong High64
			{
				get
				{
					if (!BitConverter.IsLittleEndian)
					{
						return ((ulong)U3 << 32) | U2;
					}
					return uhigh64LE;
				}
				set
				{
					if (BitConverter.IsLittleEndian)
					{
						uhigh64LE = value;
						return;
					}
					U3 = (uint)(value >> 32);
					U2 = (uint)value;
				}
			}
		}

		[StructLayout(LayoutKind.Explicit)]
		private struct Buf24
		{
			[FieldOffset(0)]
			public uint U0;

			[FieldOffset(4)]
			public uint U1;

			[FieldOffset(8)]
			public uint U2;

			[FieldOffset(12)]
			public uint U3;

			[FieldOffset(16)]
			public uint U4;

			[FieldOffset(20)]
			public uint U5;

			[FieldOffset(0)]
			private ulong ulo64LE;

			[FieldOffset(8)]
			private ulong umid64LE;

			[FieldOffset(16)]
			private ulong uhigh64LE;

			public ulong Low64
			{
				get
				{
					if (!BitConverter.IsLittleEndian)
					{
						return ((ulong)U1 << 32) | U0;
					}
					return ulo64LE;
				}
				set
				{
					if (BitConverter.IsLittleEndian)
					{
						ulo64LE = value;
						return;
					}
					U1 = (uint)(value >> 32);
					U0 = (uint)value;
				}
			}

			public ulong Mid64
			{
				set
				{
					if (BitConverter.IsLittleEndian)
					{
						umid64LE = value;
						return;
					}
					U3 = (uint)(value >> 32);
					U2 = (uint)value;
				}
			}

			public ulong High64
			{
				set
				{
					if (BitConverter.IsLittleEndian)
					{
						uhigh64LE = value;
						return;
					}
					U5 = (uint)(value >> 32);
					U4 = (uint)value;
				}
			}
		}

		private struct Buf28
		{
			public Buf24 Buf24;

			public uint U6;
		}

		[FieldOffset(0)]
		private uint uflags;

		[FieldOffset(4)]
		private uint uhi;

		[FieldOffset(8)]
		private uint ulo;

		[FieldOffset(12)]
		private uint umid;

		[FieldOffset(8)]
		private ulong ulomidLE;

		private static readonly uint[] s_powers10 = new uint[10] { 1u, 10u, 100u, 1000u, 10000u, 100000u, 1000000u, 10000000u, 100000000u, 1000000000u };

		private static readonly ulong[] s_ulongPowers10 = new ulong[19]
		{
			10uL, 100uL, 1000uL, 10000uL, 100000uL, 1000000uL, 10000000uL, 100000000uL, 1000000000uL, 10000000000uL,
			100000000000uL, 1000000000000uL, 10000000000000uL, 100000000000000uL, 1000000000000000uL, 10000000000000000uL, 100000000000000000uL, 1000000000000000000uL, 10000000000000000000uL
		};

		private static readonly double[] s_doublePowers10 = new double[81]
		{
			1.0, 10.0, 100.0, 1000.0, 10000.0, 100000.0, 1000000.0, 10000000.0, 100000000.0, 1000000000.0,
			10000000000.0, 100000000000.0, 1000000000000.0, 10000000000000.0, 100000000000000.0, 1000000000000000.0, 10000000000000000.0, 1E+17, 1E+18, 1E+19,
			1E+20, 1E+21, 1E+22, 1E+23, 1E+24, 1E+25, 1E+26, 1E+27, 1E+28, 1E+29,
			1E+30, 1E+31, 1E+32, 1E+33, 1E+34, 1E+35, 1E+36, 1E+37, 1E+38, 1E+39,
			1E+40, 1E+41, 1E+42, 1E+43, 1E+44, 1E+45, 1E+46, 1E+47, 1E+48, 1E+49,
			1E+50, 1E+51, 1E+52, 1E+53, 1E+54, 1E+55, 1E+56, 1E+57, 1E+58, 1E+59,
			1E+60, 1E+61, 1E+62, 1E+63, 1E+64, 1E+65, 1E+66, 1E+67, 1E+68, 1E+69,
			1E+70, 1E+71, 1E+72, 1E+73, 1E+74, 1E+75, 1E+76, 1E+77, 1E+78, 1E+79,
			1E+80
		};

		private static readonly PowerOvfl[] PowerOvflValues = new PowerOvfl[8]
		{
			new PowerOvfl(429496729u, 2576980377u, 2576980377u),
			new PowerOvfl(42949672u, 4123168604u, 687194767u),
			new PowerOvfl(4294967u, 1271310319u, 2645699854u),
			new PowerOvfl(429496u, 3133608139u, 694066715u),
			new PowerOvfl(42949u, 2890341191u, 2216890319u),
			new PowerOvfl(4294u, 4154504685u, 2369172679u),
			new PowerOvfl(429u, 2133437386u, 4102387834u),
			new PowerOvfl(42u, 4078814305u, 410238783u)
		};

		private uint High
		{
			get
			{
				return uhi;
			}
			set
			{
				uhi = value;
			}
		}

		private uint Low
		{
			get
			{
				return ulo;
			}
			set
			{
				ulo = value;
			}
		}

		private uint Mid
		{
			get
			{
				return umid;
			}
			set
			{
				umid = value;
			}
		}

		private bool IsNegative => (int)uflags < 0;

		private int Scale => (byte)(uflags >> 16);

		private ulong Low64
		{
			get
			{
				if (!BitConverter.IsLittleEndian)
				{
					return ((ulong)umid << 32) | ulo;
				}
				return ulomidLE;
			}
			set
			{
				if (BitConverter.IsLittleEndian)
				{
					ulomidLE = value;
					return;
				}
				umid = (uint)(value >> 32);
				ulo = (uint)value;
			}
		}

		private unsafe static uint GetExponent(float f)
		{
			return (byte)(*(uint*)(&f) >> 23);
		}

		private unsafe static uint GetExponent(double d)
		{
			return (uint)((int)(*(long*)(&d) >>> 52) & 0x7FF);
		}

		private static ulong UInt32x32To64(uint a, uint b)
		{
			return (ulong)a * (ulong)b;
		}

		private static void UInt64x64To128(ulong a, ulong b, ref DecCalc result)
		{
			ulong num = UInt32x32To64((uint)a, (uint)b);
			ulong num2 = UInt32x32To64((uint)a, (uint)(b >> 32));
			ulong num3 = UInt32x32To64((uint)(a >> 32), (uint)(b >> 32));
			num3 += num2 >> 32;
			num += (num2 <<= 32);
			if (num < num2)
			{
				num3++;
			}
			num2 = UInt32x32To64((uint)(a >> 32), (uint)b);
			num3 += num2 >> 32;
			num += (num2 <<= 32);
			if (num < num2)
			{
				num3++;
			}
			if (num3 > uint.MaxValue)
			{
				throw new OverflowException("Value was either too large or too small for a Decimal.");
			}
			result.Low64 = num;
			result.High = (uint)num3;
		}

		private static uint Div96By32(ref Buf12 bufNum, uint den)
		{
			ulong high;
			ulong num;
			if (bufNum.U2 != 0)
			{
				high = bufNum.High64;
				num = (bufNum.High64 = high / den);
				high = (high - (uint)((int)num * (int)den) << 32) | bufNum.U0;
				if (high == 0L)
				{
					return 0u;
				}
				return (uint)(int)high - (bufNum.U0 = (uint)(high / den)) * den;
			}
			high = bufNum.Low64;
			if (high == 0L)
			{
				return 0u;
			}
			num = (bufNum.Low64 = high / den);
			return (uint)(high - num * den);
		}

		[MethodImpl((MethodImplOptions)256)]
		private static bool Div96ByConst(ref ulong high64, ref uint low, uint pow)
		{
			ulong num = high64 / pow;
			uint num2 = (uint)(((high64 - num * pow << 32) + low) / pow);
			if (low == num2 * pow)
			{
				high64 = num;
				low = num2;
				return true;
			}
			return false;
		}

		[MethodImpl((MethodImplOptions)256)]
		private static void Unscale(ref uint low, ref ulong high64, ref int scale)
		{
			while ((byte)low == 0 && scale >= 8 && Div96ByConst(ref high64, ref low, 100000000u))
			{
				scale -= 8;
			}
			if ((low & 0xF) == 0 && scale >= 4 && Div96ByConst(ref high64, ref low, 10000u))
			{
				scale -= 4;
			}
			if ((low & 3) == 0 && scale >= 2 && Div96ByConst(ref high64, ref low, 100u))
			{
				scale -= 2;
			}
			if ((low & 1) == 0 && scale >= 1 && Div96ByConst(ref high64, ref low, 10u))
			{
				scale--;
			}
		}

		private static uint Div96By64(ref Buf12 bufNum, ulong den)
		{
			uint u = bufNum.U2;
			uint num;
			ulong low;
			if (u == 0)
			{
				low = bufNum.Low64;
				if (low < den)
				{
					return 0u;
				}
				num = (uint)(low / den);
				low -= num * den;
				bufNum.Low64 = low;
				return num;
			}
			uint num2 = (uint)(den >> 32);
			if (u >= num2)
			{
				low = bufNum.Low64;
				low -= den << 32;
				num = 0u;
				do
				{
					num--;
					low += den;
				}
				while (low >= den);
				bufNum.Low64 = low;
				return num;
			}
			ulong high = bufNum.High64;
			if (high < num2)
			{
				return 0u;
			}
			num = (uint)(high / num2);
			low = bufNum.U0 | (high - num * num2 << 32);
			ulong num3 = UInt32x32To64(num, (uint)den);
			low -= num3;
			if (low > ~num3)
			{
				do
				{
					num--;
					low += den;
				}
				while (low >= den);
			}
			bufNum.Low64 = low;
			return num;
		}

		private static uint Div128By96(ref Buf16 bufNum, ref Buf12 bufDen)
		{
			ulong high = bufNum.High64;
			uint u = bufDen.U2;
			if (high < u)
			{
				return 0u;
			}
			uint num = (uint)(high / u);
			uint num2 = (uint)(int)high - num * u;
			ulong num3 = UInt32x32To64(num, bufDen.U0);
			ulong num4 = UInt32x32To64(num, bufDen.U1);
			num4 += num3 >> 32;
			num3 = (uint)num3 | (num4 << 32);
			num4 >>= 32;
			ulong low = bufNum.Low64;
			low -= num3;
			num2 -= (uint)(int)num4;
			if (low > ~num3)
			{
				num2--;
				if (num2 >= (uint)(~num4))
				{
					goto IL_008b;
				}
			}
			else if (num2 > (uint)(~num4))
			{
				goto IL_008b;
			}
			goto IL_00b4;
			IL_008b:
			num3 = bufDen.Low64;
			do
			{
				num--;
				low += num3;
				num2 += u;
			}
			while ((low >= num3 || num2++ >= u) && num2 >= u);
			goto IL_00b4;
			IL_00b4:
			bufNum.Low64 = low;
			bufNum.U2 = num2;
			return num;
		}

		private static uint IncreaseScale(ref Buf12 bufNum, uint power)
		{
			ulong num = UInt32x32To64(bufNum.U0, power);
			bufNum.U0 = (uint)num;
			num >>= 32;
			num += UInt32x32To64(bufNum.U1, power);
			bufNum.U1 = (uint)num;
			num >>= 32;
			num += UInt32x32To64(bufNum.U2, power);
			bufNum.U2 = (uint)num;
			return (uint)(num >> 32);
		}

		private static void IncreaseScale64(ref Buf12 bufNum, uint power)
		{
			ulong num = UInt32x32To64(bufNum.U0, power);
			bufNum.U0 = (uint)num;
			num >>= 32;
			num += UInt32x32To64(bufNum.U1, power);
			bufNum.High64 = num;
		}

		private unsafe static int ScaleResult(Buf24* bufRes, uint hiRes, int scale)
		{
			int num = 0;
			if (hiRes > 2)
			{
				num = (int)(hiRes * 32 - 64 - 1);
				num -= LeadingZeroCount(((uint*)bufRes)[hiRes]);
				num = (num * 77 >> 8) + 1;
				if (num > scale)
				{
					goto IL_01cc;
				}
			}
			if (num < scale - 28)
			{
				num = scale - 28;
			}
			if (num == 0)
			{
				goto IL_01ca;
			}
			scale -= num;
			uint num2 = 0u;
			uint remainder = 0u;
			while (true)
			{
				num2 |= remainder;
				uint num3 = num switch
				{
					1 => DivByConst((uint*)bufRes, hiRes, out var quotient, out remainder, 10u), 
					2 => DivByConst((uint*)bufRes, hiRes, out quotient, out remainder, 100u), 
					3 => DivByConst((uint*)bufRes, hiRes, out quotient, out remainder, 1000u), 
					4 => DivByConst((uint*)bufRes, hiRes, out quotient, out remainder, 10000u), 
					5 => DivByConst((uint*)bufRes, hiRes, out quotient, out remainder, 100000u), 
					6 => DivByConst((uint*)bufRes, hiRes, out quotient, out remainder, 1000000u), 
					7 => DivByConst((uint*)bufRes, hiRes, out quotient, out remainder, 10000000u), 
					8 => DivByConst((uint*)bufRes, hiRes, out quotient, out remainder, 100000000u), 
					_ => DivByConst((uint*)bufRes, hiRes, out quotient, out remainder, 1000000000u), 
				};
				((int*)bufRes)[hiRes] = (int)quotient;
				if (quotient == 0 && hiRes != 0)
				{
					hiRes--;
				}
				num -= 9;
				if (num > 0)
				{
					continue;
				}
				if (hiRes > 2)
				{
					if (scale == 0)
					{
						break;
					}
					num = 1;
					scale--;
					continue;
				}
				num3 >>= 1;
				if (num3 <= remainder && (num3 < remainder || ((*(uint*)bufRes & 1) | num2) != 0) && ++(*(int*)bufRes) == 0)
				{
					uint num4 = 0u;
					while (++((int*)bufRes)[++num4] == 0)
					{
					}
					if (num4 > 2)
					{
						if (scale == 0)
						{
							break;
						}
						hiRes = num4;
						num2 = 0u;
						remainder = 0u;
						num = 1;
						scale--;
						continue;
					}
				}
				goto IL_01ca;
			}
			goto IL_01cc;
			IL_01cc:
			throw new OverflowException("Value was either too large or too small for a Decimal.");
			IL_01ca:
			return scale;
		}

		[MethodImpl((MethodImplOptions)256)]
		private unsafe static uint DivByConst(uint* result, uint hiRes, out uint quotient, out uint remainder, uint power)
		{
			uint num = result[hiRes];
			remainder = num - (quotient = num / power) * power;
			uint num2 = hiRes - 1;
			while ((int)num2 >= 0)
			{
				ulong num3 = result[num2] + ((ulong)remainder << 32);
				remainder = (uint)(int)num3 - (result[num2] = (uint)(num3 / power)) * power;
				num2--;
			}
			return power;
		}

		[MethodImpl((MethodImplOptions)256)]
		private static int LeadingZeroCount(uint value)
		{
			int num = 1;
			if ((value & 0xFFFF0000u) == 0)
			{
				value <<= 16;
				num += 16;
			}
			if ((value & 0xFF000000u) == 0)
			{
				value <<= 8;
				num += 8;
			}
			if ((value & 0xF0000000u) == 0)
			{
				value <<= 4;
				num += 4;
			}
			if ((value & 0xC0000000u) == 0)
			{
				value <<= 2;
				num += 2;
			}
			return num + ((int)value >> 31);
		}

		private static int OverflowUnscale(ref Buf12 bufQuo, int scale, bool sticky)
		{
			if (--scale < 0)
			{
				throw new OverflowException("Value was either too large or too small for a Decimal.");
			}
			bufQuo.U2 = 429496729u;
			long num = 25769803776L + (long)bufQuo.U1;
			long num2 = (num - (bufQuo.U1 = (uint)((ulong)num / 10uL)) * 10 << 32) + bufQuo.U0;
			uint num3 = (uint)(num2 - (bufQuo.U0 = (uint)((ulong)num2 / 10uL)) * 10);
			if (num3 > 5 || (num3 == 5 && (sticky || (bufQuo.U0 & 1) != 0)))
			{
				Add32To96(ref bufQuo, 1u);
			}
			return scale;
		}

		private static int SearchScale(ref Buf12 bufQuo, int scale)
		{
			uint u = bufQuo.U2;
			ulong low = bufQuo.Low64;
			int num = 0;
			if (u <= 429496729)
			{
				PowerOvfl[] powerOvflValues = PowerOvflValues;
				if (scale > 19)
				{
					num = 28 - scale;
					if (u < powerOvflValues[num - 1].Hi)
					{
						goto IL_00d1;
					}
				}
				else if (u < 4 || (u == 4 && low <= 5441186219426131129L))
				{
					return 9;
				}
				if (u > 42949)
				{
					if (u > 4294967)
					{
						num = 2;
						if (u > 42949672)
						{
							num--;
						}
					}
					else
					{
						num = 4;
						if (u > 429496)
						{
							num--;
						}
					}
				}
				else if (u > 429)
				{
					num = 6;
					if (u > 4294)
					{
						num--;
					}
				}
				else
				{
					num = 8;
					if (u > 42)
					{
						num--;
					}
				}
				if (u == powerOvflValues[num - 1].Hi && low > powerOvflValues[num - 1].MidLo)
				{
					num--;
				}
			}
			goto IL_00d1;
			IL_00d1:
			if (num + scale < 0)
			{
				throw new OverflowException("Value was either too large or too small for a Decimal.");
			}
			return num;
		}

		private static bool Add32To96(ref Buf12 bufNum, uint value)
		{
			if ((bufNum.Low64 += value) < value && ++bufNum.U2 == 0)
			{
				return false;
			}
			return true;
		}

		internal unsafe static void DecAddSub(ref DecCalc d1, ref DecCalc d2, bool sign)
		{
			ulong num = d1.Low64;
			uint num2 = d1.High;
			uint num3 = d1.uflags;
			uint num4 = d2.uflags;
			uint num5 = num4 ^ num3;
			sign ^= (num5 & 0x80000000u) != 0;
			int num7;
			if ((num5 & 0xFF0000) != 0)
			{
				uint num6 = num3;
				num3 = (num4 & 0xFF0000) | (num3 & 0x80000000u);
				num7 = (int)(num3 - num6) >> 16;
				if (num7 < 0)
				{
					num7 = -num7;
					num3 = num6;
					if (sign)
					{
						num3 ^= 0x80000000u;
					}
					num = d2.Low64;
					num2 = d2.High;
					d2 = d1;
				}
				if (num2 != 0)
				{
					goto IL_015f;
				}
				if (num > uint.MaxValue)
				{
					goto IL_0106;
				}
				if ((int)num == 0)
				{
					uint num8 = num3 & 0x80000000u;
					if (sign)
					{
						num8 ^= 0x80000000u;
					}
					d1 = d2;
					d1.uflags = (d2.uflags & 0xFF0000) | num8;
					return;
				}
				while (num7 > 9)
				{
					num7 -= 9;
					num = UInt32x32To64((uint)num, 1000000000u);
					if (num <= uint.MaxValue)
					{
						continue;
					}
					goto IL_0106;
				}
				num = UInt32x32To64((uint)num, s_powers10[num7]);
			}
			goto IL_0441;
			IL_0106:
			ulong num10;
			while (true)
			{
				uint b = 1000000000u;
				if (num7 < 9)
				{
					b = s_powers10[num7];
				}
				ulong num9 = UInt32x32To64((uint)num, b);
				num10 = UInt32x32To64((uint)(num >> 32), b) + (num9 >> 32);
				num = (uint)num9 + (num10 << 32);
				num2 = (uint)(num10 >> 32);
				if ((num7 -= 9) <= 0)
				{
					break;
				}
				if (num2 == 0)
				{
					continue;
				}
				goto IL_015f;
			}
			goto IL_0441;
			IL_0441:
			ulong num11 = num;
			uint num12 = num2;
			if (sign)
			{
				num = num11 - d2.Low64;
				num2 = num12 - d2.High;
				if (num > num11)
				{
					num2--;
					if (num2 >= num12)
					{
						goto IL_0390;
					}
				}
				else if (num2 > num12)
				{
					goto IL_0390;
				}
			}
			else
			{
				num = num11 + d2.Low64;
				num2 = num12 + d2.High;
				if (num < num11)
				{
					num2++;
					if (num2 <= num12)
					{
						goto IL_03ad;
					}
				}
				else if (num2 < num12)
				{
					goto IL_03ad;
				}
			}
			goto IL_04aa;
			IL_015f:
			while (true)
			{
				uint b = 1000000000u;
				if (num7 < 9)
				{
					b = s_powers10[num7];
				}
				ulong num9 = UInt32x32To64((uint)num, b);
				num10 = UInt32x32To64((uint)(num >> 32), b) + (num9 >> 32);
				num = (uint)num9 + (num10 << 32);
				num10 >>= 32;
				num10 += UInt32x32To64(num2, b);
				num7 -= 9;
				if (num10 > uint.MaxValue)
				{
					break;
				}
				num2 = (uint)num10;
				if (num7 > 0)
				{
					continue;
				}
				goto IL_0441;
			}
			Buf24 buf = default(Buf24);
			_ = ref buf;
			buf.Low64 = num;
			buf.Mid64 = num10;
			uint num13 = 3u;
			while (num7 > 0)
			{
				uint b = 1000000000u;
				if (num7 < 9)
				{
					b = s_powers10[num7];
				}
				num10 = 0uL;
				uint* ptr = (uint*)(&buf);
				uint num14 = 0u;
				do
				{
					num10 += UInt32x32To64(ptr[num14], b);
					ptr[num14] = (uint)num10;
					num14++;
					num10 >>= 32;
				}
				while (num14 <= num13);
				if ((uint)num10 != 0)
				{
					ptr[++num13] = (uint)num10;
				}
				num7 -= 9;
			}
			num10 = buf.Low64;
			num = d2.Low64;
			uint u = buf.U2;
			num2 = d2.High;
			if (sign)
			{
				num = num10 - num;
				num2 = u - num2;
				if (num > num10)
				{
					num2--;
					if (num2 >= u)
					{
						goto IL_02af;
					}
				}
				else if (num2 > u)
				{
					goto IL_02af;
				}
			}
			else
			{
				num += num10;
				num2 += u;
				if (num < num10)
				{
					num2++;
					if (num2 <= u)
					{
						goto IL_030e;
					}
				}
				else if (num2 < u)
				{
					goto IL_030e;
				}
			}
			goto IL_034c;
			IL_030e:
			uint* ptr2 = (uint*)(&buf);
			uint num15 = 3u;
			while (++ptr2[num15++] == 0)
			{
				if (num13 < num15)
				{
					ptr2[num15] = 1u;
					num13 = num15;
					break;
				}
			}
			goto IL_034c;
			IL_034c:
			buf.Low64 = num;
			buf.U2 = num2;
			num7 = ScaleResult(&buf, num13, (byte)(num3 >> 16));
			num3 = (num3 & 0xFF00FFFFu) | (uint)(num7 << 16);
			num = buf.Low64;
			num2 = buf.U2;
			goto IL_04aa;
			IL_0390:
			num3 ^= 0x80000000u;
			num2 = ~num2;
			num = 0L - num;
			if (num == 0L)
			{
				num2++;
			}
			goto IL_04aa;
			IL_04aa:
			d1.uflags = num3;
			d1.High = num2;
			d1.Low64 = num;
			return;
			IL_02af:
			uint* ptr3 = (uint*)(&buf);
			uint num16 = 3u;
			while (ptr3[num16++]-- == 0)
			{
			}
			if (ptr3[num13] != 0 || --num13 > 2)
			{
				goto IL_034c;
			}
			goto IL_04aa;
			IL_03ad:
			if ((num3 & 0xFF0000) == 0)
			{
				throw new OverflowException("Value was either too large or too small for a Decimal.");
			}
			num3 -= 65536;
			long num17 = (long)num2 + 4294967296L;
			num2 = (uint)((ulong)num17 / 10uL);
			long num18 = (num17 - num2 * 10 << 32) + (long)(num >> 32);
			uint num19 = (uint)((ulong)num18 / 10uL);
			long num20 = (num18 - num19 * 10 << 32) + (uint)num;
			num = num19;
			num <<= 32;
			num19 = (uint)((ulong)num20 / 10uL);
			num += num19;
			num19 = (uint)(int)num20 - num19 * 10;
			if (num19 >= 5 && (num19 > 5 || (num & 1) != 0L) && ++num == 0L)
			{
				num2++;
			}
			goto IL_04aa;
		}

		internal static long VarCyFromDec(ref DecCalc pdecIn)
		{
			int num = pdecIn.Scale - 4;
			long num4;
			if (num < 0)
			{
				if (pdecIn.High == 0)
				{
					uint a = s_powers10[-num];
					ulong num2 = UInt32x32To64(a, pdecIn.Mid);
					if (num2 <= uint.MaxValue)
					{
						ulong num3 = UInt32x32To64(a, pdecIn.Low);
						num3 += (num2 <<= 32);
						if (num3 >= num2)
						{
							num4 = (long)num3;
							goto IL_006d;
						}
					}
				}
			}
			else
			{
				if (num != 0)
				{
					InternalRound(ref pdecIn, (uint)num, RoundingMode.ToEven);
				}
				if (pdecIn.High == 0)
				{
					num4 = (long)pdecIn.Low64;
					goto IL_006d;
				}
			}
			goto IL_0093;
			IL_0093:
			throw new OverflowException("Value was either too large or too small for a Currency.");
			IL_006d:
			if (num4 >= 0 || (num4 == long.MinValue && pdecIn.IsNegative))
			{
				if (pdecIn.IsNegative)
				{
					num4 = -num4;
				}
				return num4;
			}
			goto IL_0093;
		}

		internal static int VarDecCmp(in decimal d1, in decimal d2)
		{
			if ((d2.Low | d2.Mid | d2.High) == 0)
			{
				if ((d1.Low | d1.Mid | d1.High) == 0)
				{
					return 0;
				}
				return (d1.flags >> 31) | 1;
			}
			if ((d1.Low | d1.Mid | d1.High) == 0)
			{
				return -((d2.flags >> 31) | 1);
			}
			int num = (d1.flags >> 31) - (d2.flags >> 31);
			if (num != 0)
			{
				return num;
			}
			return VarDecCmpSub(in d1, in d2);
		}

		private static int VarDecCmpSub(in decimal d1, in decimal d2)
		{
			int flags = d2.flags;
			int num = (flags >> 31) | 1;
			int num2 = flags - d1.flags;
			ulong num3 = d1.Low64;
			uint num4 = d1.High;
			ulong num5 = d2.Low64;
			uint num6 = d2.High;
			if (num2 != 0)
			{
				num2 >>= 16;
				if (num2 < 0)
				{
					num2 = -num2;
					num = -num;
					ulong num7 = num3;
					num3 = num5;
					num5 = num7;
					uint num8 = num4;
					num4 = num6;
					num6 = num8;
				}
				do
				{
					uint b = ((num2 >= 9) ? 1000000000u : s_powers10[num2]);
					ulong num9 = UInt32x32To64((uint)num3, b);
					ulong num10 = UInt32x32To64((uint)(num3 >> 32), b) + (num9 >> 32);
					num3 = (uint)num9 + (num10 << 32);
					num10 >>= 32;
					num10 += UInt32x32To64(num4, b);
					if (num10 > uint.MaxValue)
					{
						return num;
					}
					num4 = (uint)num10;
				}
				while ((num2 -= 9) > 0);
			}
			uint num11 = num4 - num6;
			if (num11 != 0)
			{
				if (num11 > num4)
				{
					num = -num;
				}
				return num;
			}
			ulong num12 = num3 - num5;
			if (num12 == 0L)
			{
				num = 0;
			}
			else if (num12 > num3)
			{
				num = -num;
			}
			return num;
		}

		internal unsafe static void VarDecMul(ref DecCalc d1, ref DecCalc d2)
		{
			int num = (byte)(d1.uflags + d2.uflags >> 16);
			Buf24 buf = default(Buf24);
			_ = ref buf;
			uint num6;
			if ((d1.High | d1.Mid) == 0)
			{
				ulong num4;
				if ((d2.High | d2.Mid) == 0)
				{
					ulong num2 = UInt32x32To64(d1.Low, d2.Low);
					if (num > 28)
					{
						if (num > 47)
						{
							goto IL_03cd;
						}
						num -= 29;
						ulong num3 = s_ulongPowers10[num];
						num4 = num2 / num3;
						ulong num5 = num2 - num4 * num3;
						num2 = num4;
						num3 >>= 1;
						if (num5 >= num3 && (num5 > num3 || ((int)num2 & 1) != 0))
						{
							num2++;
						}
						num = 28;
					}
					d1.Low64 = num2;
					d1.uflags = ((d2.uflags ^ d1.uflags) & 0x80000000u) | (uint)(num << 16);
					return;
				}
				num4 = UInt32x32To64(d1.Low, d2.Low);
				buf.U0 = (uint)num4;
				num4 = UInt32x32To64(d1.Low, d2.Mid) + (num4 >> 32);
				buf.U1 = (uint)num4;
				num4 >>= 32;
				if (d2.High != 0)
				{
					num4 += UInt32x32To64(d1.Low, d2.High);
					if (num4 > uint.MaxValue)
					{
						buf.Mid64 = num4;
						num6 = 3u;
						goto IL_0381;
					}
				}
				if ((uint)num4 != 0)
				{
					buf.U2 = (uint)num4;
					num6 = 2u;
					goto IL_0381;
				}
				num6 = 1u;
			}
			else if ((d2.High | d2.Mid) == 0)
			{
				ulong num4 = UInt32x32To64(d2.Low, d1.Low);
				buf.U0 = (uint)num4;
				num4 = UInt32x32To64(d2.Low, d1.Mid) + (num4 >> 32);
				buf.U1 = (uint)num4;
				num4 >>= 32;
				if (d1.High != 0)
				{
					num4 += UInt32x32To64(d2.Low, d1.High);
					if (num4 > uint.MaxValue)
					{
						buf.Mid64 = num4;
						num6 = 3u;
						goto IL_0381;
					}
				}
				if ((uint)num4 != 0)
				{
					buf.U2 = (uint)num4;
					num6 = 2u;
					goto IL_0381;
				}
				num6 = 1u;
			}
			else
			{
				ulong num4 = UInt32x32To64(d1.Low, d2.Low);
				buf.U0 = (uint)num4;
				ulong num7 = UInt32x32To64(d1.Low, d2.Mid) + (num4 >> 32);
				num4 = UInt32x32To64(d1.Mid, d2.Low);
				num4 += num7;
				buf.U1 = (uint)num4;
				num7 = ((num4 >= num7) ? (num4 >> 32) : ((num4 >> 32) | 0x100000000L));
				num4 = UInt32x32To64(d1.Mid, d2.Mid) + num7;
				if ((d1.High | d2.High) != 0)
				{
					num7 = UInt32x32To64(d1.Low, d2.High);
					num4 += num7;
					uint num8 = 0u;
					if (num4 < num7)
					{
						num8 = 1u;
					}
					num7 = UInt32x32To64(d1.High, d2.Low);
					num4 += num7;
					buf.U2 = (uint)num4;
					if (num4 < num7)
					{
						num8++;
					}
					num7 = ((ulong)num8 << 32) | (num4 >> 32);
					num4 = UInt32x32To64(d1.Mid, d2.High);
					num4 += num7;
					num8 = 0u;
					if (num4 < num7)
					{
						num8 = 1u;
					}
					num7 = UInt32x32To64(d1.High, d2.Mid);
					num4 += num7;
					buf.U3 = (uint)num4;
					if (num4 < num7)
					{
						num8++;
					}
					num4 = ((ulong)num8 << 32) | (num4 >> 32);
					buf.High64 = UInt32x32To64(d1.High, d2.High) + num4;
					num6 = 5u;
				}
				else if (num4 != 0L)
				{
					buf.Mid64 = num4;
					num6 = 3u;
				}
				else
				{
					num6 = 1u;
				}
			}
			uint* ptr = (uint*)(&buf);
			while (ptr[(int)num6] == 0)
			{
				if (num6 != 0)
				{
					num6--;
					continue;
				}
				goto IL_03cd;
			}
			goto IL_0381;
			IL_0381:
			if (num6 > 2 || num > 28)
			{
				num = ScaleResult(&buf, num6, num);
			}
			d1.Low64 = buf.Low64;
			d1.High = buf.U2;
			d1.uflags = ((d2.uflags ^ d1.uflags) & 0x80000000u) | (uint)(num << 16);
			return;
			IL_03cd:
			d1 = default(DecCalc);
		}

		internal static void VarDecFromR4(float input, out DecCalc result)
		{
			result = default(DecCalc);
			int num = (int)(GetExponent(input) - 126);
			if (num < -94)
			{
				return;
			}
			if (num > 96)
			{
				throw new OverflowException("Value was either too large or too small for a Decimal.");
			}
			uint num2 = 0u;
			if (input < 0f)
			{
				input = 0f - input;
				num2 = 2147483648u;
			}
			double num3 = input;
			int num4 = 6 - (num * 19728 >> 16);
			if (num4 >= 0)
			{
				if (num4 > 28)
				{
					num4 = 28;
				}
				num3 *= s_doublePowers10[num4];
			}
			else if (num4 != -1 || num3 >= 10000000.0)
			{
				num3 /= s_doublePowers10[-num4];
			}
			else
			{
				num4 = 0;
			}
			if (num3 < 1000000.0 && num4 < 28)
			{
				num3 *= 10.0;
				num4++;
			}
			uint num5 = (uint)(int)num3;
			num3 -= (double)(int)num5;
			if (num3 > 0.5 || (num3 == 0.5 && (num5 & 1) != 0))
			{
				num5++;
			}
			if (num5 == 0)
			{
				return;
			}
			if (num4 < 0)
			{
				num4 = -num4;
				if (num4 < 10)
				{
					result.Low64 = UInt32x32To64(num5, s_powers10[num4]);
				}
				else if (num4 > 18)
				{
					UInt64x64To128(UInt32x32To64(num5, s_powers10[num4 - 18]), 1000000000000000000uL, ref result);
				}
				else
				{
					ulong num6 = UInt32x32To64(num5, s_powers10[num4 - 9]);
					ulong num7 = UInt32x32To64(1000000000u, (uint)(num6 >> 32));
					num6 = UInt32x32To64(1000000000u, (uint)num6);
					result.Low = (uint)num6;
					num7 += num6 >> 32;
					result.Mid = (uint)num7;
					num7 >>= 32;
					result.High = (uint)num7;
				}
			}
			else
			{
				int num8 = num4;
				if (num8 > 6)
				{
					num8 = 6;
				}
				if ((num5 & 0xF) == 0 && num8 >= 4)
				{
					uint num9 = num5 / 10000;
					if (num5 == num9 * 10000)
					{
						num5 = num9;
						num4 -= 4;
						num8 -= 4;
					}
				}
				if ((num5 & 3) == 0 && num8 >= 2)
				{
					uint num10 = num5 / 100;
					if (num5 == num10 * 100)
					{
						num5 = num10;
						num4 -= 2;
						num8 -= 2;
					}
				}
				if ((num5 & 1) == 0 && num8 >= 1)
				{
					uint num11 = num5 / 10;
					if (num5 == num11 * 10)
					{
						num5 = num11;
						num4--;
					}
				}
				num2 |= (uint)(num4 << 16);
				result.Low = num5;
			}
			result.uflags = num2;
		}

		internal static void VarDecFromR8(double input, out DecCalc result)
		{
			result = default(DecCalc);
			int num = (int)(GetExponent(input) - 1022);
			if (num < -94)
			{
				return;
			}
			if (num > 96)
			{
				throw new OverflowException("Value was either too large or too small for a Decimal.");
			}
			uint num2 = 0u;
			if (input < 0.0)
			{
				input = 0.0 - input;
				num2 = 2147483648u;
			}
			double num3 = input;
			int num4 = 14 - (num * 19728 >> 16);
			if (num4 >= 0)
			{
				if (num4 > 28)
				{
					num4 = 28;
				}
				num3 *= s_doublePowers10[num4];
			}
			else if (num4 != -1 || num3 >= 1000000000000000.0)
			{
				num3 /= s_doublePowers10[-num4];
			}
			else
			{
				num4 = 0;
			}
			if (num3 < 100000000000000.0 && num4 < 28)
			{
				num3 *= 10.0;
				num4++;
			}
			ulong num5 = (ulong)(long)num3;
			num3 -= (double)(long)num5;
			if (num3 > 0.5 || (num3 == 0.5 && (num5 & 1) != 0L))
			{
				num5++;
			}
			if (num5 == 0L)
			{
				return;
			}
			if (num4 < 0)
			{
				num4 = -num4;
				if (num4 < 10)
				{
					uint b = s_powers10[num4];
					ulong num6 = UInt32x32To64((uint)num5, b);
					ulong num7 = UInt32x32To64((uint)(num5 >> 32), b);
					result.Low = (uint)num6;
					num7 += num6 >> 32;
					result.Mid = (uint)num7;
					num7 >>= 32;
					result.High = (uint)num7;
				}
				else
				{
					UInt64x64To128(num5, s_ulongPowers10[num4 - 1], ref result);
				}
			}
			else
			{
				int num8 = num4;
				if (num8 > 14)
				{
					num8 = 14;
				}
				if ((byte)num5 == 0 && num8 >= 8)
				{
					ulong num9 = num5 / 100000000;
					if ((uint)num5 == (uint)(num9 * 100000000))
					{
						num5 = num9;
						num4 -= 8;
						num8 -= 8;
					}
				}
				if (((int)num5 & 0xF) == 0 && num8 >= 4)
				{
					ulong num10 = num5 / 10000;
					if ((uint)num5 == (uint)(num10 * 10000))
					{
						num5 = num10;
						num4 -= 4;
						num8 -= 4;
					}
				}
				if (((int)num5 & 3) == 0 && num8 >= 2)
				{
					ulong num11 = num5 / 100;
					if ((uint)num5 == (uint)(num11 * 100))
					{
						num5 = num11;
						num4 -= 2;
						num8 -= 2;
					}
				}
				if (((int)num5 & 1) == 0 && num8 >= 1)
				{
					ulong num12 = num5 / 10;
					if ((uint)num5 == (uint)(num12 * 10))
					{
						num5 = num12;
						num4--;
					}
				}
				num2 |= (uint)(num4 << 16);
				result.Low64 = num5;
			}
			result.uflags = num2;
		}

		internal static float VarR4FromDec(in decimal value)
		{
			return (float)VarR8FromDec(in value);
		}

		internal static double VarR8FromDec(in decimal value)
		{
			double num = ((double)value.Low64 + (double)value.High * 1.8446744073709552E+19) / s_doublePowers10[value.Scale];
			if (value.IsNegative)
			{
				num = 0.0 - num;
			}
			return num;
		}

		internal static int GetHashCode(in decimal d)
		{
			if ((d.Low | d.Mid | d.High) == 0)
			{
				return 0;
			}
			uint flags = (uint)d.flags;
			if ((flags & 0xFF0000) == 0 || (d.Low & 1) != 0)
			{
				return (int)(flags ^ d.High ^ d.Mid ^ d.Low);
			}
			int scale = (byte)(flags >> 16);
			uint low = d.Low;
			ulong high = ((ulong)d.High << 32) | d.Mid;
			Unscale(ref low, ref high, ref scale);
			flags = (flags & 0xFF00FFFFu) | (uint)(scale << 16);
			return (int)(flags ^ (uint)(int)(high >> 32) ^ (uint)(int)high ^ low);
		}

		internal unsafe static void VarDecDiv(ref DecCalc d1, ref DecCalc d2)
		{
			Buf12 bufQuo = default(Buf12);
			_ = ref bufQuo;
			int scale = (sbyte)(d1.uflags - d2.uflags >> 16);
			bool flag = false;
			uint low;
			uint num;
			Buf16 bufNum = default(Buf16);
			ulong num7;
			Buf12 bufDen = default(Buf12);
			uint num6;
			if ((d2.High | d2.Mid) == 0)
			{
				low = d2.Low;
				if (low == 0)
				{
					throw new DivideByZeroException();
				}
				bufQuo.Low64 = d1.Low64;
				bufQuo.U2 = d1.High;
				num = Div96By32(ref bufQuo, low);
				while (true)
				{
					int num2;
					if (num == 0)
					{
						if (scale >= 0)
						{
							break;
						}
						num2 = Math.Min(9, -scale);
					}
					else
					{
						flag = true;
						if (scale == 28 || (num2 = SearchScale(ref bufQuo, scale)) == 0)
						{
							goto IL_008c;
						}
					}
					uint num3 = s_powers10[num2];
					scale += num2;
					if (IncreaseScale(ref bufQuo, num3) == 0)
					{
						ulong num4 = UInt32x32To64(num, num3);
						uint num5 = (uint)(num4 / low);
						num = (uint)(int)num4 - num5 * low;
						if (!Add32To96(ref bufQuo, num5))
						{
							scale = OverflowUnscale(ref bufQuo, scale, num != 0);
							break;
						}
						continue;
					}
					goto IL_048a;
				}
			}
			else
			{
				num6 = d2.High;
				if (num6 == 0)
				{
					num6 = d2.Mid;
				}
				int num2 = LeadingZeroCount(num6);
				_ = ref bufNum;
				bufNum.Low64 = d1.Low64 << num2;
				bufNum.High64 = d1.Mid + ((ulong)d1.High << 32) >> 32 - num2;
				num7 = d2.Low64 << num2;
				if (d2.High == 0)
				{
					bufQuo.U1 = Div96By64(ref *(Buf12*)(&bufNum.U1), num7);
					bufQuo.U0 = Div96By64(ref *(Buf12*)(&bufNum), num7);
					while (true)
					{
						if (bufNum.Low64 == 0L)
						{
							if (scale >= 0)
							{
								break;
							}
							num2 = Math.Min(9, -scale);
						}
						else
						{
							flag = true;
							if (scale == 28 || (num2 = SearchScale(ref bufQuo, scale)) == 0)
							{
								goto IL_01d3;
							}
						}
						uint num3 = s_powers10[num2];
						scale += num2;
						if (IncreaseScale(ref bufQuo, num3) == 0)
						{
							IncreaseScale64(ref *(Buf12*)(&bufNum), num3);
							num6 = Div96By64(ref *(Buf12*)(&bufNum), num7);
							if (!Add32To96(ref bufQuo, num6))
							{
								scale = OverflowUnscale(ref bufQuo, scale, bufNum.Low64 != 0);
								break;
							}
							continue;
						}
						goto IL_048a;
					}
				}
				else
				{
					_ = ref bufDen;
					bufDen.Low64 = num7;
					bufDen.U2 = (uint)(d2.Mid + ((ulong)d2.High << 32) >> 32 - num2);
					bufQuo.Low64 = Div128By96(ref bufNum, ref bufDen);
					while (true)
					{
						if ((bufNum.Low64 | bufNum.U2) == 0L)
						{
							if (scale >= 0)
							{
								break;
							}
							num2 = Math.Min(9, -scale);
						}
						else
						{
							flag = true;
							if (scale == 28 || (num2 = SearchScale(ref bufQuo, scale)) == 0)
							{
								goto IL_02e1;
							}
						}
						uint num3 = s_powers10[num2];
						scale += num2;
						if (IncreaseScale(ref bufQuo, num3) == 0)
						{
							bufNum.U3 = IncreaseScale(ref *(Buf12*)(&bufNum), num3);
							num6 = Div128By96(ref bufNum, ref bufDen);
							if (!Add32To96(ref bufQuo, num6))
							{
								scale = OverflowUnscale(ref bufQuo, scale, (bufNum.Low64 | bufNum.High64) != 0);
								break;
							}
							continue;
						}
						goto IL_048a;
					}
				}
			}
			goto IL_03d2;
			IL_02e1:
			if ((int)bufNum.U2 >= 0)
			{
				num6 = bufNum.U1 >> 31;
				bufNum.Low64 <<= 1;
				bufNum.U2 = (bufNum.U2 << 1) + num6;
				if (bufNum.U2 <= bufDen.U2 && (bufNum.U2 != bufDen.U2 || (bufNum.Low64 <= bufDen.Low64 && (bufNum.Low64 != bufDen.Low64 || (bufQuo.U0 & 1) == 0))))
				{
					goto IL_03d2;
				}
			}
			goto IL_0449;
			IL_03d2:
			if (flag)
			{
				uint low2 = bufQuo.U0;
				ulong high = bufQuo.High64;
				Unscale(ref low2, ref high, ref scale);
				d1.Low = low2;
				d1.Mid = (uint)high;
				d1.High = (uint)(high >> 32);
			}
			else
			{
				d1.Low64 = bufQuo.Low64;
				d1.High = bufQuo.U2;
			}
			d1.uflags = ((d1.uflags ^ d2.uflags) & 0x80000000u) | (uint)(scale << 16);
			return;
			IL_0449:
			if (++bufQuo.Low64 == 0L && ++bufQuo.U2 == 0)
			{
				scale = OverflowUnscale(ref bufQuo, scale, sticky: true);
			}
			goto IL_03d2;
			IL_048a:
			throw new OverflowException("Value was either too large or too small for a Decimal.");
			IL_01d3:
			ulong low3 = bufNum.Low64;
			if ((long)low3 >= 0L && (low3 <<= 1) <= num7 && (low3 != num7 || (bufQuo.U0 & 1) == 0))
			{
				goto IL_03d2;
			}
			goto IL_0449;
			IL_008c:
			num6 = num << 1;
			if (num6 >= num && (num6 < low || (num6 <= low && (bufQuo.U0 & 1) == 0)))
			{
				goto IL_03d2;
			}
			goto IL_0449;
		}

		internal static void VarDecMod(ref DecCalc d1, ref DecCalc d2)
		{
			if ((d2.ulo | d2.umid | d2.uhi) == 0)
			{
				throw new DivideByZeroException();
			}
			if ((d1.ulo | d1.umid | d1.uhi) == 0)
			{
				return;
			}
			d2.uflags = (d2.uflags & 0x7FFFFFFF) | (d1.uflags & 0x80000000u);
			int num = VarDecCmpSub(in Unsafe.As<DecCalc, decimal>(ref d1), in Unsafe.As<DecCalc, decimal>(ref d2));
			if (num == 0)
			{
				d1.ulo = 0u;
				d1.umid = 0u;
				d1.uhi = 0u;
				if (d2.uflags > d1.uflags)
				{
					d1.uflags = d2.uflags;
				}
			}
			else
			{
				if ((int)((uint)num ^ (d1.uflags & 0x80000000u)) < 0)
				{
					return;
				}
				int num2 = (sbyte)(d1.uflags - d2.uflags >> 16);
				if (num2 > 0)
				{
					do
					{
						uint num3 = ((num2 >= 9) ? 1000000000u : s_powers10[num2]);
						ulong num4 = UInt32x32To64(d2.Low, num3);
						d2.Low = (uint)num4;
						num4 >>= 32;
						num4 += (d2.Mid + ((ulong)d2.High << 32)) * num3;
						d2.Mid = (uint)num4;
						d2.High = (uint)(num4 >> 32);
					}
					while ((num2 -= 9) > 0);
					num2 = 0;
				}
				Buf12 bufQuo = default(Buf12);
				do
				{
					if (num2 < 0)
					{
						d1.uflags = d2.uflags;
						_ = ref bufQuo;
						bufQuo.Low64 = d1.Low64;
						bufQuo.U2 = d1.High;
						uint num6;
						do
						{
							int num5 = SearchScale(ref bufQuo, 28 + num2);
							if (num5 == 0)
							{
								break;
							}
							num6 = ((num5 >= 9) ? 1000000000u : s_powers10[num5]);
							num2 += num5;
							ulong num7 = UInt32x32To64(bufQuo.U0, num6);
							bufQuo.U0 = (uint)num7;
							num7 >>= 32;
							bufQuo.High64 = num7 + bufQuo.High64 * num6;
						}
						while (num6 == 1000000000 && num2 < 0);
						d1.Low64 = bufQuo.Low64;
						d1.High = bufQuo.U2;
					}
					if (d1.High == 0)
					{
						d1.Low64 %= d2.Low64;
						break;
					}
					if ((d2.High | d2.Mid) == 0)
					{
						uint low = d2.Low;
						ulong num8 = ((ulong)d1.High << 32) | d1.Mid;
						num8 = (num8 % low << 32) | d1.Low;
						d1.Low64 = num8 % low;
						d1.High = 0u;
						continue;
					}
					VarDecModFull(ref d1, ref d2, num2);
					break;
				}
				while (num2 < 0);
			}
		}

		private unsafe static void VarDecModFull(ref DecCalc d1, ref DecCalc d2, int scale)
		{
			uint num = d2.High;
			if (num == 0)
			{
				num = d2.Mid;
			}
			int num2 = LeadingZeroCount(num);
			Buf28 buf = default(Buf28);
			_ = ref buf;
			buf.Buf24.Low64 = d1.Low64 << num2;
			buf.Buf24.Mid64 = d1.Mid + ((ulong)d1.High << 32) >> 32 - num2;
			uint num3 = 3u;
			while (scale < 0)
			{
				uint b = ((scale <= -9) ? 1000000000u : s_powers10[-scale]);
				uint* ptr = (uint*)(&buf);
				ulong num4 = UInt32x32To64(buf.Buf24.U0, b);
				buf.Buf24.U0 = (uint)num4;
				for (int i = 1; i <= num3; i++)
				{
					num4 >>= 32;
					num4 += UInt32x32To64(ptr[i], b);
					ptr[i] = (uint)num4;
				}
				if (num4 > int.MaxValue)
				{
					ptr[++num3] = (uint)(num4 >> 32);
				}
				scale += 9;
			}
			if (d2.High == 0)
			{
				ulong den = d2.Low64 << num2;
				switch (num3)
				{
				case 6u:
					Div96By64(ref *(Buf12*)(&buf.Buf24.U4), den);
					goto case 5u;
				case 5u:
					Div96By64(ref *(Buf12*)(&buf.Buf24.U3), den);
					goto case 4u;
				case 4u:
					Div96By64(ref *(Buf12*)(&buf.Buf24.U2), den);
					break;
				}
				Div96By64(ref *(Buf12*)(&buf.Buf24.U1), den);
				Div96By64(ref *(Buf12*)(&buf), den);
				d1.Low64 = buf.Buf24.Low64 >> num2;
				d1.High = 0u;
				return;
			}
			Buf12 bufDen = default(Buf12);
			_ = ref bufDen;
			bufDen.Low64 = d2.Low64 << num2;
			bufDen.U2 = (uint)(d2.Mid + ((ulong)d2.High << 32) >> 32 - num2);
			switch (num3)
			{
			case 6u:
				Div128By96(ref *(Buf16*)(&buf.Buf24.U3), ref bufDen);
				goto case 5u;
			case 5u:
				Div128By96(ref *(Buf16*)(&buf.Buf24.U2), ref bufDen);
				goto case 4u;
			case 4u:
				Div128By96(ref *(Buf16*)(&buf.Buf24.U1), ref bufDen);
				break;
			}
			Div128By96(ref *(Buf16*)(&buf), ref bufDen);
			d1.Low64 = (buf.Buf24.Low64 >> num2) + ((ulong)buf.Buf24.U2 << 32 - num2 << 32);
			d1.High = buf.Buf24.U2 >> num2;
		}

		internal static void InternalRound(ref DecCalc d, uint scale, RoundingMode mode)
		{
			d.uflags -= scale << 16;
			uint num = 0u;
			while (true)
			{
				uint num6;
				uint num5;
				if (scale >= 9)
				{
					scale -= 9;
					uint num2 = d.uhi;
					if (num2 == 0)
					{
						ulong low = d.Low64;
						ulong num3 = (d.Low64 = low / 1000000000);
						num5 = (uint)(low - num3 * 1000000000);
					}
					else
					{
						num5 = num2 - (d.uhi = num2 / 1000000000) * 1000000000;
						num2 = d.umid;
						if ((num2 | num5) != 0)
						{
							num5 = num2 - (d.umid = (uint)((((ulong)num5 << 32) | num2) / 1000000000)) * 1000000000;
						}
						num2 = d.ulo;
						if ((num2 | num5) != 0)
						{
							num5 = num2 - (d.ulo = (uint)((((ulong)num5 << 32) | num2) / 1000000000)) * 1000000000;
						}
					}
					num6 = 1000000000u;
					if (scale != 0)
					{
						num |= num5;
						continue;
					}
				}
				else
				{
					num6 = s_powers10[scale];
					uint num7 = d.uhi;
					if (num7 == 0)
					{
						ulong low2 = d.Low64;
						if (low2 == 0L)
						{
							if (mode <= RoundingMode.Truncate)
							{
								break;
							}
							num5 = 0u;
						}
						else
						{
							ulong num8 = (d.Low64 = low2 / num6);
							num5 = (uint)(low2 - num8 * num6);
						}
					}
					else
					{
						num5 = num7 - (d.uhi = num7 / num6) * num6;
						num7 = d.umid;
						if ((num7 | num5) != 0)
						{
							num5 = num7 - (d.umid = (uint)((((ulong)num5 << 32) | num7) / num6)) * num6;
						}
						num7 = d.ulo;
						if ((num7 | num5) != 0)
						{
							num5 = num7 - (d.ulo = (uint)((((ulong)num5 << 32) | num7) / num6)) * num6;
						}
					}
				}
				switch (mode)
				{
				case RoundingMode.ToEven:
					num5 <<= 1;
					if ((num | (d.ulo & 1)) != 0)
					{
						num5++;
					}
					if (num6 >= num5)
					{
						break;
					}
					goto IL_01e0;
				case RoundingMode.AwayFromZero:
					num5 <<= 1;
					if (num6 > num5)
					{
						break;
					}
					goto IL_01e0;
				case RoundingMode.Floor:
					if ((num5 | num) == 0 || !d.IsNegative)
					{
						break;
					}
					goto IL_01e0;
				default:
					if ((num5 | num) == 0 || d.IsNegative)
					{
						break;
					}
					goto IL_01e0;
				case RoundingMode.Truncate:
					break;
					IL_01e0:
					if (++d.Low64 == 0L)
					{
						d.uhi++;
					}
					break;
				}
				break;
			}
		}

		internal static uint DecDivMod1E9(ref DecCalc value)
		{
			ulong num = ((ulong)value.uhi << 32) + value.umid;
			ulong num2 = num / 1000000000;
			value.uhi = (uint)(num2 >> 32);
			value.umid = (uint)num2;
			ulong num3 = (num - (uint)((int)num2 * 1000000000) << 32) + value.ulo;
			return (uint)(int)num3 - (value.ulo = (uint)(num3 / 1000000000)) * 1000000000;
		}
	}

	private const int SignMask = int.MinValue;

	private const int ScaleMask = 16711680;

	private const int ScaleShift = 16;

	public const decimal Zero = 0m;

	public const decimal One = 1m;

	public const decimal MinusOne = -1m;

	public const decimal MaxValue = 79228162514264337593543950335m;

	public const decimal MinValue = -79228162514264337593543950335m;

	[FieldOffset(0)]
	private readonly int flags;

	[FieldOffset(4)]
	private readonly int hi;

	[FieldOffset(8)]
	private readonly int lo;

	[FieldOffset(12)]
	private readonly int mid;

	[FieldOffset(8)]
	[NonSerialized]
	private readonly ulong ulomidLE;

	internal uint High => (uint)hi;

	internal uint Low => (uint)lo;

	internal uint Mid => (uint)mid;

	internal bool IsNegative => flags < 0;

	internal int Scale => (byte)(flags >> 16);

	private ulong Low64
	{
		get
		{
			if (!BitConverter.IsLittleEndian)
			{
				return ((ulong)Mid << 32) | Low;
			}
			return ulomidLE;
		}
	}

	private static ref DecCalc AsMutable(ref decimal d)
	{
		return ref Unsafe.As<decimal, DecCalc>(ref d);
	}

	internal static uint DecDivMod1E9(ref decimal value)
	{
		return DecCalc.DecDivMod1E9(ref AsMutable(ref value));
	}

	public Decimal(int value)
	{
		if (value >= 0)
		{
			flags = 0;
		}
		else
		{
			flags = int.MinValue;
			value = -value;
		}
		lo = value;
		mid = 0;
		hi = 0;
	}

	[CLSCompliant(false)]
	public Decimal(uint value)
	{
		flags = 0;
		lo = (int)value;
		mid = 0;
		hi = 0;
	}

	public Decimal(long value)
	{
		if (value >= 0)
		{
			flags = 0;
		}
		else
		{
			flags = int.MinValue;
			value = -value;
		}
		lo = (int)value;
		mid = (int)(value >> 32);
		hi = 0;
	}

	[CLSCompliant(false)]
	public Decimal(ulong value)
	{
		flags = 0;
		lo = (int)value;
		mid = (int)(value >> 32);
		hi = 0;
	}

	public Decimal(float value)
	{
		DecCalc.VarDecFromR4(value, out AsMutable(ref this));
	}

	public Decimal(double value)
	{
		DecCalc.VarDecFromR8(value, out AsMutable(ref this));
	}

	public static decimal FromOACurrency(long cy)
	{
		bool isNegative = false;
		ulong num;
		if (cy < 0)
		{
			isNegative = true;
			num = (ulong)(-cy);
		}
		else
		{
			num = (ulong)cy;
		}
		int num2 = 4;
		if (num != 0L)
		{
			while (num2 != 0 && num % 10 == 0L)
			{
				num2--;
				num /= 10;
			}
		}
		return new decimal((int)num, (int)(num >> 32), 0, isNegative, (byte)num2);
	}

	public static long ToOACurrency(decimal value)
	{
		return DecCalc.VarCyFromDec(ref AsMutable(ref value));
	}

	private static bool IsValid(int flags)
	{
		if ((flags & 0x7F00FFFF) == 0)
		{
			return (uint)(flags & 0xFF0000) <= 1835008u;
		}
		return false;
	}

	public Decimal(int[] bits)
	{
		if (bits == null)
		{
			throw new ArgumentNullException("bits");
		}
		if (bits.Length == 4)
		{
			int num = bits[3];
			if (IsValid(num))
			{
				lo = bits[0];
				mid = bits[1];
				hi = bits[2];
				flags = num;
				return;
			}
		}
		throw new ArgumentException("Decimal byte array constructor requires an array of length four containing valid decimal bytes.");
	}

	public Decimal(int lo, int mid, int hi, bool isNegative, byte scale)
	{
		if (scale > 28)
		{
			throw new ArgumentOutOfRangeException("scale", "Decimal's scale value must be between 0 and 28, inclusive.");
		}
		this.lo = lo;
		this.mid = mid;
		this.hi = hi;
		flags = scale << 16;
		if (isNegative)
		{
			flags |= int.MinValue;
		}
	}

	void IDeserializationCallback.OnDeserialization(object sender)
	{
		if (!IsValid(flags))
		{
			throw new SerializationException("Value was either too large or too small for a Decimal.");
		}
	}

	private Decimal(int lo, int mid, int hi, int flags)
	{
		if (IsValid(flags))
		{
			this.lo = lo;
			this.mid = mid;
			this.hi = hi;
			this.flags = flags;
			return;
		}
		throw new ArgumentException("Decimal byte array constructor requires an array of length four containing valid decimal bytes.");
	}

	private Decimal(in decimal d, int flags)
	{
		this = d;
		this.flags = flags;
	}

	internal static decimal Abs(ref decimal d)
	{
		return new decimal(in d, d.flags & 0x7FFFFFFF);
	}

	public static decimal Add(decimal d1, decimal d2)
	{
		DecCalc.DecAddSub(ref AsMutable(ref d1), ref AsMutable(ref d2), sign: false);
		return d1;
	}

	public static decimal Ceiling(decimal d)
	{
		int num = d.flags;
		if ((num & 0xFF0000) != 0)
		{
			DecCalc.InternalRound(ref AsMutable(ref d), (byte)(num >> 16), DecCalc.RoundingMode.Ceiling);
		}
		return d;
	}

	public static int Compare(decimal d1, decimal d2)
	{
		return DecCalc.VarDecCmp(in d1, in d2);
	}

	public int CompareTo(object value)
	{
		if (value == null)
		{
			return 1;
		}
		if (!(value is decimal d))
		{
			throw new ArgumentException("Object must be of type Decimal.");
		}
		return DecCalc.VarDecCmp(this, in d);
	}

	public int CompareTo(decimal value)
	{
		return DecCalc.VarDecCmp(this, in value);
	}

	public static decimal Divide(decimal d1, decimal d2)
	{
		DecCalc.VarDecDiv(ref AsMutable(ref d1), ref AsMutable(ref d2));
		return d1;
	}

	public override bool Equals(object value)
	{
		if (value is decimal d)
		{
			return DecCalc.VarDecCmp(this, in d) == 0;
		}
		return false;
	}

	public bool Equals(decimal value)
	{
		return DecCalc.VarDecCmp(this, in value) == 0;
	}

	public override int GetHashCode()
	{
		return DecCalc.GetHashCode(this);
	}

	public static bool Equals(decimal d1, decimal d2)
	{
		return DecCalc.VarDecCmp(in d1, in d2) == 0;
	}

	public static decimal Floor(decimal d)
	{
		int num = d.flags;
		if ((num & 0xFF0000) != 0)
		{
			DecCalc.InternalRound(ref AsMutable(ref d), (byte)(num >> 16), DecCalc.RoundingMode.Floor);
		}
		return d;
	}

	public override string ToString()
	{
		return Number.FormatDecimal(this, null, NumberFormatInfo.CurrentInfo);
	}

	public string ToString(string format)
	{
		return Number.FormatDecimal(this, format, NumberFormatInfo.CurrentInfo);
	}

	public string ToString(IFormatProvider provider)
	{
		return Number.FormatDecimal(this, null, NumberFormatInfo.GetInstance(provider));
	}

	public string ToString(string format, IFormatProvider provider)
	{
		return Number.FormatDecimal(this, format, NumberFormatInfo.GetInstance(provider));
	}

	public bool TryFormat(Span<char> destination, out int charsWritten, ReadOnlySpan<char> format = default(ReadOnlySpan<char>), IFormatProvider provider = null)
	{
		return Number.TryFormatDecimal(this, format, NumberFormatInfo.GetInstance(provider), destination, out charsWritten);
	}

	public static decimal Parse(string s)
	{
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Number.ParseDecimal(s, NumberStyles.Number, NumberFormatInfo.CurrentInfo);
	}

	public static decimal Parse(string s, NumberStyles style)
	{
		NumberFormatInfo.ValidateParseStyleFloatingPoint(style);
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Number.ParseDecimal(s, style, NumberFormatInfo.CurrentInfo);
	}

	public static decimal Parse(string s, IFormatProvider provider)
	{
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Number.ParseDecimal(s, NumberStyles.Number, NumberFormatInfo.GetInstance(provider));
	}

	public static decimal Parse(string s, NumberStyles style, IFormatProvider provider)
	{
		NumberFormatInfo.ValidateParseStyleFloatingPoint(style);
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Number.ParseDecimal(s, style, NumberFormatInfo.GetInstance(provider));
	}

	public static decimal Parse(ReadOnlySpan<char> s, NumberStyles style = NumberStyles.Number, IFormatProvider provider = null)
	{
		NumberFormatInfo.ValidateParseStyleFloatingPoint(style);
		return Number.ParseDecimal(s, style, NumberFormatInfo.GetInstance(provider));
	}

	public static bool TryParse(string s, out decimal result)
	{
		if (s == null)
		{
			result = 0m;
			return false;
		}
		return Number.TryParseDecimal(s, NumberStyles.Number, NumberFormatInfo.CurrentInfo, out result);
	}

	public static bool TryParse(ReadOnlySpan<char> s, out decimal result)
	{
		return Number.TryParseDecimal(s, NumberStyles.Number, NumberFormatInfo.CurrentInfo, out result);
	}

	public static bool TryParse(string s, NumberStyles style, IFormatProvider provider, out decimal result)
	{
		NumberFormatInfo.ValidateParseStyleFloatingPoint(style);
		if (s == null)
		{
			result = 0m;
			return false;
		}
		return Number.TryParseDecimal(s, style, NumberFormatInfo.GetInstance(provider), out result);
	}

	public static bool TryParse(ReadOnlySpan<char> s, NumberStyles style, IFormatProvider provider, out decimal result)
	{
		NumberFormatInfo.ValidateParseStyleFloatingPoint(style);
		return Number.TryParseDecimal(s, style, NumberFormatInfo.GetInstance(provider), out result);
	}

	public static int[] GetBits(decimal d)
	{
		return new int[4] { d.lo, d.mid, d.hi, d.flags };
	}

	internal static void GetBytes(in decimal d, byte[] buffer)
	{
		buffer[0] = (byte)d.lo;
		buffer[1] = (byte)(d.lo >> 8);
		buffer[2] = (byte)(d.lo >> 16);
		buffer[3] = (byte)(d.lo >> 24);
		buffer[4] = (byte)d.mid;
		buffer[5] = (byte)(d.mid >> 8);
		buffer[6] = (byte)(d.mid >> 16);
		buffer[7] = (byte)(d.mid >> 24);
		buffer[8] = (byte)d.hi;
		buffer[9] = (byte)(d.hi >> 8);
		buffer[10] = (byte)(d.hi >> 16);
		buffer[11] = (byte)(d.hi >> 24);
		buffer[12] = (byte)d.flags;
		buffer[13] = (byte)(d.flags >> 8);
		buffer[14] = (byte)(d.flags >> 16);
		buffer[15] = (byte)(d.flags >> 24);
	}

	internal static decimal ToDecimal(byte[] buffer)
	{
		int num = buffer[0] | (buffer[1] << 8) | (buffer[2] << 16) | (buffer[3] << 24);
		int num2 = buffer[4] | (buffer[5] << 8) | (buffer[6] << 16) | (buffer[7] << 24);
		int num3 = buffer[8] | (buffer[9] << 8) | (buffer[10] << 16) | (buffer[11] << 24);
		int num4 = buffer[12] | (buffer[13] << 8) | (buffer[14] << 16) | (buffer[15] << 24);
		return new decimal(num, num2, num3, num4);
	}

	internal static ref readonly decimal Max(ref decimal d1, ref decimal d2)
	{
		if (DecCalc.VarDecCmp(in d1, in d2) < 0)
		{
			return ref d2;
		}
		return ref d1;
	}

	internal static ref readonly decimal Min(ref decimal d1, ref decimal d2)
	{
		if (DecCalc.VarDecCmp(in d1, in d2) >= 0)
		{
			return ref d2;
		}
		return ref d1;
	}

	public static decimal Remainder(decimal d1, decimal d2)
	{
		DecCalc.VarDecMod(ref AsMutable(ref d1), ref AsMutable(ref d2));
		return d1;
	}

	public static decimal Multiply(decimal d1, decimal d2)
	{
		DecCalc.VarDecMul(ref AsMutable(ref d1), ref AsMutable(ref d2));
		return d1;
	}

	public static decimal Negate(decimal d)
	{
		return new decimal(in d, d.flags ^ int.MinValue);
	}

	public static decimal Round(decimal d)
	{
		return Round(ref d, 0, MidpointRounding.ToEven);
	}

	public static decimal Round(decimal d, int decimals)
	{
		return Round(ref d, decimals, MidpointRounding.ToEven);
	}

	public static decimal Round(decimal d, MidpointRounding mode)
	{
		return Round(ref d, 0, mode);
	}

	public static decimal Round(decimal d, int decimals, MidpointRounding mode)
	{
		return Round(ref d, decimals, mode);
	}

	private static decimal Round(ref decimal d, int decimals, MidpointRounding mode)
	{
		if ((uint)decimals > 28u)
		{
			throw new ArgumentOutOfRangeException("decimals", "Decimal can only round to between 0 and 28 digits of precision.");
		}
		if ((uint)mode > 1u)
		{
			throw new ArgumentException(SR.Format("The value '{0}' is not valid for this usage of the type {1}.", mode, "MidpointRounding"), "mode");
		}
		int num = d.Scale - decimals;
		if (num > 0)
		{
			DecCalc.InternalRound(ref AsMutable(ref d), (uint)num, (DecCalc.RoundingMode)mode);
		}
		return d;
	}

	internal static int Sign(ref decimal d)
	{
		if ((d.lo | d.mid | d.hi) != 0)
		{
			return (d.flags >> 31) | 1;
		}
		return 0;
	}

	public static decimal Subtract(decimal d1, decimal d2)
	{
		DecCalc.DecAddSub(ref AsMutable(ref d1), ref AsMutable(ref d2), sign: true);
		return d1;
	}

	public static byte ToByte(decimal value)
	{
		uint num;
		try
		{
			num = ToUInt32(value);
		}
		catch (OverflowException innerException)
		{
			throw new OverflowException("Value was either too large or too small for an unsigned byte.", innerException);
		}
		if (num != (byte)num)
		{
			throw new OverflowException("Value was either too large or too small for an unsigned byte.");
		}
		return (byte)num;
	}

	[CLSCompliant(false)]
	public static sbyte ToSByte(decimal value)
	{
		int num;
		try
		{
			num = ToInt32(value);
		}
		catch (OverflowException innerException)
		{
			throw new OverflowException("Value was either too large or too small for a signed byte.", innerException);
		}
		if (num != (sbyte)num)
		{
			throw new OverflowException("Value was either too large or too small for a signed byte.");
		}
		return (sbyte)num;
	}

	public static short ToInt16(decimal value)
	{
		int num;
		try
		{
			num = ToInt32(value);
		}
		catch (OverflowException innerException)
		{
			throw new OverflowException("Value was either too large or too small for an Int16.", innerException);
		}
		if (num != (short)num)
		{
			throw new OverflowException("Value was either too large or too small for an Int16.");
		}
		return (short)num;
	}

	public static double ToDouble(decimal d)
	{
		return DecCalc.VarR8FromDec(in d);
	}

	public static int ToInt32(decimal d)
	{
		Truncate(ref d);
		if ((d.hi | d.mid) == 0)
		{
			int num = d.lo;
			if (!d.IsNegative)
			{
				if (num >= 0)
				{
					return num;
				}
			}
			else
			{
				num = -num;
				if (num <= 0)
				{
					return num;
				}
			}
		}
		throw new OverflowException("Value was either too large or too small for an Int32.");
	}

	public static long ToInt64(decimal d)
	{
		Truncate(ref d);
		if (d.hi == 0)
		{
			long low = (long)d.Low64;
			if (!d.IsNegative)
			{
				if (low >= 0)
				{
					return low;
				}
			}
			else
			{
				low = -low;
				if (low <= 0)
				{
					return low;
				}
			}
		}
		throw new OverflowException("Value was either too large or too small for an Int64.");
	}

	[CLSCompliant(false)]
	public static ushort ToUInt16(decimal value)
	{
		uint num;
		try
		{
			num = ToUInt32(value);
		}
		catch (OverflowException innerException)
		{
			throw new OverflowException("Value was either too large or too small for a UInt16.", innerException);
		}
		if (num != (ushort)num)
		{
			throw new OverflowException("Value was either too large or too small for a UInt16.");
		}
		return (ushort)num;
	}

	[CLSCompliant(false)]
	public static uint ToUInt32(decimal d)
	{
		Truncate(ref d);
		if ((d.hi | d.mid) == 0)
		{
			uint low = d.Low;
			if (!d.IsNegative || low == 0)
			{
				return low;
			}
		}
		throw new OverflowException("Value was either too large or too small for a UInt32.");
	}

	[CLSCompliant(false)]
	public static ulong ToUInt64(decimal d)
	{
		Truncate(ref d);
		if (d.hi == 0)
		{
			ulong low = d.Low64;
			if (!d.IsNegative || low == 0L)
			{
				return low;
			}
		}
		throw new OverflowException("Value was either too large or too small for a UInt64.");
	}

	public static float ToSingle(decimal d)
	{
		return DecCalc.VarR4FromDec(in d);
	}

	public static decimal Truncate(decimal d)
	{
		Truncate(ref d);
		return d;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static void Truncate(ref decimal d)
	{
		int num = d.flags;
		if ((num & 0xFF0000) != 0)
		{
			DecCalc.InternalRound(ref AsMutable(ref d), (byte)(num >> 16), DecCalc.RoundingMode.Truncate);
		}
	}

	public static implicit operator decimal(byte value)
	{
		return new decimal((uint)value);
	}

	[CLSCompliant(false)]
	public static implicit operator decimal(sbyte value)
	{
		return new decimal(value);
	}

	public static implicit operator decimal(short value)
	{
		return new decimal(value);
	}

	[CLSCompliant(false)]
	public static implicit operator decimal(ushort value)
	{
		return new decimal((uint)value);
	}

	public static implicit operator decimal(char value)
	{
		return new decimal((uint)value);
	}

	public static implicit operator decimal(int value)
	{
		return new decimal(value);
	}

	[CLSCompliant(false)]
	public static implicit operator decimal(uint value)
	{
		return new decimal(value);
	}

	public static implicit operator decimal(long value)
	{
		return new decimal(value);
	}

	[CLSCompliant(false)]
	public static implicit operator decimal(ulong value)
	{
		return new decimal(value);
	}

	public static explicit operator decimal(float value)
	{
		return new decimal(value);
	}

	public static explicit operator decimal(double value)
	{
		return new decimal(value);
	}

	public static explicit operator byte(decimal value)
	{
		return ToByte(value);
	}

	[CLSCompliant(false)]
	public static explicit operator sbyte(decimal value)
	{
		return ToSByte(value);
	}

	public static explicit operator char(decimal value)
	{
		try
		{
			return (char)ToUInt16(value);
		}
		catch (OverflowException innerException)
		{
			throw new OverflowException("Value was either too large or too small for a character.", innerException);
		}
	}

	public static explicit operator short(decimal value)
	{
		return ToInt16(value);
	}

	[CLSCompliant(false)]
	public static explicit operator ushort(decimal value)
	{
		return ToUInt16(value);
	}

	public static explicit operator int(decimal value)
	{
		return ToInt32(value);
	}

	[CLSCompliant(false)]
	public static explicit operator uint(decimal value)
	{
		return ToUInt32(value);
	}

	public static explicit operator long(decimal value)
	{
		return ToInt64(value);
	}

	[CLSCompliant(false)]
	public static explicit operator ulong(decimal value)
	{
		return ToUInt64(value);
	}

	public static explicit operator float(decimal value)
	{
		return ToSingle(value);
	}

	public static explicit operator double(decimal value)
	{
		return ToDouble(value);
	}

	public static decimal operator +(decimal d)
	{
		return d;
	}

	public static decimal operator -(decimal d)
	{
		return new decimal(in d, d.flags ^ int.MinValue);
	}

	public static decimal operator ++(decimal d)
	{
		return Add(d, 1m);
	}

	public static decimal operator --(decimal d)
	{
		return Subtract(d, 1m);
	}

	public static decimal operator +(decimal d1, decimal d2)
	{
		DecCalc.DecAddSub(ref AsMutable(ref d1), ref AsMutable(ref d2), sign: false);
		return d1;
	}

	public static decimal operator -(decimal d1, decimal d2)
	{
		DecCalc.DecAddSub(ref AsMutable(ref d1), ref AsMutable(ref d2), sign: true);
		return d1;
	}

	public static decimal operator *(decimal d1, decimal d2)
	{
		DecCalc.VarDecMul(ref AsMutable(ref d1), ref AsMutable(ref d2));
		return d1;
	}

	public static decimal operator /(decimal d1, decimal d2)
	{
		DecCalc.VarDecDiv(ref AsMutable(ref d1), ref AsMutable(ref d2));
		return d1;
	}

	public static decimal operator %(decimal d1, decimal d2)
	{
		DecCalc.VarDecMod(ref AsMutable(ref d1), ref AsMutable(ref d2));
		return d1;
	}

	public static bool operator ==(decimal d1, decimal d2)
	{
		return DecCalc.VarDecCmp(in d1, in d2) == 0;
	}

	public static bool operator !=(decimal d1, decimal d2)
	{
		return DecCalc.VarDecCmp(in d1, in d2) != 0;
	}

	public static bool operator <(decimal d1, decimal d2)
	{
		return DecCalc.VarDecCmp(in d1, in d2) < 0;
	}

	public static bool operator <=(decimal d1, decimal d2)
	{
		return DecCalc.VarDecCmp(in d1, in d2) <= 0;
	}

	public static bool operator >(decimal d1, decimal d2)
	{
		return DecCalc.VarDecCmp(in d1, in d2) > 0;
	}

	public static bool operator >=(decimal d1, decimal d2)
	{
		return DecCalc.VarDecCmp(in d1, in d2) >= 0;
	}

	public TypeCode GetTypeCode()
	{
		return TypeCode.Decimal;
	}

	bool IConvertible.ToBoolean(IFormatProvider provider)
	{
		return Convert.ToBoolean(this);
	}

	char IConvertible.ToChar(IFormatProvider provider)
	{
		throw new InvalidCastException(SR.Format("Invalid cast from '{0}' to '{1}'.", "Decimal", "Char"));
	}

	sbyte IConvertible.ToSByte(IFormatProvider provider)
	{
		return Convert.ToSByte(this);
	}

	byte IConvertible.ToByte(IFormatProvider provider)
	{
		return Convert.ToByte(this);
	}

	short IConvertible.ToInt16(IFormatProvider provider)
	{
		return Convert.ToInt16(this);
	}

	ushort IConvertible.ToUInt16(IFormatProvider provider)
	{
		return Convert.ToUInt16(this);
	}

	int IConvertible.ToInt32(IFormatProvider provider)
	{
		return Convert.ToInt32(this);
	}

	uint IConvertible.ToUInt32(IFormatProvider provider)
	{
		return Convert.ToUInt32(this);
	}

	long IConvertible.ToInt64(IFormatProvider provider)
	{
		return Convert.ToInt64(this);
	}

	ulong IConvertible.ToUInt64(IFormatProvider provider)
	{
		return Convert.ToUInt64(this);
	}

	float IConvertible.ToSingle(IFormatProvider provider)
	{
		return Convert.ToSingle(this);
	}

	double IConvertible.ToDouble(IFormatProvider provider)
	{
		return Convert.ToDouble(this);
	}

	decimal IConvertible.ToDecimal(IFormatProvider provider)
	{
		return this;
	}

	DateTime IConvertible.ToDateTime(IFormatProvider provider)
	{
		throw new InvalidCastException(SR.Format("Invalid cast from '{0}' to '{1}'.", "Decimal", "DateTime"));
	}

	object IConvertible.ToType(Type type, IFormatProvider provider)
	{
		return Convert.DefaultToType(this, type, provider);
	}
}
