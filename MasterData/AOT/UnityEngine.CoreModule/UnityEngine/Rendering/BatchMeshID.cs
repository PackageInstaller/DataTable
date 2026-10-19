using System;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[NativeHeader("Runtime/Camera/BatchRendererGroup.h")]
[RequiredByNativeCode(Optional = true, GenerateProxy = true)]
[NativeClass("BatchMeshID")]
public struct BatchMeshID : IEquatable<BatchMeshID>
{
	public static readonly BatchMeshID Null = new BatchMeshID
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
		if (obj is BatchMeshID)
		{
			return Equals((BatchMeshID)obj);
		}
		return false;
	}

	public bool Equals(BatchMeshID other)
	{
		return value == other.value;
	}
}
