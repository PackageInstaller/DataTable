using System;
using System.Collections.Generic;

namespace UnityEngine.Rendering;

public abstract class RenderPipeline
{
	public bool disposed { get; private set; }

	public virtual RenderPipelineGlobalSettings defaultSettings => null;

	protected abstract void Render(ScriptableRenderContext context, Camera[] cameras);

	protected virtual void ProcessRenderRequests(ScriptableRenderContext context, Camera camera, List<Camera.RenderRequest> renderRequests)
	{
	}

	protected static void BeginContextRendering(ScriptableRenderContext context, List<Camera> cameras)
	{
		RenderPipelineManager.BeginContextRendering(context, cameras);
	}

	protected static void BeginCameraRendering(ScriptableRenderContext context, Camera camera)
	{
		RenderPipelineManager.BeginCameraRendering(context, camera);
	}

	protected static void EndContextRendering(ScriptableRenderContext context, List<Camera> cameras)
	{
		RenderPipelineManager.EndContextRendering(context, cameras);
	}

	protected static void EndCameraRendering(ScriptableRenderContext context, Camera camera)
	{
		RenderPipelineManager.EndCameraRendering(context, camera);
	}

	protected virtual void Render(ScriptableRenderContext context, List<Camera> cameras)
	{
		Render(context, cameras.ToArray());
	}

	internal void InternalRender(ScriptableRenderContext context, List<Camera> cameras)
	{
		if (disposed)
		{
			throw new ObjectDisposedException($"{this} has been disposed. Do not call Render on disposed a RenderPipeline.");
		}
		Render(context, cameras);
	}

	internal void InternalRenderWithRequests(ScriptableRenderContext context, List<Camera> cameras, List<Camera.RenderRequest> renderRequests)
	{
		if (disposed)
		{
			throw new ObjectDisposedException($"{this} has been disposed. Do not call Render on disposed a RenderPipeline.");
		}
		ProcessRenderRequests(context, (cameras == null || cameras.Count == 0) ? null : cameras[0], renderRequests);
	}

	internal void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
		disposed = true;
	}

	protected virtual void Dispose(bool disposing)
	{
	}
}
