using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace System;

internal static class DecimalEx
{
	[StructLayout(LayoutKind.Explicit)]
	private struct DecimalBits
	{
		[FieldOffset(0)]
		public int flags;

		[FieldOffset(4)]
		public int hi;

		[FieldOffset(8)]
		public int lo;

		[FieldOffset(12)]
		public int mid;
	}

	[StructLayout(LayoutKind.Explicit)]
	private struct DecCalc
	{
		private const uint TenToPowerNine = 1000000000u;

		[FieldOffset(0)]
		public uint uflags;

		[FieldOffset(4)]
		public uint uhi;

		[FieldOffset(8)]
		public uint ulo;

		[FieldOffset(12)]
		public uint umid;

		[FieldOffset(8)]
		private ulong ulomidLE;

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

	private const int ScaleShift = 16;

	private static ref DecCalc AsMutable(ref decimal d)
	{
		return ref Unsafe.As<decimal, DecCalc>(ref d);
	}

	internal static uint High(this decimal value)
	{
		return Unsafe.As<decimal, DecCalc>(ref value).uhi;
	}

	internal static uint Low(this decimal value)
	{
		return Unsafe.As<decimal, DecCalc>(ref value).ulo;
	}

	internal static uint Mid(this decimal value)
	{
		return Unsafe.As<decimal, DecCalc>(ref value).umid;
	}

	internal static bool IsNegative(this decimal value)
	{
		return Unsafe.As<decimal, DecimalBits>(ref value).flags < 0;
	}

	internal static int Scale(this decimal value)
	{
		return (byte)(Unsafe.As<decimal, DecimalBits>(ref value).flags >> 16);
	}

	internal static uint DecDivMod1E9(ref decimal value)
	{
		return DecCalc.DecDivMod1E9(ref AsMutable(ref value));
	}
}
