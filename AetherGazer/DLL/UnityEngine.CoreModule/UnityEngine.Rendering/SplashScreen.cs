using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine.Rendering;

[NativeHeader("Runtime/Graphics/DrawSplashScreenAndWatermarks.h")]
public class SplashScreen
{
	public static extern bool isFinished
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("IsSplashScreenFinished")]
		get;
	}
}
