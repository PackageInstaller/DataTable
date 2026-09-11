using UnityEngine;

public static class CustomLog
{
	public static OnVoidHandler<string> overrideSetUserID;

	public static OnVoidHandler<int> overrideSetSceneID;

	public static OnVoidHandler<object, object> overrideSetSceneData;

	public static OnVoidHandler<object> overrideLog;

	public static OnVoidHandler<object> overrideLogWarning;

	public static OnVoidHandler<object> overrideLogError;

	public static void SetUserID(string log)
	{
		if (overrideSetUserID != null)
		{
			overrideSetUserID(log);
		}
		else
		{
			Debug.Log(log);
		}
	}

	public static void SetSceneID(int log)
	{
		if (overrideSetSceneID != null)
		{
			overrideSetSceneID(log);
		}
		else
		{
			Debug.Log(log);
		}
	}

	public static void SetSceneData(object key, object value)
	{
		if (overrideSetSceneData != null)
		{
			overrideSetSceneData(key, value);
		}
		else
		{
			Debug.Log(key?.ToString() + ":" + value);
		}
	}

	public static void Log(object log)
	{
		if (overrideLog != null)
		{
			overrideLog(log);
		}
		else
		{
			Debug.Log(log);
		}
	}

	public static void LogError(object log)
	{
		if (overrideLogError != null)
		{
			overrideLogError(log);
		}
		else
		{
			Debug.LogError(log);
		}
	}

	public static void LogWarning(object log)
	{
		if (overrideLogWarning != null)
		{
			overrideLogWarning(log);
		}
		Debug.LogWarning(log);
	}
}
