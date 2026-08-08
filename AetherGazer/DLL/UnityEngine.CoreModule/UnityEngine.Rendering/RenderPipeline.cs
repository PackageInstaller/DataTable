using System;
using System.Collections.Generic;

namespace UnityEngine.Rendering;

public abstract class RenderPipeline
{
	public bool disposed { get; private set; }

	protected abstract void Render(ScriptableRenderContext context, Camera[] cameras);

	protected virtual void ProcessRenderRequests<RequestData>(ScriptableRenderContext context, Camera camera, RequestData renderRequest)
	{
	}

	protected internal virtual bool IsRenderRequestSupported<RequestData>(Camera camera, RequestData data)
	{
		return false;
	}

	protected static void BeginCameraRendering(ScriptableRenderContext context, Camera camera)
	{
		RenderPipelineManager.BeginCameraRendering(context, camera);
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

	internal void InternalProcessRenderRequests<RequestData>(ScriptableRenderContext context, Camera camera, RequestData renderRequest)
	{
		if (disposed)
		{
			throw new ObjectDisposedException($"{this} has been disposed. Do not call Render on disposed a RenderPipeline.");
		}
		ProcessRenderRequests(context, camera, renderRequest);
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
