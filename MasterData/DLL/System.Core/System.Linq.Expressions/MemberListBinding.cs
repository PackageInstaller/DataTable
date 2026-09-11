using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Dynamic.Utils;
using System.Reflection;

namespace System.Linq.Expressions;

public sealed class MemberListBinding : MemberBinding
{
	public ReadOnlyCollection<ElementInit> Initializers { get; }

	internal MemberListBinding(MemberInfo member, ReadOnlyCollection<ElementInit> initializers)
		: base(MemberBindingType.ListBinding, member)
	{
		Initializers = initializers;
	}

	public MemberListBinding Update(IEnumerable<ElementInit> initializers)
	{
		if (initializers != null && ExpressionUtils.SameElements(ref initializers, Initializers))
		{
			return this;
		}
		return Expression.ListBind(base.Member, initializers);
	}

	internal override void ValidateAsDefinedHere(int index)
	{
	}
}
