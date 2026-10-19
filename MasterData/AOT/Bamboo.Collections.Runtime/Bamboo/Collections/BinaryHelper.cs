namespace Bamboo.Collections;

internal static class BinaryHelper
{
	internal const int MIN_BIT = 3;

	internal const int MAX_BIT = 10;

	public static int GetAlignSize(int length)
	{
		for (int i = 3; i <= 10; i++)
		{
			int num = Power2Helper.Get(i);
			if (length <= num)
			{
				return num;
			}
		}
		return length;
	}
}
