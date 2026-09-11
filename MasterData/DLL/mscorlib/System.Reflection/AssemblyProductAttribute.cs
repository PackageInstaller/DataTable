using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyProductAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string _003CProduct_003Ek__BackingField;

	public AssemblyProductAttribute(string product)
	{
		_003CProduct_003Ek__BackingField = product;
	}
}
