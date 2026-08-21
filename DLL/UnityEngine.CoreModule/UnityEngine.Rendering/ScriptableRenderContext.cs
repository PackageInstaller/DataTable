using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Bindings;
using UnityEngine.Rendering.RendererUtils;

namespace UnityEngine.Rendering;

[NativeHeader("Runtime/Graphics/ScriptableRenderLoop/ScriptableDrawRenderersUtility.h")]
[NativeHeader("Modules/UI/Canvas.h")]
[NativeHeader("Modules/UI/CanvasManager.h")]
[NativeHeader("Runtime/Export/RenderPipeline/ScriptableRenderPipeline.bindings.h")]
[NativeType("Runtime/Graphics/ScriptableRenderLoop/ScriptableRenderContext.h")]
[NativeHeader("Runtime/Export/RenderPipeline/ScriptableRenderContext.bindings.h")]
public struct ScriptableRenderContext : IEquatable<ScriptableRenderContext>
{
	private static readonly ShaderTagId kRenderTypeTag = new ShaderTagId("RenderType");

	private IntPtr m_Ptr;

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ScriptableRenderContext::BeginRenderPass")]
	private static extern void BeginRenderPass_Internal(IntPtr self, int width, int height, int samples, IntPtr colors, int colorCount, int depthAttachmentIndex);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ScriptableRenderContext::BeginSubPass")]
	private static extern void BeginSubPass_Internal(IntPtr self, IntPtr colors, int colorCount, IntPtr inputs, int inputCount, bool isDepthReadOnly, bool isStencilReadOnly);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ScriptableRenderContext::EndSubPass")]
	private static extern void EndSubPass_Internal(IntPtr self);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ScriptableRenderContext::EndRenderPass")]
	private static extern void EndRenderPass_Internal(IntPtr self);

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

	private bool SubmitForRenderPassValidation_Internal()
	{
		return SubmitForRenderPassValidation_Internal_Injected(ref this);
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

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("PlayerEmitCanvasGeometryForCamera")]
	public static extern void EmitGeometryForCamera(Camera camera);

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

	private void StereoEndRender_Internal([NotNull("NullExceptionObject")] Camera camera, int eye, bool isFinalPass)
	{
		StereoEndRender_Internal_Injected(ref this, camera, eye, isFinalPass);
	}

	private void StartMultiEye_Internal([NotNull("NullExceptionObject")] Camera camera, int eye)
	{
		StartMultiEye_Internal_Injected(ref this, camera, eye);
	}

	private void StopMultiEye_Internal([NotNull("NullExceptionObject")] Camera camera)
	{
		StopMultiEye_Internal_Injected(ref this, camera);
	}

	private void DrawSkybox_Internal([NotNull("NullExceptionObject")] Camera camera)
	{
		DrawSkybox_Internal_Injected(ref this, camera);
	}

	private void InvokeOnRenderObjectCallback_Internal()
	{
		InvokeOnRenderObjectCallback_Internal_Injected(ref this);
	}

	private void DrawGizmos_Internal([NotNull("NullExceptionObject")] Camera camera, GizmoSubset gizmoSubset)
	{
		DrawGizmos_Internal_Injected(ref this, camera, gizmoSubset);
	}

	private void DrawWireOverlay_Impl([NotNull("NullExceptionObject")] Camera camera)
	{
		DrawWireOverlay_Impl_Injected(ref this, camera);
	}

	private void DrawUIOverlay_Internal([NotNull("NullExceptionObject")] Camera camera)
	{
		DrawUIOverlay_Internal_Injected(ref this, camera);
	}

	internal IntPtr Internal_GetPtr()
	{
		return m_Ptr;
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

	public unsafe void BeginRenderPass(int width, int height, int samples, NativeArray<AttachmentDescriptor> attachments, int depthAttachmentIndex = -1)
	{
		BeginRenderPass_Internal(m_Ptr, width, height, samples, (IntPtr)attachments.GetUnsafeReadOnlyPtr(), attachments.Length, depthAttachmentIndex);
	}

	public ScopedRenderPass BeginScopedRenderPass(int width, int height, int samples, NativeArray<AttachmentDescriptor> attachments, int depthAttachmentIndex = -1)
	{
		BeginRenderPass(width, height, samples, attachments, depthAttachmentIndex);
		return new ScopedRenderPass(this);
	}

	public unsafe void BeginSubPass(NativeArray<int> colors, NativeArray<int> inputs, bool isDepthReadOnly, bool isStencilReadOnly)
	{
		BeginSubPass_Internal(m_Ptr, (IntPtr)colors.GetUnsafeReadOnlyPtr(), colors.Length, (IntPtr)inputs.GetUnsafeReadOnlyPtr(), inputs.Length, isDepthReadOnly, isStencilReadOnly);
	}

	public unsafe void BeginSubPass(NativeArray<int> colors, NativeArray<int> inputs, bool isDepthStencilReadOnly = false)
	{
		BeginSubPass_Internal(m_Ptr, (IntPtr)colors.GetUnsafeReadOnlyPtr(), colors.Length, (IntPtr)inputs.GetUnsafeReadOnlyPtr(), inputs.Length, isDepthStencilReadOnly, isDepthStencilReadOnly);
	}

	public unsafe void BeginSubPass(NativeArray<int> colors, bool isDepthReadOnly, bool isStencilReadOnly)
	{
		BeginSubPass_Internal(m_Ptr, (IntPtr)colors.GetUnsafeReadOnlyPtr(), colors.Length, IntPtr.Zero, 0, isDepthReadOnly, isStencilReadOnly);
	}

	public unsafe void BeginSubPass(NativeArray<int> colors, bool isDepthStencilReadOnly = false)
	{
		BeginSubPass_Internal(m_Ptr, (IntPtr)colors.GetUnsafeReadOnlyPtr(), colors.Length, IntPtr.Zero, 0, isDepthStencilReadOnly, isDepthStencilReadOnly);
	}

	public ScopedSubPass BeginScopedSubPass(NativeArray<int> colors, NativeArray<int> inputs, bool isDepthReadOnly, bool isStencilReadOnly)
	{
		BeginSubPass(colors, inputs, isDepthReadOnly, isStencilReadOnly);
		return new ScopedSubPass(this);
	}

	public ScopedSubPass BeginScopedSubPass(NativeArray<int> colors, NativeArray<int> inputs, bool isDepthStencilReadOnly = false)
	{
		BeginSubPass(colors, inputs, isDepthStencilReadOnly);
		return new ScopedSubPass(this);
	}

	public ScopedSubPass BeginScopedSubPass(NativeArray<int> colors, bool isDepthReadOnly, bool isStencilReadOnly)
	{
		BeginSubPass(colors, isDepthReadOnly, isStencilReadOnly);
		return new ScopedSubPass(this);
	}

	public ScopedSubPass BeginScopedSubPass(NativeArray<int> colors, bool isDepthStencilReadOnly = false)
	{
		BeginSubPass(colors, isDepthStencilReadOnly);
		return new ScopedSubPass(this);
	}

	public void EndSubPass()
	{
		EndSubPass_Internal(m_Ptr);
	}

	public void EndRenderPass()
	{
		EndRenderPass_Internal(m_Ptr);
	}

	public void Submit()
	{
		Submit_Internal();
	}

	public bool SubmitForRenderPassValidation()
	{
		return SubmitForRenderPassValidation_Internal();
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

	public unsafe void DrawRenderers(CullingResults cullingResults, ref DrawingSettings drawingSettings, ref FilteringSettings filteringSettings, NativeArray<ShaderTagId> renderTypes, NativeArray<RenderStateBlock> stateBlocks)
	{
		if (renderTypes.Length != stateBlocks.Length)
		{
			throw new ArgumentException(string.Format("Arrays {0} and {1} should have same length, but {2} had length {3} while {4} had length {5}.", "renderTypes", "stateBlocks", "renderTypes", renderTypes.Length, "stateBlocks", stateBlocks.Length));
		}
		DrawRenderers_Internal(cullingResults.ptr, ref drawingSettings, ref filteringSettings, kRenderTypeTag, isPassTagName: false, (IntPtr)renderTypes.GetUnsafeReadOnlyPtr(), (IntPtr)stateBlocks.GetUnsafeReadOnlyPtr(), renderTypes.Length);
	}

	public unsafe void DrawRenderers(CullingResults cullingResults, ref DrawingSettings drawingSettings, ref FilteringSettings filteringSettings, ShaderTagId tagName, bool isPassTagName, NativeArray<ShaderTagId> tagValues, NativeArray<RenderStateBlock> stateBlocks)
	{
		if (tagValues.Length != stateBlocks.Length)
		{
			throw new ArgumentException(string.Format("Arrays {0} and {1} should have same length, but {2} had length {3} while {4} had length {5}.", "tagValues", "stateBlocks", "tagValues", tagValues.Length, "stateBlocks", stateBlocks.Length));
		}
		DrawRenderers_Internal(cullingResults.ptr, ref drawingSettings, ref filteringSettings, tagName, isPassTagName, (IntPtr)tagValues.GetUnsafeReadOnlyPtr(), (IntPtr)stateBlocks.GetUnsafeReadOnlyPtr(), tagValues.Length);
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

	public void StereoEndRender(Camera camera)
	{
		StereoEndRender(camera, 0, isFinalPass: true);
	}

	public void StereoEndRender(Camera camera, int eye)
	{
		StereoEndRender(camera, eye, isFinalPass: true);
	}

	public void StereoEndRender(Camera camera, int eye, bool isFinalPass)
	{
		StereoEndRender_Internal(camera, eye, isFinalPass);
	}

	public void StartMultiEye(Camera camera)
	{
		StartMultiEye(camera, 0);
	}

	public void StartMultiEye(Camera camera, int eye)
	{
		StartMultiEye_Internal(camera, eye);
	}

	public void StopMultiEye(Camera camera)
	{
		StopMultiEye_Internal(camera);
	}

	public void DrawSkybox(Camera camera)
	{
		DrawSkybox_Internal(camera);
	}

	public void InvokeOnRenderObjectCallback()
	{
		InvokeOnRenderObjectCallback_Internal();
	}

	public void DrawGizmos(Camera camera, GizmoSubset gizmoSubset)
	{
		DrawGizmos_Internal(camera, gizmoSubset);
	}

	public void DrawWireOverlay(Camera camera)
	{
		DrawWireOverlay_Impl(camera);
	}

	public void DrawUIOverlay(Camera camera)
	{
		DrawUIOverlay_Internal(camera);
	}

	public unsafe CullingResults Cull(ref ScriptableCullingParameters parameters)
	{
		CullingResults result = default(CullingResults);
		Internal_Cull(ref parameters, this, (IntPtr)(&result));
		return result;
	}

	[Conditional("ENABLE_UNITY_COLLECTIONS_CHECKS")]
	internal void Validate()
	{
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

	public static bool operator ==(ScriptableRenderContext left, ScriptableRenderContext right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(ScriptableRenderContext left, ScriptableRenderContext right)
	{
		return !left.Equals(right);
	}

	public unsafe RendererList CreateRendererList(RendererListDesc desc)
	{
		RendererListParams rendererListParams = RendererListParams.Create(in desc);
		if (!rendererListParams.stateBlock.HasValue)
		{
			return CreateRendererList_Internal(rendererListParams.cullingResult.ptr, ref rendererListParams.drawSettings, ref rendererListParams.filteringSettings, ShaderTagId.none, isPassTagName: false, IntPtr.Zero, IntPtr.Zero, 0);
		}
		ShaderTagId shaderTagId = default(ShaderTagId);
		RenderStateBlock value = rendererListParams.stateBlock.Value;
		RenderStateBlock* ptr = &value;
		return CreateRendererList_Internal(rendererListParams.cullingResult.ptr, ref rendererListParams.drawSettings, ref rendererListParams.filteringSettings, ShaderTagId.none, isPassTagName: false, (IntPtr)(&shaderTagId), (IntPtr)ptr, 1);
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
	private static extern bool SubmitForRenderPassValidation_Internal_Injected(ref ScriptableRenderContext _unity_self);

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
	private static extern void StereoEndRender_Internal_Injected(ref ScriptableRenderContext _unity_self, Camera camera, int eye, bool isFinalPass);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void StartMultiEye_Internal_Injected(ref ScriptableRenderContext _unity_self, Camera camera, int eye);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void StopMultiEye_Internal_Injected(ref ScriptableRenderContext _unity_self, Camera camera);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DrawSkybox_Internal_Injected(ref ScriptableRenderContext _unity_self, Camera camera);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void InvokeOnRenderObjectCallback_Internal_Injected(ref ScriptableRenderContext _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DrawGizmos_Internal_Injected(ref ScriptableRenderContext _unity_self, Camera camera, GizmoSubset gizmoSubset);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DrawWireOverlay_Impl_Injected(ref ScriptableRenderContext _unity_self, Camera camera);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DrawUIOverlay_Internal_Injected(ref ScriptableRenderContext _unity_self, Camera camera);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void CreateRendererList_Internal_Injected(ref ScriptableRenderContext _unity_self, IntPtr cullResults, ref DrawingSettings drawingSettings, ref FilteringSettings filteringSettings, ref ShaderTagId tagName, bool isPassTagName, IntPtr tagValues, IntPtr stateBlocks, int stateCount, out RendererList ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void PrepareRendererListsAsync_Internal_Injected(ref ScriptableRenderContext _unity_self, object rendererLists);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern RendererListStatus QueryRendererListStatus_Internal_Injected(ref ScriptableRenderContext _unity_self, ref RendererList handle);
}
