using System;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[NativeHeader("Runtime/Camera/BatchRendererGroup.h")]
[NativeClass("BatchMaterialID")]
[RequiredByNativeCode(Optional = true, GenerateProxy = true)]
public struct BatchMaterialID : IEquatable<BatchMaterialID>
{
	public static readonly BatchMaterialID Null = new BatchMaterialID
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
		if (obj is BatchMaterialID)
		{
			return Equals((BatchMaterialID)obj);
		}
		return false;
	}

	public bool Equals(BatchMaterialID other)
	{
		return value == other.value;
	}
}
