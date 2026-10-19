using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyTitleAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string Title__BackingField;

	public AssemblyTitleAttribute(string title)
	{
		Title__BackingField = title;
	}
}
