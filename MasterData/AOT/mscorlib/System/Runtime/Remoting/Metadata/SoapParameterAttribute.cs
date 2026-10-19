using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Metadata;

[ComVisible(true)]
[AttributeUsage(AttributeTargets.Parameter)]
public sealed class SoapParameterAttribute : SoapAttribute
{
}
