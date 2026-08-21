using System.Reflection;
using System.Runtime.InteropServices;

namespace System.Runtime.Remoting;

[ComVisible(true)]
public class WellKnownServiceTypeEntry : TypeEntry
{
	private Type obj_type;

	private string obj_uri;

	private WellKnownObjectMode obj_mode;

	public WellKnownObjectMode Mode => obj_mode;

	public Type ObjectType => obj_type;

	public string ObjectUri => obj_uri;

	public WellKnownServiceTypeEntry(string typeName, string assemblyName, string objectUri, WellKnownObjectMode mode)
	{
		base.AssemblyName = assemblyName;
		base.TypeName = typeName;
		Assembly assembly = Assembly.Load(assemblyName);
		obj_type = assembly.GetType(typeName);
		obj_uri = objectUri;
		obj_mode = mode;
		if (obj_type == null)
		{
			throw new RemotingException("Type not found: " + typeName + ", " + assemblyName);
		}
	}

	public override string ToString()
	{
		return base.TypeName + ", " + base.AssemblyName + " " + ObjectUri;
	}
}
