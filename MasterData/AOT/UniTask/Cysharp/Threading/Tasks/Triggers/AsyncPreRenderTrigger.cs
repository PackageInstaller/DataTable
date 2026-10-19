using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncPreRenderTrigger : AsyncTriggerBase<AsyncUnit>
{
	private void OnPreRender()
	{
		RaiseEvent(AsyncUnit.Default);
	}

	public IAsyncOnPreRenderHandler GetOnPreRenderAsyncHandler()
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, callOnce: false);
	}

	public IAsyncOnPreRenderHandler GetOnPreRenderAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: false);
	}

	public UniTask OnPreRenderAsync()
	{
		return ((IAsyncOnPreRenderHandler)new AsyncTriggerHandler<AsyncUnit>(this, callOnce: true)).OnPreRenderAsync();
	}

	public UniTask OnPreRenderAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnPreRenderHandler)new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: true)).OnPreRenderAsync();
	}
}
