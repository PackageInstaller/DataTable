using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncPostRenderTrigger : AsyncTriggerBase<AsyncUnit>
{
	private void OnPostRender()
	{
		RaiseEvent(AsyncUnit.Default);
	}

	public IAsyncOnPostRenderHandler GetOnPostRenderAsyncHandler()
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, callOnce: false);
	}

	public IAsyncOnPostRenderHandler GetOnPostRenderAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: false);
	}

	public UniTask OnPostRenderAsync()
	{
		return ((IAsyncOnPostRenderHandler)new AsyncTriggerHandler<AsyncUnit>(this, callOnce: true)).OnPostRenderAsync();
	}

	public UniTask OnPostRenderAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnPostRenderHandler)new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: true)).OnPostRenderAsync();
	}
}
