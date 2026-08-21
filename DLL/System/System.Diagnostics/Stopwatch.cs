using System.Runtime.CompilerServices;

namespace System.Diagnostics;

public class Stopwatch
{
	public static readonly long Frequency = 10000000L;

	public static readonly bool IsHighResolution = true;

	private long elapsed;

	private long started;

	private bool is_running;

	public TimeSpan Elapsed
	{
		get
		{
			if (IsHighResolution)
			{
				return TimeSpan.FromTicks(ElapsedTicks / (Frequency / 10000000));
			}
			return TimeSpan.FromTicks(ElapsedTicks);
		}
	}

	public long ElapsedMilliseconds
	{
		get
		{
			if (IsHighResolution)
			{
				return ElapsedTicks / (Frequency / 1000);
			}
			return checked((long)Elapsed.TotalMilliseconds);
		}
	}

	public long ElapsedTicks
	{
		get
		{
			if (!is_running)
			{
				return elapsed;
			}
			return GetTimestamp() - started + elapsed;
		}
	}

	[MethodImpl(MethodImplOptions.InternalCall)]
	public static extern long GetTimestamp();

	public static Stopwatch StartNew()
	{
		Stopwatch stopwatch = new Stopwatch();
		stopwatch.Start();
		return stopwatch;
	}

	public void Start()
	{
		if (!is_running)
		{
			started = GetTimestamp();
			is_running = true;
		}
	}
}
