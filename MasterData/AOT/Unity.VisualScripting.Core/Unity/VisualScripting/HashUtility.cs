namespace Unity.VisualScripting;

public static class HashUtility
{
	public static int GetHashCode<T>(T a)
	{
		return a?.GetHashCode() ?? 0;
	}

	public static int GetHashCode<T1, T2>(T1 a, T2 b)
	{
		return (17 * 23 + (a?.GetHashCode() ?? 0)) * 23 + (b?.GetHashCode() ?? 0);
	}

	public static int GetHashCode<T1, T2, T3>(T1 a, T2 b, T3 c)
	{
		return ((17 * 23 + (a?.GetHashCode() ?? 0)) * 23 + (b?.GetHashCode() ?? 0)) * 23 + (c?.GetHashCode() ?? 0);
	}

	public static int GetHashCode<T1, T2, T3, T4>(T1 a, T2 b, T3 c, T4 d)
	{
		return (((17 * 23 + (a?.GetHashCode() ?? 0)) * 23 + (b?.GetHashCode() ?? 0)) * 23 + (c?.GetHashCode() ?? 0)) * 23 + (d?.GetHashCode() ?? 0);
	}

	public static int GetHashCode<T1, T2, T3, T4, T5>(T1 a, T2 b, T3 c, T4 d, T5 e)
	{
		return ((((17 * 23 + (a?.GetHashCode() ?? 0)) * 23 + (b?.GetHashCode() ?? 0)) * 23 + (c?.GetHashCode() ?? 0)) * 23 + (d?.GetHashCode() ?? 0)) * 23 + (e?.GetHashCode() ?? 0);
	}

	public static int GetHashCodeAlloc(params object[] values)
	{
		int num = 17;
		for (int i = 0; i < values.Length; i++)
		{
			num = num * 23 + (values[i]?.GetHashCode() ?? 0);
		}
		return num;
	}
}
