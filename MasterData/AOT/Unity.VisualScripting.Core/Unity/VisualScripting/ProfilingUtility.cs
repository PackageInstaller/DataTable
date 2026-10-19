using System.Diagnostics;
using System.Threading;

namespace Unity.VisualScripting;

public static class ProfilingUtility
{
	private static readonly object @lock;

	public static ProfiledSegment rootSegment { get; private set; }

	public static ProfiledSegment currentSegment { get; set; }

	static ProfilingUtility()
	{
		@lock = new object();
		currentSegment = (rootSegment = new ProfiledSegment(null, "Root"));
	}

	[Conditional("ENABLE_PROFILER")]
	public static void Clear()
	{
		currentSegment = (rootSegment = new ProfiledSegment(null, "Root"));
	}

	public static ProfilingScope SampleBlock(string name)
	{
		return new ProfilingScope(name);
	}

	[Conditional("ENABLE_PROFILER")]
	public static void BeginSample(string name)
	{
		Monitor.Enter(@lock);
		if (!currentSegment.children.Contains(name))
		{
			currentSegment.children.Add(new ProfiledSegment(currentSegment, name));
		}
		currentSegment = currentSegment.children[name];
		currentSegment.calls++;
		currentSegment.stopwatch.Start();
		_ = UnityThread.allowsAPI;
	}

	[Conditional("ENABLE_PROFILER")]
	public static void EndSample()
	{
		currentSegment.stopwatch.Stop();
		if (currentSegment.parent != null)
		{
			currentSegment = currentSegment.parent;
		}
		_ = UnityThread.allowsAPI;
		Monitor.Exit(@lock);
	}
}
