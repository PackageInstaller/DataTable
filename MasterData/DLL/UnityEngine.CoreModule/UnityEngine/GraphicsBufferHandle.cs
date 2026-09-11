using System;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeClass("GfxBufferID")]
[NativeHeader("Runtime/GfxDevice/GfxDeviceTypes.h")]
public readonly struct GraphicsBufferHandle : IEquatable<GraphicsBufferHandle>
{
	public readonly uint value;

	public override int GetHashCode()
	{
		return value.GetHashCode();
	}

	public override bool Equals(object obj)
	{
		if (obj is GraphicsBufferHandle)
		{
			return Equals((GraphicsBufferHandle)obj);
		}
		return false;
	}

	public bool Equals(GraphicsBufferHandle other)
	{
		return value == other.value;
	}
}
