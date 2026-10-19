using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/GI/DynamicGI.h")]
public sealed class DynamicGI
{
	[MethodImpl((MethodImplOptions)4096)]
	public static extern void UpdateEnvironment();
}
