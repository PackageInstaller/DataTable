using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Misc/CachingManager.h")]
[StaticAccessor("GetCachingManager()", StaticAccessorType.Dot)]
public sealed class Caching
{
	[StaticAccessor("CachingManagerWrapper", StaticAccessorType.DoubleColon)]
	public static Cache currentCacheForWriting
	{
		[NativeName("Caching_GetCurrentCacheHandle")]
		get
		{
			get_currentCacheForWriting_Injected(out var ret);
			return ret;
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void get_currentCacheForWriting_Injected(out Cache ret);
}
