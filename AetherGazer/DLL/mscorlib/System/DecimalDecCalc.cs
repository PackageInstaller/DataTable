namespace System;

internal static class DecimalDecCalc
{
	private static uint D32DivMod1E9(uint hi32, ref uint lo32)
	{
		ulong num = ((ulong)hi32 << 32) | lo32;
		lo32 = (uint)(num / 1000000000);
		return (uint)(num % 1000000000);
	}

	internal static uint DecDivMod1E9(ref MutableDecimal value)
	{
		return D32DivMod1E9(D32DivMod1E9(D32DivMod1E9(0u, ref value.High), ref value.Mid), ref value.Low);
	}

	internal static void DecAddInt32(ref MutableDecimal value, uint i)
	{
		if (D32AddCarry(ref value.Low, i) && D32AddCarry(ref value.Mid, 1u))
		{
			D32AddCarry(ref value.High, 1u);
		}
	}

	private static bool D32AddCarry(ref uint value, uint i)
	{
		uint num = value;
		uint num2 = (value = num + i);
		if (num2 >= num)
		{
			return num2 < i;
		}
		return true;
	}

	internal static void DecMul10(ref MutableDecimal value)
	{
		MutableDecimal d = value;
		DecShiftLeft(ref value);
		DecShiftLeft(ref value);
		DecAdd(ref value, d);
		DecShiftLeft(ref value);
	}

	private static void DecShiftLeft(ref MutableDecimal value)
	{
		uint num = (((value.Low & 0x80000000u) != 0) ? 1u : 0u);
		uint num2 = (((value.Mid & 0x80000000u) != 0) ? 1u : 0u);
		value.Low <<= 1;
		value.Mid = (value.Mid << 1) | num;
		value.High = (value.High << 1) | num2;
	}

	private static void DecAdd(ref MutableDecimal value, MutableDecimal d)
	{
		if (D32AddCarry(ref value.Low, d.Low) && D32AddCarry(ref value.Mid, 1u))
		{
			D32AddCarry(ref value.High, 1u);
		}
		if (D32AddCarry(ref value.Mid, d.Mid))
		{
			D32AddCarry(ref value.High, 1u);
		}
		D32AddCarry(ref value.High, d.High);
	}
}
