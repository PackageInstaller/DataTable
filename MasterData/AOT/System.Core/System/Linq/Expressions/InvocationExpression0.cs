namespace System.Linq.Expressions;

internal sealed class InvocationExpression0 : InvocationExpression
{
	public override int ArgumentCount => 0;

	public InvocationExpression0(Expression lambda, Type returnType)
		: base(lambda, returnType)
	{
	}

	public override Expression GetArgument(int index)
	{
		throw new ArgumentOutOfRangeException("index");
	}

	internal override InvocationExpression Rewrite(Expression lambda, Expression[] arguments)
	{
		return Expression.Invoke(lambda);
	}
}
