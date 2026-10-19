using System.Collections.ObjectModel;
using System.Dynamic.Utils;

namespace System.Linq.Expressions;

internal sealed class Block2 : BlockExpression
{
	private object _arg0;

	private readonly Expression _arg1;

	internal override int ExpressionCount => 2;

	internal Block2(Expression arg0, Expression arg1)
	{
		_arg0 = arg0;
		_arg1 = arg1;
	}

	internal override Expression GetExpression(int index)
	{
		return index switch
		{
			0 => ExpressionUtils.ReturnObject<Expression>(_arg0), 
			1 => _arg1, 
			_ => throw Error.ArgumentOutOfRange("index"), 
		};
	}

	internal override ReadOnlyCollection<Expression> GetOrMakeExpressions()
	{
		return BlockExpression.ReturnReadOnlyExpressions(this, ref _arg0);
	}

	internal override BlockExpression Rewrite(ReadOnlyCollection<ParameterExpression> variables, Expression[] args)
	{
		return new Block2(args[0], args[1]);
	}
}
