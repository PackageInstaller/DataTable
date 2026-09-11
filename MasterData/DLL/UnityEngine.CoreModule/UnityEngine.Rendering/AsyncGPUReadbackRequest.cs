using System;
using System.Runtime.CompilerServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[NativeHeader("Runtime/Graphics/AsyncGPUReadbackManaged.h")]
[UsedByNativeCode]
[NativeHeader("Runtime/Graphics/Texture.h")]
[NativeHeader("Runtime/Shaders/ComputeShader.h")]
public struct AsyncGPUReadbackRequest
{
	internal IntPtr m_Ptr;

	internal int m_Version;

	public bool done => IsDone();

	public bool hasError => HasError();

	public int layerCount => GetLayerCount();

	public int layerDataSize => GetLayerDataSize();

	public void WaitForCompletion()
	{
		WaitForCompletion_Injected(ref this);
	}

	public unsafe NativeArray<T> GetData<T>(int layer = 0) where T : struct
	{
		if (!done || hasError)
		{
			throw new InvalidOperationException("Cannot access the data as it is not available");
		}
		if (layer < 0 || layer >= layerCount)
		{
			throw new ArgumentException($"Layer index is out of range {layer} / {layerCount}");
		}
		int num = UnsafeUtility.SizeOf<T>();
		return NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<T>((void*)GetDataRaw(layer), layerDataSize / num, Allocator.None);
	}

	private bool IsDone()
	{
		return IsDone_Injected(ref this);
	}

	private bool HasError()
	{
		return HasError_Injected(ref this);
	}

	private int GetLayerCount()
	{
		return GetLayerCount_Injected(ref this);
	}

	private int GetLayerDataSize()
	{
		return GetLayerDataSize_Injected(ref this);
	}

	internal void SetScriptingCallback(Action<AsyncGPUReadbackRequest> callback)
	{
		SetScriptingCallback_Injected(ref this, callback);
	}

	private IntPtr GetDataRaw(int layer)
	{
		return GetDataRaw_Injected(ref this, layer);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void WaitForCompletion_Injected(ref AsyncGPUReadbackRequest _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool IsDone_Injected(ref AsyncGPUReadbackRequest _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool HasError_Injected(ref AsyncGPUReadbackRequest _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int GetLayerCount_Injected(ref AsyncGPUReadbackRequest _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int GetLayerDataSize_Injected(ref AsyncGPUReadbackRequest _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetScriptingCallback_Injected(ref AsyncGPUReadbackRequest _unity_self, Action<AsyncGPUReadbackRequest> callback);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern IntPtr GetDataRaw_Injected(ref AsyncGPUReadbackRequest _unity_self, int layer);
}
