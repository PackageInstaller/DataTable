namespace System.Diagnostics;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Constructor | AttributeTargets.Method, Inherited = false)]
internal sealed class StackTraceHiddenAttribute : Attribute
{
}
