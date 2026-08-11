using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Dynamic.Utils;
using System.Reflection;

namespace System.Linq.Expressions;

internal sealed class MethodCallExpression5 : MethodCallExpression, IArgumentProvider
{
	private object _arg0;

	private readonly Expression _arg1;

	private readonly Expression _arg2;

	private readonly Expression _arg3;

	private readonly Expression _arg4;

	public override int ArgumentCount => 5;

	public MethodCallExpression5(MethodInfo method, Expression arg0, Expression arg1, Expression arg2, Expression arg3, Expression arg4)
		: base(method)
	{
		_arg0 = arg0;
		_arg1 = arg1;
		_arg2 = arg2;
		_arg3 = arg3;
		_arg4 = arg4;
	}

	public override Expression GetArgument(int index)
	{
		return index switch
		{
			0 => ExpressionUtils.ReturnObject<Expression>(_arg0), 
			1 => _arg1, 
			2 => _arg2, 
			3 => _arg3, 
			4 => _arg4, 
			_ => throw new ArgumentOutOfRangeException("index"), 
		};
	}

	internal override bool SameArguments(ICollection<Expression> arguments)
	{
		if (arguments != null && arguments.Count == 5)
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
				if (enumerator.Current == _arg1)
				{
					enumerator.MoveNext();
					if (enumerator.Current == _arg2)
					{
						enumerator.MoveNext();
						if (enumerator.Current == _arg3)
						{
							enumerator.MoveNext();
							return enumerator.Current == _arg4;
						}
					}
				}
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
			return Expression.Call(base.Method, args[0], args[1], args[2], args[3], args[4]);
		}
		return Expression.Call(base.Method, ExpressionUtils.ReturnObject<Expression>(_arg0), _arg1, _arg2, _arg3, _arg4);
	}
}
