using System.Collections.Generic;
using System.Reflection;

namespace System.Linq.Expressions;

internal sealed class InstanceMethodCallExpression0 : InstanceMethodCallExpression, IArgumentProvider
{
	public override int ArgumentCount => 0;

	public InstanceMethodCallExpression0(MethodInfo method, Expression instance)
		: base(method, instance)
	{
	}

	public override Expression GetArgument(int index)
	{
		throw new ArgumentOutOfRangeException("index");
	}

	internal override MethodCallExpression Rewrite(Expression instance, IReadOnlyList<Expression> args)
	{
		return Expression.Call(instance, Method);
	}
}
