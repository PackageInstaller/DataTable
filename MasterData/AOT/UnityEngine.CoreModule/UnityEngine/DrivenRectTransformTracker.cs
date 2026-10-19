using System;
using System.Runtime.InteropServices;

namespace UnityEngine;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public struct DrivenRectTransformTracker
{
	internal static bool CanRecordModifications()
	{
		return true;
	}

	public void Add(Object driver, RectTransform rectTransform, DrivenTransformProperties drivenProperties)
	{
	}

	[Obsolete("revertValues parameter is ignored. Please use Clear() instead.")]
	public void Clear(bool revertValues)
	{
		Clear();
	}

	public void Clear()
	{
	}
}
