using System;
using System.Diagnostics;

namespace Mono.Util;

[Conditional("UNITY")]
[Conditional("FULL_AOT_RUNTIME")]
[Conditional("MONOTOUCH")]
[AttributeUsage(AttributeTargets.Method)]
internal sealed class MonoPInvokeCallbackAttribute : Attribute
{
	public MonoPInvokeCallbackAttribute(Type t)
	{
	}
}
