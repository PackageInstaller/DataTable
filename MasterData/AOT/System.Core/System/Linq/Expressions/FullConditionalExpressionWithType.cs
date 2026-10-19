namespace System.Linq.Expressions;

internal sealed class FullConditionalExpressionWithType : FullConditionalExpression
{
	public sealed override Type Type { get; }

	internal FullConditionalExpressionWithType(Expression test, Expression ifTrue, Expression ifFalse, Type type)
		: base(test, ifTrue, ifFalse)
	{
		Type = type;
	}
}
