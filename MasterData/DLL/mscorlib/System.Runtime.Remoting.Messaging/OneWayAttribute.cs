using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Messaging;

[ComVisible(true)]
[AttributeUsage(AttributeTargets.Method)]
public class OneWayAttribute : Attribute
{
}
