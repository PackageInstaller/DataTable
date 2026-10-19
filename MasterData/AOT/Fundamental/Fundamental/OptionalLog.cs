using System.Diagnostics;
using UnityEngine;

namespace Fundamental;

public class OptionalLog
{
	[Conditional("UNITY_EDITOR")]
	public static void EditorLog(object message, string category = "", object context = null)
	{
		if (string.IsNullOrEmpty(category))
		{
			if (context == null)
			{
				Debug.Log(message);
			}
			else
			{
				Debug.Log(message, (Object)context);
			}
			return;
		}
		if (LogManager.IsLogEnabled(category))
		{
			Debug.Log(message.ToString());
		}
		LogCollector.AddInfo(category, message, context);
	}

	[Conditional("UNITY_EDITOR")]
	public static void EditorWarning(object message, string category = "", object context = null)
	{
		if (string.IsNullOrEmpty(category))
		{
			if (context == null)
			{
				Debug.LogWarning(message);
			}
			else
			{
				Debug.LogWarning(message, (Object)context);
			}
		}
		else
		{
			Debug.LogWarning(message.ToString());
			LogCollector.AddWarning(category, message, context);
		}
	}

	[Conditional("UNITY_EDITOR")]
	public static void EditorError(object message, string category = "", object context = null)
	{
		if (string.IsNullOrEmpty(category))
		{
			if (context == null)
			{
				Debug.LogError(message);
			}
			else
			{
				Debug.LogError(message, (Object)context);
			}
		}
		else
		{
			Debug.LogError(message.ToString());
			LogCollector.AddError(category, message, context);
		}
	}

	[Conditional("UNITY_EDITOR")]
	public static void EditorLogWithObjectPath(Transform obj, object message, string category, Object context = null)
	{
		string text = obj.name;
		while (obj.parent != null)
		{
			obj = obj.parent;
			text = obj.name + "/" + text;
		}
	}
}
