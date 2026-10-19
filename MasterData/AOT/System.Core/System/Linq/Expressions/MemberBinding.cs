using System.Reflection;

namespace System.Linq.Expressions;

public abstract class MemberBinding
{
	public MemberBindingType BindingType { get; }

	public MemberInfo Member { get; }
}
