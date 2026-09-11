using System.Runtime.InteropServices;

namespace System.Diagnostics;

[ComVisible(true)]
[AttributeUsage(AttributeTargets.Assembly | AttributeTargets.Class | AttributeTargets.Struct, AllowMultiple = true)]
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
