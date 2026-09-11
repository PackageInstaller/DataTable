using System.Reflection;
using System.Runtime.InteropServices;
using System.Runtime.Remoting.Contexts;

namespace System.Runtime.Remoting;

[ComVisible(true)]
public class ActivatedClientTypeEntry : TypeEntry
{
	private string applicationUrl;

	private Type obj_type;

	public string ApplicationUrl => applicationUrl;

	public IContextAttribute[] ContextAttributes => null;

	public Type ObjectType => obj_type;

	public ActivatedClientTypeEntry(string typeName, string assemblyName, string appUrl)
	{
		base.AssemblyName = assemblyName;
		base.TypeName = typeName;
		applicationUrl = appUrl;
		Assembly assembly = Assembly.Load(assemblyName);
		obj_type = assembly.GetType(typeName);
		if (obj_type == null)
		{
			throw new RemotingException("Type not found: " + typeName + ", " + assemblyName);
		}
	}

	public override string ToString()
	{
		return base.TypeName + base.AssemblyName + ApplicationUrl;
	}
}
