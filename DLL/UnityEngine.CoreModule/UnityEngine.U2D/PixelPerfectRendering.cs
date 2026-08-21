using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.U2D;

[MovedFrom("UnityEngine.Experimental.U2D")]
[NativeHeader("Runtime/2D/Common/PixelSnapping.h")]
public static class PixelPerfectRendering
{
	public static extern float pixelSnapSpacing
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("SetPixelSnapSpacing")]
		set;
	}
}
