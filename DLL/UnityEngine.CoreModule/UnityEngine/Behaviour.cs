using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[UsedByNativeCode]
[NativeHeader("Runtime/Mono/MonoBehaviour.h")]
public class Behaviour : Component
{
	[NativeProperty]
	[RequiredByNativeCode]
	public extern bool enabled
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty]
	public extern bool isActiveAndEnabled
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("IsAddedToManager")]
		get;
	}
}
