using System.Runtime.CompilerServices;

namespace System.Diagnostics.CodeAnalysis;

[AttributeUsage(AttributeTargets.Parameter, AllowMultiple = false)]
internal sealed class NotNullWhenAttribute : Attribute
{
	[CompilerGenerated]
	private readonly bool ReturnValue__BackingField;

	public NotNullWhenAttribute(bool returnValue)
	{
		ReturnValue__BackingField = returnValue;
	}
}
