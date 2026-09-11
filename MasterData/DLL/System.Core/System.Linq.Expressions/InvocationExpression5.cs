using System.Collections.ObjectModel;
using System.Dynamic.Utils;

namespace System.Linq.Expressions;

internal sealed class InvocationExpression5 : InvocationExpression
{
	private object _arg0;

	private readonly Expression _arg1;

	private readonly Expression _arg2;

	private readonly Expression _arg3;

	private readonly Expression _arg4;

	public override int ArgumentCount => 5;

	public InvocationExpression5(Expression lambda, Type returnType, Expression arg0, Expression arg1, Expression arg2, Expression arg3, Expression arg4)
		: base(lambda, returnType)
	{
		_arg0 = arg0;
		_arg1 = arg1;
		_arg2 = arg2;
		_arg3 = arg3;
		_arg4 = arg4;
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
			3 => _arg3, 
			4 => _arg4, 
			_ => throw new ArgumentOutOfRangeException("index"), 
		};
	}

	internal override InvocationExpression Rewrite(Expression lambda, Expression[] arguments)
	{
		if (arguments != null)
		{
			return Expression.Invoke(lambda, arguments[0], arguments[1], arguments[2], arguments[3], arguments[4]);
		}
		return Expression.Invoke(lambda, ExpressionUtils.ReturnObject<Expression>(_arg0), _arg1, _arg2, _arg3, _arg4);
	}
}
