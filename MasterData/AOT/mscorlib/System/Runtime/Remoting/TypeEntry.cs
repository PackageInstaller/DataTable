using System.Runtime.InteropServices;

namespace System.Runtime.Remoting;

[ComVisible(true)]
public class TypeEntry
{
	private string assembly_name;

	private string type_name;

	public string AssemblyName
	{
		get
		{
			return assembly_name;
		}
		set
		{
			assembly_name = value;
		}
	}

	public string TypeName
	{
		get
		{
			return type_name;
		}
		set
		{
			type_name = value;
		}
	}

	protected TypeEntry()
	{
	}
}
