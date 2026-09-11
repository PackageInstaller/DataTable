using System.Diagnostics;
using System.Runtime.CompilerServices;
using Unity.Collections;
using UnityEngine;

namespace Unity.Profiling;

public struct DebugScreenCapture
{
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private NativeArray<byte> _003CRawImageDataReference_003Ek__BackingField;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private TextureFormat _003CImageFormat_003Ek__BackingField;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private int _003CWidth_003Ek__BackingField;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private int _003CHeight_003Ek__BackingField;

	public NativeArray<byte> RawImageDataReference
	{
		[CompilerGenerated]
		set
		{
			_003CRawImageDataReference_003Ek__BackingField = value;
		}
	}

	public TextureFormat ImageFormat
	{
		[CompilerGenerated]
		set
		{
			_003CImageFormat_003Ek__BackingField = value;
		}
	}

	public int Width
	{
		[CompilerGenerated]
		set
		{
			_003CWidth_003Ek__BackingField = value;
		}
	}

	public int Height
	{
		[CompilerGenerated]
		set
		{
			_003CHeight_003Ek__BackingField = value;
		}
	}
}
