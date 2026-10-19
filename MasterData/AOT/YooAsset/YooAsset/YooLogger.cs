using System;
using System.Diagnostics;
using UnityEngine;

namespace YooAsset;

internal static class YooLogger
{
	public static ILogger Logger;

	[Conditional("DEBUG")]
	public static void Log(string info)
	{
		if (Logger != null)
		{
			Logger.Log(info);
		}
		else
		{
			Debug.Log(info);
		}
	}

	public static void Warning(string info)
	{
		if (Logger != null)
		{
			Logger.Warning(info);
		}
		else
		{
			Debug.LogWarning(info);
		}
	}

	public static void Error(string info)
	{
		if (Logger != null)
		{
			Logger.Error(info);
		}
		else
		{
			Debug.LogError(info);
		}
	}

	public static void Exception(Exception exception)
	{
		if (Logger != null)
		{
			Logger.Exception(exception);
		}
		else
		{
			Debug.LogException(exception);
		}
	}
}
