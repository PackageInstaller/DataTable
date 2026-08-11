using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncRenderImageTrigger : AsyncTriggerBase<(RenderTexture source, RenderTexture destination)>
{
	private void OnRenderImage(RenderTexture source, RenderTexture destination)
	{
		RaiseEvent((source, destination));
	}

	public IAsyncOnRenderImageHandler GetOnRenderImageAsyncHandler()
	{
		return new AsyncTriggerHandler<(RenderTexture, RenderTexture)>(this, callOnce: false);
	}

	public IAsyncOnRenderImageHandler GetOnRenderImageAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<(RenderTexture, RenderTexture)>(this, cancellationToken, callOnce: false);
	}

	public UniTask<(RenderTexture source, RenderTexture destination)> OnRenderImageAsync()
	{
		return ((IAsyncOnRenderImageHandler)new AsyncTriggerHandler<(RenderTexture, RenderTexture)>(this, callOnce: true)).OnRenderImageAsync();
	}

	public UniTask<(RenderTexture source, RenderTexture destination)> OnRenderImageAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnRenderImageHandler)new AsyncTriggerHandler<(RenderTexture, RenderTexture)>(this, cancellationToken, callOnce: true)).OnRenderImageAsync();
	}
}
