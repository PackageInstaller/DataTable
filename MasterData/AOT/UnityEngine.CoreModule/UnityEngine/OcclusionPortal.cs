using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Camera/OcclusionPortal.h")]
public sealed class OcclusionPortal : Component
{
	[NativeProperty("IsOpen")]
	public extern bool open
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}
}
