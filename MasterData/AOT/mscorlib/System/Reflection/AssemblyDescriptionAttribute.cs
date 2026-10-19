using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyDescriptionAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string Description__BackingField;

	public AssemblyDescriptionAttribute(string description)
	{
		Description__BackingField = description;
	}
}
