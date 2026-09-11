namespace System.Reflection;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Interface)]
public sealed class DefaultMemberAttribute : Attribute
{
	public string MemberName { get; }

	public DefaultMemberAttribute(string memberName)
	{
		MemberName = memberName;
	}
}
