using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyCompanyAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string Company__BackingField;

	public AssemblyCompanyAttribute(string company)
	{
		Company__BackingField = company;
	}
}
