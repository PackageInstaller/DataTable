namespace System.Runtime.Versioning;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Constructor | AttributeTargets.Method, AllowMultiple = false, Inherited = false)]
internal sealed class NonVersionableAttribute : Attribute
{
}
