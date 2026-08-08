using System.Reflection;
using System.Runtime.InteropServices;

namespace System.Runtime.Remoting;

[ComVisible(true)]
public class ActivatedServiceTypeEntry : TypeEntry
{
	private Type obj_type;

	public Type ObjectType => obj_type;

	public ActivatedServiceTypeEntry(string typeName, string assemblyName)
	{
		base.AssemblyName = assemblyName;
		base.TypeName = typeName;
		Assembly assembly = Assembly.Load(assemblyName);
		obj_type = assembly.GetType(typeName);
		if (obj_type == null)
		{
			throw new RemotingException("Type not found: " + typeName + ", " + assemblyName);
		}
	}

	public override string ToString()
	{
		return base.AssemblyName + base.TypeName;
	}
}
