using System.Collections.ObjectModel;
using System.Dynamic.Utils;

namespace System.Linq.Expressions;

internal sealed class InvocationExpression3 : InvocationExpression
{
	private object _arg0;

	private readonly Expression _arg1;

	private readonly Expression _arg2;

	public override int ArgumentCount => 3;

	public InvocationExpression3(Expression lambda, Type returnType, Expression arg0, Expression arg1, Expression arg2)
		: base(lambda, returnType)
	{
		_arg0 = arg0;
		_arg1 = arg1;
		_arg2 = arg2;
	}

	internal override ReadOnlyCollection<Expression> GetOrMakeArguments()
	{
		return ExpressionUtils.ReturnReadOnly(this, ref _arg0);
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

	internal override InvocationExpression Rewrite(Expression lambda, Expression[] arguments)
	{
		if (arguments != null)
		{
			return Expression.Invoke(lambda, arguments[0], arguments[1], arguments[2]);
		}
		return Expression.Invoke(lambda, ExpressionUtils.ReturnObject<Expression>(_arg0), _arg1, _arg2);
	}
}
