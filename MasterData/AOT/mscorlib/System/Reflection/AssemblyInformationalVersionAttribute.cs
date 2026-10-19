using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyInformationalVersionAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string InformationalVersion__BackingField;

	public AssemblyInformationalVersionAttribute(string informationalVersion)
	{
		InformationalVersion__BackingField = informationalVersion;
	}
}
