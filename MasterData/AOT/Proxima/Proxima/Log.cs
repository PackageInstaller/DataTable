using System;
using System.Diagnostics;
using UnityEngine;

namespace Proxima;

internal class Log
{
	[Conditional("PROXIMA_LOG_VERBOSE")]
	public static void Verbose(string message)
	{
		Debug.Log("PXV: " + message);
	}

	public static void Info(string message)
	{
		Debug.Log("PX: " + message);
	}

	public static void Warning(string message)
	{
		Debug.LogWarning("PX: " + message);
	}

	public static void Error(string message)
	{
		Debug.LogError("PX: " + message);
	}

	public static void Exception(Exception e)
	{
		Debug.LogException(e);
	}
}
