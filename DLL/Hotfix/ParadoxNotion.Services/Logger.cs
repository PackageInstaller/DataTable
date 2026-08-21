using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using UnityEngine;

namespace ParadoxNotion.Services;

public static class Logger
{
	public struct Message
	{
		private WeakReference<object> _contextRef;

		public LogType type;

		public string text;

		public string tag;

		public object context
		{
			get
			{
				object target = null;
				if (_contextRef != null)
				{
					_contextRef.TryGetTarget(out target);
				}
				return target;
			}
			set
			{
				_contextRef = new WeakReference<object>(value);
			}
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

	[Conditional("ENABLE_LOG")]
	public static void Log(object message, string tag = null, object context = null)
	{
		Internal_Log(LogType.Log, message, tag, context);
	}

	[Conditional("ENABLE_LOG")]
	public static void LogWarning(object message, string tag = null, object context = null)
	{
		Internal_Log(LogType.Warning, message, tag, context);
	}

	[Conditional("ENABLE_LOG")]
	public static void LogError(object message, string tag = null, object context = null)
	{
		Internal_Log(LogType.Error, message, tag, context);
	}

	[Conditional("ENABLE_LOG")]
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
		tag = (string.IsNullOrEmpty(tag) ? $"<b>({type.ToString()})</b>" : $"<b>({tag} {type.ToString()})</b>");
	}

	[Conditional("ENABLE_LOG")]
	private static void ForwardToUnity(LogType type, object message, string tag, object context)
	{
		if (message is Exception)
		{
			UnityEngine.Debug.unityLogger.LogException((Exception)message);
		}
		else
		{
			UnityEngine.Debug.unityLogger.Log(type, tag, message, context as UnityEngine.Object);
		}
	}
}
