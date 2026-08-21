using System.Collections.ObjectModel;
using System.Dynamic.Utils;
using System.Runtime.CompilerServices;

namespace System.Linq.Expressions;

internal class DynamicExpression1 : DynamicExpression, IArgumentProvider
{
	private object _arg0;

	int IArgumentProvider.ArgumentCount => 1;

	internal DynamicExpression1(Type delegateType, CallSiteBinder binder, Expression arg0)
		: base(delegateType, binder)
	{
		_arg0 = arg0;
	}

	Expression IArgumentProvider.GetArgument(int index)
	{
		if (index == 0)
		{
			return ExpressionUtils.ReturnObject<Expression>(_arg0);
		}
		throw new ArgumentOutOfRangeException("index");
	}

	internal override ReadOnlyCollection<Expression> GetOrMakeArguments()
	{
		return ExpressionUtils.ReturnReadOnly(this, ref _arg0);
	}

	internal override DynamicExpression Rewrite(Expression[] args)
	{
		return ExpressionExtension.MakeDynamic(base.DelegateType, base.Binder, args[0]);
	}
}
