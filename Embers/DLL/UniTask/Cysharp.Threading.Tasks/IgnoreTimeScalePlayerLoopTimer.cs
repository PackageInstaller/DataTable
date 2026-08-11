using System;
using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks;

internal sealed class IgnoreTimeScalePlayerLoopTimer : PlayerLoopTimer
{
	private int initialFrame;

	private float elapsed;

	private float interval;

	public IgnoreTimeScalePlayerLoopTimer(TimeSpan interval, bool periodic, PlayerLoopTiming playerLoopTiming, CancellationToken cancellationToken, Action<object> timerCallback, object state)
		: base(periodic, playerLoopTiming, cancellationToken, timerCallback, state)
	{
		ResetCore(interval);
	}

	protected override bool MoveNextCore()
	{
		if (elapsed == 0f && initialFrame == Time.frameCount)
		{
			return true;
		}
		elapsed += Time.unscaledDeltaTime;
		if (elapsed >= interval)
		{
			return false;
		}
		return true;
	}

	protected override void ResetCore(TimeSpan? interval)
	{
		elapsed = 0f;
		initialFrame = (PlayerLoopHelper.IsMainThread ? Time.frameCount : (-1));
		if (interval.HasValue)
		{
			this.interval = (float)interval.Value.TotalSeconds;
		}
	}
}
