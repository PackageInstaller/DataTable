using System;
using System.Threading;
using Cysharp.Threading.Tasks.Internal;

namespace Cysharp.Threading.Tasks;

internal sealed class RealtimePlayerLoopTimer : PlayerLoopTimer
{
	private ValueStopwatch stopwatch;

	private long intervalTicks;

	public RealtimePlayerLoopTimer(TimeSpan interval, bool periodic, PlayerLoopTiming playerLoopTiming, CancellationToken cancellationToken, Action<object> timerCallback, object state)
		: base(periodic, playerLoopTiming, cancellationToken, timerCallback, state)
	{
		ResetCore(interval);
	}

	protected override bool MoveNextCore()
	{
		if (stopwatch.ElapsedTicks >= intervalTicks)
		{
			return false;
		}
		return true;
	}

	protected override void ResetCore(TimeSpan? interval)
	{
		stopwatch = ValueStopwatch.StartNew();
		if (interval.HasValue)
		{
			intervalTicks = interval.Value.Ticks;
		}
	}
}
