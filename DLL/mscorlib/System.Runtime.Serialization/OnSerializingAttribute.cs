using System.Runtime.InteropServices;

namespace System.Runtime.Serialization;

[ComVisible(true)]
[AttributeUsage(AttributeTargets.Method, Inherited = false)]
public sealed class OnSerializingAttribute : Attribute
{
}
