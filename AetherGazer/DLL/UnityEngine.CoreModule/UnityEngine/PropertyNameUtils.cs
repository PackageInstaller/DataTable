using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Utilities/PropertyName.h")]
internal class PropertyNameUtils
{
	[FreeFunction(IsThreadSafe = true)]
	public static PropertyName PropertyNameFromString([Unmarshalled] string name)
	{
		PropertyNameFromString_Injected(name, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void PropertyNameFromString_Injected(string name, out PropertyName ret);
}
