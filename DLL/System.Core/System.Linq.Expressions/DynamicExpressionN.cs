using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Dynamic.Utils;
using System.Runtime.CompilerServices;

namespace System.Linq.Expressions;

internal class DynamicExpressionN : DynamicExpression, IArgumentProvider
{
	private IReadOnlyList<Expression> _arguments;

	int IArgumentProvider.ArgumentCount => _arguments.Count;

	internal DynamicExpressionN(Type delegateType, CallSiteBinder binder, IReadOnlyList<Expression> arguments)
		: base(delegateType, binder)
	{
		_arguments = arguments;
	}

	Expression IArgumentProvider.GetArgument(int index)
	{
		return _arguments[index];
	}

	internal override ReadOnlyCollection<Expression> GetOrMakeArguments()
	{
		return ExpressionUtils.ReturnReadOnly(ref _arguments);
	}

	internal override DynamicExpression Rewrite(Expression[] args)
	{
		return ExpressionExtension.MakeDynamic(base.DelegateType, base.Binder, args);
	}
}
