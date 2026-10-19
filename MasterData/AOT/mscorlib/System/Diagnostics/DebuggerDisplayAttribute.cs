using System.Runtime.InteropServices;

namespace System.Diagnostics;

[ComVisible(true)]
[AttributeUsage(AttributeTargets.Assembly | AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Enum | AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Delegate, AllowMultiple = true)]
public sealed class DebuggerDisplayAttribute : Attribute
{
	private string name;

	private string value;

	private string type;

	public string Name
	{
		set
		{
			name = value;
		}
	}

	public string Type
	{
		set
		{
			type = value;
		}
	}

	public DebuggerDisplayAttribute(string value)
	{
		if (value == null)
		{
			this.value = "";
		}
		else
		{
			this.value = value;
		}
		name = "";
		type = "";
	}
}
