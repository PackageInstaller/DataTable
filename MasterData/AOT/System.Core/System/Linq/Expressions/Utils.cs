namespace System.Linq.Expressions;

internal static class Utils
{
	public static readonly object BoxedFalse = false;

	public static readonly object BoxedTrue = true;

	public static readonly object BoxedIntM1 = -1;

	public static readonly object BoxedInt0 = 0;

	public static readonly object BoxedInt1 = 1;

	public static readonly object BoxedInt2 = 2;

	public static readonly object BoxedInt3 = 3;

	public static readonly object BoxedDefaultSByte = (sbyte)0;

	public static readonly object BoxedDefaultChar = '\0';

	public static readonly object BoxedDefaultInt16 = (short)0;

	public static readonly object BoxedDefaultInt64 = 0L;

	public static readonly object BoxedDefaultByte = (byte)0;

	public static readonly object BoxedDefaultUInt16 = (ushort)0;

	public static readonly object BoxedDefaultUInt32 = 0u;

	public static readonly object BoxedDefaultUInt64 = 0uL;

	public static readonly object BoxedDefaultSingle = 0f;

	public static readonly object BoxedDefaultDouble = 0.0;

	public static readonly object BoxedDefaultDecimal = 0m;

	public static readonly object BoxedDefaultDateTime = default(DateTime);

	private static readonly ConstantExpression s_true = Expression.Constant(BoxedTrue);

	private static readonly ConstantExpression s_false = Expression.Constant(BoxedFalse);

	private static readonly ConstantExpression s_m1 = Expression.Constant(BoxedIntM1);

	private static readonly ConstantExpression s_0 = Expression.Constant(BoxedInt0);

	private static readonly ConstantExpression s_1 = Expression.Constant(BoxedInt1);

	private static readonly ConstantExpression s_2 = Expression.Constant(BoxedInt2);

	private static readonly ConstantExpression s_3 = Expression.Constant(BoxedInt3);

	public static readonly DefaultExpression Empty = Expression.Empty();

	public static readonly ConstantExpression Null = Expression.Constant(null);

	public static ConstantExpression Constant(bool value)
	{
		if (!value)
		{
			return s_false;
		}
		return s_true;
	}

	public static ConstantExpression Constant(int value)
	{
		return value switch
		{
			-1 => s_m1, 
			0 => s_0, 
			1 => s_1, 
			2 => s_2, 
			3 => s_3, 
			_ => Expression.Constant(value), 
		};
	}
}
