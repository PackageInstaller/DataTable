using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine.Rendering;

[StaticAccessor("AsyncGPUReadbackManager::GetInstance()", StaticAccessorType.Dot)]
public static class AsyncGPUReadback
{
	public unsafe static AsyncGPUReadbackRequest Request(GraphicsBuffer src, Action<AsyncGPUReadbackRequest> callback = null)
	{
		AsyncGPUReadbackRequest result = Request_Internal_GraphicsBuffer_1(src, null);
		result.SetScriptingCallback(callback);
		return result;
	}

	[NativeMethod("Request")]
	private unsafe static AsyncGPUReadbackRequest Request_Internal_GraphicsBuffer_1([NotNull("ArgumentNullException")] GraphicsBuffer buffer, AsyncRequestNativeArrayData* data)
	{
		Request_Internal_GraphicsBuffer_1_Injected(buffer, data, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern void Request_Internal_GraphicsBuffer_1_Injected(GraphicsBuffer buffer, AsyncRequestNativeArrayData* data, out AsyncGPUReadbackRequest ret);
}
