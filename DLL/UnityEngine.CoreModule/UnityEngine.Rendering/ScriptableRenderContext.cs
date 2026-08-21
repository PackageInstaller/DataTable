using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Rendering.RendererUtils;

namespace UnityEngine.Rendering;

[NativeType("Runtime/Graphics/ScriptableRenderLoop/ScriptableRenderContext.h")]
[NativeHeader("Runtime/Export/RenderPipeline/ScriptableRenderContext.bindings.h")]
[NativeHeader("Modules/UI/CanvasManager.h")]
[NativeHeader("Modules/UI/Canvas.h")]
[NativeHeader("Runtime/Graphics/ScriptableRenderLoop/ScriptableDrawRenderersUtility.h")]
[NativeHeader("Runtime/Export/RenderPipeline/ScriptableRenderPipeline.bindings.h")]
public struct ScriptableRenderContext : IEquatable<ScriptableRenderContext>
{
	private static readonly ShaderTagId kRenderTypeTag = new ShaderTagId("RenderType");

	private IntPtr m_Ptr;

	[FreeFunction("ScriptableRenderPipeline_Bindings::Internal_Cull")]
	private static void Internal_Cull(ref ScriptableCullingParameters parameters, ScriptableRenderContext renderLoop, IntPtr results)
	{
		Internal_Cull_Injected(ref parameters, ref renderLoop, results);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("InitializeSortSettings")]
	internal static extern void InitializeSortSettings(Camera camera, out SortingSettings sortingSettings);

	private void Submit_Internal()
	{
		Submit_Internal_Injected(ref this);
	}

	private void GetCameras_Internal(Type listType, object resultList)
	{
		GetCameras_Internal_Injected(ref this, listType, resultList);
	}

	private void DrawRenderers_Internal(IntPtr cullResults, ref DrawingSettings drawingSettings, ref FilteringSettings filteringSettings, ShaderTagId tagName, bool isPassTagName, IntPtr tagValues, IntPtr stateBlocks, int stateCount)
	{
		DrawRenderers_Internal_Injected(ref this, cullResults, ref drawingSettings, ref filteringSettings, ref tagName, isPassTagName, tagValues, stateBlocks, stateCount);
	}

	private void DrawShadows_Internal(IntPtr shadowDrawingSettings)
	{
		DrawShadows_Internal_Injected(ref this, shadowDrawingSettings);
	}

	[NativeThrows]
	private void ExecuteCommandBuffer_Internal(CommandBuffer commandBuffer)
	{
		ExecuteCommandBuffer_Internal_Injected(ref this, commandBuffer);
	}

	[NativeThrows]
	private void ExecuteCommandBufferAsync_Internal(CommandBuffer commandBuffer, ComputeQueueType queueType)
	{
		ExecuteCommandBufferAsync_Internal_Injected(ref this, commandBuffer, queueType);
	}

	private void SetupCameraProperties_Internal([NotNull("NullExceptionObject")] Camera camera, bool stereoSetup, int eye)
	{
		SetupCameraProperties_Internal_Injected(ref this, camera, stereoSetup, eye);
	}

	private void DrawSkybox_Internal([NotNull("NullExceptionObject")] Camera camera)
	{
		DrawSkybox_Internal_Injected(ref this, camera);
	}

	private void DrawWireOverlay_Impl([NotNull("NullExceptionObject")] Camera camera)
	{
		DrawWireOverlay_Impl_Injected(ref this, camera);
	}

	private RendererList CreateRendererList_Internal(IntPtr cullResults, ref DrawingSettings drawingSettings, ref FilteringSettings filteringSettings, ShaderTagId tagName, bool isPassTagName, IntPtr tagValues, IntPtr stateBlocks, int stateCount)
	{
		CreateRendererList_Internal_Injected(ref this, cullResults, ref drawingSettings, ref filteringSettings, ref tagName, isPassTagName, tagValues, stateBlocks, stateCount, out var ret);
		return ret;
	}

	private void PrepareRendererListsAsync_Internal(object rendererLists)
	{
		PrepareRendererListsAsync_Internal_Injected(ref this, rendererLists);
	}

	private RendererListStatus QueryRendererListStatus_Internal(RendererList handle)
	{
		return QueryRendererListStatus_Internal_Injected(ref this, ref handle);
	}

	internal ScriptableRenderContext(IntPtr ptr)
	{
		m_Ptr = ptr;
	}

	public void Submit()
	{
		Submit_Internal();
	}

	internal void GetCameras(List<Camera> results)
	{
		GetCameras_Internal(typeof(Camera), results);
	}

	public void DrawRenderers(CullingResults cullingResults, ref DrawingSettings drawingSettings, ref FilteringSettings filteringSettings)
	{
		DrawRenderers_Internal(cullingResults.ptr, ref drawingSettings, ref filteringSettings, ShaderTagId.none, isPassTagName: false, IntPtr.Zero, IntPtr.Zero, 0);
	}

	public unsafe void DrawRenderers(CullingResults cullingResults, ref DrawingSettings drawingSettings, ref FilteringSettings filteringSettings, ref RenderStateBlock stateBlock)
	{
		ShaderTagId shaderTagId = default(ShaderTagId);
		fixed (RenderStateBlock* ptr = &stateBlock)
		{
			DrawRenderers_Internal(cullingResults.ptr, ref drawingSettings, ref filteringSettings, ShaderTagId.none, isPassTagName: false, (IntPtr)(&shaderTagId), (IntPtr)ptr, 1);
		}
	}

	public unsafe void DrawShadows(ref ShadowDrawingSettings settings)
	{
		fixed (ShadowDrawingSettings* ptr = &settings)
		{
			DrawShadows_Internal((IntPtr)ptr);
		}
	}

	public void ExecuteCommandBuffer(CommandBuffer commandBuffer)
	{
		if (commandBuffer == null)
		{
			throw new ArgumentNullException("commandBuffer");
		}
		if (commandBuffer.m_Ptr == IntPtr.Zero)
		{
			throw new ObjectDisposedException("commandBuffer");
		}
		ExecuteCommandBuffer_Internal(commandBuffer);
	}

	public void ExecuteCommandBufferAsync(CommandBuffer commandBuffer, ComputeQueueType queueType)
	{
		if (commandBuffer == null)
		{
			throw new ArgumentNullException("commandBuffer");
		}
		if (commandBuffer.m_Ptr == IntPtr.Zero)
		{
			throw new ObjectDisposedException("commandBuffer");
		}
		ExecuteCommandBufferAsync_Internal(commandBuffer, queueType);
	}

	public void SetupCameraProperties(Camera camera, bool stereoSetup = false)
	{
		SetupCameraProperties(camera, stereoSetup, 0);
	}

	public void SetupCameraProperties(Camera camera, bool stereoSetup, int eye)
	{
		SetupCameraProperties_Internal(camera, stereoSetup, eye);
	}

	public void DrawSkybox(Camera camera)
	{
		DrawSkybox_Internal(camera);
	}

	public void DrawWireOverlay(Camera camera)
	{
		DrawWireOverlay_Impl(camera);
	}

	public unsafe CullingResults Cull(ref ScriptableCullingParameters parameters)
	{
		CullingResults result = default(CullingResults);
		Internal_Cull(ref parameters, this, (IntPtr)(&result));
		return result;
	}

	public bool Equals(ScriptableRenderContext other)
	{
		return m_Ptr.Equals(other.m_Ptr);
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		return obj is ScriptableRenderContext && Equals((ScriptableRenderContext)obj);
	}

	public override int GetHashCode()
	{
		return m_Ptr.GetHashCode();
	}

	public RendererList CreateRendererList(RendererListDesc desc)
	{
		RendererListParams param = RendererListDesc.ConvertToParameters(in desc);
		RendererList result = CreateRendererList(ref param);
		param.Dispose();
		return result;
	}

	public RendererList CreateRendererList(ref RendererListParams param)
	{
		param.Validate();
		return CreateRendererList_Internal(param.cullingResults.ptr, ref param.drawSettings, ref param.filteringSettings, param.tagName, param.isPassTagName, param.tagsValuePtr, param.stateBlocksPtr, param.numStateBlocks);
	}

	public void PrepareRendererListsAsync(List<RendererList> rendererLists)
	{
		PrepareRendererListsAsync_Internal(rendererLists);
	}

	public RendererListStatus QueryRendererListStatus(RendererList rendererList)
	{
		return QueryRendererListStatus_Internal(rendererList);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Internal_Cull_Injected(ref ScriptableCullingParameters parameters, ref ScriptableRenderContext renderLoop, IntPtr results);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Submit_Internal_Injected(ref ScriptableRenderContext _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetCameras_Internal_Injected(ref ScriptableRenderContext _unity_self, Type listType, object resultList);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DrawRenderers_Internal_Injected(ref ScriptableRenderContext _unity_self, IntPtr cullResults, ref DrawingSettings drawingSettings, ref FilteringSettings filteringSettings, ref ShaderTagId tagName, bool isPassTagName, IntPtr tagValues, IntPtr stateBlocks, int stateCount);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DrawShadows_Internal_Injected(ref ScriptableRenderContext _unity_self, IntPtr shadowDrawingSettings);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void ExecuteCommandBuffer_Internal_Injected(ref ScriptableRenderContext _unity_self, CommandBuffer commandBuffer);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void ExecuteCommandBufferAsync_Internal_Injected(ref ScriptableRenderContext _unity_self, CommandBuffer commandBuffer, ComputeQueueType queueType);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetupCameraProperties_Internal_Injected(ref ScriptableRenderContext _unity_self, Camera camera, bool stereoSetup, int eye);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DrawSkybox_Internal_Injected(ref ScriptableRenderContext _unity_self, Camera camera);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DrawWireOverlay_Impl_Injected(ref ScriptableRenderContext _unity_self, Camera camera);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void CreateRendererList_Internal_Injected(ref ScriptableRenderContext _unity_self, IntPtr cullResults, ref DrawingSettings drawingSettings, ref FilteringSettings filteringSettings, ref ShaderTagId tagName, bool isPassTagName, IntPtr tagValues, IntPtr stateBlocks, int stateCount, out RendererList ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void PrepareRendererListsAsync_Internal_Injected(ref ScriptableRenderContext _unity_self, object rendererLists);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern RendererListStatus QueryRendererListStatus_Internal_Injected(ref ScriptableRenderContext _unity_self, ref RendererList handle);
}
