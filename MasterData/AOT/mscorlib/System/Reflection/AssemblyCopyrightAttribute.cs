using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyCopyrightAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string Copyright__BackingField;

	public AssemblyCopyrightAttribute(string copyright)
	{
		Copyright__BackingField = copyright;
	}
}
