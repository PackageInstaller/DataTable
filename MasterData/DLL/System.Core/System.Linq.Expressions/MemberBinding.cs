using System.Reflection;

namespace System.Linq.Expressions;

public abstract class MemberBinding
{
	public MemberBindingType BindingType { get; }

	public MemberInfo Member { get; }

	[Obsolete("Do not use this constructor. It will be removed in future releases.")]
	protected MemberBinding(MemberBindingType type, MemberInfo member)
	{
		BindingType = type;
		Member = member;
	}

	public override string ToString()
	{
		return ExpressionStringBuilder.MemberBindingToString(this);
	}

	internal virtual void ValidateAsDefinedHere(int index)
	{
		throw Error.UnknownBindingType(index);
	}
}
