using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Dynamic.Utils;
using System.Reflection;

namespace System.Linq.Expressions;

internal sealed class InstanceMethodCallExpression3 : InstanceMethodCallExpression, IArgumentProvider
{
	private object _arg0;

	private readonly Expression _arg1;

	private readonly Expression _arg2;

	public override int ArgumentCount => 3;

	public InstanceMethodCallExpression3(MethodInfo method, Expression instance, Expression arg0, Expression arg1, Expression arg2)
		: base(method, instance)
	{
		_arg0 = arg0;
		_arg1 = arg1;
		_arg2 = arg2;
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

	internal override ReadOnlyCollection<Expression> GetOrMakeArguments()
	{
		return ExpressionUtils.ReturnReadOnly(this, ref _arg0);
	}

	internal override MethodCallExpression Rewrite(Expression instance, IReadOnlyList<Expression> args)
	{
		if (args != null)
		{
			return Expression.Call(instance, base.Method, args[0], args[1], args[2]);
		}
		return Expression.Call(instance, base.Method, ExpressionUtils.ReturnObject<Expression>(_arg0), _arg1, _arg2);
	}
}
