namespace GameFramework;

public static class GameFrameworkLog
{
	public interface ILogHelper
	{
		void Log(GameFrameworkLogLevel level, object message);

		void Dismiss();
	}

	private static ILogHelper s_LogHelper;

	public static void SetLogHelper(ILogHelper logHelper)
	{
		s_LogHelper = logHelper;
	}

	public static void Debug(object message)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Debug, message);
		}
	}

	public static void Debug(string message)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Debug, message);
		}
	}

	public static void Debug(string format, object arg0)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Debug, Utility.Text.Format(format, arg0));
		}
	}

	public static void Debug(string format, object arg0, object arg1)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Debug, Utility.Text.Format(format, arg0, arg1));
		}
	}

	public static void Debug(string format, object arg0, object arg1, object arg2)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Debug, Utility.Text.Format(format, arg0, arg1, arg2));
		}
	}

	public static void Debug(string format, params object[] args)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Debug, Utility.Text.Format(format, args));
		}
	}

	public static void Info(object message)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Info, message);
		}
	}

	public static void Info(string message)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Info, message);
		}
	}

	public static void Info(string format, object arg0)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Info, Utility.Text.Format(format, arg0));
		}
	}

	public static void Info(string format, object arg0, object arg1)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Info, Utility.Text.Format(format, arg0, arg1));
		}
	}

	public static void Info(string format, object arg0, object arg1, object arg2)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Info, Utility.Text.Format(format, arg0, arg1, arg2));
		}
	}

	public static void Info(string format, params object[] args)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Info, Utility.Text.Format(format, args));
		}
	}

	public static void Warning(object message)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Warning, message);
		}
	}

	public static void Warning(string message)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Warning, message);
		}
	}

	public static void Warning(string format, object arg0)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Warning, Utility.Text.Format(format, arg0));
		}
	}

	public static void Warning(string format, object arg0, object arg1)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Warning, Utility.Text.Format(format, arg0, arg1));
		}
	}

	public static void Warning(string format, object arg0, object arg1, object arg2)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Warning, Utility.Text.Format(format, arg0, arg1, arg2));
		}
	}

	public static void Warning(string format, params object[] args)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Warning, Utility.Text.Format(format, args));
		}
	}

	public static void Error(object message)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Error, message);
		}
	}

	public static void Error(string message)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Error, message);
		}
	}

	public static void Error(string format, object arg0)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Error, Utility.Text.Format(format, arg0));
		}
	}

	public static void Error(string format, object arg0, object arg1)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Error, Utility.Text.Format(format, arg0, arg1));
		}
	}

	public static void Error(string format, object arg0, object arg1, object arg2)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Error, Utility.Text.Format(format, arg0, arg1, arg2));
		}
	}

	public static void Error(string format, params object[] args)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Error, Utility.Text.Format(format, args));
		}
	}

	public static void Fatal(object message)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Fatal, message);
		}
	}

	public static void Fatal(string message)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Fatal, message);
		}
	}

	public static void Fatal(string format, object arg0)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Fatal, Utility.Text.Format(format, arg0));
		}
	}

	public static void Fatal(string format, object arg0, object arg1)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Fatal, Utility.Text.Format(format, arg0, arg1));
		}
	}

	public static void Fatal(string format, object arg0, object arg1, object arg2)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Fatal, Utility.Text.Format(format, arg0, arg1, arg2));
		}
	}

	public static void Fatal(string format, params object[] args)
	{
		if (s_LogHelper != null)
		{
			s_LogHelper.Log(GameFrameworkLogLevel.Fatal, Utility.Text.Format(format, args));
		}
	}
}
