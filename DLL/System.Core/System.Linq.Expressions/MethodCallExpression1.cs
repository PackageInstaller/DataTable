using System.Collections.Generic;
using System.Collections.ObjectModel;
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

	internal override ReadOnlyCollection<Expression> GetOrMakeArguments()
	{
		return ExpressionUtils.ReturnReadOnly(this, ref _arg0);
	}

	internal override bool SameArguments(ICollection<Expression> arguments)
	{
		if (arguments != null && arguments.Count == 1)
		{
			using (IEnumerator<Expression> enumerator = arguments.GetEnumerator())
			{
				enumerator.MoveNext();
				return enumerator.Current == ExpressionUtils.ReturnObject<Expression>(_arg0);
			}
		}
		return false;
	}

	internal override MethodCallExpression Rewrite(Expression instance, IReadOnlyList<Expression> args)
	{
		if (args != null)
		{
			return Expression.Call(base.Method, args[0]);
		}
		return Expression.Call(base.Method, ExpressionUtils.ReturnObject<Expression>(_arg0));
	}
}
