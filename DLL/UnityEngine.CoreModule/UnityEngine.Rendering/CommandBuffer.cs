using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using Unity.Profiling;
using UnityEngine.Bindings;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Internal;
using UnityEngine.Profiling;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[UsedByNativeCode]
[NativeHeader("Runtime/Shaders/ComputeShader.h")]
[NativeHeader("Runtime/Shaders/RayTracingShader.h")]
[NativeHeader("Runtime/Export/Graphics/RenderingCommandBuffer.bindings.h")]
[NativeType("Runtime/Graphics/CommandBuffer/RenderingCommandBuffer.h")]
public class CommandBuffer : IDisposable
{
	internal IntPtr m_Ptr;

	public extern string name
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern int sizeInBytes
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("GetBufferSize")]
		get;
	}

	public void ConvertTexture(RenderTargetIdentifier src, RenderTargetIdentifier dst)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		ConvertTexture_Internal(src, 0, dst, 0);
	}

	public void ConvertTexture(RenderTargetIdentifier src, int srcElement, RenderTargetIdentifier dst, int dstElement)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		ConvertTexture_Internal(src, srcElement, dst, dstElement);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("AddWaitAllAsyncReadbackRequests")]
	public extern void WaitAllAsyncReadbackRequests();

	public unsafe void RequestAsyncReadback(ComputeBuffer src, Action<AsyncGPUReadbackRequest> callback)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Internal_RequestAsyncReadback_1(src, callback, null);
	}

	public unsafe void RequestAsyncReadback(GraphicsBuffer src, Action<AsyncGPUReadbackRequest> callback)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Internal_RequestAsyncReadback_8(src, callback, null);
	}

	public unsafe void RequestAsyncReadback(ComputeBuffer src, int size, int offset, Action<AsyncGPUReadbackRequest> callback)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Internal_RequestAsyncReadback_2(src, size, offset, callback, null);
	}

	public unsafe void RequestAsyncReadback(GraphicsBuffer src, int size, int offset, Action<AsyncGPUReadbackRequest> callback)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Internal_RequestAsyncReadback_9(src, size, offset, callback, null);
	}

	public unsafe void RequestAsyncReadback(Texture src, Action<AsyncGPUReadbackRequest> callback)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Internal_RequestAsyncReadback_3(src, callback, null);
	}

	public unsafe void RequestAsyncReadback(Texture src, int mipIndex, Action<AsyncGPUReadbackRequest> callback)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Internal_RequestAsyncReadback_4(src, mipIndex, callback, null);
	}

	public unsafe void RequestAsyncReadback(Texture src, int mipIndex, TextureFormat dstFormat, Action<AsyncGPUReadbackRequest> callback)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Internal_RequestAsyncReadback_5(src, mipIndex, GraphicsFormatUtility.GetGraphicsFormat(dstFormat, QualitySettings.activeColorSpace == ColorSpace.Linear), callback, null);
	}

	public unsafe void RequestAsyncReadback(Texture src, int mipIndex, GraphicsFormat dstFormat, Action<AsyncGPUReadbackRequest> callback)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Internal_RequestAsyncReadback_5(src, mipIndex, dstFormat, callback, null);
	}

	public unsafe void RequestAsyncReadback(Texture src, int mipIndex, int x, int width, int y, int height, int z, int depth, Action<AsyncGPUReadbackRequest> callback)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Internal_RequestAsyncReadback_6(src, mipIndex, x, width, y, height, z, depth, callback, null);
	}

	public unsafe void RequestAsyncReadback(Texture src, int mipIndex, int x, int width, int y, int height, int z, int depth, TextureFormat dstFormat, Action<AsyncGPUReadbackRequest> callback)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Internal_RequestAsyncReadback_7(src, mipIndex, x, width, y, height, z, depth, GraphicsFormatUtility.GetGraphicsFormat(dstFormat, QualitySettings.activeColorSpace == ColorSpace.Linear), callback, null);
	}

	public unsafe void RequestAsyncReadback(Texture src, int mipIndex, int x, int width, int y, int height, int z, int depth, GraphicsFormat dstFormat, Action<AsyncGPUReadbackRequest> callback)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Internal_RequestAsyncReadback_7(src, mipIndex, x, width, y, height, z, depth, dstFormat, callback, null);
	}

	public unsafe void RequestAsyncReadbackIntoNativeArray<T>(ref NativeArray<T> output, ComputeBuffer src, Action<AsyncGPUReadbackRequest> callback) where T : struct
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		Internal_RequestAsyncReadback_1(src, callback, &asyncRequestNativeArrayData);
	}

	public unsafe void RequestAsyncReadbackIntoNativeArray<T>(ref NativeArray<T> output, ComputeBuffer src, int size, int offset, Action<AsyncGPUReadbackRequest> callback) where T : struct
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		Internal_RequestAsyncReadback_2(src, size, offset, callback, &asyncRequestNativeArrayData);
	}

	public unsafe void RequestAsyncReadbackIntoNativeArray<T>(ref NativeArray<T> output, GraphicsBuffer src, Action<AsyncGPUReadbackRequest> callback) where T : struct
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		Internal_RequestAsyncReadback_8(src, callback, &asyncRequestNativeArrayData);
	}

	public unsafe void RequestAsyncReadbackIntoNativeArray<T>(ref NativeArray<T> output, GraphicsBuffer src, int size, int offset, Action<AsyncGPUReadbackRequest> callback) where T : struct
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		Internal_RequestAsyncReadback_9(src, size, offset, callback, &asyncRequestNativeArrayData);
	}

	public unsafe void RequestAsyncReadbackIntoNativeArray<T>(ref NativeArray<T> output, Texture src, Action<AsyncGPUReadbackRequest> callback) where T : struct
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		Internal_RequestAsyncReadback_3(src, callback, &asyncRequestNativeArrayData);
	}

	public unsafe void RequestAsyncReadbackIntoNativeArray<T>(ref NativeArray<T> output, Texture src, int mipIndex, Action<AsyncGPUReadbackRequest> callback) where T : struct
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		Internal_RequestAsyncReadback_4(src, mipIndex, callback, &asyncRequestNativeArrayData);
	}

	public unsafe void RequestAsyncReadbackIntoNativeArray<T>(ref NativeArray<T> output, Texture src, int mipIndex, TextureFormat dstFormat, Action<AsyncGPUReadbackRequest> callback) where T : struct
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		Internal_RequestAsyncReadback_5(src, mipIndex, GraphicsFormatUtility.GetGraphicsFormat(dstFormat, QualitySettings.activeColorSpace == ColorSpace.Linear), callback, &asyncRequestNativeArrayData);
	}

	public unsafe void RequestAsyncReadbackIntoNativeArray<T>(ref NativeArray<T> output, Texture src, int mipIndex, GraphicsFormat dstFormat, Action<AsyncGPUReadbackRequest> callback) where T : struct
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		Internal_RequestAsyncReadback_5(src, mipIndex, dstFormat, callback, &asyncRequestNativeArrayData);
	}

	public unsafe void RequestAsyncReadbackIntoNativeArray<T>(ref NativeArray<T> output, Texture src, int mipIndex, int x, int width, int y, int height, int z, int depth, Action<AsyncGPUReadbackRequest> callback) where T : struct
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		Internal_RequestAsyncReadback_6(src, mipIndex, x, width, y, height, z, depth, callback, &asyncRequestNativeArrayData);
	}

	public unsafe void RequestAsyncReadbackIntoNativeArray<T>(ref NativeArray<T> output, Texture src, int mipIndex, int x, int width, int y, int height, int z, int depth, TextureFormat dstFormat, Action<AsyncGPUReadbackRequest> callback) where T : struct
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		Internal_RequestAsyncReadback_7(src, mipIndex, x, width, y, height, z, depth, GraphicsFormatUtility.GetGraphicsFormat(dstFormat, QualitySettings.activeColorSpace == ColorSpace.Linear), callback, &asyncRequestNativeArrayData);
	}

	public unsafe void RequestAsyncReadbackIntoNativeArray<T>(ref NativeArray<T> output, Texture src, int mipIndex, int x, int width, int y, int height, int z, int depth, GraphicsFormat dstFormat, Action<AsyncGPUReadbackRequest> callback) where T : struct
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		Internal_RequestAsyncReadback_7(src, mipIndex, x, width, y, height, z, depth, dstFormat, callback, &asyncRequestNativeArrayData);
	}

	public unsafe void RequestAsyncReadbackIntoNativeSlice<T>(ref NativeSlice<T> output, ComputeBuffer src, Action<AsyncGPUReadbackRequest> callback) where T : struct
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		Internal_RequestAsyncReadback_1(src, callback, &asyncRequestNativeArrayData);
	}

	public unsafe void RequestAsyncReadbackIntoNativeSlice<T>(ref NativeSlice<T> output, ComputeBuffer src, int size, int offset, Action<AsyncGPUReadbackRequest> callback) where T : struct
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		Internal_RequestAsyncReadback_2(src, size, offset, callback, &asyncRequestNativeArrayData);
	}

	public unsafe void RequestAsyncReadbackIntoNativeSlice<T>(ref NativeSlice<T> output, GraphicsBuffer src, Action<AsyncGPUReadbackRequest> callback) where T : struct
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		Internal_RequestAsyncReadback_8(src, callback, &asyncRequestNativeArrayData);
	}

	public unsafe void RequestAsyncReadbackIntoNativeSlice<T>(ref NativeSlice<T> output, GraphicsBuffer src, int size, int offset, Action<AsyncGPUReadbackRequest> callback) where T : struct
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		Internal_RequestAsyncReadback_9(src, size, offset, callback, &asyncRequestNativeArrayData);
	}

	public unsafe void RequestAsyncReadbackIntoNativeSlice<T>(ref NativeSlice<T> output, Texture src, Action<AsyncGPUReadbackRequest> callback) where T : struct
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		Internal_RequestAsyncReadback_3(src, callback, &asyncRequestNativeArrayData);
	}

	public unsafe void RequestAsyncReadbackIntoNativeSlice<T>(ref NativeSlice<T> output, Texture src, int mipIndex, Action<AsyncGPUReadbackRequest> callback) where T : struct
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		Internal_RequestAsyncReadback_4(src, mipIndex, callback, &asyncRequestNativeArrayData);
	}

	public unsafe void RequestAsyncReadbackIntoNativeSlice<T>(ref NativeSlice<T> output, Texture src, int mipIndex, TextureFormat dstFormat, Action<AsyncGPUReadbackRequest> callback) where T : struct
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		Internal_RequestAsyncReadback_5(src, mipIndex, GraphicsFormatUtility.GetGraphicsFormat(dstFormat, QualitySettings.activeColorSpace == ColorSpace.Linear), callback, &asyncRequestNativeArrayData);
	}

	public unsafe void RequestAsyncReadbackIntoNativeSlice<T>(ref NativeSlice<T> output, Texture src, int mipIndex, GraphicsFormat dstFormat, Action<AsyncGPUReadbackRequest> callback) where T : struct
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		Internal_RequestAsyncReadback_5(src, mipIndex, dstFormat, callback, &asyncRequestNativeArrayData);
	}

	public unsafe void RequestAsyncReadbackIntoNativeSlice<T>(ref NativeSlice<T> output, Texture src, int mipIndex, int x, int width, int y, int height, int z, int depth, Action<AsyncGPUReadbackRequest> callback) where T : struct
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		Internal_RequestAsyncReadback_6(src, mipIndex, x, width, y, height, z, depth, callback, &asyncRequestNativeArrayData);
	}

	public unsafe void RequestAsyncReadbackIntoNativeSlice<T>(ref NativeSlice<T> output, Texture src, int mipIndex, int x, int width, int y, int height, int z, int depth, TextureFormat dstFormat, Action<AsyncGPUReadbackRequest> callback) where T : struct
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		Internal_RequestAsyncReadback_7(src, mipIndex, x, width, y, height, z, depth, GraphicsFormatUtility.GetGraphicsFormat(dstFormat, QualitySettings.activeColorSpace == ColorSpace.Linear), callback, &asyncRequestNativeArrayData);
	}

	public unsafe void RequestAsyncReadbackIntoNativeSlice<T>(ref NativeSlice<T> output, Texture src, int mipIndex, int x, int width, int y, int height, int z, int depth, GraphicsFormat dstFormat, Action<AsyncGPUReadbackRequest> callback) where T : struct
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		AsyncRequestNativeArrayData asyncRequestNativeArrayData = AsyncRequestNativeArrayData.CreateAndCheckAccess(output);
		Internal_RequestAsyncReadback_7(src, mipIndex, x, width, y, height, z, depth, dstFormat, callback, &asyncRequestNativeArrayData);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("AddRequestAsyncReadback")]
	private unsafe extern void Internal_RequestAsyncReadback_1([NotNull("ArgumentNullException")] ComputeBuffer src, [NotNull("ArgumentNullException")] Action<AsyncGPUReadbackRequest> callback, AsyncRequestNativeArrayData* nativeArrayData = null);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("AddRequestAsyncReadback")]
	private unsafe extern void Internal_RequestAsyncReadback_2([NotNull("ArgumentNullException")] ComputeBuffer src, int size, int offset, [NotNull("ArgumentNullException")] Action<AsyncGPUReadbackRequest> callback, AsyncRequestNativeArrayData* nativeArrayData = null);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("AddRequestAsyncReadback")]
	private unsafe extern void Internal_RequestAsyncReadback_3([NotNull("ArgumentNullException")] Texture src, [NotNull("ArgumentNullException")] Action<AsyncGPUReadbackRequest> callback, AsyncRequestNativeArrayData* nativeArrayData = null);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("AddRequestAsyncReadback")]
	private unsafe extern void Internal_RequestAsyncReadback_4([NotNull("ArgumentNullException")] Texture src, int mipIndex, [NotNull("ArgumentNullException")] Action<AsyncGPUReadbackRequest> callback, AsyncRequestNativeArrayData* nativeArrayData = null);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("AddRequestAsyncReadback")]
	private unsafe extern void Internal_RequestAsyncReadback_5([NotNull("ArgumentNullException")] Texture src, int mipIndex, GraphicsFormat dstFormat, [NotNull("ArgumentNullException")] Action<AsyncGPUReadbackRequest> callback, AsyncRequestNativeArrayData* nativeArrayData = null);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("AddRequestAsyncReadback")]
	private unsafe extern void Internal_RequestAsyncReadback_6([NotNull("ArgumentNullException")] Texture src, int mipIndex, int x, int width, int y, int height, int z, int depth, [NotNull("ArgumentNullException")] Action<AsyncGPUReadbackRequest> callback, AsyncRequestNativeArrayData* nativeArrayData = null);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("AddRequestAsyncReadback")]
	private unsafe extern void Internal_RequestAsyncReadback_7([NotNull("ArgumentNullException")] Texture src, int mipIndex, int x, int width, int y, int height, int z, int depth, GraphicsFormat dstFormat, [NotNull("ArgumentNullException")] Action<AsyncGPUReadbackRequest> callback, AsyncRequestNativeArrayData* nativeArrayData = null);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("AddRequestAsyncReadback")]
	private unsafe extern void Internal_RequestAsyncReadback_8([NotNull("ArgumentNullException")] GraphicsBuffer src, [NotNull("ArgumentNullException")] Action<AsyncGPUReadbackRequest> callback, AsyncRequestNativeArrayData* nativeArrayData = null);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("AddRequestAsyncReadback")]
	private unsafe extern void Internal_RequestAsyncReadback_9([NotNull("ArgumentNullException")] GraphicsBuffer src, int size, int offset, [NotNull("ArgumentNullException")] Action<AsyncGPUReadbackRequest> callback, AsyncRequestNativeArrayData* nativeArrayData = null);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("AddSetInvertCulling")]
	public extern void SetInvertCulling(bool invertCulling);

	private void ConvertTexture_Internal(RenderTargetIdentifier src, int srcElement, RenderTargetIdentifier dst, int dstElement)
	{
		ConvertTexture_Internal_Injected(ref src, srcElement, ref dst, dstElement);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_SetSinglePassStereo", HasExplicitThis = true)]
	private extern void Internal_SetSinglePassStereo(SinglePassStereoMode mode);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::InitBuffer")]
	private static extern IntPtr InitBuffer();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::CreateGPUFence_Internal", HasExplicitThis = true)]
	private extern IntPtr CreateGPUFence_Internal(GraphicsFenceType fenceType, SynchronisationStageFlags stage);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::WaitOnGPUFence_Internal", HasExplicitThis = true)]
	private extern void WaitOnGPUFence_Internal(IntPtr fencePtr, SynchronisationStageFlags stage);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::ReleaseBuffer", HasExplicitThis = true, IsThreadSafe = true)]
	private extern void ReleaseBuffer();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetComputeFloatParam", HasExplicitThis = true)]
	public extern void SetComputeFloatParam([NotNull("ArgumentNullException")] ComputeShader computeShader, int nameID, float val);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetComputeIntParam", HasExplicitThis = true)]
	public extern void SetComputeIntParam([NotNull("ArgumentNullException")] ComputeShader computeShader, int nameID, int val);

	[FreeFunction("RenderingCommandBuffer_Bindings::SetComputeVectorParam", HasExplicitThis = true)]
	public void SetComputeVectorParam([NotNull("ArgumentNullException")] ComputeShader computeShader, int nameID, Vector4 val)
	{
		SetComputeVectorParam_Injected(computeShader, nameID, ref val);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetComputeVectorArrayParam", HasExplicitThis = true)]
	public extern void SetComputeVectorArrayParam([NotNull("ArgumentNullException")] ComputeShader computeShader, int nameID, [Unmarshalled] Vector4[] values);

	[FreeFunction("RenderingCommandBuffer_Bindings::SetComputeMatrixParam", HasExplicitThis = true)]
	public void SetComputeMatrixParam([NotNull("ArgumentNullException")] ComputeShader computeShader, int nameID, Matrix4x4 val)
	{
		SetComputeMatrixParam_Injected(computeShader, nameID, ref val);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetComputeMatrixArrayParam", HasExplicitThis = true)]
	public extern void SetComputeMatrixArrayParam([NotNull("ArgumentNullException")] ComputeShader computeShader, int nameID, [Unmarshalled] Matrix4x4[] values);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_SetComputeFloats", HasExplicitThis = true)]
	private extern void Internal_SetComputeFloats([NotNull("ArgumentNullException")] ComputeShader computeShader, int nameID, [Unmarshalled] float[] values);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_SetComputeInts", HasExplicitThis = true)]
	private extern void Internal_SetComputeInts([NotNull("ArgumentNullException")] ComputeShader computeShader, int nameID, [Unmarshalled] int[] values);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_SetComputeTextureParam", HasExplicitThis = true)]
	private extern void Internal_SetComputeTextureParam([NotNull("ArgumentNullException")] ComputeShader computeShader, int kernelIndex, int nameID, ref RenderTargetIdentifier rt, int mipLevel, RenderTextureSubElement element);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetComputeBufferParam", HasExplicitThis = true)]
	private extern void Internal_SetComputeBufferParam([NotNull("ArgumentNullException")] ComputeShader computeShader, int kernelIndex, int nameID, ComputeBuffer buffer);

	[FreeFunction("RenderingCommandBuffer_Bindings::SetComputeBufferParam", HasExplicitThis = true)]
	private void Internal_SetComputeGraphicsBufferHandleParam([NotNull("ArgumentNullException")] ComputeShader computeShader, int kernelIndex, int nameID, GraphicsBufferHandle bufferHandle)
	{
		Internal_SetComputeGraphicsBufferHandleParam_Injected(computeShader, kernelIndex, nameID, ref bufferHandle);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetComputeBufferParam", HasExplicitThis = true)]
	private extern void Internal_SetComputeGraphicsBufferParam([NotNull("ArgumentNullException")] ComputeShader computeShader, int kernelIndex, int nameID, GraphicsBuffer buffer);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetComputeConstantBufferParam", HasExplicitThis = true)]
	private extern void Internal_SetComputeConstantComputeBufferParam([NotNull("ArgumentNullException")] ComputeShader computeShader, int nameID, ComputeBuffer buffer, int offset, int size);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetComputeConstantBufferParam", HasExplicitThis = true)]
	private extern void Internal_SetComputeConstantGraphicsBufferParam([NotNull("ArgumentNullException")] ComputeShader computeShader, int nameID, GraphicsBuffer buffer, int offset, int size);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetComputeParamsFromMaterial", HasExplicitThis = true)]
	private extern void Internal_SetComputeParamsFromMaterial([NotNull("ArgumentNullException")] ComputeShader computeShader, int kernelIndex, Material material);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_DispatchCompute", HasExplicitThis = true, ThrowsException = true)]
	private extern void Internal_DispatchCompute([NotNull("ArgumentNullException")] ComputeShader computeShader, int kernelIndex, int threadGroupsX, int threadGroupsY, int threadGroupsZ);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_DispatchComputeIndirect", HasExplicitThis = true, ThrowsException = true)]
	private extern void Internal_DispatchComputeIndirect([NotNull("ArgumentNullException")] ComputeShader computeShader, int kernelIndex, ComputeBuffer indirectBuffer, uint argsOffset);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_DispatchComputeIndirect", HasExplicitThis = true, ThrowsException = true)]
	private extern void Internal_DispatchComputeIndirectGraphicsBuffer([NotNull("ArgumentNullException")] ComputeShader computeShader, int kernelIndex, GraphicsBuffer indirectBuffer, uint argsOffset);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_SetRayTracingBufferParam", HasExplicitThis = true)]
	private extern void Internal_SetRayTracingBufferParam([NotNull("ArgumentNullException")] RayTracingShader rayTracingShader, int nameID, ComputeBuffer buffer);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_SetRayTracingConstantBufferParam", HasExplicitThis = true)]
	private extern void Internal_SetRayTracingConstantComputeBufferParam([NotNull("ArgumentNullException")] RayTracingShader rayTracingShader, int nameID, ComputeBuffer buffer, int offset, int size);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_SetRayTracingConstantBufferParam", HasExplicitThis = true)]
	private extern void Internal_SetRayTracingConstantGraphicsBufferParam([NotNull("ArgumentNullException")] RayTracingShader rayTracingShader, int nameID, GraphicsBuffer buffer, int offset, int size);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_SetRayTracingTextureParam", HasExplicitThis = true)]
	private extern void Internal_SetRayTracingTextureParam([NotNull("ArgumentNullException")] RayTracingShader rayTracingShader, int nameID, ref RenderTargetIdentifier rt);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_SetRayTracingFloatParam", HasExplicitThis = true)]
	private extern void Internal_SetRayTracingFloatParam([NotNull("ArgumentNullException")] RayTracingShader rayTracingShader, int nameID, float val);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_SetRayTracingIntParam", HasExplicitThis = true)]
	private extern void Internal_SetRayTracingIntParam([NotNull("ArgumentNullException")] RayTracingShader rayTracingShader, int nameID, int val);

	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_SetRayTracingVectorParam", HasExplicitThis = true)]
	private void Internal_SetRayTracingVectorParam([NotNull("ArgumentNullException")] RayTracingShader rayTracingShader, int nameID, Vector4 val)
	{
		Internal_SetRayTracingVectorParam_Injected(rayTracingShader, nameID, ref val);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_SetRayTracingVectorArrayParam", HasExplicitThis = true)]
	private extern void Internal_SetRayTracingVectorArrayParam([NotNull("ArgumentNullException")] RayTracingShader rayTracingShader, int nameID, [Unmarshalled] Vector4[] values);

	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_SetRayTracingMatrixParam", HasExplicitThis = true)]
	private void Internal_SetRayTracingMatrixParam([NotNull("ArgumentNullException")] RayTracingShader rayTracingShader, int nameID, Matrix4x4 val)
	{
		Internal_SetRayTracingMatrixParam_Injected(rayTracingShader, nameID, ref val);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_SetRayTracingMatrixArrayParam", HasExplicitThis = true)]
	private extern void Internal_SetRayTracingMatrixArrayParam([NotNull("ArgumentNullException")] RayTracingShader rayTracingShader, int nameID, [Unmarshalled] Matrix4x4[] values);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_SetRayTracingFloats", HasExplicitThis = true)]
	private extern void Internal_SetRayTracingFloats([NotNull("ArgumentNullException")] RayTracingShader rayTracingShader, int nameID, [Unmarshalled] float[] values);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_SetRayTracingInts", HasExplicitThis = true)]
	private extern void Internal_SetRayTracingInts([NotNull("ArgumentNullException")] RayTracingShader rayTracingShader, int nameID, [Unmarshalled] int[] values);

	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_BuildRayTracingAccelerationStructure", HasExplicitThis = true)]
	private void Internal_BuildRayTracingAccelerationStructure([NotNull("ArgumentNullException")] RayTracingAccelerationStructure accelerationStructure, Vector3 relativeOrigin)
	{
		Internal_BuildRayTracingAccelerationStructure_Injected(accelerationStructure, ref relativeOrigin);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_SetRayTracingAccelerationStructure", HasExplicitThis = true)]
	private extern void Internal_SetRayTracingAccelerationStructure([NotNull("ArgumentNullException")] RayTracingShader rayTracingShader, int nameID, RayTracingAccelerationStructure accelerationStructure);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("AddSetRayTracingShaderPass")]
	public extern void SetRayTracingShaderPass([NotNull("ArgumentNullException")] RayTracingShader rayTracingShader, string passName);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_DispatchRays", HasExplicitThis = true, ThrowsException = true)]
	private extern void Internal_DispatchRays([NotNull("ArgumentNullException")] RayTracingShader rayTracingShader, string rayGenShaderName, uint width, uint height, uint depth, Camera camera = null);

	[NativeMethod("AddGenerateMips")]
	private void Internal_GenerateMips(RenderTargetIdentifier rt)
	{
		Internal_GenerateMips_Injected(ref rt);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("AddResolveAntiAliasedSurface")]
	private extern void Internal_ResolveAntiAliasedSurface(RenderTexture rt, RenderTexture target);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("AddCopyCounterValue")]
	private extern void CopyCounterValueCC(ComputeBuffer src, ComputeBuffer dst, uint dstOffsetBytes);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("AddCopyCounterValue")]
	private extern void CopyCounterValueGC(GraphicsBuffer src, ComputeBuffer dst, uint dstOffsetBytes);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("AddCopyCounterValue")]
	private extern void CopyCounterValueCG(ComputeBuffer src, GraphicsBuffer dst, uint dstOffsetBytes);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("AddCopyCounterValue")]
	private extern void CopyCounterValueGG(GraphicsBuffer src, GraphicsBuffer dst, uint dstOffsetBytes);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("ClearCommands")]
	public extern void Clear();

	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_DrawMesh", HasExplicitThis = true)]
	private void Internal_DrawMesh([NotNull("ArgumentNullException")] Mesh mesh, Matrix4x4 matrix, Material material, int submeshIndex, int shaderPass, MaterialPropertyBlock properties)
	{
		Internal_DrawMesh_Injected(mesh, ref matrix, material, submeshIndex, shaderPass, properties);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("AddDrawRenderer")]
	private extern void Internal_DrawRenderer([NotNull("ArgumentNullException")] Renderer renderer, Material material, int submeshIndex, int shaderPass);

	[NativeMethod("AddDrawRendererList")]
	private void Internal_DrawRendererList(RendererList rendererList)
	{
		Internal_DrawRendererList_Injected(ref rendererList);
	}

	private void Internal_DrawRenderer(Renderer renderer, Material material, int submeshIndex)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Internal_DrawRenderer(renderer, material, submeshIndex, -1);
	}

	private void Internal_DrawRenderer(Renderer renderer, Material material)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Internal_DrawRenderer(renderer, material, 0);
	}

	[NativeMethod("AddDrawProcedural")]
	private void Internal_DrawProcedural(Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, int vertexCount, int instanceCount, MaterialPropertyBlock properties)
	{
		Internal_DrawProcedural_Injected(ref matrix, material, shaderPass, topology, vertexCount, instanceCount, properties);
	}

	[NativeMethod("AddDrawProceduralIndexed")]
	private void Internal_DrawProceduralIndexed(GraphicsBuffer indexBuffer, Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, int indexCount, int instanceCount, MaterialPropertyBlock properties)
	{
		Internal_DrawProceduralIndexed_Injected(indexBuffer, ref matrix, material, shaderPass, topology, indexCount, instanceCount, properties);
	}

	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_DrawProceduralIndirect", HasExplicitThis = true)]
	private void Internal_DrawProceduralIndirect(Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, ComputeBuffer bufferWithArgs, int argsOffset, MaterialPropertyBlock properties)
	{
		Internal_DrawProceduralIndirect_Injected(ref matrix, material, shaderPass, topology, bufferWithArgs, argsOffset, properties);
	}

	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_DrawProceduralIndexedIndirect", HasExplicitThis = true)]
	private void Internal_DrawProceduralIndexedIndirect(GraphicsBuffer indexBuffer, Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, ComputeBuffer bufferWithArgs, int argsOffset, MaterialPropertyBlock properties)
	{
		Internal_DrawProceduralIndexedIndirect_Injected(indexBuffer, ref matrix, material, shaderPass, topology, bufferWithArgs, argsOffset, properties);
	}

	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_DrawProceduralIndirect", HasExplicitThis = true)]
	private void Internal_DrawProceduralIndirectGraphicsBuffer(Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, GraphicsBuffer bufferWithArgs, int argsOffset, MaterialPropertyBlock properties)
	{
		Internal_DrawProceduralIndirectGraphicsBuffer_Injected(ref matrix, material, shaderPass, topology, bufferWithArgs, argsOffset, properties);
	}

	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_DrawProceduralIndexedIndirect", HasExplicitThis = true)]
	private void Internal_DrawProceduralIndexedIndirectGraphicsBuffer(GraphicsBuffer indexBuffer, Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, GraphicsBuffer bufferWithArgs, int argsOffset, MaterialPropertyBlock properties)
	{
		Internal_DrawProceduralIndexedIndirectGraphicsBuffer_Injected(indexBuffer, ref matrix, material, shaderPass, topology, bufferWithArgs, argsOffset, properties);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_DrawMeshInstanced", HasExplicitThis = true)]
	private extern void Internal_DrawMeshInstanced(Mesh mesh, int submeshIndex, Material material, int shaderPass, [Unmarshalled] Matrix4x4[] matrices, int count, MaterialPropertyBlock properties);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_DrawMeshInstancedProcedural", HasExplicitThis = true)]
	private extern void Internal_DrawMeshInstancedProcedural(Mesh mesh, int submeshIndex, Material material, int shaderPass, int count, MaterialPropertyBlock properties);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_DrawMeshInstancedIndirect", HasExplicitThis = true)]
	private extern void Internal_DrawMeshInstancedIndirect(Mesh mesh, int submeshIndex, Material material, int shaderPass, ComputeBuffer bufferWithArgs, int argsOffset, MaterialPropertyBlock properties);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_DrawMeshInstancedIndirect", HasExplicitThis = true)]
	private extern void Internal_DrawMeshInstancedIndirectGraphicsBuffer(Mesh mesh, int submeshIndex, Material material, int shaderPass, GraphicsBuffer bufferWithArgs, int argsOffset, MaterialPropertyBlock properties);

	[FreeFunction("RenderingCommandBuffer_Bindings::Internal_DrawOcclusionMesh", HasExplicitThis = true)]
	private void Internal_DrawOcclusionMesh(RectInt normalizedCamViewport)
	{
		Internal_DrawOcclusionMesh_Injected(ref normalizedCamViewport);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetRandomWriteTarget_Texture", HasExplicitThis = true, ThrowsException = true)]
	private extern void SetRandomWriteTarget_Texture(int index, ref RenderTargetIdentifier rt);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetRandomWriteTarget_Buffer", HasExplicitThis = true, ThrowsException = true)]
	private extern void SetRandomWriteTarget_Buffer(int index, ComputeBuffer uav, bool preserveCounterValue);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetRandomWriteTarget_Buffer", HasExplicitThis = true, ThrowsException = true)]
	private extern void SetRandomWriteTarget_GraphicsBuffer(int index, GraphicsBuffer uav, bool preserveCounterValue);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::ClearRandomWriteTargets", HasExplicitThis = true, ThrowsException = true)]
	public extern void ClearRandomWriteTargets();

	[FreeFunction("RenderingCommandBuffer_Bindings::SetViewport", HasExplicitThis = true, ThrowsException = true)]
	public void SetViewport(Rect pixelRect)
	{
		SetViewport_Injected(ref pixelRect);
	}

	[FreeFunction("RenderingCommandBuffer_Bindings::EnableScissorRect", HasExplicitThis = true, ThrowsException = true)]
	public void EnableScissorRect(Rect scissor)
	{
		EnableScissorRect_Injected(ref scissor);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::DisableScissorRect", HasExplicitThis = true, ThrowsException = true)]
	public extern void DisableScissorRect();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::CopyTexture_Internal", HasExplicitThis = true)]
	private extern void CopyTexture_Internal(ref RenderTargetIdentifier src, int srcElement, int srcMip, int srcX, int srcY, int srcWidth, int srcHeight, ref RenderTargetIdentifier dst, int dstElement, int dstMip, int dstX, int dstY, int mode);

	[FreeFunction("RenderingCommandBuffer_Bindings::Blit_Texture", HasExplicitThis = true)]
	private void Blit_Texture(Texture source, ref RenderTargetIdentifier dest, Material mat, int pass, Vector2 scale, Vector2 offset, int sourceDepthSlice, int destDepthSlice)
	{
		Blit_Texture_Injected(source, ref dest, mat, pass, ref scale, ref offset, sourceDepthSlice, destDepthSlice);
	}

	[FreeFunction("RenderingCommandBuffer_Bindings::Blit_Identifier", HasExplicitThis = true)]
	private void Blit_Identifier(ref RenderTargetIdentifier source, ref RenderTargetIdentifier dest, Material mat, int pass, Vector2 scale, Vector2 offset, int sourceDepthSlice, int destDepthSlice)
	{
		Blit_Identifier_Injected(ref source, ref dest, mat, pass, ref scale, ref offset, sourceDepthSlice, destDepthSlice);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::GetTemporaryRT", HasExplicitThis = true)]
	public extern void GetTemporaryRT(int nameID, int width, int height, int depthBuffer, FilterMode filter, GraphicsFormat format, int antiAliasing, bool enableRandomWrite, RenderTextureMemoryless memorylessMode, bool useDynamicScale);

	public void GetTemporaryRT(int nameID, int width, int height, int depthBuffer, FilterMode filter, GraphicsFormat format, int antiAliasing, bool enableRandomWrite, RenderTextureMemoryless memorylessMode)
	{
		GetTemporaryRT(nameID, width, height, depthBuffer, filter, format, antiAliasing, enableRandomWrite, memorylessMode, useDynamicScale: false);
	}

	public void GetTemporaryRT(int nameID, int width, int height, int depthBuffer, FilterMode filter, GraphicsFormat format, int antiAliasing, bool enableRandomWrite)
	{
		GetTemporaryRT(nameID, width, height, depthBuffer, filter, format, antiAliasing, enableRandomWrite, RenderTextureMemoryless.None);
	}

	public void GetTemporaryRT(int nameID, int width, int height, int depthBuffer, FilterMode filter, GraphicsFormat format, int antiAliasing)
	{
		GetTemporaryRT(nameID, width, height, depthBuffer, filter, format, antiAliasing, enableRandomWrite: false, RenderTextureMemoryless.None);
	}

	public void GetTemporaryRT(int nameID, int width, int height, int depthBuffer, FilterMode filter, GraphicsFormat format)
	{
		GetTemporaryRT(nameID, width, height, depthBuffer, filter, format, 1);
	}

	public void GetTemporaryRT(int nameID, int width, int height, int depthBuffer, FilterMode filter, RenderTextureFormat format, RenderTextureReadWrite readWrite, int antiAliasing, bool enableRandomWrite, RenderTextureMemoryless memorylessMode, bool useDynamicScale)
	{
		GetTemporaryRT(nameID, width, height, depthBuffer, filter, GraphicsFormatUtility.GetGraphicsFormat(format, readWrite), antiAliasing, enableRandomWrite, memorylessMode, useDynamicScale);
	}

	public void GetTemporaryRT(int nameID, int width, int height, int depthBuffer, FilterMode filter, RenderTextureFormat format, RenderTextureReadWrite readWrite, int antiAliasing, bool enableRandomWrite, RenderTextureMemoryless memorylessMode)
	{
		GetTemporaryRT(nameID, width, height, depthBuffer, filter, format, readWrite, antiAliasing, enableRandomWrite, memorylessMode, useDynamicScale: false);
	}

	public void GetTemporaryRT(int nameID, int width, int height, int depthBuffer, FilterMode filter, RenderTextureFormat format, RenderTextureReadWrite readWrite, int antiAliasing, bool enableRandomWrite)
	{
		GetTemporaryRT(nameID, width, height, depthBuffer, filter, format, readWrite, antiAliasing, enableRandomWrite, RenderTextureMemoryless.None);
	}

	public void GetTemporaryRT(int nameID, int width, int height, int depthBuffer, FilterMode filter, RenderTextureFormat format, RenderTextureReadWrite readWrite, int antiAliasing)
	{
		GetTemporaryRT(nameID, width, height, depthBuffer, filter, format, readWrite, antiAliasing, enableRandomWrite: false);
	}

	public void GetTemporaryRT(int nameID, int width, int height, int depthBuffer, FilterMode filter, RenderTextureFormat format, RenderTextureReadWrite readWrite)
	{
		GetTemporaryRT(nameID, width, height, depthBuffer, filter, format, readWrite, 1);
	}

	public void GetTemporaryRT(int nameID, int width, int height, int depthBuffer, FilterMode filter, RenderTextureFormat format)
	{
		GetTemporaryRT(nameID, width, height, depthBuffer, filter, GraphicsFormatUtility.GetGraphicsFormat(format, RenderTextureReadWrite.Default));
	}

	public void GetTemporaryRT(int nameID, int width, int height, int depthBuffer, FilterMode filter)
	{
		GetTemporaryRT(nameID, width, height, depthBuffer, filter, SystemInfo.GetGraphicsFormat(DefaultFormat.LDR));
	}

	public void GetTemporaryRT(int nameID, int width, int height, int depthBuffer)
	{
		GetTemporaryRT(nameID, width, height, depthBuffer, FilterMode.Point);
	}

	public void GetTemporaryRT(int nameID, int width, int height)
	{
		GetTemporaryRT(nameID, width, height, 0);
	}

	[FreeFunction("RenderingCommandBuffer_Bindings::GetTemporaryRTWithDescriptor", HasExplicitThis = true)]
	private void GetTemporaryRTWithDescriptor(int nameID, RenderTextureDescriptor desc, FilterMode filter)
	{
		GetTemporaryRTWithDescriptor_Injected(nameID, ref desc, filter);
	}

	public void GetTemporaryRT(int nameID, RenderTextureDescriptor desc, FilterMode filter)
	{
		GetTemporaryRTWithDescriptor(nameID, desc, filter);
	}

	public void GetTemporaryRT(int nameID, RenderTextureDescriptor desc)
	{
		GetTemporaryRT(nameID, desc, FilterMode.Point);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::GetTemporaryRTArray", HasExplicitThis = true)]
	public extern void GetTemporaryRTArray(int nameID, int width, int height, int slices, int depthBuffer, FilterMode filter, GraphicsFormat format, int antiAliasing, bool enableRandomWrite, bool useDynamicScale);

	public void GetTemporaryRTArray(int nameID, int width, int height, int slices, int depthBuffer, FilterMode filter, GraphicsFormat format, int antiAliasing, bool enableRandomWrite)
	{
		GetTemporaryRTArray(nameID, width, height, slices, depthBuffer, filter, format, antiAliasing, enableRandomWrite, useDynamicScale: false);
	}

	public void GetTemporaryRTArray(int nameID, int width, int height, int slices, int depthBuffer, FilterMode filter, GraphicsFormat format, int antiAliasing)
	{
		GetTemporaryRTArray(nameID, width, height, slices, depthBuffer, filter, format, antiAliasing, enableRandomWrite: false);
	}

	public void GetTemporaryRTArray(int nameID, int width, int height, int slices, int depthBuffer, FilterMode filter, GraphicsFormat format)
	{
		GetTemporaryRTArray(nameID, width, height, slices, depthBuffer, filter, format, 1);
	}

	public void GetTemporaryRTArray(int nameID, int width, int height, int slices, int depthBuffer, FilterMode filter, RenderTextureFormat format, RenderTextureReadWrite readWrite, int antiAliasing, bool enableRandomWrite)
	{
		GetTemporaryRTArray(nameID, width, height, slices, depthBuffer, filter, GraphicsFormatUtility.GetGraphicsFormat(format, readWrite), antiAliasing, enableRandomWrite, useDynamicScale: false);
	}

	public void GetTemporaryRTArray(int nameID, int width, int height, int slices, int depthBuffer, FilterMode filter, RenderTextureFormat format, RenderTextureReadWrite readWrite, int antiAliasing)
	{
		GetTemporaryRTArray(nameID, width, height, slices, depthBuffer, filter, GraphicsFormatUtility.GetGraphicsFormat(format, readWrite), antiAliasing, enableRandomWrite: false);
	}

	public void GetTemporaryRTArray(int nameID, int width, int height, int slices, int depthBuffer, FilterMode filter, RenderTextureFormat format, RenderTextureReadWrite readWrite)
	{
		GetTemporaryRTArray(nameID, width, height, slices, depthBuffer, filter, GraphicsFormatUtility.GetGraphicsFormat(format, readWrite), 1, enableRandomWrite: false);
	}

	public void GetTemporaryRTArray(int nameID, int width, int height, int slices, int depthBuffer, FilterMode filter, RenderTextureFormat format)
	{
		GetTemporaryRTArray(nameID, width, height, slices, depthBuffer, filter, GraphicsFormatUtility.GetGraphicsFormat(format, RenderTextureReadWrite.Default), 1, enableRandomWrite: false);
	}

	public void GetTemporaryRTArray(int nameID, int width, int height, int slices, int depthBuffer, FilterMode filter)
	{
		GetTemporaryRTArray(nameID, width, height, slices, depthBuffer, filter, SystemInfo.GetGraphicsFormat(DefaultFormat.LDR), 1, enableRandomWrite: false);
	}

	public void GetTemporaryRTArray(int nameID, int width, int height, int slices, int depthBuffer)
	{
		GetTemporaryRTArray(nameID, width, height, slices, depthBuffer, FilterMode.Point);
	}

	public void GetTemporaryRTArray(int nameID, int width, int height, int slices)
	{
		GetTemporaryRTArray(nameID, width, height, slices, 0);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::ReleaseTemporaryRT", HasExplicitThis = true)]
	public extern void ReleaseTemporaryRT(int nameID);

	[FreeFunction("RenderingCommandBuffer_Bindings::ClearRenderTarget", HasExplicitThis = true)]
	public void ClearRenderTarget(RTClearFlags clearFlags, Color backgroundColor, float depth, uint stencil)
	{
		ClearRenderTarget_Injected(clearFlags, ref backgroundColor, depth, stencil);
	}

	public void ClearRenderTarget(bool clearDepth, bool clearColor, Color backgroundColor)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		ClearRenderTarget((RTClearFlags)((clearColor ? 1 : 0) | (clearDepth ? 6 : 0)), backgroundColor, 1f, 0u);
	}

	public void ClearRenderTarget(bool clearDepth, bool clearColor, Color backgroundColor, float depth)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		ClearRenderTarget((RTClearFlags)((clearColor ? 1 : 0) | (clearDepth ? 6 : 0)), backgroundColor, depth, 0u);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetGlobalFloat", HasExplicitThis = true)]
	public extern void SetGlobalFloat(int nameID, float value);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetGlobalInt", HasExplicitThis = true)]
	public extern void SetGlobalInt(int nameID, int value);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetGlobalInteger", HasExplicitThis = true)]
	public extern void SetGlobalInteger(int nameID, int value);

	[FreeFunction("RenderingCommandBuffer_Bindings::SetGlobalVector", HasExplicitThis = true)]
	public void SetGlobalVector(int nameID, Vector4 value)
	{
		SetGlobalVector_Injected(nameID, ref value);
	}

	[FreeFunction("RenderingCommandBuffer_Bindings::SetGlobalColor", HasExplicitThis = true)]
	public void SetGlobalColor(int nameID, Color value)
	{
		SetGlobalColor_Injected(nameID, ref value);
	}

	[FreeFunction("RenderingCommandBuffer_Bindings::SetGlobalMatrix", HasExplicitThis = true)]
	public void SetGlobalMatrix(int nameID, Matrix4x4 value)
	{
		SetGlobalMatrix_Injected(nameID, ref value);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::EnableShaderKeyword", HasExplicitThis = true)]
	public extern void EnableShaderKeyword(string keyword);

	[FreeFunction("RenderingCommandBuffer_Bindings::EnableShaderKeyword", HasExplicitThis = true)]
	private void EnableGlobalKeyword(GlobalKeyword keyword)
	{
		EnableGlobalKeyword_Injected(ref keyword);
	}

	[FreeFunction("RenderingCommandBuffer_Bindings::EnableMaterialKeyword", HasExplicitThis = true)]
	private void EnableMaterialKeyword(Material material, LocalKeyword keyword)
	{
		EnableMaterialKeyword_Injected(material, ref keyword);
	}

	[FreeFunction("RenderingCommandBuffer_Bindings::EnableComputeKeyword", HasExplicitThis = true)]
	private void EnableComputeKeyword(ComputeShader computeShader, LocalKeyword keyword)
	{
		EnableComputeKeyword_Injected(computeShader, ref keyword);
	}

	public void EnableKeyword(in GlobalKeyword keyword)
	{
		EnableGlobalKeyword(keyword);
	}

	public void EnableKeyword(Material material, in LocalKeyword keyword)
	{
		EnableMaterialKeyword(material, keyword);
	}

	public void EnableKeyword(ComputeShader computeShader, in LocalKeyword keyword)
	{
		EnableComputeKeyword(computeShader, keyword);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::DisableShaderKeyword", HasExplicitThis = true)]
	public extern void DisableShaderKeyword(string keyword);

	[FreeFunction("RenderingCommandBuffer_Bindings::DisableShaderKeyword", HasExplicitThis = true)]
	private void DisableGlobalKeyword(GlobalKeyword keyword)
	{
		DisableGlobalKeyword_Injected(ref keyword);
	}

	[FreeFunction("RenderingCommandBuffer_Bindings::DisableMaterialKeyword", HasExplicitThis = true)]
	private void DisableMaterialKeyword(Material material, LocalKeyword keyword)
	{
		DisableMaterialKeyword_Injected(material, ref keyword);
	}

	[FreeFunction("RenderingCommandBuffer_Bindings::DisableComputeKeyword", HasExplicitThis = true)]
	private void DisableComputeKeyword(ComputeShader computeShader, LocalKeyword keyword)
	{
		DisableComputeKeyword_Injected(computeShader, ref keyword);
	}

	public void DisableKeyword(in GlobalKeyword keyword)
	{
		DisableGlobalKeyword(keyword);
	}

	public void DisableKeyword(Material material, in LocalKeyword keyword)
	{
		DisableMaterialKeyword(material, keyword);
	}

	public void DisableKeyword(ComputeShader computeShader, in LocalKeyword keyword)
	{
		DisableComputeKeyword(computeShader, keyword);
	}

	[FreeFunction("RenderingCommandBuffer_Bindings::SetShaderKeyword", HasExplicitThis = true)]
	private void SetGlobalKeyword(GlobalKeyword keyword, bool value)
	{
		SetGlobalKeyword_Injected(ref keyword, value);
	}

	[FreeFunction("RenderingCommandBuffer_Bindings::SetMaterialKeyword", HasExplicitThis = true)]
	private void SetMaterialKeyword(Material material, LocalKeyword keyword, bool value)
	{
		SetMaterialKeyword_Injected(material, ref keyword, value);
	}

	[FreeFunction("RenderingCommandBuffer_Bindings::SetComputeKeyword", HasExplicitThis = true)]
	private void SetComputeKeyword(ComputeShader computeShader, LocalKeyword keyword, bool value)
	{
		SetComputeKeyword_Injected(computeShader, ref keyword, value);
	}

	public void SetKeyword(in GlobalKeyword keyword, bool value)
	{
		SetGlobalKeyword(keyword, value);
	}

	public void SetKeyword(Material material, in LocalKeyword keyword, bool value)
	{
		SetMaterialKeyword(material, keyword, value);
	}

	public void SetKeyword(ComputeShader computeShader, in LocalKeyword keyword, bool value)
	{
		SetComputeKeyword(computeShader, keyword, value);
	}

	[FreeFunction("RenderingCommandBuffer_Bindings::SetViewMatrix", HasExplicitThis = true, ThrowsException = true)]
	public void SetViewMatrix(Matrix4x4 view)
	{
		SetViewMatrix_Injected(ref view);
	}

	[FreeFunction("RenderingCommandBuffer_Bindings::SetProjectionMatrix", HasExplicitThis = true, ThrowsException = true)]
	public void SetProjectionMatrix(Matrix4x4 proj)
	{
		SetProjectionMatrix_Injected(ref proj);
	}

	[FreeFunction("RenderingCommandBuffer_Bindings::SetViewProjectionMatrices", HasExplicitThis = true, ThrowsException = true)]
	public void SetViewProjectionMatrices(Matrix4x4 view, Matrix4x4 proj)
	{
		SetViewProjectionMatrices_Injected(ref view, ref proj);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("AddSetGlobalDepthBias")]
	public extern void SetGlobalDepthBias(float bias, float slopeBias);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetExecutionFlags", HasExplicitThis = true, ThrowsException = true)]
	public extern void SetExecutionFlags(CommandBufferExecutionFlags flags);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::ValidateAgainstExecutionFlags", HasExplicitThis = true, ThrowsException = true)]
	private extern bool ValidateAgainstExecutionFlags(CommandBufferExecutionFlags requiredFlags, CommandBufferExecutionFlags invalidFlags);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetGlobalFloatArrayListImpl", HasExplicitThis = true)]
	private extern void SetGlobalFloatArrayListImpl(int nameID, object values);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetGlobalVectorArrayListImpl", HasExplicitThis = true)]
	private extern void SetGlobalVectorArrayListImpl(int nameID, object values);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetGlobalMatrixArrayListImpl", HasExplicitThis = true)]
	private extern void SetGlobalMatrixArrayListImpl(int nameID, object values);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetGlobalFloatArray", HasExplicitThis = true, ThrowsException = true)]
	public extern void SetGlobalFloatArray(int nameID, [Unmarshalled] float[] values);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetGlobalVectorArray", HasExplicitThis = true, ThrowsException = true)]
	public extern void SetGlobalVectorArray(int nameID, [Unmarshalled] Vector4[] values);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetGlobalMatrixArray", HasExplicitThis = true, ThrowsException = true)]
	public extern void SetGlobalMatrixArray(int nameID, [Unmarshalled] Matrix4x4[] values);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetLateLatchProjectionMatrices", HasExplicitThis = true, ThrowsException = true)]
	public extern void SetLateLatchProjectionMatrices([Unmarshalled] Matrix4x4[] projectionMat);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::MarkLateLatchMatrixShaderPropertyID", HasExplicitThis = true)]
	public extern void MarkLateLatchMatrixShaderPropertyID(CameraLateLatchMatrixType matrixPropertyType, int shaderPropertyID);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::UnmarkLateLatchMatrix", HasExplicitThis = true)]
	public extern void UnmarkLateLatchMatrix(CameraLateLatchMatrixType matrixPropertyType);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetGlobalTexture_Impl", HasExplicitThis = true)]
	private extern void SetGlobalTexture_Impl(int nameID, ref RenderTargetIdentifier rt, RenderTextureSubElement element);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetGlobalBuffer", HasExplicitThis = true)]
	private extern void SetGlobalBufferInternal(int nameID, ComputeBuffer value);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetGlobalBuffer", HasExplicitThis = true)]
	private extern void SetGlobalGraphicsBufferInternal(int nameID, GraphicsBuffer value);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetShadowSamplingMode_Impl", HasExplicitThis = true)]
	private extern void SetShadowSamplingMode_Impl(ref RenderTargetIdentifier shadowmap, ShadowSamplingMode mode);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::IssuePluginEventInternal", HasExplicitThis = true)]
	private extern void IssuePluginEventInternal(IntPtr callback, int eventID);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::BeginSample", HasExplicitThis = true)]
	public extern void BeginSample(string name);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::EndSample", HasExplicitThis = true)]
	public extern void EndSample(string name);

	public void BeginSample(CustomSampler sampler)
	{
		BeginSample_CustomSampler(sampler);
	}

	public void EndSample(CustomSampler sampler)
	{
		EndSample_CustomSampler(sampler);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::BeginSample_CustomSampler", HasExplicitThis = true)]
	private extern void BeginSample_CustomSampler([NotNull("ArgumentNullException")] CustomSampler sampler);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::EndSample_CustomSampler", HasExplicitThis = true)]
	private extern void EndSample_CustomSampler([NotNull("ArgumentNullException")] CustomSampler sampler);

	[MethodImpl((MethodImplOptions)256)]
	[Conditional("ENABLE_PROFILER")]
	public void BeginSample(ProfilerMarker marker)
	{
		BeginSample_ProfilerMarker(marker.Handle);
	}

	[MethodImpl((MethodImplOptions)256)]
	[Conditional("ENABLE_PROFILER")]
	public void EndSample(ProfilerMarker marker)
	{
		EndSample_ProfilerMarker(marker.Handle);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::BeginSample_ProfilerMarker", HasExplicitThis = true, ThrowsException = true)]
	private extern void BeginSample_ProfilerMarker(IntPtr markerHandle);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::EndSample_ProfilerMarker", HasExplicitThis = true, ThrowsException = true)]
	private extern void EndSample_ProfilerMarker(IntPtr markerHandle);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::IssuePluginEventAndDataInternal", HasExplicitThis = true)]
	private extern void IssuePluginEventAndDataInternal(IntPtr callback, int eventID, IntPtr data);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::IssuePluginEventAndDataWithFlagsInternal", HasExplicitThis = true)]
	private extern void IssuePluginEventAndDataInternalWithFlags(IntPtr callback, int eventID, CustomMarkerCallbackFlags flags, IntPtr data);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::IssuePluginCustomBlitInternal", HasExplicitThis = true)]
	private extern void IssuePluginCustomBlitInternal(IntPtr callback, uint command, ref RenderTargetIdentifier source, ref RenderTargetIdentifier dest, uint commandParam, uint commandFlags);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::IssuePluginCustomTextureUpdateInternal", HasExplicitThis = true)]
	private extern void IssuePluginCustomTextureUpdateInternal(IntPtr callback, Texture targetTexture, uint userData, bool useNewUnityRenderingExtTextureUpdateParamsV2);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetGlobalConstantBuffer", HasExplicitThis = true)]
	private extern void SetGlobalConstantBufferInternal(ComputeBuffer buffer, int nameID, int offset, int size);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetGlobalConstantBuffer", HasExplicitThis = true)]
	private extern void SetGlobalConstantGraphicsBufferInternal(GraphicsBuffer buffer, int nameID, int offset, int size);

	[FreeFunction("RenderingCommandBuffer_Bindings::IncrementUpdateCount", HasExplicitThis = true)]
	public void IncrementUpdateCount(RenderTargetIdentifier dest)
	{
		IncrementUpdateCount_Injected(ref dest);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetInstanceMultiplier", HasExplicitThis = true)]
	public extern void SetInstanceMultiplier(uint multiplier);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetFoveatedRenderingMode", HasExplicitThis = true)]
	public extern void SetFoveatedRenderingMode(FoveatedRenderingMode foveatedRenderingMode);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::SetWireframe", HasExplicitThis = true)]
	public extern void SetWireframe(bool enable);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBuffer_Bindings::ConfigureFoveatedRendering", HasExplicitThis = true)]
	public extern void ConfigureFoveatedRendering(IntPtr platformData);

	public void SetRenderTarget(RenderTargetIdentifier rt)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		SetRenderTargetSingle_Internal(rt, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store);
	}

	public void SetRenderTarget(RenderTargetIdentifier rt, RenderBufferLoadAction loadAction, RenderBufferStoreAction storeAction)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		if (loadAction == RenderBufferLoadAction.Clear)
		{
			throw new ArgumentException("RenderBufferLoadAction.Clear is not supported");
		}
		SetRenderTargetSingle_Internal(rt, loadAction, storeAction, loadAction, storeAction);
	}

	public void SetRenderTarget(RenderTargetIdentifier rt, RenderBufferLoadAction colorLoadAction, RenderBufferStoreAction colorStoreAction, RenderBufferLoadAction depthLoadAction, RenderBufferStoreAction depthStoreAction)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		if (colorLoadAction == RenderBufferLoadAction.Clear || depthLoadAction == RenderBufferLoadAction.Clear)
		{
			throw new ArgumentException("RenderBufferLoadAction.Clear is not supported");
		}
		SetRenderTargetSingle_Internal(rt, colorLoadAction, colorStoreAction, depthLoadAction, depthStoreAction);
	}

	public void SetRenderTarget(RenderTargetIdentifier rt, int mipLevel)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		if (mipLevel < 0)
		{
			throw new ArgumentException($"Invalid value for mipLevel ({mipLevel})");
		}
		SetRenderTargetSingle_Internal(new RenderTargetIdentifier(rt, mipLevel), RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store);
	}

	public void SetRenderTarget(RenderTargetIdentifier rt, int mipLevel, CubemapFace cubemapFace)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		if (mipLevel < 0)
		{
			throw new ArgumentException($"Invalid value for mipLevel ({mipLevel})");
		}
		SetRenderTargetSingle_Internal(new RenderTargetIdentifier(rt, mipLevel, cubemapFace), RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store);
	}

	public void SetRenderTarget(RenderTargetIdentifier rt, int mipLevel, CubemapFace cubemapFace, int depthSlice)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		if (depthSlice < -1)
		{
			throw new ArgumentException($"Invalid value for depthSlice ({depthSlice})");
		}
		if (mipLevel < 0)
		{
			throw new ArgumentException($"Invalid value for mipLevel ({mipLevel})");
		}
		SetRenderTargetSingle_Internal(new RenderTargetIdentifier(rt, mipLevel, cubemapFace, depthSlice), RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store);
	}

	public void SetRenderTarget(RenderTargetIdentifier color, RenderTargetIdentifier depth)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		SetRenderTargetColorDepth_Internal(color, depth, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, RenderTargetFlags.None);
	}

	public void SetRenderTarget(RenderTargetIdentifier color, RenderTargetIdentifier depth, int mipLevel)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		if (mipLevel < 0)
		{
			throw new ArgumentException($"Invalid value for mipLevel ({mipLevel})");
		}
		SetRenderTargetColorDepth_Internal(new RenderTargetIdentifier(color, mipLevel), depth, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, RenderTargetFlags.None);
	}

	public void SetRenderTarget(RenderTargetIdentifier color, RenderTargetIdentifier depth, int mipLevel, CubemapFace cubemapFace)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		if (mipLevel < 0)
		{
			throw new ArgumentException($"Invalid value for mipLevel ({mipLevel})");
		}
		SetRenderTargetColorDepth_Internal(new RenderTargetIdentifier(color, mipLevel, cubemapFace), depth, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, RenderTargetFlags.None);
	}

	public void SetRenderTarget(RenderTargetIdentifier color, RenderTargetIdentifier depth, int mipLevel, CubemapFace cubemapFace, int depthSlice)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		if (depthSlice < -1)
		{
			throw new ArgumentException($"Invalid value for depthSlice ({depthSlice})");
		}
		if (mipLevel < 0)
		{
			throw new ArgumentException($"Invalid value for mipLevel ({mipLevel})");
		}
		SetRenderTargetColorDepth_Internal(new RenderTargetIdentifier(color, mipLevel, cubemapFace, depthSlice), depth, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, RenderTargetFlags.None);
	}

	public void SetRenderTarget(RenderTargetIdentifier color, RenderBufferLoadAction colorLoadAction, RenderBufferStoreAction colorStoreAction, RenderTargetIdentifier depth, RenderBufferLoadAction depthLoadAction, RenderBufferStoreAction depthStoreAction)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		if (colorLoadAction == RenderBufferLoadAction.Clear || depthLoadAction == RenderBufferLoadAction.Clear)
		{
			throw new ArgumentException("RenderBufferLoadAction.Clear is not supported");
		}
		SetRenderTargetColorDepth_Internal(color, depth, colorLoadAction, colorStoreAction, depthLoadAction, depthStoreAction, RenderTargetFlags.None);
	}

	public void SetRenderTarget(RenderTargetIdentifier[] colors, RenderTargetIdentifier depth)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		if (colors.Length < 1)
		{
			throw new ArgumentException($"colors.Length must be at least 1, but was {colors.Length}");
		}
		if (colors.Length > SystemInfo.supportedRenderTargetCount)
		{
			throw new ArgumentException($"colors.Length is {colors.Length} and exceeds the maximum number of supported render targets ({SystemInfo.supportedRenderTargetCount})");
		}
		SetRenderTargetMulti_Internal(colors, depth, null, null, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, RenderTargetFlags.None);
	}

	public void SetRenderTarget(RenderTargetIdentifier[] colors, RenderTargetIdentifier depth, int mipLevel, CubemapFace cubemapFace, int depthSlice)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		if (colors.Length < 1)
		{
			throw new ArgumentException($"colors.Length must be at least 1, but was {colors.Length}");
		}
		if (colors.Length > SystemInfo.supportedRenderTargetCount)
		{
			throw new ArgumentException($"colors.Length is {colors.Length} and exceeds the maximum number of supported render targets ({SystemInfo.supportedRenderTargetCount})");
		}
		SetRenderTargetMultiSubtarget(colors, depth, null, null, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, mipLevel, cubemapFace, depthSlice);
	}

	public void SetRenderTarget(RenderTargetBinding binding, int mipLevel, CubemapFace cubemapFace, int depthSlice)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		if (binding.colorRenderTargets.Length < 1)
		{
			throw new ArgumentException($"The number of color render targets must be at least 1, but was {binding.colorRenderTargets.Length}");
		}
		if (binding.colorRenderTargets.Length > SystemInfo.supportedRenderTargetCount)
		{
			throw new ArgumentException($"The number of color render targets ({binding.colorRenderTargets.Length}) and exceeds the maximum supported number of render targets ({SystemInfo.supportedRenderTargetCount})");
		}
		if (binding.colorLoadActions.Length != binding.colorRenderTargets.Length)
		{
			throw new ArgumentException($"The number of color load actions provided ({binding.colorLoadActions.Length}) does not match the number of color render targets ({binding.colorRenderTargets.Length})");
		}
		if (binding.colorStoreActions.Length != binding.colorRenderTargets.Length)
		{
			throw new ArgumentException($"The number of color store actions provided ({binding.colorLoadActions.Length}) does not match the number of color render targets ({binding.colorRenderTargets.Length})");
		}
		if (binding.depthLoadAction == RenderBufferLoadAction.Clear || Array.IndexOf(binding.colorLoadActions, RenderBufferLoadAction.Clear) > -1)
		{
			throw new ArgumentException("RenderBufferLoadAction.Clear is not supported");
		}
		if (binding.colorRenderTargets.Length == 1)
		{
			SetRenderTargetColorDepthSubtarget(binding.colorRenderTargets[0], binding.depthRenderTarget, binding.colorLoadActions[0], binding.colorStoreActions[0], binding.depthLoadAction, binding.depthStoreAction, mipLevel, cubemapFace, depthSlice);
		}
		else
		{
			SetRenderTargetMultiSubtarget(binding.colorRenderTargets, binding.depthRenderTarget, binding.colorLoadActions, binding.colorStoreActions, binding.depthLoadAction, binding.depthStoreAction, mipLevel, cubemapFace, depthSlice);
		}
	}

	public void SetRenderTarget(RenderTargetBinding binding)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		if (binding.colorRenderTargets.Length < 1)
		{
			throw new ArgumentException($"The number of color render targets must be at least 1, but was {binding.colorRenderTargets.Length}");
		}
		if (binding.colorRenderTargets.Length > SystemInfo.supportedRenderTargetCount)
		{
			throw new ArgumentException($"The number of color render targets ({binding.colorRenderTargets.Length}) and exceeds the maximum supported number of render targets ({SystemInfo.supportedRenderTargetCount})");
		}
		if (binding.colorLoadActions.Length != binding.colorRenderTargets.Length)
		{
			throw new ArgumentException($"The number of color load actions provided ({binding.colorLoadActions.Length}) does not match the number of color render targets ({binding.colorRenderTargets.Length})");
		}
		if (binding.colorStoreActions.Length != binding.colorRenderTargets.Length)
		{
			throw new ArgumentException($"The number of color store actions provided ({binding.colorLoadActions.Length}) does not match the number of color render targets ({binding.colorRenderTargets.Length})");
		}
		if (binding.depthLoadAction == RenderBufferLoadAction.Clear || Array.IndexOf(binding.colorLoadActions, RenderBufferLoadAction.Clear) > -1)
		{
			throw new ArgumentException("RenderBufferLoadAction.Clear is not supported");
		}
		if (binding.colorRenderTargets.Length == 1)
		{
			SetRenderTargetColorDepth_Internal(binding.colorRenderTargets[0], binding.depthRenderTarget, binding.colorLoadActions[0], binding.colorStoreActions[0], binding.depthLoadAction, binding.depthStoreAction, binding.flags);
		}
		else
		{
			SetRenderTargetMulti_Internal(binding.colorRenderTargets, binding.depthRenderTarget, binding.colorLoadActions, binding.colorStoreActions, binding.depthLoadAction, binding.depthStoreAction, binding.flags);
		}
	}

	private void SetRenderTargetSingle_Internal(RenderTargetIdentifier rt, RenderBufferLoadAction colorLoadAction, RenderBufferStoreAction colorStoreAction, RenderBufferLoadAction depthLoadAction, RenderBufferStoreAction depthStoreAction)
	{
		SetRenderTargetSingle_Internal_Injected(ref rt, colorLoadAction, colorStoreAction, depthLoadAction, depthStoreAction);
	}

	private void SetRenderTargetColorDepth_Internal(RenderTargetIdentifier color, RenderTargetIdentifier depth, RenderBufferLoadAction colorLoadAction, RenderBufferStoreAction colorStoreAction, RenderBufferLoadAction depthLoadAction, RenderBufferStoreAction depthStoreAction, RenderTargetFlags flags)
	{
		SetRenderTargetColorDepth_Internal_Injected(ref color, ref depth, colorLoadAction, colorStoreAction, depthLoadAction, depthStoreAction, flags);
	}

	private void SetRenderTargetMulti_Internal(RenderTargetIdentifier[] colors, RenderTargetIdentifier depth, RenderBufferLoadAction[] colorLoadActions, RenderBufferStoreAction[] colorStoreActions, RenderBufferLoadAction depthLoadAction, RenderBufferStoreAction depthStoreAction, RenderTargetFlags flags)
	{
		SetRenderTargetMulti_Internal_Injected(colors, ref depth, colorLoadActions, colorStoreActions, depthLoadAction, depthStoreAction, flags);
	}

	private void SetRenderTargetColorDepthSubtarget(RenderTargetIdentifier color, RenderTargetIdentifier depth, RenderBufferLoadAction colorLoadAction, RenderBufferStoreAction colorStoreAction, RenderBufferLoadAction depthLoadAction, RenderBufferStoreAction depthStoreAction, int mipLevel, CubemapFace cubemapFace, int depthSlice)
	{
		SetRenderTargetColorDepthSubtarget_Injected(ref color, ref depth, colorLoadAction, colorStoreAction, depthLoadAction, depthStoreAction, mipLevel, cubemapFace, depthSlice);
	}

	private void SetRenderTargetMultiSubtarget(RenderTargetIdentifier[] colors, RenderTargetIdentifier depth, RenderBufferLoadAction[] colorLoadActions, RenderBufferStoreAction[] colorStoreActions, RenderBufferLoadAction depthLoadAction, RenderBufferStoreAction depthStoreAction, int mipLevel, CubemapFace cubemapFace, int depthSlice)
	{
		SetRenderTargetMultiSubtarget_Injected(colors, ref depth, colorLoadActions, colorStoreActions, depthLoadAction, depthStoreAction, mipLevel, cubemapFace, depthSlice);
	}

	[NativeMethod("ProcessVTFeedback")]
	private void Internal_ProcessVTFeedback(RenderTargetIdentifier rt, IntPtr resolver, int slice, int x, int width, int y, int height, int mip)
	{
		Internal_ProcessVTFeedback_Injected(ref rt, resolver, slice, x, width, y, height, mip);
	}

	public void SetBufferData(ComputeBuffer buffer, Array data)
	{
		if (data == null)
		{
			throw new ArgumentNullException("data");
		}
		if (!UnsafeUtility.IsArrayBlittable(data))
		{
			throw new ArgumentException($"Array passed to RenderingCommandBuffer.SetBufferData(array) must be blittable.\n{UnsafeUtility.GetReasonForArrayNonBlittable(data)}");
		}
		InternalSetComputeBufferData(buffer, data, 0, 0, data.Length, UnsafeUtility.SizeOf(data.GetType().GetElementType()));
	}

	public void SetBufferData<T>(ComputeBuffer buffer, List<T> data) where T : struct
	{
		if (data == null)
		{
			throw new ArgumentNullException("data");
		}
		if (!UnsafeUtility.IsGenericListBlittable<T>())
		{
			throw new ArgumentException($"List<{typeof(T)}> passed to RenderingCommandBuffer.SetBufferData(List<>) must be blittable.\n{UnsafeUtility.GetReasonForGenericListNonBlittable<T>()}");
		}
		InternalSetComputeBufferData(buffer, NoAllocHelpers.ExtractArrayFromList(data), 0, 0, NoAllocHelpers.SafeLength(data), Marshal.SizeOf(typeof(T)));
	}

	public unsafe void SetBufferData<T>(ComputeBuffer buffer, NativeArray<T> data) where T : struct
	{
		InternalSetComputeBufferNativeData(buffer, (IntPtr)data.GetUnsafeReadOnlyPtr(), 0, 0, data.Length, UnsafeUtility.SizeOf<T>());
	}

	public void SetBufferData(ComputeBuffer buffer, Array data, int managedBufferStartIndex, int graphicsBufferStartIndex, int count)
	{
		if (data == null)
		{
			throw new ArgumentNullException("data");
		}
		if (!UnsafeUtility.IsArrayBlittable(data))
		{
			throw new ArgumentException($"Array passed to RenderingCommandBuffer.SetBufferData(array) must be blittable.\n{UnsafeUtility.GetReasonForArrayNonBlittable(data)}");
		}
		if (managedBufferStartIndex < 0 || graphicsBufferStartIndex < 0 || count < 0 || managedBufferStartIndex + count > data.Length)
		{
			throw new ArgumentOutOfRangeException($"Bad indices/count arguments (managedBufferStartIndex:{managedBufferStartIndex} graphicsBufferStartIndex:{graphicsBufferStartIndex} count:{count})");
		}
		InternalSetComputeBufferData(buffer, data, managedBufferStartIndex, graphicsBufferStartIndex, count, Marshal.SizeOf(data.GetType().GetElementType()));
	}

	public void SetBufferData<T>(ComputeBuffer buffer, List<T> data, int managedBufferStartIndex, int graphicsBufferStartIndex, int count) where T : struct
	{
		if (data == null)
		{
			throw new ArgumentNullException("data");
		}
		if (!UnsafeUtility.IsGenericListBlittable<T>())
		{
			throw new ArgumentException($"List<{typeof(T)}> passed to RenderingCommandBuffer.SetBufferData(List<>) must be blittable.\n{UnsafeUtility.GetReasonForGenericListNonBlittable<T>()}");
		}
		if (managedBufferStartIndex < 0 || graphicsBufferStartIndex < 0 || count < 0 || managedBufferStartIndex + count > data.Count)
		{
			throw new ArgumentOutOfRangeException($"Bad indices/count arguments (managedBufferStartIndex:{managedBufferStartIndex} graphicsBufferStartIndex:{graphicsBufferStartIndex} count:{count})");
		}
		InternalSetComputeBufferData(buffer, NoAllocHelpers.ExtractArrayFromList(data), managedBufferStartIndex, graphicsBufferStartIndex, count, Marshal.SizeOf(typeof(T)));
	}

	public unsafe void SetBufferData<T>(ComputeBuffer buffer, NativeArray<T> data, int nativeBufferStartIndex, int graphicsBufferStartIndex, int count) where T : struct
	{
		if (nativeBufferStartIndex < 0 || graphicsBufferStartIndex < 0 || count < 0 || nativeBufferStartIndex + count > data.Length)
		{
			throw new ArgumentOutOfRangeException($"Bad indices/count arguments (nativeBufferStartIndex:{nativeBufferStartIndex} graphicsBufferStartIndex:{graphicsBufferStartIndex} count:{count})");
		}
		InternalSetComputeBufferNativeData(buffer, (IntPtr)data.GetUnsafeReadOnlyPtr(), nativeBufferStartIndex, graphicsBufferStartIndex, count, UnsafeUtility.SizeOf<T>());
	}

	public void SetBufferCounterValue(ComputeBuffer buffer, uint counterValue)
	{
		InternalSetComputeBufferCounterValue(buffer, counterValue);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "RenderingCommandBuffer_Bindings::InternalSetGraphicsBufferNativeData", HasExplicitThis = true, ThrowsException = true)]
	private extern void InternalSetComputeBufferNativeData([NotNull("ArgumentNullException")] ComputeBuffer buffer, IntPtr data, int nativeBufferStartIndex, int graphicsBufferStartIndex, int count, int elemSize);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "RenderingCommandBuffer_Bindings::InternalSetGraphicsBufferData", HasExplicitThis = true, ThrowsException = true)]
	private extern void InternalSetComputeBufferData([NotNull("ArgumentNullException")] ComputeBuffer buffer, Array data, int managedBufferStartIndex, int graphicsBufferStartIndex, int count, int elemSize);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "RenderingCommandBuffer_Bindings::InternalSetGraphicsBufferCounterValue", HasExplicitThis = true)]
	private extern void InternalSetComputeBufferCounterValue([NotNull("ArgumentNullException")] ComputeBuffer buffer, uint counterValue);

	public void SetBufferData(GraphicsBuffer buffer, Array data)
	{
		if (data == null)
		{
			throw new ArgumentNullException("data");
		}
		if (!UnsafeUtility.IsArrayBlittable(data))
		{
			throw new ArgumentException($"Array passed to RenderingCommandBuffer.SetBufferData(array) must be blittable.\n{UnsafeUtility.GetReasonForArrayNonBlittable(data)}");
		}
		InternalSetGraphicsBufferData(buffer, data, 0, 0, data.Length, UnsafeUtility.SizeOf(data.GetType().GetElementType()));
	}

	public void SetBufferData<T>(GraphicsBuffer buffer, List<T> data) where T : struct
	{
		if (data == null)
		{
			throw new ArgumentNullException("data");
		}
		if (!UnsafeUtility.IsGenericListBlittable<T>())
		{
			throw new ArgumentException($"List<{typeof(T)}> passed to RenderingCommandBuffer.SetBufferData(List<>) must be blittable.\n{UnsafeUtility.GetReasonForGenericListNonBlittable<T>()}");
		}
		InternalSetGraphicsBufferData(buffer, NoAllocHelpers.ExtractArrayFromList(data), 0, 0, NoAllocHelpers.SafeLength(data), Marshal.SizeOf(typeof(T)));
	}

	public unsafe void SetBufferData<T>(GraphicsBuffer buffer, NativeArray<T> data) where T : struct
	{
		InternalSetGraphicsBufferNativeData(buffer, (IntPtr)data.GetUnsafeReadOnlyPtr(), 0, 0, data.Length, UnsafeUtility.SizeOf<T>());
	}

	public void SetBufferData(GraphicsBuffer buffer, Array data, int managedBufferStartIndex, int graphicsBufferStartIndex, int count)
	{
		if (data == null)
		{
			throw new ArgumentNullException("data");
		}
		if (!UnsafeUtility.IsArrayBlittable(data))
		{
			throw new ArgumentException($"Array passed to RenderingCommandBuffer.SetBufferData(array) must be blittable.\n{UnsafeUtility.GetReasonForArrayNonBlittable(data)}");
		}
		if (managedBufferStartIndex < 0 || graphicsBufferStartIndex < 0 || count < 0 || managedBufferStartIndex + count > data.Length)
		{
			throw new ArgumentOutOfRangeException($"Bad indices/count arguments (managedBufferStartIndex:{managedBufferStartIndex} graphicsBufferStartIndex:{graphicsBufferStartIndex} count:{count})");
		}
		InternalSetGraphicsBufferData(buffer, data, managedBufferStartIndex, graphicsBufferStartIndex, count, Marshal.SizeOf(data.GetType().GetElementType()));
	}

	public void SetBufferData<T>(GraphicsBuffer buffer, List<T> data, int managedBufferStartIndex, int graphicsBufferStartIndex, int count) where T : struct
	{
		if (data == null)
		{
			throw new ArgumentNullException("data");
		}
		if (!UnsafeUtility.IsGenericListBlittable<T>())
		{
			throw new ArgumentException($"List<{typeof(T)}> passed to RenderingCommandBuffer.SetBufferData(List<>) must be blittable.\n{UnsafeUtility.GetReasonForGenericListNonBlittable<T>()}");
		}
		if (managedBufferStartIndex < 0 || graphicsBufferStartIndex < 0 || count < 0 || managedBufferStartIndex + count > data.Count)
		{
			throw new ArgumentOutOfRangeException($"Bad indices/count arguments (managedBufferStartIndex:{managedBufferStartIndex} graphicsBufferStartIndex:{graphicsBufferStartIndex} count:{count})");
		}
		InternalSetGraphicsBufferData(buffer, NoAllocHelpers.ExtractArrayFromList(data), managedBufferStartIndex, graphicsBufferStartIndex, count, Marshal.SizeOf(typeof(T)));
	}

	public unsafe void SetBufferData<T>(GraphicsBuffer buffer, NativeArray<T> data, int nativeBufferStartIndex, int graphicsBufferStartIndex, int count) where T : struct
	{
		if (nativeBufferStartIndex < 0 || graphicsBufferStartIndex < 0 || count < 0 || nativeBufferStartIndex + count > data.Length)
		{
			throw new ArgumentOutOfRangeException($"Bad indices/count arguments (nativeBufferStartIndex:{nativeBufferStartIndex} graphicsBufferStartIndex:{graphicsBufferStartIndex} count:{count})");
		}
		InternalSetGraphicsBufferNativeData(buffer, (IntPtr)data.GetUnsafeReadOnlyPtr(), nativeBufferStartIndex, graphicsBufferStartIndex, count, UnsafeUtility.SizeOf<T>());
	}

	public void SetBufferCounterValue(GraphicsBuffer buffer, uint counterValue)
	{
		InternalSetGraphicsBufferCounterValue(buffer, counterValue);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "RenderingCommandBuffer_Bindings::InternalSetGraphicsBufferNativeData", HasExplicitThis = true, ThrowsException = true)]
	private extern void InternalSetGraphicsBufferNativeData([NotNull("ArgumentNullException")] GraphicsBuffer buffer, IntPtr data, int nativeBufferStartIndex, int graphicsBufferStartIndex, int count, int elemSize);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "RenderingCommandBuffer_Bindings::InternalSetGraphicsBufferData", HasExplicitThis = true, ThrowsException = true)]
	private extern void InternalSetGraphicsBufferData([NotNull("ArgumentNullException")] GraphicsBuffer buffer, Array data, int managedBufferStartIndex, int graphicsBufferStartIndex, int count, int elemSize);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "RenderingCommandBuffer_Bindings::InternalSetGraphicsBufferCounterValue", HasExplicitThis = true)]
	private extern void InternalSetGraphicsBufferCounterValue([NotNull("ArgumentNullException")] GraphicsBuffer buffer, uint counterValue);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "RenderingCommandBuffer_Bindings::CopyBuffer", HasExplicitThis = true, ThrowsException = true)]
	private extern void CopyBufferImpl([NotNull("ArgumentNullException")] GraphicsBuffer source, [NotNull("ArgumentNullException")] GraphicsBuffer dest);

	~CommandBuffer()
	{
		Dispose(disposing: false);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	private void Dispose(bool disposing)
	{
		ReleaseBuffer();
		m_Ptr = IntPtr.Zero;
	}

	public CommandBuffer()
	{
		m_Ptr = InitBuffer();
	}

	public void Release()
	{
		Dispose();
	}

	public GraphicsFence CreateAsyncGraphicsFence()
	{
		return CreateGraphicsFence(GraphicsFenceType.AsyncQueueSynchronisation, SynchronisationStageFlags.PixelProcessing);
	}

	public GraphicsFence CreateAsyncGraphicsFence(SynchronisationStage stage)
	{
		return CreateGraphicsFence(GraphicsFenceType.AsyncQueueSynchronisation, GraphicsFence.TranslateSynchronizationStageToFlags(stage));
	}

	public GraphicsFence CreateGraphicsFence(GraphicsFenceType fenceType, SynchronisationStageFlags stage)
	{
		GraphicsFence result = default(GraphicsFence);
		result.m_FenceType = fenceType;
		result.m_Ptr = CreateGPUFence_Internal(fenceType, stage);
		result.InitPostAllocation();
		result.Validate();
		return result;
	}

	public void WaitOnAsyncGraphicsFence(GraphicsFence fence)
	{
		WaitOnAsyncGraphicsFence(fence, SynchronisationStage.VertexProcessing);
	}

	public void WaitOnAsyncGraphicsFence(GraphicsFence fence, SynchronisationStage stage)
	{
		WaitOnAsyncGraphicsFence(fence, GraphicsFence.TranslateSynchronizationStageToFlags(stage));
	}

	public void WaitOnAsyncGraphicsFence(GraphicsFence fence, SynchronisationStageFlags stage)
	{
		if (fence.m_FenceType != GraphicsFenceType.AsyncQueueSynchronisation)
		{
			throw new ArgumentException("Attempting to call WaitOnAsyncGPUFence on a fence that is not of GraphicsFenceType.AsyncQueueSynchronization");
		}
		fence.Validate();
		if (fence.IsFencePending())
		{
			WaitOnGPUFence_Internal(fence.m_Ptr, stage);
		}
	}

	public void SetComputeFloatParam(ComputeShader computeShader, string name, float val)
	{
		SetComputeFloatParam(computeShader, Shader.PropertyToID(name), val);
	}

	public void SetComputeIntParam(ComputeShader computeShader, string name, int val)
	{
		SetComputeIntParam(computeShader, Shader.PropertyToID(name), val);
	}

	public void SetComputeVectorParam(ComputeShader computeShader, string name, Vector4 val)
	{
		SetComputeVectorParam(computeShader, Shader.PropertyToID(name), val);
	}

	public void SetComputeVectorArrayParam(ComputeShader computeShader, string name, Vector4[] values)
	{
		SetComputeVectorArrayParam(computeShader, Shader.PropertyToID(name), values);
	}

	public void SetComputeMatrixParam(ComputeShader computeShader, string name, Matrix4x4 val)
	{
		SetComputeMatrixParam(computeShader, Shader.PropertyToID(name), val);
	}

	public void SetComputeMatrixArrayParam(ComputeShader computeShader, string name, Matrix4x4[] values)
	{
		SetComputeMatrixArrayParam(computeShader, Shader.PropertyToID(name), values);
	}

	public void SetComputeFloatParams(ComputeShader computeShader, string name, params float[] values)
	{
		Internal_SetComputeFloats(computeShader, Shader.PropertyToID(name), values);
	}

	public void SetComputeFloatParams(ComputeShader computeShader, int nameID, params float[] values)
	{
		Internal_SetComputeFloats(computeShader, nameID, values);
	}

	public void SetComputeIntParams(ComputeShader computeShader, string name, params int[] values)
	{
		Internal_SetComputeInts(computeShader, Shader.PropertyToID(name), values);
	}

	public void SetComputeIntParams(ComputeShader computeShader, int nameID, params int[] values)
	{
		Internal_SetComputeInts(computeShader, nameID, values);
	}

	public void SetComputeTextureParam(ComputeShader computeShader, int kernelIndex, string name, RenderTargetIdentifier rt)
	{
		Internal_SetComputeTextureParam(computeShader, kernelIndex, Shader.PropertyToID(name), ref rt, 0, RenderTextureSubElement.Default);
	}

	public void SetComputeTextureParam(ComputeShader computeShader, int kernelIndex, int nameID, RenderTargetIdentifier rt)
	{
		Internal_SetComputeTextureParam(computeShader, kernelIndex, nameID, ref rt, 0, RenderTextureSubElement.Default);
	}

	public void SetComputeTextureParam(ComputeShader computeShader, int kernelIndex, string name, RenderTargetIdentifier rt, int mipLevel)
	{
		Internal_SetComputeTextureParam(computeShader, kernelIndex, Shader.PropertyToID(name), ref rt, mipLevel, RenderTextureSubElement.Default);
	}

	public void SetComputeTextureParam(ComputeShader computeShader, int kernelIndex, int nameID, RenderTargetIdentifier rt, int mipLevel)
	{
		Internal_SetComputeTextureParam(computeShader, kernelIndex, nameID, ref rt, mipLevel, RenderTextureSubElement.Default);
	}

	public void SetComputeTextureParam(ComputeShader computeShader, int kernelIndex, string name, RenderTargetIdentifier rt, int mipLevel, RenderTextureSubElement element)
	{
		Internal_SetComputeTextureParam(computeShader, kernelIndex, Shader.PropertyToID(name), ref rt, mipLevel, element);
	}

	public void SetComputeTextureParam(ComputeShader computeShader, int kernelIndex, int nameID, RenderTargetIdentifier rt, int mipLevel, RenderTextureSubElement element)
	{
		Internal_SetComputeTextureParam(computeShader, kernelIndex, nameID, ref rt, mipLevel, element);
	}

	public void SetComputeBufferParam(ComputeShader computeShader, int kernelIndex, int nameID, ComputeBuffer buffer)
	{
		Internal_SetComputeBufferParam(computeShader, kernelIndex, nameID, buffer);
	}

	public void SetComputeBufferParam(ComputeShader computeShader, int kernelIndex, string name, ComputeBuffer buffer)
	{
		Internal_SetComputeBufferParam(computeShader, kernelIndex, Shader.PropertyToID(name), buffer);
	}

	public void SetComputeBufferParam(ComputeShader computeShader, int kernelIndex, int nameID, GraphicsBufferHandle bufferHandle)
	{
		Internal_SetComputeGraphicsBufferHandleParam(computeShader, kernelIndex, nameID, bufferHandle);
	}

	public void SetComputeBufferParam(ComputeShader computeShader, int kernelIndex, string name, GraphicsBufferHandle bufferHandle)
	{
		Internal_SetComputeGraphicsBufferHandleParam(computeShader, kernelIndex, Shader.PropertyToID(name), bufferHandle);
	}

	public void SetComputeBufferParam(ComputeShader computeShader, int kernelIndex, int nameID, GraphicsBuffer buffer)
	{
		Internal_SetComputeGraphicsBufferParam(computeShader, kernelIndex, nameID, buffer);
	}

	public void SetComputeBufferParam(ComputeShader computeShader, int kernelIndex, string name, GraphicsBuffer buffer)
	{
		Internal_SetComputeGraphicsBufferParam(computeShader, kernelIndex, Shader.PropertyToID(name), buffer);
	}

	public void SetComputeConstantBufferParam(ComputeShader computeShader, int nameID, ComputeBuffer buffer, int offset, int size)
	{
		Internal_SetComputeConstantComputeBufferParam(computeShader, nameID, buffer, offset, size);
	}

	public void SetComputeConstantBufferParam(ComputeShader computeShader, string name, ComputeBuffer buffer, int offset, int size)
	{
		Internal_SetComputeConstantComputeBufferParam(computeShader, Shader.PropertyToID(name), buffer, offset, size);
	}

	public void SetComputeConstantBufferParam(ComputeShader computeShader, int nameID, GraphicsBuffer buffer, int offset, int size)
	{
		Internal_SetComputeConstantGraphicsBufferParam(computeShader, nameID, buffer, offset, size);
	}

	public void SetComputeConstantBufferParam(ComputeShader computeShader, string name, GraphicsBuffer buffer, int offset, int size)
	{
		Internal_SetComputeConstantGraphicsBufferParam(computeShader, Shader.PropertyToID(name), buffer, offset, size);
	}

	public void SetComputeParamsFromMaterial(ComputeShader computeShader, int kernelIndex, Material material)
	{
		Internal_SetComputeParamsFromMaterial(computeShader, kernelIndex, material);
	}

	public void DispatchCompute(ComputeShader computeShader, int kernelIndex, int threadGroupsX, int threadGroupsY, int threadGroupsZ)
	{
		Internal_DispatchCompute(computeShader, kernelIndex, threadGroupsX, threadGroupsY, threadGroupsZ);
	}

	public void DispatchCompute(ComputeShader computeShader, int kernelIndex, ComputeBuffer indirectBuffer, uint argsOffset)
	{
		if (SystemInfo.graphicsDeviceType == GraphicsDeviceType.Metal && !SystemInfo.supportsIndirectArgumentsBuffer)
		{
			throw new InvalidOperationException("Indirect argument buffers are not supported.");
		}
		Internal_DispatchComputeIndirect(computeShader, kernelIndex, indirectBuffer, argsOffset);
	}

	public void DispatchCompute(ComputeShader computeShader, int kernelIndex, GraphicsBuffer indirectBuffer, uint argsOffset)
	{
		if (SystemInfo.graphicsDeviceType == GraphicsDeviceType.Metal && !SystemInfo.supportsIndirectArgumentsBuffer)
		{
			throw new InvalidOperationException("Indirect argument buffers are not supported.");
		}
		Internal_DispatchComputeIndirectGraphicsBuffer(computeShader, kernelIndex, indirectBuffer, argsOffset);
	}

	public void BuildRayTracingAccelerationStructure(RayTracingAccelerationStructure accelerationStructure)
	{
		Vector3 relativeOrigin = new Vector3(0f, 0f, 0f);
		Internal_BuildRayTracingAccelerationStructure(accelerationStructure, relativeOrigin);
	}

	public void BuildRayTracingAccelerationStructure(RayTracingAccelerationStructure accelerationStructure, Vector3 relativeOrigin)
	{
		Internal_BuildRayTracingAccelerationStructure(accelerationStructure, relativeOrigin);
	}

	public void SetRayTracingAccelerationStructure(RayTracingShader rayTracingShader, string name, RayTracingAccelerationStructure rayTracingAccelerationStructure)
	{
		Internal_SetRayTracingAccelerationStructure(rayTracingShader, Shader.PropertyToID(name), rayTracingAccelerationStructure);
	}

	public void SetRayTracingAccelerationStructure(RayTracingShader rayTracingShader, int nameID, RayTracingAccelerationStructure rayTracingAccelerationStructure)
	{
		Internal_SetRayTracingAccelerationStructure(rayTracingShader, nameID, rayTracingAccelerationStructure);
	}

	public void SetRayTracingBufferParam(RayTracingShader rayTracingShader, string name, ComputeBuffer buffer)
	{
		Internal_SetRayTracingBufferParam(rayTracingShader, Shader.PropertyToID(name), buffer);
	}

	public void SetRayTracingBufferParam(RayTracingShader rayTracingShader, int nameID, ComputeBuffer buffer)
	{
		Internal_SetRayTracingBufferParam(rayTracingShader, nameID, buffer);
	}

	public void SetRayTracingConstantBufferParam(RayTracingShader rayTracingShader, int nameID, ComputeBuffer buffer, int offset, int size)
	{
		Internal_SetRayTracingConstantComputeBufferParam(rayTracingShader, nameID, buffer, offset, size);
	}

	public void SetRayTracingConstantBufferParam(RayTracingShader rayTracingShader, string name, ComputeBuffer buffer, int offset, int size)
	{
		Internal_SetRayTracingConstantComputeBufferParam(rayTracingShader, Shader.PropertyToID(name), buffer, offset, size);
	}

	public void SetRayTracingConstantBufferParam(RayTracingShader rayTracingShader, int nameID, GraphicsBuffer buffer, int offset, int size)
	{
		Internal_SetRayTracingConstantGraphicsBufferParam(rayTracingShader, nameID, buffer, offset, size);
	}

	public void SetRayTracingConstantBufferParam(RayTracingShader rayTracingShader, string name, GraphicsBuffer buffer, int offset, int size)
	{
		Internal_SetRayTracingConstantGraphicsBufferParam(rayTracingShader, Shader.PropertyToID(name), buffer, offset, size);
	}

	public void SetRayTracingTextureParam(RayTracingShader rayTracingShader, string name, RenderTargetIdentifier rt)
	{
		Internal_SetRayTracingTextureParam(rayTracingShader, Shader.PropertyToID(name), ref rt);
	}

	public void SetRayTracingTextureParam(RayTracingShader rayTracingShader, int nameID, RenderTargetIdentifier rt)
	{
		Internal_SetRayTracingTextureParam(rayTracingShader, nameID, ref rt);
	}

	public void SetRayTracingFloatParam(RayTracingShader rayTracingShader, string name, float val)
	{
		Internal_SetRayTracingFloatParam(rayTracingShader, Shader.PropertyToID(name), val);
	}

	public void SetRayTracingFloatParam(RayTracingShader rayTracingShader, int nameID, float val)
	{
		Internal_SetRayTracingFloatParam(rayTracingShader, nameID, val);
	}

	public void SetRayTracingFloatParams(RayTracingShader rayTracingShader, string name, params float[] values)
	{
		Internal_SetRayTracingFloats(rayTracingShader, Shader.PropertyToID(name), values);
	}

	public void SetRayTracingFloatParams(RayTracingShader rayTracingShader, int nameID, params float[] values)
	{
		Internal_SetRayTracingFloats(rayTracingShader, nameID, values);
	}

	public void SetRayTracingIntParam(RayTracingShader rayTracingShader, string name, int val)
	{
		Internal_SetRayTracingIntParam(rayTracingShader, Shader.PropertyToID(name), val);
	}

	public void SetRayTracingIntParam(RayTracingShader rayTracingShader, int nameID, int val)
	{
		Internal_SetRayTracingIntParam(rayTracingShader, nameID, val);
	}

	public void SetRayTracingIntParams(RayTracingShader rayTracingShader, string name, params int[] values)
	{
		Internal_SetRayTracingInts(rayTracingShader, Shader.PropertyToID(name), values);
	}

	public void SetRayTracingIntParams(RayTracingShader rayTracingShader, int nameID, params int[] values)
	{
		Internal_SetRayTracingInts(rayTracingShader, nameID, values);
	}

	public void SetRayTracingVectorParam(RayTracingShader rayTracingShader, string name, Vector4 val)
	{
		Internal_SetRayTracingVectorParam(rayTracingShader, Shader.PropertyToID(name), val);
	}

	public void SetRayTracingVectorParam(RayTracingShader rayTracingShader, int nameID, Vector4 val)
	{
		Internal_SetRayTracingVectorParam(rayTracingShader, nameID, val);
	}

	public void SetRayTracingVectorArrayParam(RayTracingShader rayTracingShader, string name, params Vector4[] values)
	{
		Internal_SetRayTracingVectorArrayParam(rayTracingShader, Shader.PropertyToID(name), values);
	}

	public void SetRayTracingVectorArrayParam(RayTracingShader rayTracingShader, int nameID, params Vector4[] values)
	{
		Internal_SetRayTracingVectorArrayParam(rayTracingShader, nameID, values);
	}

	public void SetRayTracingMatrixParam(RayTracingShader rayTracingShader, string name, Matrix4x4 val)
	{
		Internal_SetRayTracingMatrixParam(rayTracingShader, Shader.PropertyToID(name), val);
	}

	public void SetRayTracingMatrixParam(RayTracingShader rayTracingShader, int nameID, Matrix4x4 val)
	{
		Internal_SetRayTracingMatrixParam(rayTracingShader, nameID, val);
	}

	public void SetRayTracingMatrixArrayParam(RayTracingShader rayTracingShader, string name, params Matrix4x4[] values)
	{
		Internal_SetRayTracingMatrixArrayParam(rayTracingShader, Shader.PropertyToID(name), values);
	}

	public void SetRayTracingMatrixArrayParam(RayTracingShader rayTracingShader, int nameID, params Matrix4x4[] values)
	{
		Internal_SetRayTracingMatrixArrayParam(rayTracingShader, nameID, values);
	}

	public void DispatchRays(RayTracingShader rayTracingShader, string rayGenName, uint width, uint height, uint depth, Camera camera = null)
	{
		Internal_DispatchRays(rayTracingShader, rayGenName, width, height, depth, camera);
	}

	public void GenerateMips(RenderTargetIdentifier rt)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Internal_GenerateMips(rt);
	}

	public void GenerateMips(RenderTexture rt)
	{
		if (rt == null)
		{
			throw new ArgumentNullException("rt");
		}
		GenerateMips(new RenderTargetIdentifier(rt));
	}

	public void ResolveAntiAliasedSurface(RenderTexture rt, RenderTexture target = null)
	{
		if (rt == null)
		{
			throw new ArgumentNullException("rt");
		}
		Internal_ResolveAntiAliasedSurface(rt, target);
	}

	public void DrawMesh(Mesh mesh, Matrix4x4 matrix, Material material, [DefaultValue("0")] int submeshIndex, [DefaultValue("-1")] int shaderPass, [DefaultValue("null")] MaterialPropertyBlock properties)
	{
		if (mesh == null)
		{
			throw new ArgumentNullException("mesh");
		}
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		if (submeshIndex < 0 || submeshIndex >= mesh.subMeshCount)
		{
			submeshIndex = Mathf.Clamp(submeshIndex, 0, mesh.subMeshCount - 1);
			Debug.LogWarning($"submeshIndex out of range. Clampped to {submeshIndex}.");
		}
		if (material == null)
		{
			throw new ArgumentNullException("material");
		}
		Internal_DrawMesh(mesh, matrix, material, submeshIndex, shaderPass, properties);
	}

	[ExcludeFromDocs]
	public void DrawMesh(Mesh mesh, Matrix4x4 matrix, Material material, int submeshIndex, int shaderPass)
	{
		DrawMesh(mesh, matrix, material, submeshIndex, shaderPass, null);
	}

	[ExcludeFromDocs]
	public void DrawMesh(Mesh mesh, Matrix4x4 matrix, Material material, int submeshIndex)
	{
		DrawMesh(mesh, matrix, material, submeshIndex, -1);
	}

	[ExcludeFromDocs]
	public void DrawMesh(Mesh mesh, Matrix4x4 matrix, Material material)
	{
		DrawMesh(mesh, matrix, material, 0);
	}

	public void DrawRenderer(Renderer renderer, Material material, [DefaultValue("0")] int submeshIndex, [DefaultValue("-1")] int shaderPass)
	{
		if (renderer == null)
		{
			throw new ArgumentNullException("renderer");
		}
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		if (submeshIndex < 0)
		{
			submeshIndex = Mathf.Max(submeshIndex, 0);
			Debug.LogWarning($"submeshIndex out of range. Clampped to {submeshIndex}.");
		}
		if (material == null)
		{
			throw new ArgumentNullException("material");
		}
		Internal_DrawRenderer(renderer, material, submeshIndex, shaderPass);
	}

	[ExcludeFromDocs]
	public void DrawRenderer(Renderer renderer, Material material, int submeshIndex)
	{
		DrawRenderer(renderer, material, submeshIndex, -1);
	}

	[ExcludeFromDocs]
	public void DrawRenderer(Renderer renderer, Material material)
	{
		DrawRenderer(renderer, material, 0);
	}

	public void DrawRendererList(RendererList rendererList)
	{
		Internal_DrawRendererList(rendererList);
	}

	public void DrawProcedural(Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, int vertexCount, [DefaultValue("1")] int instanceCount, [DefaultValue("null")] MaterialPropertyBlock properties)
	{
		if (material == null)
		{
			throw new ArgumentNullException("material");
		}
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Internal_DrawProcedural(matrix, material, shaderPass, topology, vertexCount, instanceCount, properties);
	}

	[ExcludeFromDocs]
	public void DrawProcedural(Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, int vertexCount, int instanceCount)
	{
		DrawProcedural(matrix, material, shaderPass, topology, vertexCount, instanceCount, null);
	}

	[ExcludeFromDocs]
	public void DrawProcedural(Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, int vertexCount)
	{
		DrawProcedural(matrix, material, shaderPass, topology, vertexCount, 1);
	}

	public void DrawProcedural(GraphicsBuffer indexBuffer, Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, int indexCount, int instanceCount, MaterialPropertyBlock properties)
	{
		if (indexBuffer == null)
		{
			throw new ArgumentNullException("indexBuffer");
		}
		if (material == null)
		{
			throw new ArgumentNullException("material");
		}
		Internal_DrawProceduralIndexed(indexBuffer, matrix, material, shaderPass, topology, indexCount, instanceCount, properties);
	}

	public void DrawProcedural(GraphicsBuffer indexBuffer, Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, int indexCount, int instanceCount)
	{
		DrawProcedural(indexBuffer, matrix, material, shaderPass, topology, indexCount, instanceCount, null);
	}

	public void DrawProcedural(GraphicsBuffer indexBuffer, Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, int indexCount)
	{
		DrawProcedural(indexBuffer, matrix, material, shaderPass, topology, indexCount, 1);
	}

	public void DrawProceduralIndirect(Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, ComputeBuffer bufferWithArgs, int argsOffset, MaterialPropertyBlock properties)
	{
		if (!SystemInfo.supportsIndirectArgumentsBuffer)
		{
			throw new InvalidOperationException("Indirect argument buffers are not supported.");
		}
		if (material == null)
		{
			throw new ArgumentNullException("material");
		}
		if (bufferWithArgs == null)
		{
			throw new ArgumentNullException("bufferWithArgs");
		}
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Internal_DrawProceduralIndirect(matrix, material, shaderPass, topology, bufferWithArgs, argsOffset, properties);
	}

	public void DrawProceduralIndirect(Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, ComputeBuffer bufferWithArgs, int argsOffset)
	{
		DrawProceduralIndirect(matrix, material, shaderPass, topology, bufferWithArgs, argsOffset, null);
	}

	public void DrawProceduralIndirect(Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, ComputeBuffer bufferWithArgs)
	{
		DrawProceduralIndirect(matrix, material, shaderPass, topology, bufferWithArgs, 0);
	}

	public void DrawProceduralIndirect(GraphicsBuffer indexBuffer, Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, ComputeBuffer bufferWithArgs, int argsOffset, MaterialPropertyBlock properties)
	{
		if (!SystemInfo.supportsIndirectArgumentsBuffer)
		{
			throw new InvalidOperationException("Indirect argument buffers are not supported.");
		}
		if (indexBuffer == null)
		{
			throw new ArgumentNullException("indexBuffer");
		}
		if (material == null)
		{
			throw new ArgumentNullException("material");
		}
		if (bufferWithArgs == null)
		{
			throw new ArgumentNullException("bufferWithArgs");
		}
		Internal_DrawProceduralIndexedIndirect(indexBuffer, matrix, material, shaderPass, topology, bufferWithArgs, argsOffset, properties);
	}

	public void DrawProceduralIndirect(GraphicsBuffer indexBuffer, Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, ComputeBuffer bufferWithArgs, int argsOffset)
	{
		DrawProceduralIndirect(indexBuffer, matrix, material, shaderPass, topology, bufferWithArgs, argsOffset, null);
	}

	public void DrawProceduralIndirect(GraphicsBuffer indexBuffer, Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, ComputeBuffer bufferWithArgs)
	{
		DrawProceduralIndirect(indexBuffer, matrix, material, shaderPass, topology, bufferWithArgs, 0);
	}

	public void DrawProceduralIndirect(Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, GraphicsBuffer bufferWithArgs, int argsOffset, MaterialPropertyBlock properties)
	{
		if (!SystemInfo.supportsIndirectArgumentsBuffer)
		{
			throw new InvalidOperationException("Indirect argument buffers are not supported.");
		}
		if (material == null)
		{
			throw new ArgumentNullException("material");
		}
		if (bufferWithArgs == null)
		{
			throw new ArgumentNullException("bufferWithArgs");
		}
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Internal_DrawProceduralIndirectGraphicsBuffer(matrix, material, shaderPass, topology, bufferWithArgs, argsOffset, properties);
	}

	public void DrawProceduralIndirect(Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, GraphicsBuffer bufferWithArgs, int argsOffset)
	{
		DrawProceduralIndirect(matrix, material, shaderPass, topology, bufferWithArgs, argsOffset, null);
	}

	public void DrawProceduralIndirect(Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, GraphicsBuffer bufferWithArgs)
	{
		DrawProceduralIndirect(matrix, material, shaderPass, topology, bufferWithArgs, 0);
	}

	public void DrawProceduralIndirect(GraphicsBuffer indexBuffer, Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, GraphicsBuffer bufferWithArgs, int argsOffset, MaterialPropertyBlock properties)
	{
		if (!SystemInfo.supportsIndirectArgumentsBuffer)
		{
			throw new InvalidOperationException("Indirect argument buffers are not supported.");
		}
		if (indexBuffer == null)
		{
			throw new ArgumentNullException("indexBuffer");
		}
		if (material == null)
		{
			throw new ArgumentNullException("material");
		}
		if (bufferWithArgs == null)
		{
			throw new ArgumentNullException("bufferWithArgs");
		}
		Internal_DrawProceduralIndexedIndirectGraphicsBuffer(indexBuffer, matrix, material, shaderPass, topology, bufferWithArgs, argsOffset, properties);
	}

	public void DrawProceduralIndirect(GraphicsBuffer indexBuffer, Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, GraphicsBuffer bufferWithArgs, int argsOffset)
	{
		DrawProceduralIndirect(indexBuffer, matrix, material, shaderPass, topology, bufferWithArgs, argsOffset, null);
	}

	public void DrawProceduralIndirect(GraphicsBuffer indexBuffer, Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, GraphicsBuffer bufferWithArgs)
	{
		DrawProceduralIndirect(indexBuffer, matrix, material, shaderPass, topology, bufferWithArgs, 0);
	}

	public void DrawMeshInstanced(Mesh mesh, int submeshIndex, Material material, int shaderPass, Matrix4x4[] matrices, int count, MaterialPropertyBlock properties)
	{
		if (!SystemInfo.supportsInstancing)
		{
			throw new InvalidOperationException("DrawMeshInstanced is not supported.");
		}
		if (mesh == null)
		{
			throw new ArgumentNullException("mesh");
		}
		if (submeshIndex < 0 || submeshIndex >= mesh.subMeshCount)
		{
			throw new ArgumentOutOfRangeException("submeshIndex", "submeshIndex out of range.");
		}
		if (material == null)
		{
			throw new ArgumentNullException("material");
		}
		if (matrices == null)
		{
			throw new ArgumentNullException("matrices");
		}
		if (count < 0 || count > Mathf.Min(Graphics.kMaxDrawMeshInstanceCount, matrices.Length))
		{
			throw new ArgumentOutOfRangeException("count", $"Count must be in the range of 0 to {Mathf.Min(Graphics.kMaxDrawMeshInstanceCount, matrices.Length)}.");
		}
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		if (count > 0)
		{
			Internal_DrawMeshInstanced(mesh, submeshIndex, material, shaderPass, matrices, count, properties);
		}
	}

	public void DrawMeshInstanced(Mesh mesh, int submeshIndex, Material material, int shaderPass, Matrix4x4[] matrices, int count)
	{
		DrawMeshInstanced(mesh, submeshIndex, material, shaderPass, matrices, count, null);
	}

	public void DrawMeshInstanced(Mesh mesh, int submeshIndex, Material material, int shaderPass, Matrix4x4[] matrices)
	{
		DrawMeshInstanced(mesh, submeshIndex, material, shaderPass, matrices, matrices.Length);
	}

	public void DrawMeshInstancedProcedural(Mesh mesh, int submeshIndex, Material material, int shaderPass, int count, MaterialPropertyBlock properties = null)
	{
		if (!SystemInfo.supportsInstancing)
		{
			throw new InvalidOperationException("DrawMeshInstancedProcedural is not supported.");
		}
		if (mesh == null)
		{
			throw new ArgumentNullException("mesh");
		}
		if (submeshIndex < 0 || submeshIndex >= mesh.subMeshCount)
		{
			throw new ArgumentOutOfRangeException("submeshIndex", "submeshIndex out of range.");
		}
		if (material == null)
		{
			throw new ArgumentNullException("material");
		}
		if (count <= 0)
		{
			throw new ArgumentOutOfRangeException("count");
		}
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		if (count > 0)
		{
			Internal_DrawMeshInstancedProcedural(mesh, submeshIndex, material, shaderPass, count, properties);
		}
	}

	public void DrawMeshInstancedIndirect(Mesh mesh, int submeshIndex, Material material, int shaderPass, ComputeBuffer bufferWithArgs, int argsOffset, MaterialPropertyBlock properties)
	{
		if (!SystemInfo.supportsInstancing)
		{
			throw new InvalidOperationException("Instancing is not supported.");
		}
		if (!SystemInfo.supportsIndirectArgumentsBuffer)
		{
			throw new InvalidOperationException("Indirect argument buffers are not supported.");
		}
		if (mesh == null)
		{
			throw new ArgumentNullException("mesh");
		}
		if (submeshIndex < 0 || submeshIndex >= mesh.subMeshCount)
		{
			throw new ArgumentOutOfRangeException("submeshIndex", "submeshIndex out of range.");
		}
		if (material == null)
		{
			throw new ArgumentNullException("material");
		}
		if (bufferWithArgs == null)
		{
			throw new ArgumentNullException("bufferWithArgs");
		}
		Internal_DrawMeshInstancedIndirect(mesh, submeshIndex, material, shaderPass, bufferWithArgs, argsOffset, properties);
	}

	public void DrawMeshInstancedIndirect(Mesh mesh, int submeshIndex, Material material, int shaderPass, ComputeBuffer bufferWithArgs, int argsOffset)
	{
		DrawMeshInstancedIndirect(mesh, submeshIndex, material, shaderPass, bufferWithArgs, argsOffset, null);
	}

	public void DrawMeshInstancedIndirect(Mesh mesh, int submeshIndex, Material material, int shaderPass, ComputeBuffer bufferWithArgs)
	{
		DrawMeshInstancedIndirect(mesh, submeshIndex, material, shaderPass, bufferWithArgs, 0, null);
	}

	public void DrawMeshInstancedIndirect(Mesh mesh, int submeshIndex, Material material, int shaderPass, GraphicsBuffer bufferWithArgs, int argsOffset, MaterialPropertyBlock properties)
	{
		if (!SystemInfo.supportsInstancing)
		{
			throw new InvalidOperationException("Instancing is not supported.");
		}
		if (!SystemInfo.supportsIndirectArgumentsBuffer)
		{
			throw new InvalidOperationException("Indirect argument buffers are not supported.");
		}
		if (mesh == null)
		{
			throw new ArgumentNullException("mesh");
		}
		if (submeshIndex < 0 || submeshIndex >= mesh.subMeshCount)
		{
			throw new ArgumentOutOfRangeException("submeshIndex", "submeshIndex out of range.");
		}
		if (material == null)
		{
			throw new ArgumentNullException("material");
		}
		if (bufferWithArgs == null)
		{
			throw new ArgumentNullException("bufferWithArgs");
		}
		Internal_DrawMeshInstancedIndirectGraphicsBuffer(mesh, submeshIndex, material, shaderPass, bufferWithArgs, argsOffset, properties);
	}

	public void DrawMeshInstancedIndirect(Mesh mesh, int submeshIndex, Material material, int shaderPass, GraphicsBuffer bufferWithArgs, int argsOffset)
	{
		DrawMeshInstancedIndirect(mesh, submeshIndex, material, shaderPass, bufferWithArgs, argsOffset, null);
	}

	public void DrawMeshInstancedIndirect(Mesh mesh, int submeshIndex, Material material, int shaderPass, GraphicsBuffer bufferWithArgs)
	{
		DrawMeshInstancedIndirect(mesh, submeshIndex, material, shaderPass, bufferWithArgs, 0, null);
	}

	public void DrawOcclusionMesh(RectInt normalizedCamViewport)
	{
		Internal_DrawOcclusionMesh(normalizedCamViewport);
	}

	public void SetRandomWriteTarget(int index, RenderTargetIdentifier rt)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		SetRandomWriteTarget_Texture(index, ref rt);
	}

	public void SetRandomWriteTarget(int index, ComputeBuffer buffer, bool preserveCounterValue)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		SetRandomWriteTarget_Buffer(index, buffer, preserveCounterValue);
	}

	public void SetRandomWriteTarget(int index, ComputeBuffer buffer)
	{
		SetRandomWriteTarget(index, buffer, preserveCounterValue: false);
	}

	public void SetRandomWriteTarget(int index, GraphicsBuffer buffer, bool preserveCounterValue)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		SetRandomWriteTarget_GraphicsBuffer(index, buffer, preserveCounterValue);
	}

	public void SetRandomWriteTarget(int index, GraphicsBuffer buffer)
	{
		SetRandomWriteTarget(index, buffer, preserveCounterValue: false);
	}

	public void CopyCounterValue(ComputeBuffer src, ComputeBuffer dst, uint dstOffsetBytes)
	{
		CopyCounterValueCC(src, dst, dstOffsetBytes);
	}

	public void CopyCounterValue(GraphicsBuffer src, ComputeBuffer dst, uint dstOffsetBytes)
	{
		CopyCounterValueGC(src, dst, dstOffsetBytes);
	}

	public void CopyCounterValue(ComputeBuffer src, GraphicsBuffer dst, uint dstOffsetBytes)
	{
		CopyCounterValueCG(src, dst, dstOffsetBytes);
	}

	public void CopyCounterValue(GraphicsBuffer src, GraphicsBuffer dst, uint dstOffsetBytes)
	{
		CopyCounterValueGG(src, dst, dstOffsetBytes);
	}

	public void CopyTexture(RenderTargetIdentifier src, RenderTargetIdentifier dst)
	{
		CopyTexture_Internal(ref src, -1, -1, -1, -1, -1, -1, ref dst, -1, -1, -1, -1, 1);
	}

	public void CopyTexture(RenderTargetIdentifier src, int srcElement, RenderTargetIdentifier dst, int dstElement)
	{
		CopyTexture_Internal(ref src, srcElement, -1, -1, -1, -1, -1, ref dst, dstElement, -1, -1, -1, 2);
	}

	public void CopyTexture(RenderTargetIdentifier src, int srcElement, int srcMip, RenderTargetIdentifier dst, int dstElement, int dstMip)
	{
		CopyTexture_Internal(ref src, srcElement, srcMip, -1, -1, -1, -1, ref dst, dstElement, dstMip, -1, -1, 3);
	}

	public void CopyTexture(RenderTargetIdentifier src, int srcElement, int srcMip, int srcX, int srcY, int srcWidth, int srcHeight, RenderTargetIdentifier dst, int dstElement, int dstMip, int dstX, int dstY)
	{
		CopyTexture_Internal(ref src, srcElement, srcMip, srcX, srcY, srcWidth, srcHeight, ref dst, dstElement, dstMip, dstX, dstY, 4);
	}

	public void Blit(Texture source, RenderTargetIdentifier dest)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Blit_Texture(source, ref dest, null, -1, new Vector2(1f, 1f), new Vector2(0f, 0f), Texture2DArray.allSlices, 0);
	}

	public void Blit(Texture source, RenderTargetIdentifier dest, Vector2 scale, Vector2 offset)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Blit_Texture(source, ref dest, null, -1, scale, offset, Texture2DArray.allSlices, 0);
	}

	public void Blit(Texture source, RenderTargetIdentifier dest, Material mat)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Blit_Texture(source, ref dest, mat, -1, new Vector2(1f, 1f), new Vector2(0f, 0f), Texture2DArray.allSlices, 0);
	}

	public void Blit(Texture source, RenderTargetIdentifier dest, Material mat, int pass)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Blit_Texture(source, ref dest, mat, pass, new Vector2(1f, 1f), new Vector2(0f, 0f), Texture2DArray.allSlices, 0);
	}

	public void Blit(RenderTargetIdentifier source, RenderTargetIdentifier dest)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Blit_Identifier(ref source, ref dest, null, -1, new Vector2(1f, 1f), new Vector2(0f, 0f), Texture2DArray.allSlices, 0);
	}

	public void Blit(RenderTargetIdentifier source, RenderTargetIdentifier dest, Vector2 scale, Vector2 offset)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Blit_Identifier(ref source, ref dest, null, -1, scale, offset, Texture2DArray.allSlices, 0);
	}

	public void Blit(RenderTargetIdentifier source, RenderTargetIdentifier dest, Material mat)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Blit_Identifier(ref source, ref dest, mat, -1, new Vector2(1f, 1f), new Vector2(0f, 0f), Texture2DArray.allSlices, 0);
	}

	public void Blit(RenderTargetIdentifier source, RenderTargetIdentifier dest, Material mat, int pass)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Blit_Identifier(ref source, ref dest, mat, pass, new Vector2(1f, 1f), new Vector2(0f, 0f), Texture2DArray.allSlices, 0);
	}

	public void Blit(RenderTargetIdentifier source, RenderTargetIdentifier dest, int sourceDepthSlice, int destDepthSlice)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Blit_Identifier(ref source, ref dest, null, -1, new Vector2(1f, 1f), new Vector2(0f, 0f), sourceDepthSlice, destDepthSlice);
	}

	public void Blit(RenderTargetIdentifier source, RenderTargetIdentifier dest, Vector2 scale, Vector2 offset, int sourceDepthSlice, int destDepthSlice)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Blit_Identifier(ref source, ref dest, null, -1, scale, offset, sourceDepthSlice, destDepthSlice);
	}

	public void Blit(RenderTargetIdentifier source, RenderTargetIdentifier dest, Material mat, int pass, int destDepthSlice)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Blit_Identifier(ref source, ref dest, mat, pass, new Vector2(1f, 1f), new Vector2(0f, 0f), Texture2DArray.allSlices, destDepthSlice);
	}

	public void SetGlobalFloat(string name, float value)
	{
		SetGlobalFloat(Shader.PropertyToID(name), value);
	}

	public void SetGlobalInt(string name, int value)
	{
		SetGlobalInt(Shader.PropertyToID(name), value);
	}

	public void SetGlobalInteger(string name, int value)
	{
		SetGlobalInteger(Shader.PropertyToID(name), value);
	}

	public void SetGlobalVector(string name, Vector4 value)
	{
		SetGlobalVector(Shader.PropertyToID(name), value);
	}

	public void SetGlobalColor(string name, Color value)
	{
		SetGlobalColor(Shader.PropertyToID(name), value);
	}

	public void SetGlobalMatrix(string name, Matrix4x4 value)
	{
		SetGlobalMatrix(Shader.PropertyToID(name), value);
	}

	public void SetGlobalFloatArray(string propertyName, List<float> values)
	{
		SetGlobalFloatArray(Shader.PropertyToID(propertyName), values);
	}

	public void SetGlobalFloatArray(int nameID, List<float> values)
	{
		if (values == null)
		{
			throw new ArgumentNullException("values");
		}
		if (values.Count == 0)
		{
			throw new ArgumentException("Zero-sized array is not allowed.");
		}
		SetGlobalFloatArrayListImpl(nameID, values);
	}

	public void SetGlobalFloatArray(string propertyName, float[] values)
	{
		SetGlobalFloatArray(Shader.PropertyToID(propertyName), values);
	}

	public void SetGlobalVectorArray(string propertyName, List<Vector4> values)
	{
		SetGlobalVectorArray(Shader.PropertyToID(propertyName), values);
	}

	public void SetGlobalVectorArray(int nameID, List<Vector4> values)
	{
		if (values == null)
		{
			throw new ArgumentNullException("values");
		}
		if (values.Count == 0)
		{
			throw new ArgumentException("Zero-sized array is not allowed.");
		}
		SetGlobalVectorArrayListImpl(nameID, values);
	}

	public void SetGlobalVectorArray(string propertyName, Vector4[] values)
	{
		SetGlobalVectorArray(Shader.PropertyToID(propertyName), values);
	}

	public void SetGlobalMatrixArray(string propertyName, List<Matrix4x4> values)
	{
		SetGlobalMatrixArray(Shader.PropertyToID(propertyName), values);
	}

	public void SetGlobalMatrixArray(int nameID, List<Matrix4x4> values)
	{
		if (values == null)
		{
			throw new ArgumentNullException("values");
		}
		if (values.Count == 0)
		{
			throw new ArgumentException("Zero-sized array is not allowed.");
		}
		SetGlobalMatrixArrayListImpl(nameID, values);
	}

	public void SetGlobalMatrixArray(string propertyName, Matrix4x4[] values)
	{
		SetGlobalMatrixArray(Shader.PropertyToID(propertyName), values);
	}

	public void SetGlobalTexture(string name, RenderTargetIdentifier value)
	{
		SetGlobalTexture(Shader.PropertyToID(name), value, RenderTextureSubElement.Default);
	}

	public void SetGlobalTexture(int nameID, RenderTargetIdentifier value)
	{
		SetGlobalTexture_Impl(nameID, ref value, RenderTextureSubElement.Default);
	}

	public void SetGlobalTexture(string name, RenderTargetIdentifier value, RenderTextureSubElement element)
	{
		SetGlobalTexture(Shader.PropertyToID(name), value, element);
	}

	public void SetGlobalTexture(int nameID, RenderTargetIdentifier value, RenderTextureSubElement element)
	{
		SetGlobalTexture_Impl(nameID, ref value, element);
	}

	public void SetGlobalBuffer(string name, ComputeBuffer value)
	{
		SetGlobalBufferInternal(Shader.PropertyToID(name), value);
	}

	public void SetGlobalBuffer(int nameID, ComputeBuffer value)
	{
		SetGlobalBufferInternal(nameID, value);
	}

	public void SetGlobalBuffer(string name, GraphicsBuffer value)
	{
		SetGlobalGraphicsBufferInternal(Shader.PropertyToID(name), value);
	}

	public void SetGlobalBuffer(int nameID, GraphicsBuffer value)
	{
		SetGlobalGraphicsBufferInternal(nameID, value);
	}

	public void SetGlobalConstantBuffer(ComputeBuffer buffer, int nameID, int offset, int size)
	{
		SetGlobalConstantBufferInternal(buffer, nameID, offset, size);
	}

	public void SetGlobalConstantBuffer(ComputeBuffer buffer, string name, int offset, int size)
	{
		SetGlobalConstantBufferInternal(buffer, Shader.PropertyToID(name), offset, size);
	}

	public void SetGlobalConstantBuffer(GraphicsBuffer buffer, int nameID, int offset, int size)
	{
		SetGlobalConstantGraphicsBufferInternal(buffer, nameID, offset, size);
	}

	public void SetGlobalConstantBuffer(GraphicsBuffer buffer, string name, int offset, int size)
	{
		SetGlobalConstantGraphicsBufferInternal(buffer, Shader.PropertyToID(name), offset, size);
	}

	public void SetShadowSamplingMode(RenderTargetIdentifier shadowmap, ShadowSamplingMode mode)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		SetShadowSamplingMode_Impl(ref shadowmap, mode);
	}

	public void SetSinglePassStereo(SinglePassStereoMode mode)
	{
		Internal_SetSinglePassStereo(mode);
	}

	public void IssuePluginEvent(IntPtr callback, int eventID)
	{
		if (callback == IntPtr.Zero)
		{
			throw new ArgumentException("Null callback specified.");
		}
		IssuePluginEventInternal(callback, eventID);
	}

	public void IssuePluginEventAndData(IntPtr callback, int eventID, IntPtr data)
	{
		if (callback == IntPtr.Zero)
		{
			throw new ArgumentException("Null callback specified.");
		}
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		IssuePluginEventAndDataInternal(callback, eventID, data);
	}

	public void IssuePluginEventAndDataWithFlags(IntPtr callback, int eventID, CustomMarkerCallbackFlags flags, IntPtr data)
	{
		if (callback == IntPtr.Zero)
		{
			throw new ArgumentException("Null callback specified.");
		}
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		IssuePluginEventAndDataInternalWithFlags(callback, eventID, flags, data);
	}

	public void IssuePluginCustomBlit(IntPtr callback, uint command, RenderTargetIdentifier source, RenderTargetIdentifier dest, uint commandParam, uint commandFlags)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		IssuePluginCustomBlitInternal(callback, command, ref source, ref dest, commandParam, commandFlags);
	}

	[Obsolete("Use IssuePluginCustomTextureUpdateV2 to register TextureUpdate callbacks instead. Callbacks will be passed event IDs kUnityRenderingExtEventUpdateTextureBeginV2 or kUnityRenderingExtEventUpdateTextureEndV2, and data parameter of type UnityRenderingExtTextureUpdateParamsV2.", false)]
	public void IssuePluginCustomTextureUpdate(IntPtr callback, Texture targetTexture, uint userData)
	{
		IssuePluginCustomTextureUpdateInternal(callback, targetTexture, userData, useNewUnityRenderingExtTextureUpdateParamsV2: false);
	}

	[Obsolete("Use IssuePluginCustomTextureUpdateV2 to register TextureUpdate callbacks instead. Callbacks will be passed event IDs kUnityRenderingExtEventUpdateTextureBeginV2 or kUnityRenderingExtEventUpdateTextureEndV2, and data parameter of type UnityRenderingExtTextureUpdateParamsV2.", false)]
	public void IssuePluginCustomTextureUpdateV1(IntPtr callback, Texture targetTexture, uint userData)
	{
		IssuePluginCustomTextureUpdateInternal(callback, targetTexture, userData, useNewUnityRenderingExtTextureUpdateParamsV2: false);
	}

	public void IssuePluginCustomTextureUpdateV2(IntPtr callback, Texture targetTexture, uint userData)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		IssuePluginCustomTextureUpdateInternal(callback, targetTexture, userData, useNewUnityRenderingExtTextureUpdateParamsV2: true);
	}

	public void ProcessVTFeedback(RenderTargetIdentifier rt, IntPtr resolver, int slice, int x, int width, int y, int height, int mip)
	{
		ValidateAgainstExecutionFlags(CommandBufferExecutionFlags.None, CommandBufferExecutionFlags.AsyncCompute);
		Internal_ProcessVTFeedback(rt, resolver, slice, x, width, y, height, mip);
	}

	public void CopyBuffer(GraphicsBuffer source, GraphicsBuffer dest)
	{
		Graphics.ValidateCopyBuffer(source, dest);
		CopyBufferImpl(source, dest);
	}

	[Obsolete("CommandBuffer.CreateGPUFence has been deprecated. Use CreateGraphicsFence instead (UnityUpgradable) -> CreateAsyncGraphicsFence(*)", false)]
	public GPUFence CreateGPUFence(SynchronisationStage stage)
	{
		return default(GPUFence);
	}

	[Obsolete("CommandBuffer.CreateGPUFence has been deprecated. Use CreateGraphicsFence instead (UnityUpgradable) -> CreateAsyncGraphicsFence()", false)]
	public GPUFence CreateGPUFence()
	{
		return default(GPUFence);
	}

	[Obsolete("CommandBuffer.WaitOnGPUFence has been deprecated. Use WaitOnGraphicsFence instead (UnityUpgradable) -> WaitOnAsyncGraphicsFence(*)", false)]
	public void WaitOnGPUFence(GPUFence fence, SynchronisationStage stage)
	{
	}

	[Obsolete("CommandBuffer.WaitOnGPUFence has been deprecated. Use WaitOnGraphicsFence instead (UnityUpgradable) -> WaitOnAsyncGraphicsFence(*)", false)]
	public void WaitOnGPUFence(GPUFence fence)
	{
	}

	[Obsolete("CommandBuffer.SetComputeBufferData has been deprecated. Use SetBufferData instead (UnityUpgradable) -> SetBufferData(*)", false)]
	public void SetComputeBufferData(ComputeBuffer buffer, Array data)
	{
		SetBufferData(buffer, data);
	}

	[Obsolete("CommandBuffer.SetComputeBufferData has been deprecated. Use SetBufferData instead (UnityUpgradable) -> SetBufferData<T>(*)", false)]
	public void SetComputeBufferData<T>(ComputeBuffer buffer, List<T> data) where T : struct
	{
		SetBufferData(buffer, data);
	}

	[Obsolete("CommandBuffer.SetComputeBufferData has been deprecated. Use SetBufferData instead (UnityUpgradable) -> SetBufferData<T>(*)", false)]
	public void SetComputeBufferData<T>(ComputeBuffer buffer, NativeArray<T> data) where T : struct
	{
		SetBufferData(buffer, data);
	}

	[Obsolete("CommandBuffer.SetComputeBufferData has been deprecated. Use SetBufferData instead (UnityUpgradable) -> SetBufferData(*)", false)]
	public void SetComputeBufferData(ComputeBuffer buffer, Array data, int managedBufferStartIndex, int graphicsBufferStartIndex, int count)
	{
		SetBufferData(buffer, data, managedBufferStartIndex, graphicsBufferStartIndex, count);
	}

	[Obsolete("CommandBuffer.SetComputeBufferData has been deprecated. Use SetBufferData instead (UnityUpgradable) -> SetBufferData<T>(*)", false)]
	public void SetComputeBufferData<T>(ComputeBuffer buffer, List<T> data, int managedBufferStartIndex, int graphicsBufferStartIndex, int count) where T : struct
	{
		SetBufferData(buffer, data, managedBufferStartIndex, graphicsBufferStartIndex, count);
	}

	[Obsolete("CommandBuffer.SetComputeBufferData has been deprecated. Use SetBufferData instead (UnityUpgradable) -> SetBufferData<T>(*)", false)]
	public void SetComputeBufferData<T>(ComputeBuffer buffer, NativeArray<T> data, int nativeBufferStartIndex, int graphicsBufferStartIndex, int count) where T : struct
	{
		SetBufferData(buffer, data, nativeBufferStartIndex, graphicsBufferStartIndex, count);
	}

	[Obsolete("CommandBuffer.SetComputeBufferCounterValue has been deprecated. Use SetBufferCounterValue instead (UnityUpgradable) -> SetBufferCounterValue(*)", false)]
	public void SetComputeBufferCounterValue(ComputeBuffer buffer, uint counterValue)
	{
		SetBufferCounterValue(buffer, counterValue);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern void ConvertTexture_Internal_Injected(ref RenderTargetIdentifier src, int srcElement, ref RenderTargetIdentifier dst, int dstElement);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetComputeVectorParam_Injected(ComputeShader computeShader, int nameID, ref Vector4 val);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetComputeMatrixParam_Injected(ComputeShader computeShader, int nameID, ref Matrix4x4 val);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Internal_SetComputeGraphicsBufferHandleParam_Injected(ComputeShader computeShader, int kernelIndex, int nameID, ref GraphicsBufferHandle bufferHandle);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Internal_SetRayTracingVectorParam_Injected(RayTracingShader rayTracingShader, int nameID, ref Vector4 val);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Internal_SetRayTracingMatrixParam_Injected(RayTracingShader rayTracingShader, int nameID, ref Matrix4x4 val);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Internal_BuildRayTracingAccelerationStructure_Injected(RayTracingAccelerationStructure accelerationStructure, ref Vector3 relativeOrigin);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Internal_GenerateMips_Injected(ref RenderTargetIdentifier rt);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Internal_DrawMesh_Injected(Mesh mesh, ref Matrix4x4 matrix, Material material, int submeshIndex, int shaderPass, MaterialPropertyBlock properties);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Internal_DrawRendererList_Injected(ref RendererList rendererList);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Internal_DrawProcedural_Injected(ref Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, int vertexCount, int instanceCount, MaterialPropertyBlock properties);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Internal_DrawProceduralIndexed_Injected(GraphicsBuffer indexBuffer, ref Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, int indexCount, int instanceCount, MaterialPropertyBlock properties);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Internal_DrawProceduralIndirect_Injected(ref Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, ComputeBuffer bufferWithArgs, int argsOffset, MaterialPropertyBlock properties);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Internal_DrawProceduralIndexedIndirect_Injected(GraphicsBuffer indexBuffer, ref Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, ComputeBuffer bufferWithArgs, int argsOffset, MaterialPropertyBlock properties);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Internal_DrawProceduralIndirectGraphicsBuffer_Injected(ref Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, GraphicsBuffer bufferWithArgs, int argsOffset, MaterialPropertyBlock properties);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Internal_DrawProceduralIndexedIndirectGraphicsBuffer_Injected(GraphicsBuffer indexBuffer, ref Matrix4x4 matrix, Material material, int shaderPass, MeshTopology topology, GraphicsBuffer bufferWithArgs, int argsOffset, MaterialPropertyBlock properties);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Internal_DrawOcclusionMesh_Injected(ref RectInt normalizedCamViewport);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetViewport_Injected(ref Rect pixelRect);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void EnableScissorRect_Injected(ref Rect scissor);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Blit_Texture_Injected(Texture source, ref RenderTargetIdentifier dest, Material mat, int pass, ref Vector2 scale, ref Vector2 offset, int sourceDepthSlice, int destDepthSlice);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Blit_Identifier_Injected(ref RenderTargetIdentifier source, ref RenderTargetIdentifier dest, Material mat, int pass, ref Vector2 scale, ref Vector2 offset, int sourceDepthSlice, int destDepthSlice);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetTemporaryRTWithDescriptor_Injected(int nameID, ref RenderTextureDescriptor desc, FilterMode filter);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void ClearRenderTarget_Injected(RTClearFlags clearFlags, ref Color backgroundColor, float depth, uint stencil);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetGlobalVector_Injected(int nameID, ref Vector4 value);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetGlobalColor_Injected(int nameID, ref Color value);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetGlobalMatrix_Injected(int nameID, ref Matrix4x4 value);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void EnableGlobalKeyword_Injected(ref GlobalKeyword keyword);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void EnableMaterialKeyword_Injected(Material material, ref LocalKeyword keyword);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void EnableComputeKeyword_Injected(ComputeShader computeShader, ref LocalKeyword keyword);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void DisableGlobalKeyword_Injected(ref GlobalKeyword keyword);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void DisableMaterialKeyword_Injected(Material material, ref LocalKeyword keyword);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void DisableComputeKeyword_Injected(ComputeShader computeShader, ref LocalKeyword keyword);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetGlobalKeyword_Injected(ref GlobalKeyword keyword, bool value);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetMaterialKeyword_Injected(Material material, ref LocalKeyword keyword, bool value);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetComputeKeyword_Injected(ComputeShader computeShader, ref LocalKeyword keyword, bool value);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetViewMatrix_Injected(ref Matrix4x4 view);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetProjectionMatrix_Injected(ref Matrix4x4 proj);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetViewProjectionMatrices_Injected(ref Matrix4x4 view, ref Matrix4x4 proj);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void IncrementUpdateCount_Injected(ref RenderTargetIdentifier dest);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetRenderTargetSingle_Internal_Injected(ref RenderTargetIdentifier rt, RenderBufferLoadAction colorLoadAction, RenderBufferStoreAction colorStoreAction, RenderBufferLoadAction depthLoadAction, RenderBufferStoreAction depthStoreAction);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetRenderTargetColorDepth_Internal_Injected(ref RenderTargetIdentifier color, ref RenderTargetIdentifier depth, RenderBufferLoadAction colorLoadAction, RenderBufferStoreAction colorStoreAction, RenderBufferLoadAction depthLoadAction, RenderBufferStoreAction depthStoreAction, RenderTargetFlags flags);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetRenderTargetMulti_Internal_Injected(RenderTargetIdentifier[] colors, ref RenderTargetIdentifier depth, RenderBufferLoadAction[] colorLoadActions, RenderBufferStoreAction[] colorStoreActions, RenderBufferLoadAction depthLoadAction, RenderBufferStoreAction depthStoreAction, RenderTargetFlags flags);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetRenderTargetColorDepthSubtarget_Injected(ref RenderTargetIdentifier color, ref RenderTargetIdentifier depth, RenderBufferLoadAction colorLoadAction, RenderBufferStoreAction colorStoreAction, RenderBufferLoadAction depthLoadAction, RenderBufferStoreAction depthStoreAction, int mipLevel, CubemapFace cubemapFace, int depthSlice);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetRenderTargetMultiSubtarget_Injected(RenderTargetIdentifier[] colors, ref RenderTargetIdentifier depth, RenderBufferLoadAction[] colorLoadActions, RenderBufferStoreAction[] colorStoreActions, RenderBufferLoadAction depthLoadAction, RenderBufferStoreAction depthStoreAction, int mipLevel, CubemapFace cubemapFace, int depthSlice);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Internal_ProcessVTFeedback_Injected(ref RenderTargetIdentifier rt, IntPtr resolver, int slice, int x, int width, int y, int height, int mip);
}
