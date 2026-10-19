using System.Collections.ObjectModel;

namespace System.Linq.Expressions;

public sealed class MemberMemberBinding : MemberBinding
{
	public ReadOnlyCollection<MemberBinding> Bindings { get; }
}
