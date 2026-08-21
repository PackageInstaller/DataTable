using System;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[NativeHeader("Runtime/Camera/BatchRendererGroup.h")]
[RequiredByNativeCode(Optional = true, GenerateProxy = true)]
[NativeClass("BatchID")]
public struct BatchID : IEquatable<BatchID>
{
	public static readonly BatchID Null = new BatchID
	{
		value = 0u
	};

	public uint value;

	public override int GetHashCode()
	{
		return value.GetHashCode();
	}

	public override bool Equals(object obj)
	{
		if (obj is BatchID)
		{
			return Equals((BatchID)obj);
		}
		return false;
	}

	public bool Equals(BatchID other)
	{
		return value == other.value;
	}
}
