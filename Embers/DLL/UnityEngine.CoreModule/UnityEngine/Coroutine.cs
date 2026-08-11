using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[StructLayout(LayoutKind.Sequential)]
[RequiredByNativeCode]
[NativeHeader("Runtime/Mono/Coroutine.h")]
public sealed class Coroutine : YieldInstruction
{
	internal IntPtr m_Ptr;

	private Coroutine()
	{
	}

	~Coroutine()
	{
		ReleaseCoroutine(m_Ptr);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Coroutine::CleanupCoroutineGC", true)]
	private static extern void ReleaseCoroutine(IntPtr ptr);
}
