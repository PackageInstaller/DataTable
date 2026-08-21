using System;
using NLog;
using NLog.Config;

public class XLogger
{
	public const string CLIENT_LOGGER_NAME = "client";

	public const string SERVER_LOGGER_NAME = "server";

	public const string RUNTIME_LOGGER_NAME = "runtime";

	private static bool isInit;

	private static Logger _logger;

	public static Logger Nloger
	{
		get
		{
			if (!isInit)
			{
				return null;
			}
			if (_logger == null)
			{
				_logger = LogManager.LogFactory.GetCurrentClassLogger();
			}
			return _logger;
		}
	}

	public static void Debug(string message)
	{
		if (isInit)
		{
			Nloger.Debug(message);
		}
	}

	public static void Debug(Exception e)
	{
		if (isInit)
		{
			Nloger.Debug(e);
		}
	}

	public static void Debug<TArgument>(string message, TArgument argument)
	{
		if (isInit)
		{
			Nloger.Debug(message, argument);
		}
	}

	public static void Debug<TArgument1, TArgument2>(string message, TArgument1 argument1, TArgument2 argument2)
	{
		if (isInit)
		{
			Nloger.Debug(message, argument1, argument2);
		}
	}

	public static void Debug<TArgument1, TArgument2, TArgument3>(string message, TArgument1 argument1, TArgument2 argument2, TArgument3 argument3)
	{
		if (isInit)
		{
			Nloger.Debug(message, argument1, argument2, argument3);
		}
	}

	public static void Warn<TArgument>(string message, TArgument argument)
	{
		if (isInit)
		{
			Nloger.Warn(message, argument);
		}
	}

	public static void Warn(string message)
	{
		if (isInit)
		{
			Nloger.Warn(message);
		}
	}

	public static void Error(Exception e)
	{
		if (isInit)
		{
			Nloger.Error(e);
		}
	}

	public static void Error(string message)
	{
		if (isInit)
		{
			Nloger.Error(message);
		}
	}

	public static void Error<TArgument>(string message, TArgument argument)
	{
		if (isInit)
		{
			Nloger.Error(message, argument);
		}
	}

	public static void Error<TArgument1, TArgument2>(string message, TArgument1 argument1, TArgument2 argument2)
	{
		if (isInit)
		{
			Nloger.Error(message, argument1, argument2);
		}
	}

	public static void Initialize(string configPath)
	{
		LogManager.Configuration = new XmlLoggingConfiguration(configPath, ignoreErrors: false);
		isInit = true;
	}

	public static void ShutDown()
	{
		if (isInit)
		{
			LogManager.Shutdown();
		}
	}

	public static void Assert(bool condition, string message)
	{
		if (isInit && !condition)
		{
			Nloger.Error(message);
		}
	}

	public static void Info(string message)
	{
		if (isInit)
		{
			Nloger.Info(message);
		}
	}
}
