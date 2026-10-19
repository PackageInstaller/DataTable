namespace System.Linq.Expressions.Interpreter;

internal static class ConvertHelper
{
	public static int ToInt32NoNull(object val)
	{
		if (val != null)
		{
			return Convert.ToInt32(val);
		}
		return ((int?)val).Value;
	}
}
