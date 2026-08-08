using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyTitleAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string _003CTitle_003Ek__BackingField;

	public AssemblyTitleAttribute(string title)
	{
		_003CTitle_003Ek__BackingField = title;
	}
}
