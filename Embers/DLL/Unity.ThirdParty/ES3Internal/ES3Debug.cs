using UnityEngine;

namespace ES3Internal;

internal static class ES3Debug
{
	private const string disableInfoMsg = "\n<i>To disable these messages from Easy Save, go to Window > Easy Save 3 > Settings, and uncheck 'Log Info'</i>";

	private const string disableWarningMsg = "\n<i>To disable warnings from Easy Save, go to Window > Easy Save 3 > Settings, and uncheck 'Log Warnings'</i>";

	private const string disableErrorMsg = "\n<i>To disable these error messages from Easy Save, go to Window > Easy Save 3 > Settings, and uncheck 'Log Errors'</i>";

	private const char indentChar = '-';

	public static void Log(string msg, Object context = null, int indent = 0)
	{
		if (ES3Settings.defaultSettingsScriptableObject.logDebugInfo)
		{
			if (context != null)
			{
				Debug.LogFormat(context, Indent(indent) + msg + "\n<i>To disable these messages from Easy Save, go to Window > Easy Save 3 > Settings, and uncheck 'Log Info'</i>");
			}
			else
			{
				Debug.LogFormat(context, Indent(indent) + msg);
			}
		}
	}

	public static void LogWarning(string msg, Object context = null, int indent = 0)
	{
		if (ES3Settings.defaultSettingsScriptableObject.logWarnings)
		{
			if (context != null)
			{
				Debug.LogWarningFormat(context, Indent(indent) + msg + "\n<i>To disable warnings from Easy Save, go to Window > Easy Save 3 > Settings, and uncheck 'Log Warnings'</i>");
			}
			else
			{
				Debug.LogWarningFormat(context, Indent(indent) + msg + "\n<i>To disable warnings from Easy Save, go to Window > Easy Save 3 > Settings, and uncheck 'Log Warnings'</i>");
			}
		}
	}

	public static void LogError(string msg, Object context = null, int indent = 0)
	{
		if (ES3Settings.defaultSettingsScriptableObject.logErrors)
		{
			if (context != null)
			{
				Debug.LogErrorFormat(context, Indent(indent) + msg + "\n<i>To disable these error messages from Easy Save, go to Window > Easy Save 3 > Settings, and uncheck 'Log Errors'</i>");
			}
			else
			{
				Debug.LogErrorFormat(context, Indent(indent) + msg + "\n<i>To disable these error messages from Easy Save, go to Window > Easy Save 3 > Settings, and uncheck 'Log Errors'</i>");
			}
		}
	}

	private static string Indent(int size)
	{
		if (size < 0)
		{
			return "";
		}
		return new string('-', size);
	}
}
