using System.Diagnostics;

namespace Unity.VisualScripting.Community;

[UnitTitle("StopWatch")]
[TypeIcon(typeof(Timer))]
[UnitCategory("Community/Time")]
public class StopwatchUnit : Unit
{
	private Stopwatch stopwatch;

	[DoNotSerialize]
	public ControlInput start;

	[DoNotSerialize]
	public ControlInput stop;

	[DoNotSerialize]
	public ControlOutput started;

	[DoNotSerialize]
	public ControlOutput stopped;

	[DoNotSerialize]
	public ValueOutput elapsedSeconds;

	[DoNotSerialize]
	public ValueOutput isRunning;

	protected override void Definition()
	{
		started = ControlOutput("Started");
		stopped = ControlOutput("Stopped");
		start = ControlInput("Start", StartStopwatch);
		stop = ControlInput("Stop", StopStopwatch);
		elapsedSeconds = ValueOutput("elapsedSeconds", GetElapsedSeconds);
		isRunning = ValueOutput("isRunning", IsRunning);
	}

	private ControlOutput StartStopwatch(Flow flow)
	{
		stopwatch = new Stopwatch();
		stopwatch.Start();
		return started;
	}

	private ControlOutput StopStopwatch(Flow flow)
	{
		if (stopwatch != null)
		{
			stopwatch.Stop();
		}
		return stopped;
	}

	private float GetElapsedSeconds(Flow flow)
	{
		if (stopwatch == null)
		{
			return 0f;
		}
		return (float)stopwatch.Elapsed.TotalSeconds;
	}

	private bool IsRunning(Flow flow)
	{
		if (stopwatch != null)
		{
			return stopwatch.IsRunning;
		}
		return false;
	}
}
