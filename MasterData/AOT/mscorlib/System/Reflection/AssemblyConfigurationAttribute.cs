using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyConfigurationAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string Configuration__BackingField;

	public AssemblyConfigurationAttribute(string configuration)
	{
		Configuration__BackingField = configuration;
	}
}
