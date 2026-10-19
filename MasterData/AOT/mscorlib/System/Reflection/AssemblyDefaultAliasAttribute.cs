using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyDefaultAliasAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string DefaultAlias__BackingField;

	public AssemblyDefaultAliasAttribute(string defaultAlias)
	{
		DefaultAlias__BackingField = defaultAlias;
	}
}
