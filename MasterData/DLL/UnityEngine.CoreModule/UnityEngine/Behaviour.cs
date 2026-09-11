using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Mono/MonoBehaviour.h")]
[UsedByNativeCode]
public class Behaviour : Component
{
	[RequiredByNativeCode]
	[NativeProperty]
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
