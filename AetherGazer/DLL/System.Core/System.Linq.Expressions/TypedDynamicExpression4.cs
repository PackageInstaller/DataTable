using System.Runtime.CompilerServices;

namespace System.Linq.Expressions;

internal sealed class TypedDynamicExpression4 : DynamicExpression4
{
	public sealed override Type Type { get; }

	internal TypedDynamicExpression4(Type retType, Type delegateType, CallSiteBinder binder, Expression arg0, Expression arg1, Expression arg2, Expression arg3)
		: base(delegateType, binder, arg0, arg1, arg2, arg3)
	{
		Type = retType;
	}
}
