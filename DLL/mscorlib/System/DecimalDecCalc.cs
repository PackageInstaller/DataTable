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
}
