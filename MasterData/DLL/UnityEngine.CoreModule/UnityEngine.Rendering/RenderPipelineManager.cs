using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

public static class RenderPipelineManager
{
	internal static RenderPipelineAsset s_CurrentPipelineAsset;

	private static List<Camera> s_Cameras = new List<Camera>();

	private static string s_CurrentPipelineType = "Built-in Pipeline";

	private static RenderPipeline s_CurrentPipeline = null;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private static Action<ScriptableRenderContext, Camera> endCameraRendering;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private static Action activeRenderPipelineTypeChanged;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private static Action<RenderPipelineAsset, RenderPipelineAsset> activeRenderPipelineAssetChanged;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private static Action activeRenderPipelineCreated;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private static Action activeRenderPipelineDisposed;

	public static RenderPipeline currentPipeline
	{
		get
		{
			return s_CurrentPipeline;
		}
		private set
		{
			s_CurrentPipelineType = ((value != null) ? value.GetType().ToString() : "Built-in Pipeline");
			s_CurrentPipeline = value;
		}
	}

	public static event Action<ScriptableRenderContext, Camera> beginCameraRendering;

	internal static void BeginCameraRendering(ScriptableRenderContext context, Camera camera)
	{
		beginCameraRendering?.Invoke(context, camera);
	}

	internal static void EndCameraRendering(ScriptableRenderContext context, Camera camera)
	{
		endCameraRendering?.Invoke(context, camera);
	}

	[RequiredByNativeCode]
	internal static void OnActiveRenderPipelineTypeChanged()
	{
		activeRenderPipelineTypeChanged?.Invoke();
	}

	[RequiredByNativeCode]
	internal static void OnActiveRenderPipelineAssetChanged(ScriptableObject from, ScriptableObject to)
	{
		activeRenderPipelineAssetChanged?.Invoke(from as RenderPipelineAsset, to as RenderPipelineAsset);
	}

	[RequiredByNativeCode]
	internal static void HandleRenderPipelineChange(RenderPipelineAsset pipelineAsset)
	{
		if ((object)s_CurrentPipelineAsset != pipelineAsset)
		{
			CleanupRenderPipeline();
			s_CurrentPipelineAsset = pipelineAsset;
		}
	}

	[RequiredByNativeCode]
	internal static void CleanupRenderPipeline()
	{
		if (currentPipeline != null && !currentPipeline.disposed)
		{
			activeRenderPipelineDisposed?.Invoke();
			currentPipeline.Dispose();
			s_CurrentPipelineAsset = null;
			currentPipeline = null;
			SupportedRenderingFeatures.active = new SupportedRenderingFeatures();
		}
	}

	[RequiredByNativeCode]
	private static string GetCurrentPipelineAssetType()
	{
		return s_CurrentPipelineType;
	}

	[RequiredByNativeCode]
	private static void DoRenderLoop_Internal(RenderPipelineAsset pipe, IntPtr loopPtr, Object renderRequest)
	{
		PrepareRenderPipeline(pipe);
		if (currentPipeline != null)
		{
			ScriptableRenderContext context = new ScriptableRenderContext(loopPtr);
			s_Cameras.Clear();
			context.GetCameras(s_Cameras);
			if (renderRequest == null)
			{
				currentPipeline.InternalRender(context, s_Cameras);
			}
			else
			{
				currentPipeline.InternalProcessRenderRequests(context, s_Cameras[0], renderRequest);
			}
			s_Cameras.Clear();
		}
	}

	internal static void PrepareRenderPipeline(RenderPipelineAsset pipelineAsset)
	{
		HandleRenderPipelineChange(pipelineAsset);
		if (IsPipelineRequireCreation())
		{
			currentPipeline = s_CurrentPipelineAsset.InternalCreatePipeline();
			activeRenderPipelineCreated?.Invoke();
		}
	}

	private static bool IsPipelineRequireCreation()
	{
		return s_CurrentPipelineAsset != null && (currentPipeline == null || currentPipeline.disposed);
	}
}
