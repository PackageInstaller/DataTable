using System.Diagnostics;
using System.Runtime.CompilerServices;
using Unity.Collections;

namespace UnityEngine.Profiling.Experimental;

public struct DebugScreenCapture
{
	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private NativeArray<byte> _003CrawImageDataReference_003Ek__BackingField;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private TextureFormat _003CimageFormat_003Ek__BackingField;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private int _003Cwidth_003Ek__BackingField;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private int _003Cheight_003Ek__BackingField;

	public NativeArray<byte> rawImageDataReference
	{
		[CompilerGenerated]
		set
		{
			_003CrawImageDataReference_003Ek__BackingField = value;
		}
	}

	public TextureFormat imageFormat
	{
		[CompilerGenerated]
		set
		{
			_003CimageFormat_003Ek__BackingField = value;
		}
	}

	public int width
	{
		[CompilerGenerated]
		set
		{
			_003Cwidth_003Ek__BackingField = value;
		}
	}

	public int height
	{
		[CompilerGenerated]
		set
		{
			_003Cheight_003Ek__BackingField = value;
		}
	}
}
