using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace System.Linq.Expressions;

internal class TypedDynamicExpressionN : DynamicExpressionN
{
	public sealed override Type Type { get; }

	internal TypedDynamicExpressionN(Type returnType, Type delegateType, CallSiteBinder binder, IReadOnlyList<Expression> arguments)
		: base(delegateType, binder, arguments)
	{
		Type = returnType;
	}
}
