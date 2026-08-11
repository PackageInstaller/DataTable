using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyCopyrightAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string _003CCopyright_003Ek__BackingField;

	public AssemblyCopyrightAttribute(string copyright)
	{
		_003CCopyright_003Ek__BackingField = copyright;
	}
}
