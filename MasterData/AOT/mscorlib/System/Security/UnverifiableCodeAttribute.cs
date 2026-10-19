using System.Runtime.InteropServices;

namespace System.Security;

[ComVisible(true)]
[AttributeUsage(AttributeTargets.Module, AllowMultiple = true, Inherited = false)]
public sealed class UnverifiableCodeAttribute : Attribute
{
}
