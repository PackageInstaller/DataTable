using System.Collections.ObjectModel;
using System.Dynamic.Utils;
using System.Runtime.CompilerServices;

namespace System.Linq.Expressions;

internal class DynamicExpression4 : DynamicExpression, IArgumentProvider
{
	private object _arg0;

	private readonly Expression _arg1;

	private readonly Expression _arg2;

	private readonly Expression _arg3;

	int IArgumentProvider.ArgumentCount => 4;

	internal DynamicExpression4(Type delegateType, CallSiteBinder binder, Expression arg0, Expression arg1, Expression arg2, Expression arg3)
		: base(delegateType, binder)
	{
		_arg0 = arg0;
		_arg1 = arg1;
		_arg2 = arg2;
		_arg3 = arg3;
	}

	Expression IArgumentProvider.GetArgument(int index)
	{
		return index switch
		{
			0 => ExpressionUtils.ReturnObject<Expression>(_arg0), 
			1 => _arg1, 
			2 => _arg2, 
			3 => _arg3, 
			_ => throw new ArgumentOutOfRangeException("index"), 
		};
	}

	internal override ReadOnlyCollection<Expression> GetOrMakeArguments()
	{
		return ExpressionUtils.ReturnReadOnly(this, ref _arg0);
	}

	internal override DynamicExpression Rewrite(Expression[] args)
	{
		return ExpressionExtension.MakeDynamic(base.DelegateType, base.Binder, args[0], args[1], args[2], args[3]);
	}
}
