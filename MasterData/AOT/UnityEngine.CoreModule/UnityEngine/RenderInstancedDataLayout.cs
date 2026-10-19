using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace UnityEngine;

internal readonly struct RenderInstancedDataLayout
{
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private readonly int size__BackingField;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private readonly int offsetObjectToWorld__BackingField;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private readonly int offsetPrevObjectToWorld__BackingField;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private readonly int offsetRenderingLayerMask__BackingField;

	public RenderInstancedDataLayout(Type t)
	{
		size__BackingField = Marshal.SizeOf(t);
		offsetObjectToWorld__BackingField = ((!(t == typeof(Matrix4x4))) ? Marshal.OffsetOf(t, "objectToWorld").ToInt32() : 0);
		try
		{
			offsetPrevObjectToWorld__BackingField = Marshal.OffsetOf(t, "prevObjectToWorld").ToInt32();
		}
		catch (ArgumentException)
		{
			offsetPrevObjectToWorld__BackingField = -1;
		}
		try
		{
			offsetRenderingLayerMask__BackingField = Marshal.OffsetOf(t, "renderingLayerMask").ToInt32();
		}
		catch (ArgumentException)
		{
			offsetRenderingLayerMask__BackingField = -1;
		}
	}
}
