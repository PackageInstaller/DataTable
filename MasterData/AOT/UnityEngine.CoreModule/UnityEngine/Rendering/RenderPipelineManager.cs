using System;
using System.Collections.Generic;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

public static class RenderPipelineManager
{
	internal static RenderPipelineAsset s_CurrentPipelineAsset;

	private static List<Camera> s_Cameras = new List<Camera>();

	private static string s_CurrentPipelineType = "Built-in Pipeline";

	private const string k_BuiltinPipelineName = "Built-in Pipeline";

	private static RenderPipeline s_CurrentPipeline = null;

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

	public static bool pipelineSwitchCompleted => (object)s_CurrentPipelineAsset == GraphicsSettings.currentRenderPipeline && !IsPipelineRequireCreation();

	public static event Action<ScriptableRenderContext, Camera[]> beginFrameRendering;

	public static event Action<ScriptableRenderContext, Camera[]> endFrameRendering;

	public static event Action<ScriptableRenderContext, List<Camera>> beginContextRendering;

	public static event Action<ScriptableRenderContext, List<Camera>> endContextRendering;

	public static event Action<ScriptableRenderContext, Camera> beginCameraRendering;

	public static event Action<ScriptableRenderContext, Camera> endCameraRendering;

	public static event Action activeRenderPipelineTypeChanged;

	public static event Action<RenderPipelineAsset, RenderPipelineAsset> activeRenderPipelineAssetChanged;

	public static event Action activeRenderPipelineCreated;

	public static event Action activeRenderPipelineDisposed;

	internal static void BeginContextRendering(ScriptableRenderContext context, List<Camera> cameras)
	{
		beginContextRendering?.Invoke(context, cameras);
		beginFrameRendering?.Invoke(context, cameras.ToArray());
	}

	internal static void BeginCameraRendering(ScriptableRenderContext context, Camera camera)
	{
		beginCameraRendering?.Invoke(context, camera);
	}

	internal static void EndContextRendering(ScriptableRenderContext context, List<Camera> cameras)
	{
		endFrameRendering?.Invoke(context, cameras.ToArray());
		endContextRendering?.Invoke(context, cameras);
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
