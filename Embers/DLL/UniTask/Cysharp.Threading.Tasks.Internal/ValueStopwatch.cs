using System;
using System.Diagnostics;

namespace Cysharp.Threading.Tasks.Internal;

internal readonly struct ValueStopwatch
{
	private static readonly double TimestampToTicks = 10000000.0 / (double)Stopwatch.Frequency;

	private readonly long startTimestamp;

	public TimeSpan Elapsed => TimeSpan.FromTicks(ElapsedTicks);

	public bool IsInvalid => startTimestamp == 0;

	public long ElapsedTicks
	{
		get
		{
			if (startTimestamp == 0L)
			{
				throw new InvalidOperationException("Detected invalid initialization(use 'default'), only to create from StartNew().");
			}
			return (long)((double)(Stopwatch.GetTimestamp() - startTimestamp) * TimestampToTicks);
		}
	}

	public static ValueStopwatch StartNew()
	{
		return new ValueStopwatch(Stopwatch.GetTimestamp());
	}

	private ValueStopwatch(long startTimestamp)
	{
		this.startTimestamp = startTimestamp;
	}
}
