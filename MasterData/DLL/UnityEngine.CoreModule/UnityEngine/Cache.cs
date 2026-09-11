using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[StaticAccessor("CacheWrapper", StaticAccessorType.DoubleColon)]
[NativeHeader("Runtime/Misc/Cache.h")]
public struct Cache : IEquatable<Cache>
{
	private int m_Handle;

	internal int handle => m_Handle;

	public string path => Cache_GetPath(m_Handle);

	public override int GetHashCode()
	{
		return m_Handle;
	}

	public override bool Equals(object other)
	{
		return other is Cache && Equals((Cache)other);
	}

	public bool Equals(Cache other)
	{
		return handle == other.handle;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeThrows]
	internal static extern string Cache_GetPath(int handle);
}
