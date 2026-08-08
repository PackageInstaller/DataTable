using System.Runtime.CompilerServices;

namespace System.Linq.Expressions;

internal sealed class TypedDynamicExpression2 : DynamicExpression2
{
	public sealed override Type Type { get; }

	internal TypedDynamicExpression2(Type retType, Type delegateType, CallSiteBinder binder, Expression arg0, Expression arg1)
		: base(delegateType, binder, arg0, arg1)
	{
		Type = retType;
	}
}
