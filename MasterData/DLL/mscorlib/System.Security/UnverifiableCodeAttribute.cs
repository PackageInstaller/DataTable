using System.Runtime.InteropServices;

namespace System.Security;

[AttributeUsage(AttributeTargets.Module, AllowMultiple = true, Inherited = false)]
[ComVisible(true)]
public sealed class UnverifiableCodeAttribute : Attribute
{
}
