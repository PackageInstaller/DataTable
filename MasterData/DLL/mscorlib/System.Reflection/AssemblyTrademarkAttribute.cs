using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyTrademarkAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string _003CTrademark_003Ek__BackingField;

	public AssemblyTrademarkAttribute(string trademark)
	{
		_003CTrademark_003Ek__BackingField = trademark;
	}
}
