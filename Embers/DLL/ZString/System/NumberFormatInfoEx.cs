using System.Globalization;

namespace System;

internal static class NumberFormatInfoEx
{
	internal static bool HasInvariantNumberSigns(this NumberFormatInfo info)
	{
		if (info.PositiveSign == "+")
		{
			return info.NegativeSign == "-";
		}
		return false;
	}
}
