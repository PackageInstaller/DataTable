using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyConfigurationAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string _003CConfiguration_003Ek__BackingField;

	public AssemblyConfigurationAttribute(string configuration)
	{
		_003CConfiguration_003Ek__BackingField = configuration;
	}
}
