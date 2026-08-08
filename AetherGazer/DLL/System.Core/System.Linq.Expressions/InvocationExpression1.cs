using System.Collections.ObjectModel;
using System.Dynamic.Utils;

namespace System.Linq.Expressions;

internal sealed class InvocationExpression1 : InvocationExpression
{
	private object _arg0;

	public override int ArgumentCount => 1;

	public InvocationExpression1(Expression lambda, Type returnType, Expression arg0)
		: base(lambda, returnType)
	{
		_arg0 = arg0;
	}

	internal override ReadOnlyCollection<Expression> GetOrMakeArguments()
	{
		return ExpressionUtils.ReturnReadOnly(this, ref _arg0);
	}

	public override Expression GetArgument(int index)
	{
		if (index == 0)
		{
			return ExpressionUtils.ReturnObject<Expression>(_arg0);
		}
		throw new ArgumentOutOfRangeException("index");
	}

	internal override InvocationExpression Rewrite(Expression lambda, Expression[] arguments)
	{
		if (arguments != null)
		{
			return Expression.Invoke(lambda, arguments[0]);
		}
		return Expression.Invoke(lambda, ExpressionUtils.ReturnObject<Expression>(_arg0));
	}
}
