using System;
using UnityEngine;

public static class SummerRaceRuntimeLog
{
	private static bool gameplayVerboseEnabled;

	public static bool IsGameplayVerboseEnabled => gameplayVerboseEnabled;

	public static void SetGameplayVerboseEnabled(bool enabled)
	{
		gameplayVerboseEnabled = enabled;
	}

	public static void Verbose(string message, UnityEngine.Object context = null)
	{
		if (gameplayVerboseEnabled && !string.IsNullOrEmpty(message))
		{
			if (context != null)
			{
				Debug.Log(message, context);
			}
			else
			{
				Debug.Log(message);
			}
		}
	}

	public static void Log(object message, UnityEngine.Object context = null)
	{
		if (gameplayVerboseEnabled)
		{
			if (context != null)
			{
				Debug.Log(message, context);
			}
			else
			{
				Debug.Log(message);
			}
		}
	}

	public static void Warning(object message, UnityEngine.Object context = null)
	{
		if (context != null)
		{
			Debug.LogWarning(message, context);
		}
		else
		{
			Debug.LogWarning(message);
		}
	}

	public static void Error(object message, UnityEngine.Object context = null)
	{
		if (context != null)
		{
			Debug.LogError(message, context);
		}
		else
		{
			Debug.LogError(message);
		}
	}

	public static void Exception(Exception exception, UnityEngine.Object context = null)
	{
		if (context != null)
		{
			Debug.LogException(exception, context);
		}
		else
		{
			Debug.LogException(exception);
		}
	}
}
