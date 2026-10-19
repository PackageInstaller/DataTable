using System.Collections.Generic;
using System.Reflection;

namespace System.Linq.Expressions;

internal sealed class MethodCallExpression0 : MethodCallExpression, IArgumentProvider
{
	public override int ArgumentCount => 0;

	public MethodCallExpression0(MethodInfo method)
		: base(method)
	{
	}

	public override Expression GetArgument(int index)
	{
		throw new ArgumentOutOfRangeException("index");
	}

	internal override MethodCallExpression Rewrite(Expression instance, IReadOnlyList<Expression> args)
	{
		return Expression.Call(Method);
	}
}
