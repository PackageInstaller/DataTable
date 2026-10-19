using System;
using System.Runtime.CompilerServices;
using Unity.Collections;
using UnityEngine.Bindings;
using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering;

[StaticAccessor("AsyncGPUReadbackManager::GetInstance()", StaticAccessorType.Dot)]
public static class AsyncGPUReadback
{
	internal static void ValidateFormat(Texture src, GraphicsFormat dstformat)
	{
		GraphicsFormat format = GraphicsFormatUtility.GetFormat(src);
		if (!SystemInfo.IsFormatSupported(format, FormatUsage.ReadPixels))
		{
			Debug.LogError($"'{format}' doesn't support ReadPixels usage on this platform. Async GPU readback failed.");
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void WaitAllRequests();

	public unsafe static AsyncGPUReadbackRequest Request(ComputeBuffer src, Action<AsyncGPUReadbackRequest> callback = null)
	{
		AsyncGPUReadbackRequest result = Request_Internal_ComputeBuffer_1(src, null);
		result.SetScriptingCallback(callback);
		return result;
	}

	public unsafe static AsyncGPUReadbackRequest Request(ComputeBuffer src, int size, int offset, Action<AsyncGPUReadbackRequest> callback = null)
	{
		AsyncGPUReadbackRequest result = Request_Internal_ComputeBuffer_2(src, size, offset, null);
		result.SetScriptingCallback(callback);
		return result;
	}

	public unsafe static AsyncGPUReadbackRequest Request(GraphicsBuffer src, Action<AsyncGPUReadbackRequest> callback = null)
	{
		AsyncGPUReadbackRequest result = Request_Internal_GraphicsBuffer_1(src, null);
		result.SetScriptingCallback(callback);
		return result;
	}

	public unsafe static AsyncGPUReadbackRequest Request(GraphicsBuffer src, int size, int offset, Action<AsyncGPUReadbackRequest> callback = null)
	{
		AsyncGPUReadbackRequest result = Request_Internal_GraphicsBuffer_2(src, size, offset, null);
		result.SetScriptingCallback(callback);
		return result;
	}

	public unsafe static AsyncGPUReadbackRequest Request(Texture src, int mipIndex = 0, Action<AsyncGPUReadbackRequest> callback = null)
	{
		AsyncGPUReadbackRequest result = Request_Internal_Texture_1(src, mipIndex, null);
		result.SetScriptingCallback(callback);
		return result;
	}

	public static AsyncGPUReadbackRequest Request(Texture src, int mipIndex, TextureFormat dstFormat, Action<AsyncGPUReadbackRequest> callback = null)
	{
		return Request(src, mipIndex, GraphicsFormatUtility.GetGraphicsFormat(dstFormat, QualitySettings.activeColorSpace == ColorSpace.Linear), callback);
	}

	public unsafe static AsyncGPUReadbackRequest Request(Texture src, int mipIndex, GraphicsFormat dstFormat, Action<AsyncGPUReadbackRequest> callback = null)
	{
		ValidateFormat(src, dstFormat);
		AsyncGPUReadbackRequest result = Request_Internal_Texture_2(src, mipIndex, dstFormat, null);
		result.SetScriptingCallback(callback);
		return result;
	}

	public unsafe static AsyncGPUReadbackRequest Request(Texture src, int mipIndex, int x, int width, int y, int height, int z, int depth, Action<AsyncGPUReadbackRequest> callback = null)
	{
		AsyncGPUReadbackRequest result = Request_Internal_Texture_3(src, mipIndex, x, width, y, height, z, depth, null);
		result.SetScriptingCallback(callback);
		return result;
	}

	public static AsyncGPUReadbackRequest Request(Texture src, int mipIndex, int x, int width, int y, int height, int z, int depth, TextureFormat dstFormat, Action<AsyncGPUReadbackRequest> callback = null)
	{
		return Request(src, mipIndex, x, width, y, height, z, depth, GraphicsFormatUtility.GetGraphicsFormat(dstFormat, QualitySettings.activeColorSpace == ColorSpace.Linear), callback);
	}

	public unsafe static AsyncGPUReadbackRequest Request(Texture src, int mipIndex, int x, int width, int y, int height, int z, int depth, GraphicsFormat dstFormat, Action<AsyncGPUReadbackRequest> callback = null)
	{
		ValidateFormat(src, dstFormat);
		AsyncGPUReadbackRequest result = Request_Internal_Texture_4(src, mipIndex, x, width, y, height, z, depth, dstFormat, null);
		result.SetScriptingCallback(callback);
		return result;
	}

	public unsafe static AsyncGPUReadbackRequest RequestIntoNativeArray<T>(ref NativeArray<T> output, ComputeBuffer src, Action<AsyncGPUReadbackRequest> callback = null) where T : struct
	{
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		AsyncGPUReadbackRequest result = Request_Internal_ComputeBuffer_1(src, &asyncRequestNativeArrayData);
		result.SetScriptingCallback(callback);
		return result;
	}

	public unsafe static AsyncGPUReadbackRequest RequestIntoNativeArray<T>(ref NativeArray<T> output, ComputeBuffer src, int size, int offset, Action<AsyncGPUReadbackRequest> callback = null) where T : struct
	{
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		AsyncGPUReadbackRequest result = Request_Internal_ComputeBuffer_2(src, size, offset, &asyncRequestNativeArrayData);
		result.SetScriptingCallback(callback);
		return result;
	}

	public unsafe static AsyncGPUReadbackRequest RequestIntoNativeArray<T>(ref NativeArray<T> output, GraphicsBuffer src, Action<AsyncGPUReadbackRequest> callback = null) where T : struct
	{
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		AsyncGPUReadbackRequest result = Request_Internal_GraphicsBuffer_1(src, &asyncRequestNativeArrayData);
		result.SetScriptingCallback(callback);
		return result;
	}

	public unsafe static AsyncGPUReadbackRequest RequestIntoNativeArray<T>(ref NativeArray<T> output, GraphicsBuffer src, int size, int offset, Action<AsyncGPUReadbackRequest> callback = null) where T : struct
	{
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		AsyncGPUReadbackRequest result = Request_Internal_GraphicsBuffer_2(src, size, offset, &asyncRequestNativeArrayData);
		result.SetScriptingCallback(callback);
		return result;
	}

	public unsafe static AsyncGPUReadbackRequest RequestIntoNativeArray<T>(ref NativeArray<T> output, Texture src, int mipIndex = 0, Action<AsyncGPUReadbackRequest> callback = null) where T : struct
	{
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		AsyncGPUReadbackRequest result = Request_Internal_Texture_1(src, mipIndex, &asyncRequestNativeArrayData);
		result.SetScriptingCallback(callback);
		return result;
	}

	public static AsyncGPUReadbackRequest RequestIntoNativeArray<T>(ref NativeArray<T> output, Texture src, int mipIndex, TextureFormat dstFormat, Action<AsyncGPUReadbackRequest> callback = null) where T : struct
	{
		return RequestIntoNativeArray(ref output, src, mipIndex, GraphicsFormatUtility.GetGraphicsFormat(dstFormat, QualitySettings.activeColorSpace == ColorSpace.Linear), callback);
	}

	public unsafe static AsyncGPUReadbackRequest RequestIntoNativeArray<T>(ref NativeArray<T> output, Texture src, int mipIndex, GraphicsFormat dstFormat, Action<AsyncGPUReadbackRequest> callback = null) where T : struct
	{
		ValidateFormat(src, dstFormat);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		AsyncGPUReadbackRequest result = Request_Internal_Texture_2(src, mipIndex, dstFormat, &asyncRequestNativeArrayData);
		result.SetScriptingCallback(callback);
		return result;
	}

	public static AsyncGPUReadbackRequest RequestIntoNativeArray<T>(ref NativeArray<T> output, Texture src, int mipIndex, int x, int width, int y, int height, int z, int depth, TextureFormat dstFormat, Action<AsyncGPUReadbackRequest> callback = null) where T : struct
	{
		return RequestIntoNativeArray(ref output, src, mipIndex, x, width, y, height, z, depth, GraphicsFormatUtility.GetGraphicsFormat(dstFormat, QualitySettings.activeColorSpace == ColorSpace.Linear), callback);
	}

	public unsafe static AsyncGPUReadbackRequest RequestIntoNativeArray<T>(ref NativeArray<T> output, Texture src, int mipIndex, int x, int width, int y, int height, int z, int depth, GraphicsFormat dstFormat, Action<AsyncGPUReadbackRequest> callback = null) where T : struct
	{
		ValidateFormat(src, dstFormat);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		AsyncGPUReadbackRequest result = Request_Internal_Texture_4(src, mipIndex, x, width, y, height, z, depth, dstFormat, &asyncRequestNativeArrayData);
		result.SetScriptingCallback(callback);
		return result;
	}

	public unsafe static AsyncGPUReadbackRequest RequestIntoNativeSlice<T>(ref NativeSlice<T> output, ComputeBuffer src, Action<AsyncGPUReadbackRequest> callback = null) where T : struct
	{
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		AsyncGPUReadbackRequest result = Request_Internal_ComputeBuffer_1(src, &asyncRequestNativeArrayData);
		result.SetScriptingCallback(callback);
		return result;
	}

	public unsafe static AsyncGPUReadbackRequest RequestIntoNativeSlice<T>(ref NativeSlice<T> output, ComputeBuffer src, int size, int offset, Action<AsyncGPUReadbackRequest> callback = null) where T : struct
	{
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		AsyncGPUReadbackRequest result = Request_Internal_ComputeBuffer_2(src, size, offset, &asyncRequestNativeArrayData);
		result.SetScriptingCallback(callback);
		return result;
	}

	public unsafe static AsyncGPUReadbackRequest RequestIntoNativeSlice<T>(ref NativeSlice<T> output, GraphicsBuffer src, Action<AsyncGPUReadbackRequest> callback = null) where T : struct
	{
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		AsyncGPUReadbackRequest result = Request_Internal_GraphicsBuffer_1(src, &asyncRequestNativeArrayData);
		result.SetScriptingCallback(callback);
		return result;
	}

	public unsafe static AsyncGPUReadbackRequest RequestIntoNativeSlice<T>(ref NativeSlice<T> output, GraphicsBuffer src, int size, int offset, Action<AsyncGPUReadbackRequest> callback = null) where T : struct
	{
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		AsyncGPUReadbackRequest result = Request_Internal_GraphicsBuffer_2(src, size, offset, &asyncRequestNativeArrayData);
		result.SetScriptingCallback(callback);
		return result;
	}

	public unsafe static AsyncGPUReadbackRequest RequestIntoNativeSlice<T>(ref NativeSlice<T> output, Texture src, int mipIndex = 0, Action<AsyncGPUReadbackRequest> callback = null) where T : struct
	{
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		AsyncGPUReadbackRequest result = Request_Internal_Texture_1(src, mipIndex, &asyncRequestNativeArrayData);
		result.SetScriptingCallback(callback);
		return result;
	}

	public static AsyncGPUReadbackRequest RequestIntoNativeSlice<T>(ref NativeSlice<T> output, Texture src, int mipIndex, TextureFormat dstFormat, Action<AsyncGPUReadbackRequest> callback = null) where T : struct
	{
		return RequestIntoNativeSlice(ref output, src, mipIndex, GraphicsFormatUtility.GetGraphicsFormat(dstFormat, QualitySettings.activeColorSpace == ColorSpace.Linear), callback);
	}

	public unsafe static AsyncGPUReadbackRequest RequestIntoNativeSlice<T>(ref NativeSlice<T> output, Texture src, int mipIndex, GraphicsFormat dstFormat, Action<AsyncGPUReadbackRequest> callback = null) where T : struct
	{
		ValidateFormat(src, dstFormat);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		AsyncGPUReadbackRequest result = Request_Internal_Texture_2(src, mipIndex, dstFormat, &asyncRequestNativeArrayData);
		result.SetScriptingCallback(callback);
		return result;
	}

	public static AsyncGPUReadbackRequest RequestIntoNativeSlice<T>(ref NativeSlice<T> output, Texture src, int mipIndex, int x, int width, int y, int height, int z, int depth, TextureFormat dstFormat, Action<AsyncGPUReadbackRequest> callback = null) where T : struct
	{
		return RequestIntoNativeSlice(ref output, src, mipIndex, x, width, y, height, z, depth, GraphicsFormatUtility.GetGraphicsFormat(dstFormat, QualitySettings.activeColorSpace == ColorSpace.Linear), callback);
	}

	public unsafe static AsyncGPUReadbackRequest RequestIntoNativeSlice<T>(ref NativeSlice<T> output, Texture src, int mipIndex, int x, int width, int y, int height, int z, int depth, GraphicsFormat dstFormat, Action<AsyncGPUReadbackRequest> callback = null) where T : struct
	{
		ValidateFormat(src, dstFormat);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		AsyncGPUReadbackRequest result = Request_Internal_Texture_4(src, mipIndex, x, width, y, height, z, depth, dstFormat, &asyncRequestNativeArrayData);
		result.SetScriptingCallback(callback);
		return result;
	}

	[NativeMethod("Request")]
	private unsafe static AsyncGPUReadbackRequest Request_Internal_ComputeBuffer_1([NotNull("ArgumentNullException")] ComputeBuffer buffer, AsyncRequestNativeArrayData* data)
	{
		Request_Internal_ComputeBuffer_1_Injected(buffer, data, out var ret);
		return ret;
	}

	[NativeMethod("Request")]
	private unsafe static AsyncGPUReadbackRequest Request_Internal_ComputeBuffer_2([NotNull("ArgumentNullException")] ComputeBuffer src, int size, int offset, AsyncRequestNativeArrayData* data)
	{
		Request_Internal_ComputeBuffer_2_Injected(src, size, offset, data, out var ret);
		return ret;
	}

	[NativeMethod("Request")]
	private unsafe static AsyncGPUReadbackRequest Request_Internal_GraphicsBuffer_1([NotNull("ArgumentNullException")] GraphicsBuffer buffer, AsyncRequestNativeArrayData* data)
	{
		Request_Internal_GraphicsBuffer_1_Injected(buffer, data, out var ret);
		return ret;
	}

	[NativeMethod("Request")]
	private unsafe static AsyncGPUReadbackRequest Request_Internal_GraphicsBuffer_2([NotNull("ArgumentNullException")] GraphicsBuffer src, int size, int offset, AsyncRequestNativeArrayData* data)
	{
		Request_Internal_GraphicsBuffer_2_Injected(src, size, offset, data, out var ret);
		return ret;
	}

	[NativeMethod("Request")]
	private unsafe static AsyncGPUReadbackRequest Request_Internal_Texture_1([NotNull("ArgumentNullException")] Texture src, int mipIndex, AsyncRequestNativeArrayData* data)
	{
		Request_Internal_Texture_1_Injected(src, mipIndex, data, out var ret);
		return ret;
	}

	[NativeMethod("Request")]
	private unsafe static AsyncGPUReadbackRequest Request_Internal_Texture_2([NotNull("ArgumentNullException")] Texture src, int mipIndex, GraphicsFormat dstFormat, AsyncRequestNativeArrayData* data)
	{
		Request_Internal_Texture_2_Injected(src, mipIndex, dstFormat, data, out var ret);
		return ret;
	}

	[NativeMethod("Request")]
	private unsafe static AsyncGPUReadbackRequest Request_Internal_Texture_3([NotNull("ArgumentNullException")] Texture src, int mipIndex, int x, int width, int y, int height, int z, int depth, AsyncRequestNativeArrayData* data)
	{
		Request_Internal_Texture_3_Injected(src, mipIndex, x, width, y, height, z, depth, data, out var ret);
		return ret;
	}

	[NativeMethod("Request")]
	private unsafe static AsyncGPUReadbackRequest Request_Internal_Texture_4([NotNull("ArgumentNullException")] Texture src, int mipIndex, int x, int width, int y, int height, int z, int depth, GraphicsFormat dstFormat, AsyncRequestNativeArrayData* data)
	{
		Request_Internal_Texture_4_Injected(src, mipIndex, x, width, y, height, z, depth, dstFormat, data, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern void Request_Internal_ComputeBuffer_1_Injected(ComputeBuffer buffer, AsyncRequestNativeArrayData* data, out AsyncGPUReadbackRequest ret);

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern void Request_Internal_ComputeBuffer_2_Injected(ComputeBuffer src, int size, int offset, AsyncRequestNativeArrayData* data, out AsyncGPUReadbackRequest ret);

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern void Request_Internal_GraphicsBuffer_1_Injected(GraphicsBuffer buffer, AsyncRequestNativeArrayData* data, out AsyncGPUReadbackRequest ret);

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern void Request_Internal_GraphicsBuffer_2_Injected(GraphicsBuffer src, int size, int offset, AsyncRequestNativeArrayData* data, out AsyncGPUReadbackRequest ret);

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern void Request_Internal_Texture_1_Injected(Texture src, int mipIndex, AsyncRequestNativeArrayData* data, out AsyncGPUReadbackRequest ret);

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern void Request_Internal_Texture_2_Injected(Texture src, int mipIndex, GraphicsFormat dstFormat, AsyncRequestNativeArrayData* data, out AsyncGPUReadbackRequest ret);

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern void Request_Internal_Texture_3_Injected(Texture src, int mipIndex, int x, int width, int y, int height, int z, int depth, AsyncRequestNativeArrayData* data, out AsyncGPUReadbackRequest ret);

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern void Request_Internal_Texture_4_Injected(Texture src, int mipIndex, int x, int width, int y, int height, int z, int depth, GraphicsFormat dstFormat, AsyncRequestNativeArrayData* data, out AsyncGPUReadbackRequest ret);
}
