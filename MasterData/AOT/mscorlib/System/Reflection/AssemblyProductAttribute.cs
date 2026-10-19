using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyProductAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string Product__BackingField;

	public AssemblyProductAttribute(string product)
	{
		Product__BackingField = product;
	}
}
