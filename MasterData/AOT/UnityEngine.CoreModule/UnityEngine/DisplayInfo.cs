using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeType("Runtime/Graphics/DisplayInfo.h")]
[UsedByNativeCode]
public struct DisplayInfo : IEquatable<DisplayInfo>
{
	internal ulong handle;

	public int width;

	public int height;

	public RefreshRate refreshRate;

	public RectInt workArea;

	public string name;

	[MethodImpl((MethodImplOptions)256)]
	public bool Equals(DisplayInfo other)
	{
		return handle == other.handle && width == other.width && height == other.height && refreshRate.Equals(other.refreshRate) && workArea.Equals(other.workArea) && name == other.name;
	}
}
