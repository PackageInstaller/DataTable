using Unity.Collections;
using UnityEngine;

namespace Unity.Profiling;

public struct DebugScreenCapture
{
	public NativeArray<byte> RawImageDataReference { set; }

	public TextureFormat ImageFormat { set; }

	public int Width { set; }

	public int Height { set; }
}
