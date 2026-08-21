namespace System.Collections.Generic;

internal static class IntrospectiveSortUtilities
{
	internal static int FloorLog2PlusOne(int n)
	{
		int num = 0;
		while (n >= 1)
		{
			num++;
			n /= 2;
		}
		return num;
	}

	internal static void ThrowOrIgnoreBadComparer(object comparer)
	{
		throw new ArgumentException(SR.Format("Unable to sort because the IComparer.Compare() method returns inconsistent results. Either a value does not compare equal to itself, or one value repeatedly compared to another value yields different results. IComparer: '{0}'.", comparer));
	}
}
