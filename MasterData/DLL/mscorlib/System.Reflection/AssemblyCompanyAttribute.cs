using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyCompanyAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string _003CCompany_003Ek__BackingField;

	public AssemblyCompanyAttribute(string company)
	{
		_003CCompany_003Ek__BackingField = company;
	}
}
