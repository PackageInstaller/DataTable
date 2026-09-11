using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Metadata;

[AttributeUsage(AttributeTargets.Parameter)]
[ComVisible(true)]
public sealed class SoapParameterAttribute : SoapAttribute
{
}
