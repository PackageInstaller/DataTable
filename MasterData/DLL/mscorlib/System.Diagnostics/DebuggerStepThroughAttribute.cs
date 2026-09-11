using System.Runtime.InteropServices;

namespace System.Diagnostics;

[Serializable]
[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Constructor | AttributeTargets.Method, Inherited = false)]
[ComVisible(true)]
public sealed class DebuggerStepThroughAttribute : Attribute
{
}
