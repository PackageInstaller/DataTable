namespace System.Linq.Expressions;

internal class FullConditionalExpression : ConditionalExpression
{
	private readonly Expression _false;

	internal FullConditionalExpression(Expression test, Expression ifTrue, Expression ifFalse)
		: base(test, ifTrue)
	{
		_false = ifFalse;
	}

	internal override Expression GetFalse()
	{
		return _false;
	}
}
