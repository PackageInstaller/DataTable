using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Dynamic.Utils;

namespace System.Linq.Expressions;

internal sealed class InvocationExpressionN : InvocationExpression
{
	private IReadOnlyList<Expression> _arguments;

	public override int ArgumentCount => _arguments.Count;

	public InvocationExpressionN(Expression lambda, IReadOnlyList<Expression> arguments, Type returnType)
		: base(lambda, returnType)
	{
		_arguments = arguments;
	}

	internal override ReadOnlyCollection<Expression> GetOrMakeArguments()
	{
		return ExpressionUtils.ReturnReadOnly(ref _arguments);
	}

	public override Expression GetArgument(int index)
	{
		return _arguments[index];
	}

	internal override InvocationExpression Rewrite(Expression lambda, Expression[] arguments)
	{
		return Expression.Invoke(lambda, arguments ?? _arguments);
	}
}
