using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Dynamic.Utils;
using System.Reflection;

namespace System.Linq.Expressions;

internal sealed class InstanceMethodCallExpression2 : InstanceMethodCallExpression, IArgumentProvider
{
	private object _arg0;

	private readonly Expression _arg1;

	public override int ArgumentCount => 2;

	public InstanceMethodCallExpression2(MethodInfo method, Expression instance, Expression arg0, Expression arg1)
		: base(method, instance)
	{
		_arg0 = arg0;
		_arg1 = arg1;
	}

	public override Expression GetArgument(int index)
	{
		return index switch
		{
			0 => ExpressionUtils.ReturnObject<Expression>(_arg0), 
			1 => _arg1, 
			_ => throw new ArgumentOutOfRangeException("index"), 
		};
	}

	internal override bool SameArguments(ICollection<Expression> arguments)
	{
		if (arguments != null && arguments.Count == 2)
		{
			if (_arg0 is ReadOnlyCollection<Expression> current)
			{
				return ExpressionUtils.SameElements(arguments, current);
			}
			using IEnumerator<Expression> enumerator = arguments.GetEnumerator();
			enumerator.MoveNext();
			if (enumerator.Current == _arg0)
			{
				enumerator.MoveNext();
				return enumerator.Current == _arg1;
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
			return Expression.Call(instance, base.Method, args[0], args[1]);
		}
		return Expression.Call(instance, base.Method, ExpressionUtils.ReturnObject<Expression>(_arg0), _arg1);
	}
}
