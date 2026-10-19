using System.Collections.ObjectModel;
using System.Diagnostics;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(MemberInitExpressionProxy))]
public sealed class MemberInitExpression : Expression
{
	public NewExpression NewExpression { get; }

	public ReadOnlyCollection<MemberBinding> Bindings { get; }
}
