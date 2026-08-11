using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyInformationalVersionAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string _003CInformationalVersion_003Ek__BackingField;

	public AssemblyInformationalVersionAttribute(string informationalVersion)
	{
		_003CInformationalVersion_003Ek__BackingField = informationalVersion;
	}
}
