using System.Runtime.InteropServices;

namespace System.Diagnostics;

[Serializable]
[ComVisible(true)]
[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Constructor | AttributeTargets.Method, Inherited = false)]
public sealed class DebuggerStepThroughAttribute : Attribute
{
}
