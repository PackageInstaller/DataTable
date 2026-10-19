using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyTrademarkAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string Trademark__BackingField;

	public AssemblyTrademarkAttribute(string trademark)
	{
		Trademark__BackingField = trademark;
	}
}
