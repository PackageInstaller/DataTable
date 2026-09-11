using System.Runtime.InteropServices;

namespace System.Runtime.Serialization;

[AttributeUsage(AttributeTargets.Method, Inherited = false)]
[ComVisible(true)]
public sealed class OnDeserializedAttribute : Attribute
{
}
