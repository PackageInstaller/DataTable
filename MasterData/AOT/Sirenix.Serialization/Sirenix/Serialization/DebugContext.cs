using System;

namespace Sirenix.Serialization;

public sealed class DebugContext
{
	private readonly object LOCK = new object();

	private volatile ILogger logger;

	private volatile LoggingPolicy loggingPolicy;

	private volatile ErrorHandlingPolicy errorHandlingPolicy;

	public ILogger Logger
	{
		get
		{
			if (logger == null)
			{
				lock (LOCK)
				{
					if (logger == null)
					{
						logger = DefaultLoggers.UnityLogger;
					}
				}
			}
			return logger;
		}
		set
		{
			lock (LOCK)
			{
				logger = value;
			}
		}
	}

	public LoggingPolicy LoggingPolicy
	{
		get
		{
			return loggingPolicy;
		}
		set
		{
			loggingPolicy = value;
		}
	}

	public ErrorHandlingPolicy ErrorHandlingPolicy
	{
		get
		{
			return errorHandlingPolicy;
		}
		set
		{
			errorHandlingPolicy = value;
		}
	}

	public void LogWarning(string message)
	{
		if (errorHandlingPolicy == ErrorHandlingPolicy.ThrowOnWarningsAndErrors)
		{
			throw new SerializationAbortException("The following warning was logged during serialization or deserialization: " + (message ?? "EMPTY EXCEPTION MESSAGE"));
		}
		if (loggingPolicy == LoggingPolicy.LogWarningsAndErrors)
		{
			Logger.LogWarning(message);
		}
	}

	public void LogError(string message)
	{
		if (errorHandlingPolicy != ErrorHandlingPolicy.Resilient)
		{
			throw new SerializationAbortException("The following error was logged during serialization or deserialization: " + (message ?? "EMPTY EXCEPTION MESSAGE"));
		}
		if (loggingPolicy != LoggingPolicy.Silent)
		{
			Logger.LogError(message);
		}
	}

	public void LogException(Exception exception)
	{
		if (exception == null)
		{
			throw new ArgumentNullException("exception");
		}
		if (exception is SerializationAbortException)
		{
			throw exception;
		}
		if (errorHandlingPolicy != ErrorHandlingPolicy.Resilient)
		{
			throw new SerializationAbortException("An exception of type " + exception.GetType().Name + " occurred during serialization or deserialization.", exception);
		}
		if (loggingPolicy != LoggingPolicy.Silent)
		{
			Logger.LogException(exception);
		}
	}

	public void ResetToDefault()
	{
		lock (LOCK)
		{
			logger = null;
			loggingPolicy = LoggingPolicy.LogErrors;
			errorHandlingPolicy = ErrorHandlingPolicy.Resilient;
		}
	}
}
