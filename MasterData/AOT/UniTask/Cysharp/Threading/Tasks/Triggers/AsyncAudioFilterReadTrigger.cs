using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncAudioFilterReadTrigger : AsyncTriggerBase<(float[] data, int channels)>
{
	private void OnAudioFilterRead(float[] data, int channels)
	{
		RaiseEvent((data, channels));
	}

	public IAsyncOnAudioFilterReadHandler GetOnAudioFilterReadAsyncHandler()
	{
		return new AsyncTriggerHandler<(float[], int)>(this, callOnce: false);
	}

	public IAsyncOnAudioFilterReadHandler GetOnAudioFilterReadAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<(float[], int)>(this, cancellationToken, callOnce: false);
	}

	public UniTask<(float[] data, int channels)> OnAudioFilterReadAsync()
	{
		return ((IAsyncOnAudioFilterReadHandler)new AsyncTriggerHandler<(float[], int)>(this, callOnce: true)).OnAudioFilterReadAsync();
	}

	public UniTask<(float[] data, int channels)> OnAudioFilterReadAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnAudioFilterReadHandler)new AsyncTriggerHandler<(float[], int)>(this, cancellationToken, callOnce: true)).OnAudioFilterReadAsync();
	}
}
