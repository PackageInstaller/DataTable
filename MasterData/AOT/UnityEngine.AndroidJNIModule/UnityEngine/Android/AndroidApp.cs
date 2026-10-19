using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine.Android;

[NativeHeader("Modules/AndroidJNI/Public/AndroidApp.bindings.h")]
[StaticAccessor("AndroidApp", StaticAccessorType.DoubleColon)]
[NativeConditional("PLATFORM_ANDROID")]
internal static class AndroidApp
{
	public static extern IntPtr UnityPlayerRaw
	{
		[MethodImpl((MethodImplOptions)4096)]
		[ThreadSafe]
		get;
	}
}
