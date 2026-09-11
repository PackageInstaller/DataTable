using System;

namespace AOT;

[AttributeUsage(AttributeTargets.Method, AllowMultiple = true)]
public class MonoPInvokeCallbackAttribute : Attribute
{
	public MonoPInvokeCallbackAttribute(Type type)
	{
	}
}
