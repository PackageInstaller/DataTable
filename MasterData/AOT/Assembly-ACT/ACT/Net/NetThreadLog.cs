using System.Collections.Concurrent;
using UnityEngine;

namespace ACT.Net;

internal static class NetThreadLog
{
	private static readonly ConcurrentQueue<(string message, LogType type)> Pending = new ConcurrentQueue<(string, LogType)>();

	public static void Enqueue(string message, LogType type = LogType.Log)
	{
		if (LuminApplication.LogEnabled || type == LogType.Error || type == LogType.Exception)
		{
			Pending.Enqueue((message, type));
		}
	}

	public static void Flush()
	{
		(string, LogType) result;
		while (Pending.TryDequeue(out result))
		{
			switch (result.Item2)
			{
			case LogType.Warning:
				Debug.LogWarning(result.Item1);
				break;
			case LogType.Error:
			case LogType.Exception:
				Debug.LogError(result.Item1);
				break;
			default:
				Debug.Log(result.Item1);
				break;
			}
		}
	}
}
