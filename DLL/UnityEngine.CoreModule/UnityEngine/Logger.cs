using System;
using System.Globalization;

namespace UnityEngine;

public class Logger : ILogger, ILogHandler
{
	public ILogHandler logHandler { get; set; }

	public bool logEnabled { get; set; }

	public LogType filterLogType { get; set; }

	public Logger(ILogHandler logHandler)
	{
		this.logHandler = logHandler;
		logEnabled = true;
		filterLogType = LogType.Log;
	}

	public bool IsLogTypeAllowed(LogType logType)
	{
		if (logEnabled)
		{
			if (logType == LogType.Exception)
			{
				return true;
			}
			if (filterLogType != LogType.Exception)
			{
				return logType <= filterLogType;
			}
		}
		return false;
	}

	private static string GetString(object message)
	{
		if (message == null)
		{
			return "Null";
		}
		if (message is IFormattable formattable)
		{
			return formattable.ToString(null, CultureInfo.InvariantCulture);
		}
		return message.ToString();
	}

	public void Log(LogType logType, object message)
	{
		if (IsLogTypeAllowed(logType))
		{
			logHandler.LogFormat(logType, null, "{0}", GetString(message));
		}
	}

	public void Log(LogType logType, object message, Object context)
	{
		if (IsLogTypeAllowed(logType))
		{
			logHandler.LogFormat(logType, context, "{0}", GetString(message));
		}
	}

	public void Log(LogType logType, string tag, object message)
	{
		if (IsLogTypeAllowed(logType))
		{
			logHandler.LogFormat(logType, null, "{0}: {1}", tag, GetString(message));
		}
	}

	public void Log(LogType logType, string tag, object message, Object context)
	{
		if (IsLogTypeAllowed(logType))
		{
			logHandler.LogFormat(logType, context, "{0}: {1}", tag, GetString(message));
		}
	}

	public void Log(object message)
	{
		if (IsLogTypeAllowed(LogType.Log))
		{
			logHandler.LogFormat(LogType.Log, null, "{0}", GetString(message));
		}
	}

	public void Log(string tag, object message)
	{
		if (IsLogTypeAllowed(LogType.Log))
		{
			logHandler.LogFormat(LogType.Log, null, "{0}: {1}", tag, GetString(message));
		}
	}

	public void Log(string tag, object message, Object context)
	{
		if (IsLogTypeAllowed(LogType.Log))
		{
			logHandler.LogFormat(LogType.Log, context, "{0}: {1}", tag, GetString(message));
		}
	}

	public void LogWarning(string tag, object message)
	{
		if (IsLogTypeAllowed(LogType.Warning))
		{
			logHandler.LogFormat(LogType.Warning, null, "{0}: {1}", tag, GetString(message));
		}
	}

	public void LogWarning(string tag, object message, Object context)
	{
		if (IsLogTypeAllowed(LogType.Warning))
		{
			logHandler.LogFormat(LogType.Warning, context, "{0}: {1}", tag, GetString(message));
		}
	}

	public void LogError(string tag, object message)
	{
		if (IsLogTypeAllowed(LogType.Error))
		{
			logHandler.LogFormat(LogType.Error, null, "{0}: {1}", tag, GetString(message));
		}
	}

	public void LogError(string tag, object message, Object context)
	{
		if (IsLogTypeAllowed(LogType.Error))
		{
			logHandler.LogFormat(LogType.Error, context, "{0}: {1}", tag, GetString(message));
		}
	}

	public void LogException(Exception exception)
	{
		if (logEnabled)
		{
			logHandler.LogException(exception, null);
		}
	}

	public void LogException(Exception exception, Object context)
	{
		if (logEnabled)
		{
			logHandler.LogException(exception, context);
		}
	}

	public void LogFormat(LogType logType, string format, params object[] args)
	{
		if (IsLogTypeAllowed(logType))
		{
			logHandler.LogFormat(logType, null, format, args);
		}
	}

	public void LogFormat(LogType logType, Object context, string format, params object[] args)
	{
		if (IsLogTypeAllowed(logType))
		{
			logHandler.LogFormat(logType, context, format, args);
		}
	}
}
