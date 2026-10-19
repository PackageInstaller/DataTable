using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncJointBreak2DTrigger : AsyncTriggerBase<Joint2D>
{
	private void OnJointBreak2D(Joint2D brokenJoint)
	{
		RaiseEvent(brokenJoint);
	}

	public IAsyncOnJointBreak2DHandler GetOnJointBreak2DAsyncHandler()
	{
		return new AsyncTriggerHandler<Joint2D>(this, callOnce: false);
	}

	public IAsyncOnJointBreak2DHandler GetOnJointBreak2DAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<Joint2D>(this, cancellationToken, callOnce: false);
	}

	public UniTask<Joint2D> OnJointBreak2DAsync()
	{
		return ((IAsyncOnJointBreak2DHandler)new AsyncTriggerHandler<Joint2D>(this, callOnce: true)).OnJointBreak2DAsync();
	}

	public UniTask<Joint2D> OnJointBreak2DAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnJointBreak2DHandler)new AsyncTriggerHandler<Joint2D>(this, cancellationToken, callOnce: true)).OnJointBreak2DAsync();
	}
}
