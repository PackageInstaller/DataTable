using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace ParadoxNotion.Services;

public static class Logger
{
	public struct Message
	{
		public LogType type;

		public string text;

		public string tag;

		public object context;

		public bool IsSameAs(Message b)
		{
			if (type == b.type && text == b.text && tag == b.tag)
			{
				return context == b.context;
			}
			return false;
		}

		public bool IsValid()
		{
			return !string.IsNullOrEmpty(text);
		}
	}

	public delegate bool LogHandler(Message message);

	private static List<LogHandler> subscribers = new List<LogHandler>();

	public static void AddListener(LogHandler callback)
	{
		subscribers.Add(callback);
	}

	public static void RemoveListener(LogHandler callback)
	{
		subscribers.Remove(callback);
	}

	public static void Log(object message, string tag = null, object context = null)
	{
		Internal_Log(LogType.Log, message, tag, context);
	}

	public static void LogWarning(object message, string tag = null, object context = null)
	{
		Internal_Log(LogType.Warning, message, tag, context);
	}

	public static void LogError(object message, string tag = null, object context = null)
	{
		Internal_Log(LogType.Error, message, tag, context);
	}

	public static void LogException(Exception exception, string tag = null, object context = null)
	{
		Internal_Log(LogType.Exception, exception, tag, context);
	}

	private static void Internal_Log(LogType type, object message, string tag, object context)
	{
		if (subscribers != null && subscribers.Count > 0)
		{
			Message message2 = new Message
			{
				type = type
			};
			if (message is Exception)
			{
				Exception ex = (Exception)message;
				message2.text = ex.Message + "\n" + ex.StackTrace.Split('\n').FirstOrDefault();
			}
			else
			{
				message2.text = ((message != null) ? message.ToString() : "NULL");
			}
			message2.tag = tag;
			message2.context = context;
			bool flag = false;
			foreach (LogHandler subscriber in subscribers)
			{
				if (subscriber(message2))
				{
					flag = true;
					break;
				}
			}
			if (flag && type != LogType.Exception)
			{
				return;
			}
		}
		tag = $"<b>({tag} {type.ToString()})</b>";
		ForwardToUnity(type, message, tag, context);
	}

	private static void ForwardToUnity(LogType type, object message, string tag, object context)
	{
		if (message is Exception)
		{
			Debug.unityLogger.LogException((Exception)message);
		}
	}
}
