using System.Collections.ObjectModel;
using System.Diagnostics;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(ListInitExpressionProxy))]
public sealed class ListInitExpression : Expression
{
	public NewExpression NewExpression { get; }

	public ReadOnlyCollection<ElementInit> Initializers { get; }
}
