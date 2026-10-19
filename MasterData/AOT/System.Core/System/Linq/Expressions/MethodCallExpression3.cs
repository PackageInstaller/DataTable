using System.Collections.Generic;
using System.Dynamic.Utils;
using System.Reflection;

namespace System.Linq.Expressions;

internal sealed class MethodCallExpression3 : MethodCallExpression, IArgumentProvider
{
	private object _arg0;

	private readonly Expression _arg1;

	private readonly Expression _arg2;

	public override int ArgumentCount => 3;

	public MethodCallExpression3(MethodInfo method, Expression arg0, Expression arg1, Expression arg2)
		: base(method)
	{
		_arg0 = arg0;
		_arg1 = arg1;
		_arg2 = arg2;
	}

	public override Expression GetArgument(int index)
	{
		return index switch
		{
			0 => ExpressionUtils.ReturnObject<Expression>(_arg0), 
			1 => _arg1, 
			2 => _arg2, 
			_ => throw new ArgumentOutOfRangeException("index"), 
		};
	}

	internal override MethodCallExpression Rewrite(Expression instance, IReadOnlyList<Expression> args)
	{
		if (args != null)
		{
			return Expression.Call(Method, args[0], args[1], args[2]);
		}
		return Expression.Call(Method, ExpressionUtils.ReturnObject<Expression>(_arg0), _arg1, _arg2);
	}
}
