using System.Collections.ObjectModel;

namespace System.Linq.Expressions;

public sealed class MemberListBinding : MemberBinding
{
	public ReadOnlyCollection<ElementInit> Initializers { get; }
}
