using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Dynamic.Utils;
using System.Reflection;

namespace System.Linq.Expressions;

internal sealed class MethodCallExpressionN : MethodCallExpression, IArgumentProvider
{
	private IReadOnlyList<Expression> _arguments;

	public override int ArgumentCount => _arguments.Count;

	public MethodCallExpressionN(MethodInfo method, IReadOnlyList<Expression> args)
		: base(method)
	{
		_arguments = args;
	}

	public override Expression GetArgument(int index)
	{
		return _arguments[index];
	}

	internal override ReadOnlyCollection<Expression> GetOrMakeArguments()
	{
		return ExpressionUtils.ReturnReadOnly(ref _arguments);
	}

	internal override bool SameArguments(ICollection<Expression> arguments)
	{
		return ExpressionUtils.SameElements(arguments, _arguments);
	}

	internal override MethodCallExpression Rewrite(Expression instance, IReadOnlyList<Expression> args)
	{
		return Expression.Call(base.Method, args ?? _arguments);
	}
}
