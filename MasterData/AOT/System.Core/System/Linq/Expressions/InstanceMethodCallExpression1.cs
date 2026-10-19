using System.Collections.Generic;
using System.Dynamic.Utils;
using System.Reflection;

namespace System.Linq.Expressions;

internal sealed class InstanceMethodCallExpression1 : InstanceMethodCallExpression, IArgumentProvider
{
	private object _arg0;

	public override int ArgumentCount => 1;

	public InstanceMethodCallExpression1(MethodInfo method, Expression instance, Expression arg0)
		: base(method, instance)
	{
		_arg0 = arg0;
	}

	public override Expression GetArgument(int index)
	{
		if (index == 0)
		{
			return ExpressionUtils.ReturnObject<Expression>(_arg0);
		}
		throw new ArgumentOutOfRangeException("index");
	}

	internal override MethodCallExpression Rewrite(Expression instance, IReadOnlyList<Expression> args)
	{
		if (args != null)
		{
			return Expression.Call(instance, Method, args[0]);
		}
		return Expression.Call(instance, Method, ExpressionUtils.ReturnObject<Expression>(_arg0));
	}
}
