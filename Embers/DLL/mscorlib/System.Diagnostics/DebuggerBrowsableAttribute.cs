using System.Runtime.InteropServices;

namespace System.Diagnostics;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = false)]
[ComVisible(true)]
public sealed class DebuggerBrowsableAttribute : Attribute
{
	private DebuggerBrowsableState state;

	public DebuggerBrowsableState State => state;

	public DebuggerBrowsableAttribute(DebuggerBrowsableState state)
	{
		if (state < DebuggerBrowsableState.Never || state > DebuggerBrowsableState.RootHidden)
		{
			throw new ArgumentOutOfRangeException("state");
		}
		this.state = state;
	}
}
