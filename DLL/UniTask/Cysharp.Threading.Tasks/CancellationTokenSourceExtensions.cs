using System;
using System.Threading;
using Cysharp.Threading.Tasks.Triggers;
using UnityEngine;

namespace Cysharp.Threading.Tasks;

public static class CancellationTokenSourceExtensions
{
	private static readonly Action<object> CancelCancellationTokenSourceStateDelegate = CancelCancellationTokenSourceState;

	private static void CancelCancellationTokenSourceState(object state)
	{
		((CancellationTokenSource)state).Cancel();
	}

	public static IDisposable CancelAfterSlim(this CancellationTokenSource cts, int millisecondsDelay, DelayType delayType = DelayType.DeltaTime, PlayerLoopTiming delayTiming = PlayerLoopTiming.Update)
	{
		return cts.CancelAfterSlim(TimeSpan.FromMilliseconds(millisecondsDelay), delayType, delayTiming);
	}

	public static IDisposable CancelAfterSlim(this CancellationTokenSource cts, TimeSpan delayTimeSpan, DelayType delayType = DelayType.DeltaTime, PlayerLoopTiming delayTiming = PlayerLoopTiming.Update)
	{
		return PlayerLoopTimer.StartNew(delayTimeSpan, periodic: false, delayType, delayTiming, cts.Token, CancelCancellationTokenSourceStateDelegate, cts);
	}

	public static void RegisterRaiseCancelOnDestroy(this CancellationTokenSource cts, Component component)
	{
		cts.RegisterRaiseCancelOnDestroy(component.gameObject);
	}

	public static void RegisterRaiseCancelOnDestroy(this CancellationTokenSource cts, GameObject gameObject)
	{
		gameObject.GetAsyncDestroyTrigger().CancellationToken.RegisterWithoutCaptureExecutionContext(CancelCancellationTokenSourceStateDelegate, cts);
	}
}
