using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace UnityEngine;

internal readonly struct RenderInstancedDataLayout
{
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private readonly int _003Csize_003Ek__BackingField;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private readonly int _003CoffsetObjectToWorld_003Ek__BackingField;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private readonly int _003CoffsetPrevObjectToWorld_003Ek__BackingField;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private readonly int _003CoffsetRenderingLayerMask_003Ek__BackingField;

	public RenderInstancedDataLayout(Type t)
	{
		_003Csize_003Ek__BackingField = Marshal.SizeOf(t);
		_003CoffsetObjectToWorld_003Ek__BackingField = ((!(t == typeof(Matrix4x4))) ? Marshal.OffsetOf(t, "objectToWorld").ToInt32() : 0);
		try
		{
			_003CoffsetPrevObjectToWorld_003Ek__BackingField = Marshal.OffsetOf(t, "prevObjectToWorld").ToInt32();
		}
		catch (ArgumentException)
		{
			_003CoffsetPrevObjectToWorld_003Ek__BackingField = -1;
		}
		try
		{
			_003CoffsetRenderingLayerMask_003Ek__BackingField = Marshal.OffsetOf(t, "renderingLayerMask").ToInt32();
		}
		catch (ArgumentException)
		{
			_003CoffsetRenderingLayerMask_003Ek__BackingField = -1;
		}
	}
}
