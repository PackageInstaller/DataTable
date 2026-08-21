using System.Diagnostics;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(Expression.CatchBlockProxy))]
public sealed class CatchBlock
{
	public ParameterExpression Variable { get; }

	public Type Test { get; }

	public Expression Body { get; }

	public Expression Filter { get; }

	internal CatchBlock(Type test, ParameterExpression variable, Expression body, Expression filter)
	{
		Test = test;
		Variable = variable;
		Body = body;
		Filter = filter;
	}

	public override string ToString()
	{
		return ExpressionStringBuilder.CatchBlockToString(this);
	}

	public CatchBlock Update(ParameterExpression variable, Expression filter, Expression body)
	{
		if (variable == Variable && filter == Filter && body == Body)
		{
			return this;
		}
		return Expression.MakeCatchBlock(Test, variable, body, filter);
	}
}
