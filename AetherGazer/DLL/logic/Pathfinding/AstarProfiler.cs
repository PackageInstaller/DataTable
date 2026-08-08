using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using UnityEngine;

namespace Pathfinding;

public class AstarProfiler
{
	public class ProfilePoint
	{
		public Stopwatch watch = new Stopwatch();

		public int totalCalls;

		public long tmpBytes;

		public long totalBytes;
	}

	private static readonly Dictionary<string, ProfilePoint> profiles = new Dictionary<string, ProfilePoint>();

	private static DateTime startTime = DateTime.UtcNow;

	public static ProfilePoint[] fastProfiles;

	public static string[] fastProfileNames;

	private AstarProfiler()
	{
	}

	[Conditional("ProfileAstar")]
	public static void InitializeFastProfile(string[] profileNames)
	{
		fastProfileNames = new string[profileNames.Length + 2];
		Array.Copy(profileNames, fastProfileNames, profileNames.Length);
		fastProfileNames[fastProfileNames.Length - 2] = "__Control1__";
		fastProfileNames[fastProfileNames.Length - 1] = "__Control2__";
		fastProfiles = new ProfilePoint[fastProfileNames.Length];
		for (int i = 0; i < fastProfiles.Length; i++)
		{
			fastProfiles[i] = new ProfilePoint();
		}
	}

	[Conditional("ProfileAstar")]
	public static void StartFastProfile(int tag)
	{
		fastProfiles[tag].watch.Start();
	}

	[Conditional("ProfileAstar")]
	public static void EndFastProfile(int tag)
	{
		ProfilePoint profilePoint = fastProfiles[tag];
		profilePoint.totalCalls++;
		profilePoint.watch.Stop();
	}

	[Conditional("ASTAR_UNITY_PRO_PROFILER")]
	public static void EndProfile()
	{
	}

	[Conditional("ProfileAstar")]
	public static void StartProfile(string tag)
	{
		profiles.TryGetValue(tag, out var value);
		if (value == null)
		{
			value = new ProfilePoint();
			profiles[tag] = value;
		}
		value.tmpBytes = GC.GetTotalMemory(forceFullCollection: false);
		value.watch.Start();
	}

	[Conditional("ProfileAstar")]
	public static void EndProfile(string tag)
	{
		if (!profiles.ContainsKey(tag))
		{
			Debug.LogError((object)("Can only end profiling for a tag which has already been started (tag was " + tag + ")"));
			return;
		}
		ProfilePoint profilePoint = profiles[tag];
		profilePoint.totalCalls++;
		profilePoint.watch.Stop();
		profilePoint.totalBytes += GC.GetTotalMemory(forceFullCollection: false) - profilePoint.tmpBytes;
	}

	[Conditional("ProfileAstar")]
	public static void Reset()
	{
		profiles.Clear();
		startTime = DateTime.UtcNow;
		if (fastProfiles != null)
		{
			for (int i = 0; i < fastProfiles.Length; i++)
			{
				fastProfiles[i] = new ProfilePoint();
			}
		}
	}

	[Conditional("ProfileAstar")]
	public static void PrintFastResults()
	{
		if (fastProfiles == null)
		{
			return;
		}
		for (int i = 0; i < 1000; i++)
		{
		}
		double num = fastProfiles[fastProfiles.Length - 2].watch.Elapsed.TotalMilliseconds / 1000.0;
		TimeSpan timeSpan = DateTime.UtcNow - startTime;
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append("============================\n\t\t\t\tProfile results:\n============================\n");
		stringBuilder.Append("Name\t\t|\tTotal Time\t|\tTotal Calls\t|\tAvg/Call\t|\tBytes");
		for (int j = 0; j < fastProfiles.Length; j++)
		{
			string text = fastProfileNames[j];
			ProfilePoint profilePoint = fastProfiles[j];
			int totalCalls = profilePoint.totalCalls;
			double num2 = profilePoint.watch.Elapsed.TotalMilliseconds - num * (double)totalCalls;
			if (totalCalls >= 1)
			{
				stringBuilder.Append("\n").Append(text.PadLeft(10)).Append("|   ");
				stringBuilder.Append(num2.ToString("0.0 ").PadLeft(10)).Append(profilePoint.watch.Elapsed.TotalMilliseconds.ToString("(0.0)").PadLeft(10)).Append("|   ");
				stringBuilder.Append(totalCalls.ToString().PadLeft(10)).Append("|   ");
				stringBuilder.Append((num2 / (double)totalCalls).ToString("0.000").PadLeft(10));
			}
		}
		stringBuilder.Append("\n\n============================\n\t\tTotal runtime: ");
		stringBuilder.Append(timeSpan.TotalSeconds.ToString("F3"));
		stringBuilder.Append(" seconds\n============================");
		Debug.Log((object)stringBuilder.ToString());
	}

	[Conditional("ProfileAstar")]
	public static void PrintResults()
	{
		TimeSpan timeSpan = DateTime.UtcNow - startTime;
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append("============================\n\t\t\t\tProfile results:\n============================\n");
		int num = 5;
		foreach (KeyValuePair<string, ProfilePoint> profile in profiles)
		{
			num = Math.Max(profile.Key.Length, num);
		}
		stringBuilder.Append(" Name ".PadRight(num)).Append("|").Append(" Total Time\t".PadRight(20))
			.Append("|")
			.Append(" Total Calls ".PadRight(20))
			.Append("|")
			.Append(" Avg/Call ".PadRight(20));
		foreach (KeyValuePair<string, ProfilePoint> profile2 in profiles)
		{
			double totalMilliseconds = profile2.Value.watch.Elapsed.TotalMilliseconds;
			int totalCalls = profile2.Value.totalCalls;
			if (totalCalls >= 1)
			{
				string key = profile2.Key;
				stringBuilder.Append("\n").Append(key.PadRight(num)).Append("| ");
				stringBuilder.Append(totalMilliseconds.ToString("0.0").PadRight(20)).Append("| ");
				stringBuilder.Append(totalCalls.ToString().PadRight(20)).Append("| ");
				stringBuilder.Append((totalMilliseconds / (double)totalCalls).ToString("0.000").PadRight(20));
				stringBuilder.Append(AstarMath.FormatBytesBinary((int)profile2.Value.totalBytes).PadLeft(10));
			}
		}
		stringBuilder.Append("\n\n============================\n\t\tTotal runtime: ");
		stringBuilder.Append(timeSpan.TotalSeconds.ToString("F3"));
		stringBuilder.Append(" seconds\n============================");
		Debug.Log((object)stringBuilder.ToString());
	}
}
