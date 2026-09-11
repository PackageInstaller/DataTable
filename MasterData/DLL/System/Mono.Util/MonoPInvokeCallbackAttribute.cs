using System;
using System.Diagnostics;

namespace Mono.Util;

[AttributeUsage(AttributeTargets.Method)]
[Conditional("MONOTOUCH")]
[Conditional("FULL_AOT_RUNTIME")]
[Conditional("UNITY")]
internal sealed class MonoPInvokeCallbackAttribute : Attribute
{
	public MonoPInvokeCallbackAttribute(Type t)
	{
	}
}
