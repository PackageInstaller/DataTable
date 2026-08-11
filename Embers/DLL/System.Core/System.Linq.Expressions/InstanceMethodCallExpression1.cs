using System.Collections.Generic;
using System.Collections.ObjectModel;
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

	internal override ReadOnlyCollection<Expression> GetOrMakeArguments()
	{
		return ExpressionUtils.ReturnReadOnly(this, ref _arg0);
	}

	internal override MethodCallExpression Rewrite(Expression instance, IReadOnlyList<Expression> args)
	{
		if (args != null)
		{
			return Expression.Call(instance, base.Method, args[0]);
		}
		return Expression.Call(instance, base.Method, ExpressionUtils.ReturnObject<Expression>(_arg0));
	}
}
