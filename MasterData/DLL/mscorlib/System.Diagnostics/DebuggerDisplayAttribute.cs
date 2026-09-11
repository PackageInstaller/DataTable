using System.Runtime.InteropServices;

namespace System.Diagnostics;

[AttributeUsage(AttributeTargets.Assembly | AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Enum | AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Delegate, AllowMultiple = true)]
[ComVisible(true)]
public sealed class DebuggerDisplayAttribute : Attribute
{
	private string name;

	private string value;

	private string type;

	private string targetName;

	private Type target;

	public string Value => value;

	public string Name
	{
		get
		{
			return name;
		}
		set
		{
			name = value;
		}
	}

	public string Type
	{
		get
		{
			return type;
		}
		set
		{
			type = value;
		}
	}

	public Type Target
	{
		get
		{
			return target;
		}
		set
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			targetName = value.AssemblyQualifiedName;
			target = value;
		}
	}

	public string TargetTypeName
	{
		get
		{
			return targetName;
		}
		set
		{
			targetName = value;
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
