using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Dynamic.Utils;
using System.Reflection;

namespace System.Linq.Expressions;

public sealed class MemberMemberBinding : MemberBinding
{
	public ReadOnlyCollection<MemberBinding> Bindings { get; }

	internal MemberMemberBinding(MemberInfo member, ReadOnlyCollection<MemberBinding> bindings)
		: base(MemberBindingType.MemberBinding, member)
	{
		Bindings = bindings;
	}

	public MemberMemberBinding Update(IEnumerable<MemberBinding> bindings)
	{
		if (bindings != null && ExpressionUtils.SameElements(ref bindings, Bindings))
		{
			return this;
		}
		return Expression.MemberBind(base.Member, bindings);
	}

	internal override void ValidateAsDefinedHere(int index)
	{
	}
}
