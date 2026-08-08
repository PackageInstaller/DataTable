using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/BaseClasses/BitField.h")]
[NativeClass("BitField", "struct BitField;")]
[RequiredByNativeCode(Optional = true, GenerateProxy = true)]
[NativeHeader("Runtime/BaseClasses/TagManager.h")]
public struct LayerMask
{
	[NativeName("m_Bits")]
	private int m_Mask;

	public int value
	{
		get
		{
			return m_Mask;
		}
		set
		{
			m_Mask = value;
		}
	}

	public static implicit operator int(LayerMask mask)
	{
		return mask.m_Mask;
	}

	public static implicit operator LayerMask(int intVal)
	{
		LayerMask result = default(LayerMask);
		result.m_Mask = intVal;
		return result;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("LayerToString")]
	[StaticAccessor("GetTagManager()", StaticAccessorType.Dot)]
	public static extern string LayerToName(int layer);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("StringToLayer")]
	[StaticAccessor("GetTagManager()", StaticAccessorType.Dot)]
	public static extern int NameToLayer(string layerName);

	public static int GetMask(params string[] layerNames)
	{
		if (layerNames == null)
		{
			throw new ArgumentNullException("layerNames");
		}
		int num = 0;
		foreach (string layerName in layerNames)
		{
			int num2 = NameToLayer(layerName);
			if (num2 != -1)
			{
				num |= 1 << num2;
			}
		}
		return num;
	}
}
