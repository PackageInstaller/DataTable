using System;

namespace Proxima;

[AttributeUsage(AttributeTargets.Field)]
internal class SerializeIfAttribute : Attribute
{
	public string Method;

	public SerializeIfAttribute(string method)
	{
		Method = method;
	}
}
