using System.Runtime.InteropServices;

namespace System.Diagnostics;

[Serializable]
[ComVisible(true)]
[AttributeUsage(AttributeTargets.Constructor | AttributeTargets.Method | AttributeTargets.Property, Inherited = false)]
public sealed class DebuggerHiddenAttribute : Attribute
{
}
