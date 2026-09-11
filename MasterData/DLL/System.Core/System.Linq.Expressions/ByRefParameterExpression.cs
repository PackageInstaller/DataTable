namespace System.Linq.Expressions;

internal sealed class ByRefParameterExpression : TypedParameterExpression
{
	internal ByRefParameterExpression(Type type, string name)
		: base(type, name)
	{
	}

	internal override bool GetIsByRef()
	{
		return true;
	}
}
