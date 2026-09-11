using System.Runtime.CompilerServices;

namespace System.Linq.Expressions;

internal sealed class TypedDynamicExpression3 : DynamicExpression3
{
	public sealed override Type Type { get; }

	internal TypedDynamicExpression3(Type retType, Type delegateType, CallSiteBinder binder, Expression arg0, Expression arg1, Expression arg2)
		: base(delegateType, binder, arg0, arg1, arg2)
	{
		Type = retType;
	}
}
