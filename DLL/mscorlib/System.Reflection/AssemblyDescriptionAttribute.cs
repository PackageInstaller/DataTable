using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyDescriptionAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string _003CDescription_003Ek__BackingField;

	public AssemblyDescriptionAttribute(string description)
	{
		_003CDescription_003Ek__BackingField = description;
	}
}
