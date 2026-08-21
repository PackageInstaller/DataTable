using System.Runtime.InteropServices;

namespace System.Diagnostics;

[AttributeUsage(AttributeTargets.Assembly | AttributeTargets.Class | AttributeTargets.Struct, AllowMultiple = true)]
[ComVisible(true)]
public sealed class DebuggerTypeProxyAttribute : Attribute
{
	private string typeName;

	public DebuggerTypeProxyAttribute(Type type)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		typeName = type.AssemblyQualifiedName;
	}
}
