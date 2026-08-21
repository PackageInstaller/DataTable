using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[NativeHeader("Runtime/Graphics/Texture.h")]
[NativeHeader("Runtime/Graphics/AsyncGPUReadbackManaged.h")]
[UsedByNativeCode]
[NativeHeader("Runtime/Shaders/ComputeShader.h")]
public struct AsyncGPUReadbackRequest
{
	internal IntPtr m_Ptr;

	internal int m_Version;

	public bool done => IsDone();

	public bool hasError => HasError();

	private bool IsDone()
	{
		return IsDone_Injected(ref this);
	}

	private bool HasError()
	{
		return HasError_Injected(ref this);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool IsDone_Injected(ref AsyncGPUReadbackRequest _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool HasError_Injected(ref AsyncGPUReadbackRequest _unity_self);
}
