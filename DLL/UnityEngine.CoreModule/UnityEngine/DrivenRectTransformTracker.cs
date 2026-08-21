using System.Runtime.InteropServices;

namespace UnityEngine;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public struct DrivenRectTransformTracker
{
	public void Add(Object driver, RectTransform rectTransform, DrivenTransformProperties drivenProperties)
	{
	}

	public void Clear()
	{
	}
}
