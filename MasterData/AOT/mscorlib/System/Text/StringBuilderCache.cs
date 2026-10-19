namespace System.Text;

internal static class StringBuilderCache
{
	[ThreadStatic]
	private static StringBuilder t_cachedInstance;

	public static StringBuilder Acquire(int capacity = 16)
	{
		if (capacity <= 360)
		{
			StringBuilder stringBuilder = t_cachedInstance;
			if (stringBuilder != null && capacity <= stringBuilder.Capacity)
			{
				t_cachedInstance = null;
				stringBuilder.Clear();
				return stringBuilder;
			}
		}
		return new StringBuilder(capacity);
	}

	public static void Release(StringBuilder sb)
	{
		if (sb.Capacity <= 360)
		{
			t_cachedInstance = sb;
		}
	}

	public static string GetStringAndRelease(StringBuilder sb)
	{
		string result = sb.ToString();
		Release(sb);
		return result;
	}
}
