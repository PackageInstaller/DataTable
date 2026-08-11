using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyDefaultAliasAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string _003CDefaultAlias_003Ek__BackingField;

	public AssemblyDefaultAliasAttribute(string defaultAlias)
	{
		_003CDefaultAlias_003Ek__BackingField = defaultAlias;
	}
}
