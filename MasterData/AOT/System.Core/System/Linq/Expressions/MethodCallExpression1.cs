using System.Collections.Generic;
using System.Dynamic.Utils;
using System.Reflection;

namespace System.Linq.Expressions;

internal sealed class MethodCallExpression1 : MethodCallExpression, IArgumentProvider
{
	private object _arg0;

	public override int ArgumentCount => 1;

	public MethodCallExpression1(MethodInfo method, Expression arg0)
		: base(method)
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
			return Expression.Call(Method, args[0]);
		}
		return Expression.Call(Method, ExpressionUtils.ReturnObject<Expression>(_arg0));
	}
}
